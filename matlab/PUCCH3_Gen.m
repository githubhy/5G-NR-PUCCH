nid   = 512;  % 10 bit
rnti  = 56789; % 16 bit
Mrb   = 1; % Msc = Mrb * nRBSC with nRBSC = 12

sf   = [];
occi = [];
% sf   = [];
% occi = [];
% sf   = [1 1];
% occi = [0 0];

% modulation = 'QPSK';
modulation = 'pi/2-BPSK';

lenUCI = Mrb*12*2;
uciCW = [
     1;
     1;
     0;
     1;
     1;
     0;
     0;
     1;
     1;
     1;
     0;
     1;
     1;
     0;
     1;
     0;
     0;
     1;
     1;
     1;
     1;
     0;
     1;
     1;
     1;
     1;
     1;
     0;
     1;
     0;
     1;
     0;
     0;
     0;
     0;
     1;
     1;
     0;
     1;
     0;
     0;
     0;
     1;
     1;
     0;
     0;
     0;
     1;
     1;
     1;
     0;
     1;
     1;
     0;
     0;
     0;
     1;
     0;
     1;
     0;
     1;
     0;
     1;
     1;
     1;
     1;
     1;
     0;
     0;
     0;
     1;
     0;
];


sym = hPUCCH3(uciCW,modulation,nid,rnti,Mrb,sf,occi);
% disp(sym);

%nrPUCCH3 Physical uplink control channel format 3
%   SYM = nrPUCCH3(UCICW,MODULATION,NID,RNTI,MRB) returns a complex column
%   vector SYM containing physical uplink control channel format 3 encoded
%   symbols as per TS 38.211 Section 6.3.2.6, by considering the following
%   inputs:
%   UCICW      - Encoded UCI codeword as per TS 38.212 Section 6.3.1. It
%                must be a column vector.
%   MODULATION - Modulation scheme. It must be one of the set
%                {'pi/2-BPSK', 'QPSK'}.
%   NID        - Scrambling identity. It is equal to the higher-layer
%                parameter dataScramblingIdentityPUSCH (0...1023), if
%                configured, else, it is equal to the physical layer cell
%                identity, NCellID (0...1007).
%   RNTI       - Radio Network Temporary Identifier (0...65535).
%   MRB        - The number of resource blocks associated with the PUCCH
%                format 3 transmission. Nominally the value of MRB will be
%                one of the set {1,2,3,4,5,6,8,9,10,12,15,16}.
%
%   The encoding process involves scrambling, symbol modulation and
%   transform precoding.

function sym = hPUCCH3(uciCW,modulation,nid,rnti,Mrb,sf,occi)
%hPUCCH3 Physical uplink control channel format 3
%
%   Note: This is an internal undocumented function and its API and/or
%   functionality may change in subsequent releases.

%   Copyright 2023 The MathWorks, Inc.

%#codegen

    % Scrambling, TS 38.211 Section 6.3.2.6.1
    c = nrPUCCHPRBS(nid,rnti,length(uciCW));
    btilde = xor(uciCW,c);

    % Modulation, TS 38.211 Section 6.3.2.6.2
    d = nrSymbolModulate(btilde,modulation);

    interlaced = ~isempty(sf);
    if ~interlaced % Direct mapping when interlacing is disabled

        y = d;
        disp(y);

    else % Block spreading with interlaced mapping, TS 38.211 Section 6.3.2.6.3

        % Validate input size and block-spreading configuration
        nRE = 12;
        formatPUCCH = 3;
        nr5g.internal.pucch.validateSpreadingConfig(length(d),modulation,Mrb,nRE,sf,formatPUCCH);

        % Blockwise spreading TS 38.211 Section 6.3.2.6.3
        y = blockWiseSpread(d,Mrb,sf,occi);

    end

    % Transform precoding, TS 38.211 Section 6.3.2.6.4
    sym = nrTransformPrecode(y,Mrb);

end


function y = blockWiseSpread(d,Mrb,sf,occi)
%blockWiseSpread Blockwise spreading for PUCCH formats 3 and 4
%
%   Note: This is an internal undocumented function and its API and/or
%   functionality may change in subsequent releases.
%
%   Y = blockWiseSpread(D,MRB,SF,OCCI) returns the blockwise spread
%   symbols Y given the modulated symbols D, the number of resource blocks
%   MRB, spreading factor SF, and orthogonal cover code index OCCI, as
%   defined in TS 38.211 Section 6.3.2.6.3.

%   Copyright 2023 The MathWorks, Inc.

%#codegen

    sf = double(sf(1));
    Msc = double(Mrb(1))*12;

    % Get the orthogonal cover code sequence based on sf and occi values
    wn = nr5g.internal.pucch.blockWiseSpreadingSequence(sf,occi);
    w = repmat(wn,Msc/sf,1);
    y = zeros(sf*length(d),1,'like',d);
    k = 0:Msc-1;
    nSymbols = sf * length(d)/Msc;
    for l = 0:nSymbols-1
        y_range  = l*Msc + k;
        d_range  = l*(Msc/sf) + mod(k,(Msc/sf));
        target_d = d(d_range + 1);
        target_y = w(:).*d(d_range + 1);
        y(y_range + 1) = target_y;
    end

    % Initialize a cell array to store groups
    groups = cell(1, sf);  % sf groups
    group_size = Msc/sf;
    for l = 0:nSymbols-1
        y_symbol_range = l*Msc:(l+1)*Msc-1;
        y_symbol = y(y_symbol_range+1);
        for i = 0:sf-1
            group_range = i*group_size:(i+1)*group_size-1;
            groups{i+1} = [groups{i+1} y_symbol(group_range+1)];
        end
    end

    join_groups = [];
    for i = 1:sf 
        join_groups = [join_groups groups{i}(:)];
    end
    disp(join_groups(:));

end