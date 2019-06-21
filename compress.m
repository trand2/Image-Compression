clear;

x=imread('DSC_1179.tif');
x=double(x);

%2d-DCT
n=8;
C=zeros(n,n);

for i=1:n
  for j=1:n
    C(i,j)=cos((i-1)*(2*j-1)*pi/(2*n));
    j+=1;
  end
  i+=1;
end
C=sqrt(2/n)*C;
C(1,:)=C(1,:)/sqrt(2);

%Linear quantization
p=11;
Q=p*8./C;

B1=zeros(3280,4928);

for h=1:3
  for i=1:7:3272
   for j=1:7:4920
    
    x8=x(i:i+7,j:j+7,h);
    xc = x8-128;
    yq=C*xc*C';
    
    q=p*8./hilb(8);
    yq=round(yq./q);
    
    
    Ydq=yq.*q;
    Xdq=C'*Ydq*C;
    xe=Xdq+128;
    B1(i:i+7,j:j+7,h)=xe;
   end
  end
end
B1=uint8(B1);
imagesc(B1)
