clear;clc;
l=500e-9;
z1g=2e-3;
z2g=9e-3;
zend=20e-3;
wo=25e-6;   %Talbot-lau effects start showing up for wo>1000. Investigate later
ro=-20e-3;
lo=wo;   %limit coherence to suppress talbot and talbot-lau effects 
d1=10e-6;
d2=10e-6;
z_step=0.2e-3;
lim=500*1e-6;
x=linspace(-lim,lim,1024);
xstep=abs(x(1)-x(2));
y=linspace(-lim,lim,1024);
aa=size(x,2);
z1=0:z_step:z1g;
for i=1:size(z1,2)
    wx=wo*((1+z1(i)/ro)^2+((l*z1(i))/(wo*lo))^2)^0.5;
    wy=wo*((1+z1(i)/ro)^2+((l*z1(i))/(wo*lo))^2)^0.5;
    Ii(:,:,i)=wo/wx*wo/wy*exp(-pi*y.^2/wy^2)'*exp(-pi*x.^2/wx^2);
end
Ai(:,:)=abs(Ii(round(aa/2),:,:));
for i=1:size(Ai,2)
    Ai(:,i)=Ai(:,i)/max(Ai(:,i));
end
%%

z2=z1g:z_step:z2g;
mlim=1;
nlim=1;
coeff=[0.5,1,0.5];
for i=1:size(z2,2)
    z12=z2(i)-z1g;
    wx=wo*((1+z2(i)/ro)^2+((l*z2(i))/(wo*lo))^2)^0.5;
    wy=wo*((1+z2(i)/ro)^2+((l*z2(i))/(wo*lo))^2)^0.5;
    lx=wx/wo*lo;
    ly=wy/wo*lo;
    rx=z2(i)*((1+z2(i)/ro)^2+((l*z2(i))/(wo*lo))^2)/((z2(i)/ro)*(1+z2(i)/ro)+((l*z2(i))/(wo*lo))^2);
    rxo(i)=rx;
    ry=z2(i)*((1+z2(i)/ro)^2+((l*z2(i))/(wo*lo))^2)/((z2(i)/ro)*(1+z2(i)/ro)+((l*z2(i))/(wo*lo))^2);
    id=1;
    jd=1;
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
    I1(:,:,i)=a2;
end
%%
A1(:,:)=abs(I1(round(aa/2),:,:));
for i=1:size(A1,2)
    A1(:,i)=A1(:,i)/max(A1(:,i));
end
%figure();
%imagesc(x,z2,(A1'));
%imagesc(x,y,I(:,:,14))
%plot(z3,z3.*f1./f2);

%%
z3=z2g+z_step:z_step:zend;
for i=1:size(z3,2)
    z23=z3(i)-z2g;
    z13=z3(i)-z1g;
    wx=wo*((1+z3(i)/ro)^2+((l*z3(i))/(wo*lo))^2)^0.5;
    wy=wo*((1+z3(i)/ro)^2+((l*z3(i))/(wo*lo))^2)^0.5;
    lx=wx/wo*lo;
    ly=wy/wo*lo;
    rx=z3(i)*((1+z3(i)/ro)^2+((l*z3(i))/(wo*lo))^2)/((z3(i)/ro)*(1+z3(i)/ro)+((l*z3(i))/(wo*lo))^2);
    rxo(i)=rx;
    ry=z3(i)*((1+z3(i)/ro)^2+((l*z3(i))/(wo*lo))^2)/((z3(i)/ro)*(1+z3(i)/ro)+((l*z3(i))/(wo*lo))^2);
    im=1;
    jm=1;
    in=1;
    jn=1;
    for i1=-mlim:1:mlim
        for j1=-mlim:1:mlim
            for i2=-nlim:1:nlim
                for j2=-nlim:1:nlim
                    mav=(i1+j1)/2;
                    mdel=i1-j1;
                    nav=(i2+j2)/2;
                    ndel=i2-j2;
                    Df(im,jm,in,jn,:)=coeff(im)*coeff(jm)*coeff(in)*coeff(jn)*exp(-pi*(x-l*z23*(nav/d2+mav/d1*z13/z23)).^2/wx^2);
                    %D(im,jm,in,jn,:)=coeff(im)*coeff(jm)*coeff(in)*coeff(jn)*exp(-pi*(x-l*z23*nav/d2).^2/wx^2);
                    F(im,jm,in,jn,:)=exp(-2*pi*x*1i*(ndel/d2*(1-z23/rx)+mdel/d1*(1-z13/rx)));
                    %F(im,jm,in,jn,:)=exp(-2*pi*x*1i*(ndel/d2*(1-z23/rx)));
                    V(im,jm,in,jn)=exp(-pi*(l*z23*(ndel/d2+mdel/d1*z13/z23))^2/lx^2);
                    %V(im,jm,in,jn)=exp(-pi*(l*z23*ndel/d2)^2/lx^2);
                    P(im,jm,in,jn)=exp(2*pi*1i*l*z13/d1*mdel*(nav/d2+mav/d1)*(1-z13/rx))*exp(2*pi*1i*l*z23*ndel/d2*(mav/d1*(1-z13/rx)-nav*z23/d2/rx))*exp(2*pi*1i*ndel/d2*z23*l*(nav/d2));
                    %P(im,jm,in,jn)=exp(2*pi*1i*ndel/d2*z23*l*(nav/d2))*exp(-2*pi*1i*ndel/d2*nav/d2*l*z23*z23/rx);
                    I2(im,jm,in,jn,:)=Df(im,jm,in,jn,:).*F(im,jm,in,jn,:)*V(im,jm,in,jn)*P(im,jm,in,jn);
                    
                    jn=jn+1;
                end
                jn=1;
                in=in+1;
            end
            in=1;
            jm=jm+1;
        end
        jm=1;
        im=im+1;
    end
    %PP=zeros(9,1201,1201);
    %PP(:,:,:)=[P ones(1201, 1201)];
    a11(:,:,:,:)=sum(I2,1);
    a22(:,:,:)=sum(a11,1);
    a33(:,:)=sum(a22,1);
    a44=0.5*wo/wx*wo/wy*exp(-pi*y.^2/wy^2)'*sum(a33,1);
    If(:,:,i)=a44;
end
%%
Af(:,:)=abs(If(round(aa/2),:,:));
for i=1:size(Af,2)
    tt(i)=max(Af(:,i));
    Af(:,i)=Af(:,i)/max(Af(:,i));
end
%figure();
%imagesc(x,z3,(Af'));
%imagesc(x,y,I(:,:,14))
%plot(z3,z3.*f1./f2);

%%
At=[Ai A1 Af];
zt=[z1 z2 z3];
%imagesc(x/1e-6,zt/1e-3,At');
%plot(x(302:402)/1e6, At(302:402,180));
%imagesc(x,y,abs(If(:,:,40)));
fringe_im=If(501,820:1024,35);   %40 for 17, 35 for 16
plot(x(820:1024)*1e6,abs(fringe_im));
fft_im=fftshift(fft(fringe_im,1024));
k=linspace(-0.5/xstep,0.5/xstep,1024);
%figure();
plot(k,abs(fft_im));
[~,invper]=max(fft_im(540:end));
fringe_period=1e6/k(invper+540-1)
%imagesc(abs(fft_im));
%hold on;
%%
[xsize,zsize]=size(At);
At1=zeros(xsize,zsize);
% for i=1:zsize
%     At1(:,i)=At(:,i);
%     At1(:,21)=1;
%     At1(:,21+71)=1;
%     imagesc(x/1e-6,zt/1e-3,At1');
%     filename=sprintf('aa%d.jpg',i);
%     imwrite(At1,filename);
%     hold on;
%     pause(0.001);
% end
