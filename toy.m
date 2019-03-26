tic;
clear;
n = 1000;
sep1=linspace(0.2,5,25);
for kk=1:25
    sep=sep1(kk);
    r1 = 10; r2 =15;
    r = sqrt(r1^2+(r2^2-r1^2)*rand(1,n));
    t = 2*pi*rand(1,n);
    x = r.*cos(t);
    y = abs(r.*sin(t))+2.5;
    plot(x,y,'r o')
    hold on

    x1 = r.*cos(t)+12.5;
    y1 = -abs(r.*sin(t))-2.5;
    plot(x1,y1,'b o')
    axis equal
    traindata1=cat(1,x.',x1.');
    traindata2=cat(1,y.',y1.');
    traindata3=cat(2,traindata1,traindata2);
    traindata(:,1)=repmat(1,2000,1);
    traindata(:,2)=traindata3(:,1);
    traindata(:,3)=traindata3(:,2);
    A=repmat(1,1000,1);
    B=repmat(-1,1000,1);
    trainlabel=cat(1,A,B);
    % PLA train
    syms x
    flag=0;
    flag1=1;
    flag2=0;
    flag7=0;
    w=[0 0 0];
    while flag1~=0
        flag1=0;
        flag=0;
        for j1=1:2000 %hang
            if sign(sum(traindata(j1,:).*w))==trainlabel(j1)
                flag=flag+1;
                if flag==2000
                    flag1=0;
                    break;
                else
                    continue;
                end
            else
                flag1=flag1+1;
                flag2=flag2+1;
                w=w+traindata(j1,:)*trainlabel(j1);      
            end
        end
    end
%     syms x1 x2
%     Xs=[1 x1 x2];
%     f=sum(w.*Xs); 
%     fimplicit(f,'m')

    iter(kk)=flag2;
end
cc=linspace(1,25,25);
plot(cc,iter,'r')

% [a b c d e]=regress(ones(length(traindata2),1),traindata2);
% syms t
% y=a*t;
% fplot(y) %linear regress

    
    







toc;