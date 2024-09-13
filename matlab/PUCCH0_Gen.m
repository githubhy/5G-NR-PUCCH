% Specify a transmission with two-bit HARQ-ACK and positive SR.
% ack = [0;1];
% sr = 1;

% Specify a transmission with one-bit ACK and negative SR
% ack = [1;1];
% sr = 0;

% Specify a transmission with no ACK and positive SR
ack = [1;1];
sr = 1;

% Specify a transmission with no ACK and negative SR => empty sequence
% ack = [];
% sr = 0;

% Specify a transmission with no ACK and no SR => empty sequence
% ack = [];
% sr = [];

% Specify the first symbol index in the PUCCH transmission slot as 0, the number of allocated PUCCH symbols as 14, and the slot number as 3.
OFDMSymbStartIndex = 2;
OFDMSymbLength = 2;
symAllocation = [OFDMSymbStartIndex OFDMSymbLength];

nslot = 3;
% occi = 0;

% Set the scrambling identity to 512 and the initial cyclic shift to 5.
nid = 512;
initialCS = 5; % m0

% Generate the symbols with normal cyclic prefix, intra-slot frequency hopping and group hopping enabled, and orthogonal cover code index 2.
cp           = 'normal';
freqHopping  = 'disabled';
groupHopping = 'neither';

sym = nrPUCCH0(ack,sr,symAllocation,cp,nslot, ...
    nid,groupHopping,initialCS,freqHopping);
%nrPUCCH0 Physical uplink control channel format 0
%   SYM = nrPUCCH0(ACK,SR,SYMALLOCATION,CP,NSLOT,NID,GROUPHOPPING,INITIALCS,FREQHOPPING)
%   returns the PUCCH format 0 symbols SYM as per TS 38.211 Section
%   6.3.2.3, by considering the following inputs:
%   ACK           - Acknowledgment bits of hybrid automatic repeat request
%                   (HARQ-ACK). It is a column vector of length 0, 1 or 2
%                   HARQ-ACK bits. The bit value of 1 stands for positive
%                   acknowledgment and bit value of 0 stands for negative
%                   acknowledgment. Use empty ([]) to indicate no HARQ-ACK
%                   transmission.
%   SR            - Scheduling request (SR). It is a column vector of
%                   length 0 or 1 SR bits. The bit value of 1 stands for
%                   positive SR and bit value of 0 stands for negative SR.
%                   Use empty ([]) to indicate no SR transmission. The
%                   output SYM is empty when there is only negative SR
%                   transmission.
%   SYMALLOCATION - Symbol allocation for PUCCH transmission. It is a
%                   two-element vector, where first element is the symbol
%                   index corresponding to first OFDM symbol of the PUCCH
%                   transmission in the slot and second element is the
%                   number of OFDM symbols allocated for PUCCH
%                   transmission, which is either 1 or 2.
%   CP            - Cyclic prefix ('normal','extended').
%   NSLOT         - Slot number in radio frame. It is in range 0 to 159 for
%                   normal cyclic prefix for different numerologies. For
%                   extended cyclic prefix, it is in range 0 to 39, as
%                   specified in TS 38.211 Section 4.3.2.
%   NID           - Scrambling identity. It is in range 0 to 1023 if
%                   higher-layer parameter hoppingId is provided, else, it
%                   is in range 0 to 1007, equal to the physical layer cell
%                   identity NCellID.
%   GROUPHOPPING  - Group hopping configuration. It is one of the set
%                   {'neither','enable','disable'} provided by higher-layer
%                   parameter pucch-GroupHopping.
%   INITIALCS     - Initial cyclic shift (m_0). It is in range 0 to 11,
%                   provided by higher-layer parameter initialCyclicShift.
%   FREQHOPPING   - Intra-slot frequency hopping. It is one of the set
%                   {'enabled','disabled'} provided by higher-layer
%                   parameter intraSlotFrequencyHopping.
%
%   Note that when GROUPHOPPING is set to 'disable', sequence hopping is
%   enabled which might result in selecting a sequence number that is not
%   appropriate for short base sequences.
%
%   SYM = nrPUCCH0(...,MRB) also specifies the number of resource blocks
%   associated with the PUCCH format 0 transmission. If MRB is not
%   specified, the function uses the default value of 1.
%
%   The output symbols SYM is a column vector of length given by product of
%   number of subcarriers in the MRB resource blocks and the number of OFDM
%   symbols allocated for PUCCH transmission in SYMALLOCATION.
%
%   SYM = nrPUCCH0(...,NAME,VALUE) specifies an additional option as a
%   NAME,VALUE pair to allow control over the format of the symbols:
%
%   'OutputDataType' - 'double' for double precision (default)
%                      'single' for single precision

disp(sym);