uciCW = [
    1;
    0;
    1;
    0;
    1;
    1;
    1;
    0;
    1;
    0;
    1;
    0;
    0;
    1;
    1;
    0;
    1;
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
    0;
    0;
    1;
    1;
    0;
    0;
    1;
    1;
    0;
    1;
    1;
    0;
    1;
    1;
    1;
    0;
    1;
    0;
    1;
    0;
    1
];

nid   = 512;  % 10 bit
rnti  = 56789; % 16 bit
Mrb   = 1; % Msc = Mrb * nRBSC with nRBSC = 12

% Set interlacing specific parameters to empty as they are not
% supported in this function.
sf   = [];
occi = [];

modulation = 'QPSK';
% modulation = 'pi/2-BPSK';

sym = nrPUCCH3(uciCW,modulation,nid,rnti,Mrb);
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

disp(sym);