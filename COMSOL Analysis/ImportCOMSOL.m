function [field] = ImportCOMSOL(filename, portVoltage)
%IMPORTCOMSOL_TF Summary of this function goes here
%   Detailed explanation goes here

    data=readtable(filename,'HeaderLines',5);
    data=table2array(data);

    % NO DC TERM IN RAW!
    field.freq = (data(:,1)).';
    field.posX 
    %Default state of mirror!
    


end

