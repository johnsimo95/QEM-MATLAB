clear;clc;
l=500e-9;
z1=0.3e-3;
wo=100e-6;
ro=-0.7e-3;
lo=100e-6;
d1=10e-6;
d2=10e-6;
ff=0.5;
z2=0.3e-3:0.01e-3:2e-3;
x=(0:0.5:100)*1e-6;
y=(0:0.5:100)*1e-6;
aa=size(x,2);
%z3=0;
%rxo=1.*((1+z3/ro).^2+((l*z3)./(wo*lo)).^2);%./((z3/ro).*(1+z3/ro)+((l*z3)./(wo*lo)).^2);
%f1=((1+z3/ro).^2+((l*z3)./(wo*lo)).^2);
%f2=((z3/ro).*(1+z3/ro)+((l*z3)./(wo*lo)).^2);
for i=1:size(z2,2)
    z12=z2(i)-z1;
    wx=wo*((1+z2(i)/ro)^2+((l*z2(i))/(wo*lo))^2)^0.5;
    wy=wo*((1+z2(i)/ro)^2+((l*z2(i))/(wo*lo))^2)^0.5;
    lx=wx/wo*lo;
    ly=wy/wo*lo;
    rx=z2(i)*((1+z2(i)/ro)^2+((l*z2(i))/(wo*lo))^2)/((z2(i)/ro)*(1+z2(i)/ro)+((l*z2(i))/(wo*lo))^2);
    rxo(i)=rx;
    ry=z2(i)*((1+z2(i)/ro)^2+((l*z2(i))/(wo*lo))^2)/((z2(i)/ro)*(1+z2(i)/ro)+((l*z2(i))/(wo*lo))^2);
    mlim=1;
    id=1;
    jd=1;
    coeff=[0.5,1,0.5];
    for i1=-mlim:1:mlim
        for j1=-mlim:1:mlim
        mav=(i1+j1)/2;
        mdel=i1-j1;
        D(id,jd,:)=coeff(id)*coeff(jd)*exp(-pi*(x-l*z12*mav/d1).^2/wx^2).*exp((-1i*2*pi*mdel/d1)*(x-mdel*l*z12/d1)*(1-z12/rx))*exp(-pi*(mdel*l*z12/lx/d1)^2);
        jd=jd+1;
        end
        jd=1;
        id=id+1;
    end
    %PP=zeros(9,1201,1201);
    %PP(:,:,:)=[P ones(1201, 1201)];
    a1(:,:)=sum(D,1);
    a2=0.5*wo/wx*wo/wy*exp(-pi*y.^2/wy^2)'*sum(a1,1);
    I(:,:,i)=a2;
end
%%
A(:,:)=abs(I(round(aa/2),:,:));
for i=1:size(A,2)
    A(:,i)=A(:,i)/max(A(:,i));
end
figure();
imagesc(x,z2,(A'));
%imagesc(x,y,I(:,:,14))
%plot(z3,z3.*f1./f2);


