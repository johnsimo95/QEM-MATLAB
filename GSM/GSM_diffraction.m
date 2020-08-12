clear;clc;

l=500e-9;
z1=0.3e-3;
z2=9e-3;
wo=100e-6;
ro=100000e-3;
lo=100e-6;
d1=10e-6;
d2=10e-6;
ff=0.5;
z3=0e-3:0.25e-3:20e-3;
x=(0:1:400)*1e-6;
y=(0:1:400)*1e-6;
%z3=0;
%rxo=1.*((1+z3/ro).^2+((l*z3)./(wo*lo)).^2);%./((z3/ro).*(1+z3/ro)+((l*z3)./(wo*lo)).^2);
%f1=((1+z3/ro).^2+((l*z3)./(wo*lo)).^2);
%f2=((z3/ro).*(1+z3/ro)+((l*z3)./(wo*lo)).^2);
for i=1:size(z3,2)
    z12=z2-z1;
    z23=z3(i)-z2;
    z13=z12+z23;
    wx=wo*((1+z3(i)/ro)^2+((l*z3(i))/(wo*lo))^2)^0.5;
    wy=wo*((1+z3(i)/ro)^2+((l*z3(i))/(wo*lo))^2)^0.5;
    lx=wx/wo*lo;
    ly=wy/wo*lo;
    rx=z3(i)*((1+z3(i)/ro)^2+((l*z3(i))/(wo*lo))^2)/((z3(i)/ro)*(1+z3(i)/ro)+((l*z3(i))/(wo*lo))^2);
    rxo(i)=rx;
    ry=z3(i)*((1+z3(i)/ro)^2+((l*z3(i))/(wo*lo))^2)/((z3(i)/ro)*(1+z3(i)/ro)+((l*z3(i))/(wo*lo))^2);
    %d0000=exp(-pi*x'.^2/wx^2)*exp(-pi*y.^2/wy^2);
    %d1000=exp(-pi*(x-l*z23*(0.5*(z13/d1/z23)))'.^2/wx^2)*exp(-pi*y.^2/wy^2);
    mlim=1;
    nlim=1;
    id=1;
    jd=1;
    for i1=-mlim:1:mlim
        for j1=-mlim:1:mlim;
            for i2=-nlim:1:nlim
                for j2=-nlim:1:nlim
                    [D(id,jd,:,:),F(id,jd,:,:),P(id,jd,:,:),V(id,jd,:,:)]=gsmparameters(i1,j1,i2,j2,l,d1,d2,z13,z23,x,y,wx,wy,rx,lx);
                    id=id+1;
                    jd=jd+1;
                end
            end
        end
    end
    %PP=zeros(9,1201,1201);
    %PP(:,:,:)=[P ones(1201, 1201)];
    I(:,:,i)=wo/wx*wo/wy*sum(sum((D.*F.*P.*V)));
end
%%
A(:,:)=abs(I(:,21,:));
imagesc(x,z3,normr(A'));
%imagesc(x,y,I(:,:,14))
%plot(z3,z3.*f1./f2);


