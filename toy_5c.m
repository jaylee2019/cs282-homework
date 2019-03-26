tic;
clear;
n = 1000;
sep=-5;
r1 = 10; r2 =15;
r = sqrt(r1^2+(r2^2-r1^2)*rand(1,n));
t = 2*pi*rand(1,n);
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
traindata=cat(2,traindata3,traindata2);
traindata1=[];
traindata1(:,1)=repmat(1,2000,1);
traindata1(:,2)=traindata(:,1);
traindata1(:,3)=traindata(:,2);

A=repmat(1,1000,1);
B=repmat(-1,1000,1);
trainlabel1=cat(1,A,B);
% Pocket train
syms x

flag=0;
flag1=1;
flag2=0;
w=[0 0 0];
w1=[];
q=zeros;
p=zeros;
h=zeros;
r=zeros;
w2=[];
errorset=[];
errorlabel=zeros;
n=10000;
for j=1:n
    h(j)=j;
    flag1=0;
    flag=0;
    for j1=1:2000 %hang
        if sign(sum(traindata1(j1,:).*w))==trainlabel1(j1)
            flag=flag+1;
        else           
            flag1=flag1+1;
            errorset(flag1,:)=traindata1(j1,:);
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
Xs=[1 x1 x2];
f=sum(w1.*Xs); 
fimplicit(f,'m')
hold on
% Ein

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
for hh=1:1000
    Ein2(hh)=Ein1(hh);
end
hhh=linspace(1,1000,1000);
plot(hhh,Ein2)
xlabel('iteration')
ylabel('Ein')


    
    







toc;