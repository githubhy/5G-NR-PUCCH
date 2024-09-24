% nrPUCCH

uciCW = [
    1;
    1;
    0;
    0;
    1;
    0;
    0;
    1;
    
    0;
    0;
    0;
    1;
    1;
    0;
    1;
    1;

    1;
    1;
    0;
    0;
    % 1;
    % 0;
    % 0;
    % 1;
    % 
    % 0;
    % 0;
    % 0;
    % 1;
    % 1;
    % 0;
    % 1;
    % 1;
    % 
    % 1;
    % 1;
    % 0;
    % 0;
    % 1;
    % 0;
    % 0;
    % 1;
];
nid  = 512;   % 10 bit
rnti = 56789; % 16 bit

% Spreading 6.3.2.5.2A TS38.211
% If higher parameter 'interlace1' is not configured, and the higher-layer 
% parameter 'occ-Length' (occi) is configured:
% sf = {2,4} given by occi
% wn(i) is given by Table and n = (n0 + nIRB) mod sf

sf   = [4]; % sf given by 'occ-Length'
occi = [0 1 2 3 0]; % occi given by 'occ-Index'
nIRB = [0 0 0 0 1]; % to compute n = (n0 + nIRB) mod sf with n0 = occi
% occi = [2]; % occi given by 'occ-Index'
% nIRB = [1]; % to compute n = (n0 + nIRB) mod sf with n0 = occi
sym = hPUCCH2(uciCW,nid,rnti,nIRB,sf,occi);

disp(sym);

function sym = hPUCCH2(uciCW,nid,rnti,nIRB,sf,occi,varargin)

    % Scrambling, TS 38.211 Section 6.3.2.5.1
    c = nrPUCCHPRBS(nid,rnti,length(uciCW));
    btilde = xor(uciCW,c);

    % Modulation, TS 38.211 Section 6.3.2.5.2
    d = nrSymbolModulate(btilde,'QPSK',varargin{:});

    % Symbol spreading for operation in unlicensed spectrum, as described
    % in TS 38.211 Section 6.3.2.5.2A (Rel-16). Symbol spreading applies to
    % single-interlace transmissions only, which is indicated here by
    % content of the spreading factor.
    noSpreading = isempty(nIRB) || isempty(sf);
    if noSpreading

        sym = d;

    else % Symbol spreading

        % Verify that the number of input bits is compatible with the bit
        % capacity. The number of REs in each RB and OFDM symbol available
        % for PUCCH with no DM-RS is 8 according to TS 38.211 Section
        % 6.4.1.3.2.2.
        seqLength = length(d);
        modulation = 'QPSK';
        numRB = length(nIRB);
        nRE = 8; % Number of RE per PRB available for PUCCH
        formatPUCCH = 2;
        validateSpreadingConfig(seqLength,modulation,numRB,nRE,sf,formatPUCCH);

        % NIRB-dependent spreading sequence for each PUCCH modulated symbol
        numOFDMSymbols = sf*seqLength/(numRB*nRE);
        wn = interlacedSpreadingSequences(nIRB,nRE,sf,occi,numOFDMSymbols);

        % Spread PUCCH modulated symbols. The mapping is frequency first.
        z = (d.*wn).';
        sym = z(:);

    end

end

function wn = interlacedSpreadingSequences(nIRB,nRE,sf,occi,numOFDMSymbols)
%interlacedSpreadingSequences Spreading sequences for interlaced PUCCH format 2
%
%   Note: This is an internal undocumented function and its API and/or
%   functionality may change in subsequent releases.
%
%   interlacedSpreadingSequences(NIRB,NRE,SF,OCCI,NSYM) returns the
%   NIRB-dependent spreading sequences for PUCCH format 2 with interlacing.
%   The output is an N-by-SF matrix of spreading sequences. N is the number
%   of REs available for PUCCH transmission in NIRB resource blocks (N =
%   numel(NIRB)*(NRE/SF), with NRE = 8 the number of RE per PRB available
%   for PUCCH format 2) and NSYM number of OFDM symbols.

%   Copyright 2023 The MathWorks, Inc.

%#codegen

    % Calculate the spreading sequence for each interlaced RB (wn). The
    % index n of wn depends on the OCCI and the index of the RB in the
    % interlace. Each row corresponds to 1 IRB and each column to a
    % subcarrier. The QPSK modulated symbols will be spread along SF
    % subcarriers.
    n0 = double(occi);
    n = mod(n0 + nIRB,sf);
    original_wn = nr5g.internal.pucch.spreadingSequence(sf,n);
     % 1     1     1     1
     % 1    -1     1    -1
     % 1     1    -1    -1
     % 1    -1    -1     1

    % Repeat the IRB-dependent spreading sequences (rows of wn) such that
    % all PUCCH modulation symbols in a PRB are spread with the same
    % sequence.
    repeated_wn = repelem(original_wn,nRE/sf(1),1);
     % 1     1     1     1  |
     % 1     1     1     1  | duplicated by nRE/sf
     % 
     % 1    -1     1    -1  |
     % 1    -1     1    -1  | duplicated by nRE/sf
     % 
     % 1     1    -1    -1  |
     % 1     1    -1    -1  | duplicated by nRE/sf
     % 
     % 1    -1    -1     1  |
     % 1    -1    -1     1  | duplicated by nRE/sf

    % Replicate spreading sequences to match the number of OFDM symbols
    wn = repmat(repeated_wn,numOFDMSymbols(1),1);
     % 1     1     1     1  | 
     % 1     1     1     1  | 
     % 1    -1     1    -1  | 
     % 1    -1     1    -1  | 
     % 1     1    -1    -1  | 
     % 1     1    -1    -1  | 
     % 1    -1    -1     1  | 
     % 1    -1    -1     1  |
     % ---------------------|   <-- duplicated by numOFDMSymbols
     % 1     1     1     1  |
     % 1     1     1     1  |
     % 1    -1     1    -1  |
     % 1    -1     1    -1  |
     % 1     1    -1    -1  |
     % 1     1    -1    -1  |
     % 1    -1    -1     1  |
     % 1    -1    -1     1  |
end

function validateSpreadingConfig(seqLength,modulation,Mrb,nRE,sf,formatPUCCH)
%validateSpreadingConfig Validate spreading configuration for PUCCH 2, 3 and 4
%
%   Note: This is an internal undocumented function and its API and/or
%   functionality may change in subsequent releases.

%   Copyright 2023 The MathWorks, Inc.

%#codegen

    % Modulation order
    Q = nr5g.internal.getQm(modulation);

    SF = sf(1);
    Msc = Mrb*nRE;
    nSymbols = SF * seqLength/Msc;
    switch formatPUCCH
        case 2
            coder.internal.errorIf(nSymbols ~= fix(nSymbols),'nr5g:nrPUCCH:InvalidNumOfModSymbolsF2',seqLength*Q,SF,Mrb);
        case 3
            coder.internal.errorIf(nSymbols ~= fix(nSymbols),'nr5g:nrPUCCH:InvalidNumOfModSymbolsF3',seqLength*Q,modulation,SF,Mrb);
        case 4
            coder.internal.errorIf(nSymbols ~= fix(nSymbols),'nr5g:nrPUCCH:InvalidNumOfModSymbolsF4',seqLength*Q,modulation,SF,Mrb);
    end

end

function validateInputs(uciCW,nid,rnti)
    % Validate mandatory inputs
    fcnName = 'nrPUCCH2';
    validateattributes(uciCW,{'double','int8','logical'},{'real'},...
        fcnName,'UCICW');
    coder.internal.errorIf(~(iscolumn(uciCW) || isempty(uciCW)),...
        'nr5g:nrPUCCH:InvalidInputDim');
    validateattributes(nid,{'numeric'},{'scalar',...
        'real','integer','>=',0,'<=',1023},fcnName,'NID');
    validateattributes(rnti,{'numeric'},{'scalar',...
        'real','integer','>=',0,'<=',65535},fcnName,'RNTI');
end