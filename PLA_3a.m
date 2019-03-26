tic;
%% plot train set 
% a=[];
% b=[];
% flag3=0;
% flag4=0;
% for k=1:400
%     if trainlabel(k)==1
%         flag3=flag3+1;
%         a(flag3,:)=traindata(k,:);
%     else
%         flag4=flag4+1;
%         b(flag4,:)=traindata(k,:);
%     end
% end
% figure(1)        
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
%     if testlabel(k)==1
%         flag5=flag5+1;
%         c(flag5,:)=testdata(k,:);
%     else
%         flag6=flag6+1;
%         d(flag6,:)=testdata(k,:);
%     end
% end
%         
% plot(c(:,1),c(:,2),'* b')
% hold on
% plot(d(:,1),d(:,2),'v c')
% hold on
plot(testdata(:,1),testdata(:,2),'*')
hold on
%% PLA train
syms x
flag=0;
flag1=1;
flag2=0;
flag7=0;
for i=1:400
    if trainlabel(i)==0
        trainlabel(i)=-1;
    else
        continue;
    end
end

w=[0 0];
Ein=zeros;
while flag1~=0
    flag1=0;
    flag=0;
    for j1=1:400 %hang
        if sign(sum(traindata(j1,:).*w))==trainlabel(j1)
            flag=flag+1;
            if flag==400
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
    flag7=flag7+1;
    Ein(flag7)=flag1;
end
f=-w(1)*x/w(2); 
fplot(f,'m')
figure(2)
l=size(Ein);
for v=1:max(l)
    vv(v)=v; %the numeber of iteration
end
Eins=Ein./400;
plot(vv,Eins)
xlabel('iteration')
ylabel('Ein')
            
toc;