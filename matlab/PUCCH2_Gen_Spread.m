uciCW = [1;0;1;0;1;1;1;1;1;0;1;0;1;1;1;1];
nid = 512;  % 10 bit
rnti = 56789; % 16 bit
sym = nrPUCCH2(uciCW,nid,rnti);

disp(sym);


function sym = nrPUCCH2(uciCW,nid,rnti,varargin)
%nrPUCCH2 Physical uplink control channel format 2
%   SYM = nrPUCCH2(UCICW,NID,RNTI) returns a complex column vector SYM
%   containing physical uplink control channel format 2 encoded symbols as
%   per TS 38.211 Section 6.3.2.5, by considering the following inputs:
%   UCICW - Encoded UCI codeword as per TS 38.212 Section 6.3.1. It must be
%           a column vector.
%   NID   - Scrambling identity. It is equal to the higher-layer parameter
%           dataScramblingIdentityPUSCH (0...1023), if configured, else, it
%           is equal to the physical layer cell identity, NCellID
%           (0...1007).
%   RNTI  - Radio Network Temporary Identifier (0...65535).
%
%   The encoding process involves scrambling followed by QPSK modulation.
%
%   SYM = nrPUCCH2(UCICW,NID,RNTI,NAME,VALUE) specifies an additional
%   option as a NAME,VALUE pair to allow control over the data type of the
%   output symbols:
%
%   'OutputDataType' - 'double' for double precision (default)
%                      'single' for single precision
%
%   Example 1:
%   % Generate PUCCH format 2 symbols with nid as 148 and rnti as 160.
%
%   uciCW = randi([0 1],100,1);
%   nid = 148;
%   rnti = 160;
%   sym = nrPUCCH2(uciCW,nid,rnti);
%
%   Example 2:
%   % Generate PUCCH format 2 symbols of single data type with nid as 512
%   % and rnti as 2563.
%
%   uciCW = randi([0 1],100,1);
%   nid = 512;
%   rnti = 2563;
%   sym = nrPUCCH2(uciCW,nid,rnti,'OutputDataType','single');
%
%   See also nrPUCCH0, nrPUCCH1, nrPUCCH3, nrPUCCH4, nrPUCCHPRBS,
%   nrSymbolModulate.
    narginchk(3,5);

    validateInputs(uciCW,nid,rnti);

    % Set interlacing specific parameters to empty as they are not
    % supported in this function.
    nIRB = [1 2];
    sf = [2 4];
    occi = [1 3];
    sym = hPUCCH2(uciCW,nid,rnti,nIRB,sf,occi,varargin{:});

end

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