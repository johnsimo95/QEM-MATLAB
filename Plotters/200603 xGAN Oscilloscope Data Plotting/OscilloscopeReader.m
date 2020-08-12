maxElem = 10;
rootName = 'C3Raw_Ringing_1uf_0R1uf_FloatingSource';
extension = '.dat';

for n = 0:maxElem
    s = [rootName num2str(3,'%05.f') extension]
    load s -ascii
end