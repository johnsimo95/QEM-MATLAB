clear;clc;
l=2.5e-12;
z1=0.3e-6;
wo=7000e-9;   %10 micron
ro=-200e-6;   %0.55e-6
lo=500e-9;    %50 nm
d1=3.2e-10;
d2=3.2e-10;
z2=0.3e-6:1e-6:300e-6;  %0.0025e-6
x=(0:5:5000)*1e-9;
y=(0:5:5000)*1e-9;
aa=size(x,2);
for i=1:size(z2,2)
    z12=z2(i)-z1;
    wx=wo*((1+z2(i)/ro)^2+((l*z2(i))/(wo*lo))^2)^0.5;
    wxm(i)=wx;
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
    a1(:,:)=sum(D,1);
    a2=0.5*wo/wx*wo/wy*exp(-pi*y.^2/wy^2)'*sum(a1,1);
    I(:,:,i)=a2;
end
%%
%A(:,:)=abs(I(round(aa/2),:,:));
A(:,:)=abs(I(1,:,:));
for i=1:size(A,2)
    tt(i)=max(A(:,i));
    A(:,i)=A(:,i)/max(A(:,i));
end
imagesc(x,z2,(A'));
l=A(:,end-200:end);
for i=1:201
    K(i)=(max(l(:,i))-min(l(:,i)))/(max(l(:,i))+min(l(:,i)));
end
%plot(K)
%hold on;

