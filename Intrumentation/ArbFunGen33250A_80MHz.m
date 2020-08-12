%% 33250A_80MHZ_ARBFUNGEN Code for communicating with an instrument.
%
%   This is the machine generated representation of an instrument control
%   session. The instrument control session comprises all the steps you are
%   likely to take when communicating with your instrument. These steps are:
%   
%       1. Instrument Connection
%       2. Instrument Configuration and Control
%       3. Disconnect and Clean Up
% 
%   To run the instrument control session, type the name of the file,
%   33250A_80MHz_ArbFunGen, at the MATLAB command prompt.
% 
%   The file, 33250A_80MHZ_ARBFUNGEN.M must be on your MATLAB PATH. For additional information 
%   on setting your MATLAB PATH, type 'help addpath' at the MATLAB command 
%   prompt.
% 
%   Example:
%       33250a_80mhz_arbfungen;
% 
%   See also SERIAL, GPIB, TCPIP, UDP, VISA, BLUETOOTH, I2C, SPI.
% 
%   Creation time: 19-Nov-2019 15:03:56

%% Instrument Connection

% Find a GPIB object.
obj1 = instrfind('Type', 'gpib', 'BoardIndex', 0, 'PrimaryAddress', 1, 'Tag', '');

% Create the GPIB object if it does not exist
% otherwise use the object that was found.
if isempty(obj1)
    obj1 = gpib('NI', 0, 1);
else
    fclose(obj1);
    obj1 = obj1(1);
end

%% Instrument Connection

% Connect to instrument object, obj1.
fopen(obj1);

%% Instrument Configuration and Control

% Communicating with instrument object, obj1.
data1 = query(obj1, 'data:cat?');
data2 = query(obj1, 'appl?');
fprintf(obj1, 'appl:user 1 hz, 1 v, 0 v');
fprintf(obj1, 'burst:mode trig');
data3 = query(obj1, 'burst:mode?');
fprintf(obj1, 'trig:sour ext');
data4 = query(obj1, 'trig:sour? ');
data5 = query(obj1, 'trig:slop? ');
data6 = query(obj1, 'trig:del? ');
fprintf(obj1, 'trig:del 10 ns');
fprintf(obj1, 'outp off');

%% Notes
% for triggering
%     When the Bus (software) source is selected, the function generator
%     initiates one sweep each time a bus trigger command is received.
%     To trigger the function generator from the remote interface 
%     (either GPIB or RS-232), send the TRIG or *TRG (trigger) command. 
%     The front-panel key is illuminated when the function generator is
%     waiting for a bus trigger.


%% Disconnect and Clean Up

% The following code has been automatically generated to ensure that any
% object manipulated in TMTOOL has been properly disposed when executed
% as part of a function or script.

% Disconnect all objects.
fclose(obj1);

% Clean up all objects.
delete(obj1);
clear obj1;

