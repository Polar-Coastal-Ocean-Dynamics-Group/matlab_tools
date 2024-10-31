%function [time,amp,phase]=dmod(x,t,per1,per2,ns)
%per1 is the period of demodulation for M2 12.4206/24
%per2 is the period of the filter and > p1 ---but in number of data points
% ns window width and bigger than per2
       function [time,amp,phase]=dmod(x,t,per1,per2,ns)
       om1=2*pi/per1;
       om2=2*pi/per2;
       x1= x.*cos(om1*t)*2;
       x2=-x.*sin(om1*t)*2;     
       h1=lanczos(ns,om2);
       d1=conv(h1,x1);
       d2=conv(h1,x2);
       a=sqrt(d1.^2+d2.^2);
       p=atan2(d2,d1);
       n=length(a);
       amp=a(2*ns+1:n-2*ns);
       time=t(ns+1:length(t)-ns);
       phase=p(2*ns+1:n-2*ns);
       