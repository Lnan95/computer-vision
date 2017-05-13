clear all;  
close all;  
% �������Ե�ĸ�˹�˲�����Ӧ�ĵ��ķ���һ  
originimg=imread('superman.png');
originimg=rgb2gray(originimg);
[ori_row,ori_col]=size(originimg);  
  
sigma = 1.6;      %sigma��ֵ  
N = 1;            %��С�ǣ�2N+1������2N+1��  
N_row = 2*N+1;  
  
OriImage_noise = imnoise(originimg,'gaussian'); %����  
  
gausFilter = fspecial('gaussian',[N_row N_row],sigma);      %matlab �Դ���˹ģ���˲�  
blur=imfilter(OriImage_noise,gausFilter,'conv');  
  
H = [];                                        %���˹ģ��H  
for i=1:N_row  
    for j=1:N_row  
        fenzi=double((i-N-1)^2+(j-N-1)^2);  
        H(i,j)=exp(-fenzi/(2*sigma*sigma))/(2*pi*sigma);  
    end  
end  
H=H/sum(H(:));              %��һ��  
  
desimg=OriImage_noise;            %�˲���ͼ��  

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
  
  
subplot(2,2,1);imshow(originimg);title('ԭͼ');  
subplot(2,2,2);imshow(OriImage_noise);title('����ͼ');  
subplot(2,2,3);imshow(desimg);title('myself��˹�˲�');  
subplot(2,2,4);imshow(blur);title('matlab��˹�˲�');  