function [xrot yrot] = vecrot(x,y,deg) 
%
%   [xrot yrot] = vecrot(x,y,deg) 
%
%  Performs counter clockwise vector rotation in cartesian space. 
%
%   Input   - x = vector array of x-coordinates to rotate.
%           - y = vector array of y-coordinates to rotate.
%           - deg = degrees of COUNTERCLOCKWISE rotation in decimal degrees. 
%   Output  - 2-D arrays of rotated vectors [xrot yrot]
%
% Could add a case function for rads or degrees:

xrot = x*cos(deg*pi/180) - y*sin(deg*pi/180);
yrot = y*cos(deg*pi/180) + x*sin(deg*pi/180);

end