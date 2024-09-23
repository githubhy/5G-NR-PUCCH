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
];
nid  = 512;   % 10 bit
rnti = 56789; % 16 bit

% Spreading 6.3.2.5.2A TS38.211
% If higher parameter 'interlace1' is not configured, and the higher-layer 
% parameter 'occ-Length' (occi) is configured:
% sf = {2,4} given by occi
% wn(i) is given by Table and n = (n0 + nIRB) mod sf

nIRB = [1]; % to compute n = (n0 + nIRB) mod sf with n0 = occi
sf   = [2]; % sf given by 'occ-Length'
occi = [2]; % occi given by 'occ-Index'

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
        nr5g.internal.pucch.validateSpreadingConfig(seqLength,modulation,numRB,nRE,sf,formatPUCCH);

        % NIRB-dependent spreading sequence for each PUCCH modulated symbol
        numOFDMSymbols = sf*seqLength/(numRB*nRE);
        wn = nr5g.internal.interlacing.interlacedSpreadingSequences(nIRB,nRE,sf,occi,numOFDMSymbols);

        % Spread PUCCH modulated symbols. The mapping is frequency first.
        z = (d.*wn).';
        sym = z(:);

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