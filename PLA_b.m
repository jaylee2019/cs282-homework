tic;
%% plot train set 
% a=[];
% b=[];
% flag3=0;
% flag4=0;
% for k=1:400
%     if trainlabel1(k)==1
%         flag3=flag3+1;
%         a(flag3,:)=traindata1(k,:);
%     else
%         flag4=flag4+1;
%         b(flag4,:)=traindata1(k,:);
%     end
% end
% figure(3)        
% plot(a(:,1),a(:,2),'o r')
% hold on
% plot(b(:,1),b(:,2),'+ g')
% hold on
%% plot test set
% c=[];
% d=[];
% flag5=0;
% flag6=0;
% for k=1:100
%     if testlabel1(k)==1
%         flag5=flag5+1;
%         c(flag5,:)=testdata1(k,:);
%     else
%         flag6=flag6+1;
%         d(flag6,:)=testdata1(k,:);
%     end
% end
%         
% plot(c(:,1),c(:,2),'* b')
% hold on
% plot(d(:,1),d(:,2),'v c')
% hold on
plot(testdata1(:,1),testdata1(:,2),'*')
hold on
%% PLA train
syms x

flag=0;
flag1=1;
flag2=0;
for i=1:400
    if trainlabel1(i)==0
        trainlabel1(i)=-1;
    else
        continue;
    end
end

w=[1 1];
w1=[];
q=zeros;
p=zeros;
h=zeros;
r=zeros;
flag9=0;
w2=[];
errorset=[];
errorlabel=zeros;
n=1000;
for j=1:n
    h(j)=j;
    flag1=0;
    flag=0;
    for j1=1:400 %hang
        if sign(sum(traindata1(j1,:).*w))==trainlabel1(j1)
            flag=flag+1;
        else           
            flag1=flag1+1;
            flag9=flag9+1;%number of iteration
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
    if flag~=400
        r=unidrnd(flag1);
        w=w+errorset(r,:)*errorlabel(r);
        w2(j,:)=w; 
        continue;
    end
end
f=-w1(1)*x/w1(2); 
fplot(f,'m')
%% Ein

        
figure(4)
Ein1=p./400;
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
        

    
    
plot(h,Ein1)
xlabel('iteration')
ylabel('Ein')
            
toc;