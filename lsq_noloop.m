function [B Ym Yerr]=lsq_noloop(tm,om,H);
X=exp(1i*om'*tm);
D=[ones(length(tm),1),real(X)' imag(X)']; % makes the first row vector
DD=D'*D; % creates the square matrix
Y=sum(D.*H')';
B=DD\Y;
Ym=sum(D'.*B); % model of our 
Yerr=H-Ym;



