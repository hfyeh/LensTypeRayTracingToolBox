function [d] = world2pixel(d0)
% Transform from world coordinate to pixel coordinate
%{
d(1) = -d0(2);
d(2) = d0(1);
d(3) = d0(3);
%}
d = [-d0(2) d0(1) d0(3)];