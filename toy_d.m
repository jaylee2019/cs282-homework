tic;
clear;

n1 = 1000;
sep=-5;
r1 = 10; r2 =15;
r = sqrt(r1^2+(r2^2-r1^2)*rand(1,n1));
t = 2*pi*rand(1,n1);
x = r.*cos(t);
y = abs(r.*sin(t))+sep;
figure(1)
plot(x,y,'r o')
hold on

x1 = r.*cos(t)+12.5;
y1 = -abs(r.*sin(t));
plot(x1,y1,'b o')

traindata3=cat(1,x.',x1.');
traindata2=cat(1,y.',y1.');
traindata1=cat(2,traindata3,traindata2);
A=repmat(1,1000,1);
B=repmat(-1,1000,1);
trainlabel1=cat(1,A,B);
sigma=[];
sigma(:,1)=repmat(1,2000,1);
sigma(:,2)=traindata1(:,1);
sigma(:,3)=traindata1(:,1);
sigma(:,4)=traindata1(:,1).^2;
sigma(:,5)=traindata1(:,1).*traindata1(:,2);
sigma(:,6)=traindata1(:,2).^2; 
sigma(:,7)=traindata1(:,1).^3;
sigma(:,8)=traindata1(:,1).^2.*traindata1(:,2);
sigma(:,9)=traindata1(:,1).*traindata1(:,2).^2;
sigma(:,10)=traindata1(:,2).^3; 
%fourth order
% sigma(:,11)=traindata1(:,1).^4; 
% sigma(:,12)=traindata1(:,1).^3.*traindata1(:,2);
% sigma(:,13)=traindata1(:,1).^2.*traindata1(:,2).^2;
% sigma(:,14)=traindata1(:,1).*traindata1(:,2).^3;
% sigma(:,15)=traindata1(:,2).^4; 
% Pocket train
syms x

flag=0;
flag1=1;
flag2=0;
w=[0 0 0 0 0 0 0 0 0 0];
w1=[];
q=zeros;
p=zeros;
h=zeros;
r=zeros;
flag9=0;
w2=[];
errorset=[];
errorlabel=zeros;
n=100000;
for j=1:n
    h(j)=j;
    flag1=0;
    flag=0;
    for j1=1:2000 %hang
        if sign(sum(sigma(j1,:).*w))==trainlabel1(j1)
            flag=flag+1;
        else           
            flag1=flag1+1;
            flag9=flag9+1;%number of iteration
            errorset(flag1,:)=sigma(j1,:);
            errorlabel(flag1)=trainlabel1(j1);
        end
    end
    q(j)=flag;
    p(j)=flag1;
    if j==1
        w1=w;
    else
        if q(j)>q(j-1)
            w1=w;
        end
    end
    if flag~=2000
        r=unidrnd(flag1);
        w=w+errorset(r,:)*errorlabel(r);
        w2(j,:)=w; 
        continue;
    end
end
syms x1 x2
Xn=[1 x1 x2 x1^2 x1*x2 x2^2 x1^3 x1^2*x2 x1*x2^2 x2^3 ];
f=sum(w1.*Xn); 
fimplicit(f,'m')
hold on


Ein1=p./2000;
for i=1:n
    if i~=n
        if Ein1(i+1)<Ein1(i)
            Ein1(i+1)=Ein1(i+1);
        else
            Ein1(i+1)=Ein1(i);
        end
    else
        if Ein1(i)<Ein1(i-1)
            Ein1(i)=Ein1(i);
            break;
        else
            Ein1(i)=Ein1(i-1);
            break;
        end
    end
end
axis equal
figure(2)
for hh=1:100000
    Ein2(hh)=Ein1(hh);
end
hhh=linspace(1,100000,100000);
plot(hhh,Ein2)
xlabel('iteration')
ylabel('Ein')

% [a b c d e]=regress(ones(length(traindata2),1),traindata2);
% syms t
% y=a*t;
% fplot(y) %linear regress

    
    







toc;