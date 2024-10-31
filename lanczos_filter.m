function [tlow, xlow, xhi] = lanczos_filter(x,tm,hww,t_cut,f_samp)
% Applies a Lanczos filter to get low-passed data. Can be applied to
% time-series of sea surface height or currents.
%
% [tlow, xlow] = lanczos_filter(x,tm,ns,t_cut,f_samp)
%
% INPUTS 
% x: Raw time series of currents or sea surface elevation.
% tm: Time variable coresponding to x. 
% hww: Half window width for the lanczos filter. must be larger than om. 
% t_cut: Desired cut-off period. 32 hours is often good for seperating low
%        frequency signal from tidal signal.
% f_samp: Sampling frequency per hour. 
%
% OUTPUTS 
% tlow: New time varible with matching size for xlow.
% xlow: The low-passed data.
% xhi: the high-passed data determined by x-xlow.

    om = (2*pi)/(t_cut*f_samp);  % om = 2 pi over cut off period times sampling frequency per hour  

    omn = 2*pi/(2*hww+1);
    i = -hww:hww;
    h = sinc(om*i/pi).*sinc(omn*i/pi);
    h = h/sum(h); % h is the actual Lanczos filter that will be applied to the time series

    xlow = conv(x,h,'valid'); % performs a convolution of the filter, h, and the time series, x. The 'valid' input discards the edges which reduces the size of the low-passed data. 
    tlow = tm(hww+1:length(tm)-hww); % a new time variable is created to match the size of xlow

    xhi = x(hww+1:length(x)-hww) - xlow;
end