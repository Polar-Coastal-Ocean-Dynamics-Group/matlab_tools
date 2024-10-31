function [UR,ZI]=sigma(UU,bins);
    
n=size(UU,2); % Original n=length(UU);
for i=1:n;
    k=find(isfinite(UU(:,i)));
    if(length(k>=6));
        ibad= find(~isfinite(UU(1:k(end),i)));
    if(length(ibad>=1));
        UU(ibad,i)=interp1(bins(k),UU(k,i),bins(ibad));
    end
%       dz=press(i)/50
        dz=(bins(k(end))-bins(1))/50;
%       zi=[0:dz:press(i)];
%        ztop=press(i)-bins(kend)
        zi=bins(1):dz:bins(k(end));
%        ZBINS=[bins(1)/2 bins(1:k(end)) bins(kend)+ztop/2]
%        UUU=[U(1)/2 ,UU(1:k(end),i), UU(k(end),i)]
        UR(:,i)=interp1(bins(1:k(end)),UU(1:k(end),i),zi);
%       UR(:,i)=interp1(ZBINS,UUU,zi);

        ZI(1:51,i)=zi;
    else
        UR(1:51,i)=NaN;
        ZI(1:51,i)=NaN;
    end

end
