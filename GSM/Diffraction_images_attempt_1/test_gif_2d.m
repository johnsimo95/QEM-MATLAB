clear;clc;
x = 0:0.01:1;
xx= 0:0.01:1;
figure
filename = 'testAnimated.gif';
for n = 1:0.5:10
    for m=1:0.5:10;
y = x.^n+xx.^m;
imagesc(x,xx,y)
drawnow
frame = getframe(1);
im = frame2im(frame);
[A,map] = rgb2ind(im,256); 
	if m == 1 & n ==1;
		imwrite(A,map,filename,'gif','LoopCount',Inf,'DelayTime',0.1);
	else
		imwrite(A,map,filename,'gif','WriteMode','append','DelayTime',0.1);
    end
    end
end