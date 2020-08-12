clear;clc;
l=2.5e-12;
z1=2e-6;
z2=22e-6;
wo=120e-9;
ro=-30e-6;
lo=30e-9;
d1=3.2e-10;
d2=3.2e-10;
ff=0.5;
zstep=0.05e-6; 
z3=40.4e-6:zstep:44e-6;
%z3=22.01e-6:zstep:22.03e-6;
x=(0:0.05:200)*1e-9;  %limit these to 50 to just see the primary beam
y=(0:0.05:200)*1e-9;
aa=size(x,2);
for i=1:size(z3,2)
    z23=z3(i)-z2;
    z13=z3(i)-z1;
    wx=wo*((1+z3(i)/ro)^2+((l*z3(i))/(wo*lo))^2)^0.5;
    wy=wo*((1+z3(i)/ro)^2+((l*z3(i))/(wo*lo))^2)^0.5;
    lx=wx/wo*lo;
    ly=wy/wo*lo;
    rx=z3(i)*((1+z3(i)/ro)^2+((l*z3(i))/(wo*lo))^2)/((z3(i)/ro)*(1+z3(i)/ro)+((l*z3(i))/(wo*lo))^2);
    rxo(i)=rx;
    ry=z3(i)*((1+z3(i)/ro)^2+((l*z3(i))/(wo*lo))^2)/((z3(i)/ro)*(1+z3(i)/ro)+((l*z3(i))/(wo*lo))^2);
    mlim=1;
    nlim=1;
    im=1;
    jm=1;
    in=1;
    jn=1;
    coeff=[0.5,1,0.5];
    for i1=-mlim:1:mlim
        for j1=-mlim:1:mlim
            for i2=-nlim:1:nlim
                for j2=-nlim:1:nlim
                    mav=(i1+j1)/2;
                    mdel=i1-j1;
                    nav=(i2+j2)/2;
                    ndel=i2-j2;
                    D(im,jm,in,jn,:)=coeff(im)*coeff(jm)*coeff(in)*coeff(jn)*exp(-pi*(x-l*z23*(nav/d2+mav/d1*z13/z23)).^2/wx^2);
                    %D(im,jm,in,jn,:)=coeff(im)*coeff(jm)*coeff(in)*coeff(jn)*exp(-pi*(x-l*z23*nav/d2).^2/wx^2);
                    F(im,jm,in,jn,:)=exp(-2*pi*x*1i*(ndel/d2*(1-z23/rx)+mdel/d1*(1-z13/rx)));
                    %F(im,jm,in,jn,:)=exp(-2*pi*x*1i*(ndel/d2*(1-z23/rx)));
                    V(im,jm,in,jn)=exp(-pi*(l*z23*(ndel/d2+mdel/d1*z13/z23))^2/lx^2);
                    %V(im,jm,in,jn)=exp(-pi*(l*z23*ndel/d2)^2/lx^2);
                    P(im,jm,in,jn)=exp(2*pi*1i*l*z13/d1*mdel*(nav/d2+mav/d1)*(1-z13/rx))*exp(2*pi*1i*l*z23*ndel/d2*(mav/d1*(1-z13/rx)-nav*z23/d2/rx))*exp(2*pi*1i*ndel/d2*z23*l*(nav/d2));
                    %P(im,jm,in,jn)=exp(2*pi*1i*ndel/d2*z23*l*(nav/d2))*exp(-2*pi*1i*ndel/d2*nav/d2*l*z23*z23/rx);
                    I2(im,jm,in,jn,:)=D(im,jm,in,jn,:).*F(im,jm,in,jn,:)*V(im,jm,in,jn)*P(im,jm,in,jn);
                    
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
    a1(:,:,:,:)=sum(I2,1);
    a2(:,:,:)=sum(a1,1);
    a3(:,:)=sum(a2,1);
    a4=0.5*wo/wx*wo/wy*exp(-pi*y.^2/wy^2)'*sum(a3,1);
    I(:,:,i)=a4;
end
%%
A(:,:)=abs(I(1,:,:));
for i=1:size(A,2)
    A(:,i)=A(:,i)/max(A(:,i));
end
figure();
imagesc(x*1e9,z3*1e6,(A'));
imagesc(x,y,I(:,:,14))
%plot(z3,z3.*f1./f2);
%%

%A2(:,:)=abs(I(round(aa/2),:,:));
%figure();
%imagesc(x*1e9,z3*1e6,A2');
%imwrite(A','c:\\Users\\akshay\\Documents\\MATLAB\\GSM\\spot_images\\diff_zoom.jpg');



