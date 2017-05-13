clear all;  
close all;  
% 不处理边缘的高斯滤波，对应文档的方案一  
originimg=imread('superman.png');
originimg=rgb2gray(originimg);
[ori_row,ori_col]=size(originimg);  
  
sigma = 1.6;      %sigma赋值  
N = 1;            %大小是（2N+1）×（2N+1）  
N_row = 2*N+1;  
  
OriImage_noise = imnoise(originimg,'gaussian'); %加噪  
  
gausFilter = fspecial('gaussian',[N_row N_row],sigma);      %matlab 自带高斯模板滤波  
blur=imfilter(OriImage_noise,gausFilter,'conv');  
  
H = [];                                        %求高斯模板H  
for i=1:N_row  
    for j=1:N_row  
        fenzi=double((i-N-1)^2+(j-N-1)^2);  
        H(i,j)=exp(-fenzi/(2*sigma*sigma))/(2*pi*sigma);  
    end  
end  
H=H/sum(H(:));              %归一化  
  
desimg=OriImage_noise;            %滤波后图像  

for ai=N+1:ori_row-N-1  
    for aj=N+1:ori_col-N-1  
        temp=0;  
        for bi=1:N_row  
            for bj=1:N_row  
                temp= temp+(desimg(ai+bi-N-1,aj+bj-N-1)*H(bi,bj));  
            end  
        end  
        desimg(ai,aj)=temp;  
    end  
end  
desimg=uint8(desimg);  
  
  
subplot(2,2,1);imshow(originimg);title('原图');  
subplot(2,2,2);imshow(OriImage_noise);title('噪声图');  
subplot(2,2,3);imshow(desimg);title('myself高斯滤波');  
subplot(2,2,4);imshow(blur);title('matlab高斯滤波');  