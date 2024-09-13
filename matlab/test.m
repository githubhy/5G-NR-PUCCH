ack = [1;1];
sr = [1];

lenACK = length(ack);   
lenSR = length(sr);

% Get the possible cyclic shift values for the length of ack input
csTable = getCyclicShiftTable(lenACK);

% Get the sequence cyclic shift based on ack and sr inputs
if lenACK==0
    seqCS = csTable(1,1);
elseif (lenSR==0) || (sr(1) ==0)
    uciValue = comm.internal.utilities.convertBit2Int(ack,lenACK);
    seqCS = csTable(1,uciValue+1);
else
    uciValue = comm.internal.utilities.convertBit2Int(ack,lenACK);
    seqCS = csTable(2,uciValue+1);
end

disp(seqCS);


function csTable = getCyclicShiftTable(len)
%   csTable = getCyclicShiftTable(LEN) provides the possible sequence
%   cyclic shift values based on the length LEN.

    if len == 1
        csTable = [0 6;
                   3 9];
    else
        csTable = [0 3  9 6;
                   1 4 10 7];
    end

end