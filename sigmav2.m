
function [UR,ZI]=sigmav2(UU,bins,press)
% This function puts velocity data from an ADCP into a sigma-coordinate
% system.
% 
% Inputs are:
% UU = velocity 
% bins = depth of each bin
% press = pressure time series measured at the ADCP head
%
%* pressure is optional. If there is no pressure passed into the function
% then depth will be calculated by bins. This is less optimal but works when
% pressure data isn't available
%
% outputs are:
% UR = interpolated velocity values into sigma co-ordinate grid
% Zi = the depth of the sigma-coordinate bins


n = length(UU);
if exist('press','var')
    for i=1:n
            k = find(isfinite(UU(:,i))); % Checks each time step and see if there is good data
            
            if (length(k>=6)) && isfinite(press(i)) % If there is at least 6 bins of good data
        
                ibad= find(~isfinite(UU(1:k(end),i))); %finds any bad data in the column of good data
        
                if(length(ibad>=1))
                    UU(ibad,i)=interp1(bins(k),UU(k,i),bins(ibad)); % interperates across bad bins
                end
                dz= press(i)/50;
                zi= [0:dz:press(i)];
                ztop= press(i)-bins(k(end));
                  
                ZBINS=[bins(1)/2 bins(1:k(end)) bins(k(end))+ztop/2];
                UUU=[UU(1,i)/2; UU(1:k(end),i); UU(k(end),i)]; %adds a bottom bin and top bin with values u/2 and u
                   
                UR(:,i)=interp1(ZBINS,UUU,zi,'linear','extrap'); % interpolates lower and upper values linearly (may not be the best method)
            
                ZI(1:51,i)=zi;
            else
                UR(1:51,i)=NaN;
                ZI(1:51,i)=NaN;
            end
        end
else %If pressure data does not exsist then depth is interpolated from the bins. This is less ideal
    for i=1:n
        k=find(isfinite(UU(:,i)));
            if (length(k>=6))
                ibad= find(~isfinite(UU(1:k(end),i)));
                if (length(ibad>=1))
                    UU(ibad,i)=interp1(bins(k),UU(k,i),bins(ibad));
                end
                dz=(bins(k(end))-bins(1))/50;
                zi=bins(1):dz:bins(k(end));
                UR(:,i)=interp1(bins(1:k(end)),UU(1:k(end),i),zi,'linear','extrap'); % once again linera interpolation 
                ZI(1:51,i)=zi;
            else
                UR(1:51,i)=NaN;
                ZI(1:51,i)=NaN;
            end

    end
    
end

