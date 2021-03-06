function xGANxGEMFreqResponse = LTFreq2Matlab(filename, dataLines)
%IMPORTFILE Import data from a text file
%  XGANXGEMFREQRESPONSE = IMPORTFILE(FILENAME) reads data from text file
%  FILENAME for the default selection.  Returns the data as a table.
%
%  XGANXGEMFREQRESPONSE = IMPORTFILE(FILE, DATALINES) reads data for the
%  specified row interval(s) of text file FILENAME. Specify DATALINES as
%  a positive scalar integer or a N-by-2 array of positive scalar
%  integers for dis-contiguous row intervals.
%
%  Example:
%  xGANxGEMFreqResponse = importfile("G:\My Drive\Code\LTSpice\200630 xGAN xGEM Load Responses V0\200701 xGAN xGEM Freq Response.txt", [2, Inf]);
%
%  See also READTABLE.
%
% Auto-generated by MATLAB on 27-Jul-2020 16:52:39

%% Input handling

% If dataLines is not specified, define defaults
if nargin < 2
    dataLines = [2, Inf];
end

%% Setup the Import Options and import the data
opts = delimitedTextImportOptions("NumVariables", 5);

% Specify range and delimiter
opts.DataLines = dataLines;
opts.Delimiter = ["\t", "(", ")", ",", "dB", "°"];

% Specify column names and types
opts.VariableNames = ["Freq", "V", "n002", "Ix", "U1po1"];
opts.VariableTypes = ["double", "string", "double", "string", "double"];

% Specify file level properties
opts.ImportErrorRule = "omitvar";
opts.MissingRule = "omitvar";
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";

% Specify variable properties
opts = setvaropts(opts, ["V", "Ix"], "WhitespaceRule", "preserve");
opts = setvaropts(opts, ["V", "Ix"], "EmptyFieldRule", "auto");

% Import the data
xGANxGEMFreqResponse = readtable(filename, opts);

end