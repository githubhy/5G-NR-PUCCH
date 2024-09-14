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

modulation = 'QPSK';
% modulation = 'pi/2-BPSK';

sf = 2;
occi = 1;

sym = nrPUCCH4(uciCW,modulation,nid,rnti,sf,occi);

%nrPUCCH4 Physical uplink control channel format 4
%   SYM = nrPUCCH4(UCICW,MODULATION,NID,RNTI,SF,OCCI) returns a complex
%   column vector SYM containing physical uplink control channel format 4
%   encoded symbols as per TS 38.211 Section 6.3.2.6, by considering the
%   following inputs:
%   UCICW      - Encoded UCI codeword as per TS 38.212 Section 6.3.1. It
%                must be a column vector.
%   MODULATION - Modulation scheme. It must be one of the set
%                {'pi/2-BPSK', 'QPSK'}.
%   NID        - Scrambling identity. It is equal to the higher-layer
%                parameter dataScramblingIdentityPUSCH (0...1023), if
%                configured, else, it is equal to the physical layer cell
%                identity, NCellID (0...1007).
%   RNTI       - Radio Network Temporary Identifier (0...65535).
%   SF         - Spreading factor for PUCCH format 4. It must be either 2
%                or 4.
%   OCCI       - Orthogonal cover code sequence index. It must be greater
%                than or equal to zero and less than SF.
%
%   The encoding process involves scrambling, symbol modulation, blockwise
%   spreading and transform precoding.
%
%   SYM = nrPUCCH4(...,MRB) also specifies the number of resource blocks
%   associated with the PUCCH format 4 transmission. If MRB is not
%   specified, the function uses the default value of 1.
%
%   Note that the transform precoding is done by considering the number of
%   subcarriers associated with the PUCCH format 4 transmission as MRB*12.
%   The length of UCICW must be an integer multiple of Qm*12, where Qm is 1
%   for pi/2-BPSK modulation and 2 for QPSK modulation.

disp(sym);