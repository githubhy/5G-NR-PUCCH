% ACK = [BIT0; BIT1];

% Specify a transmission with two-bit HARQ-ACK and positive SR.
% ack = [0;1];
% sr = 1;

% Specify a transmission with two-bit ACK and negative SR
ack = [1]; % ack = [ack0, ack1]
sr = 0;

% Specify a transmission with no ACK and positive SR
% ack = [];
% sr = 1;

% Specify a transmission with no ACK and negative SR => empty sequence
% ack = [];
% sr = 0;

% Specify a transmission with no ACK and no SR => empty sequence
% ack = [];
% sr = [];

% Specify the first symbol index in the PUCCH transmission slot as 0, the number of allocated PUCCH symbols as 14, and the slot number as 3.
% OFDMSymbStartIndex = 0;
% OFDMSymbLength = 12;
symStart = 3;
nPUCCHSym = 7;
symAllocation = [symStart nPUCCHSym];

nslot = 3;
occi = 1;

% Set the scrambling identity to 512 and the initial cyclic shift to 5.
nid = 512;
initialCS = 5; % m0

% Generate the symbols with normal cyclic prefix, intra-slot frequency hopping and group hopping enabled, and orthogonal cover code index 2.
cp           = 'normal';
freqHopping  = 'disabled';
groupHopping = 'neither';

sym = nrPUCCH1(ack,sr,symAllocation,cp,nslot, ...
    nid,groupHopping,initialCS,freqHopping,occi);

%nrPUCCH1 Physical uplink control channel format 1
%   SYM = nrPUCCH1(ACK,SR,SYMALLOCATION,CP,NSLOT,NID,GROUPHOPPING,INITIALCS,FREQHOPPING,OCCI)
%   returns the PUCCH format 1 modulated symbols SYM as per TS 38.211
%   Section 6.3.2.4, by considering the following inputs:
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
%                   transmission. For positive SR with HARQ-ACK information
%                   bits, only HARQ-ACK transmission happens.
%   SYMALLOCATION - Symbol allocation for PUCCH transmission. It is a
%                   two-element vector, where first element is the symbol
%                   index corresponding to first OFDM symbol of the PUCCH
%                   transmission in the slot and second element is the
%                   number of OFDM symbols allocated for PUCCH
%                   transmission, which is in range 4 and 14.
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
%   OCCI          - Orthogonal cover code index. It is in range 0 to 6,
%                   provided by higher-layer parameter timeDomainOCC. The
%                   valid range depends on the number of OFDM symbols per
%                   hop which contain control information.

disp(sym);

% PUCCH_Sequence_UI(sym);


function PUCCH_Sequence_UI(sym)
    % Create a UI figure
    fig = uifigure('Name', 'PUCCH Sequence Viewer', 'Position', [100, 100, 400, 400]);

    % Create axes to plot the complex plane
    ax = uiaxes(fig, 'Position', [50, 80, 300, 300]);
    plot_complex_unit_circle(ax);  % Plot the unit circle on the complex plane
    hold(ax, 'on');

    % Create buttons to control the sequence display
    prevButton = uibutton(fig, 'push', 'Text', 'Previous', 'Position', [80, 20, 100, 30], ...
        'ButtonPushedFcn', @(btn, event) plot_symbol(ax, -1));
    nextButton = uibutton(fig, 'push', 'Text', 'Next', 'Position', [220, 20, 100, 30], ...
        'ButtonPushedFcn', @(btn, event) plot_symbol(ax, 1));

    % Initialize index for displaying symbols
    currentIndex = 1;

    % Plot the first symbol
    plot_symbol(ax, 0);

    % Nested function to plot the unit circle and complex points
    function plot_complex_unit_circle(ax)
        theta = linspace(0, 2*pi, 100);
        plot(ax, cos(theta), sin(theta), '--');  % Plot unit circle
        xlim(ax, [-1.5, 1.5]);
        ylim(ax, [-1.5, 1.5]);
        title(ax, 'PUCCH Sequence on Complex Plane');
        xlabel(ax, 'Real Part');
        ylabel(ax, 'Imaginary Part');
    end

    % Nested function to plot the current symbol
    function plot_symbol(ax, step)
        % Update current index based on step
        currentIndex = currentIndex + step;
        if currentIndex < 1
            currentIndex = 1;
        elseif currentIndex > length(sym)
            currentIndex = length(sym);
        end

        % Clear previous points and plot the new one
        cla(ax);
        plot_complex_unit_circle(ax);
        plot(ax, real(sym(currentIndex)), imag(sym(currentIndex)), 'ro', 'MarkerSize', 8, 'MarkerFaceColor', 'r');
        text(ax, real(sym(currentIndex))+0.05, imag(sym(currentIndex))+0.05, sprintf('Index: %d/%d. %.4f + j%.4f', currentIndex - 1, length(sym) - 1, real(sym(currentIndex)), imag(sym(currentIndex))));
    end
end

%   cinit = 512

%   ncs =
%   239   107   223     6    24     2     3    66   238   125   209   145    44   233

%   ncs =
%   1   1   1   1   0   1   1   1   1   1   0   1   0   1   1   0   1   1   1   1   1   0   1   1   0   1   1   0   0   0   0   0   0   0   0   1   1   0   0   0   0   1   0   0   0   0   0   0   1   1   0   0   0   0   0   0   0   1   0   0   0   0   1   0   0   1   1   1   0   1   1   1   1   0   1   1   1   1   1   0   1   0   0   0   1   0   1   1   1   0   0   0   1   0   0   1   0   0   1   1   0   1   0   0   1   0   0   1   0   1   1   1

%   ncs =
%   1   1   1   1   0   1   1   1   (239)
%   1   1   0   1   0   1   1   0   (107)
%   1   1   1   1   1   0   1   1    ...
%   0   1   1   0   0   0   0   0
%   0   0   0   1   1   0   0   0
%   0   1   0   0   0   0   0   0
%   1   1   0   0   0   0   0   0
%   0   1   0   0   0   0   1   0
%   0   1   1   1   0   1   1   1
%   1   0   1   1   1   1   1   0
%   1   0   0   0   1   0   1   1
%   1   0   0   0   1   0   0   1
%   0   0   1   1   0   1   0   0    ...
%   1   0   0   1   0   1   1   1   (233)


%   prbs =
%   0   0   0   1   0   1   0   0
%   1   1   1   1   1   1   0   0
%   0   1   0   1   0   0   1   0
%   0   0   1   0   1   0   1   0
%   0   0   1   0   0   1   1   1
%   0   1   0   0   0   0   0   1
%   0   0   0   0   0   1   0   0
%   1   0   0   0   0   1   0   1
%   1   0   1   1   0   1   1   0
%   0   1   0   0   1   1   1   1
%   0   1   0   1   0   0   1   0
%   1   0   0   0   0   0   1   0
%   1   0   1   1   0   0   0   1
%   0   0   0   1   1   0   0   1

%   c_seq_gen.o_seq_bit =
%   0   1   0   0   0   0   0   1
%   1   0   0   1   1   0   0   1
%   1   0   0   1   0   0   0   1
%   1   0   0   0   0   1   0   1
%   1   0   0   0   1   0   0   0
%   1   0   1   1   1   0   0   0
%   0   0   1   0   1   0   1   1
%   0   1   0   1   0   0   0   0
%   0   1   0   0   0   1   1   1
%   0   0   1   0   1   1   1   1
%   0   0   0   0   0   0   1   1
%   1   0   0   0   1   1   1   1
%   0   0   0   0   0   0   1   1
%   0   1   0   1   0   0   1   1

