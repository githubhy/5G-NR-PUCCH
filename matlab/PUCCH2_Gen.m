
% uciCW = [1;0;1;0;1;1;1;1];
uciCW = [1;1;0;0;1;0;0;1; 0;0;0;1;1;0;1;1];
nid = 512;  % 10 bit
rnti = 56789; % 16 bit
sym = nrPUCCH2(uciCW,nid,rnti);

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

disp(sym);