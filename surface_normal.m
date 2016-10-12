% Find surface normal at single point in lens
function [sdata] = surface_normal(sdata, R, base, slp, hslp, position, cosine, sine)
% Position relative to lens' left edge
position = mod(position,hslp)*cosine;
% Lens center
slp2 = slp/2;
% Generalized for elliptical lens and parabolic lens, for future use.
%{
if length(R) == 1
    % Generalized for elliptical lens, for future use.
    a=R;
    b=R;

    y0 = position - slp2;
    y1 = y0+0.0001;
    z0 = b*sqrt(1-(y0/a)^2);
    z1 = b*sqrt(1-(y1/a)^2);
    z_bottom = b*sqrt(1-(slp2/a)^2);
else
    a=R(1);
    c=R(2);
    
    y0 = position - slp2;
    z0 = a*(y0)^2 + c;
    z_bottom = a*(slp2)^2 + c;
    
    y1 = y0+0.0001;
    z1 = a*(y1)^2 + c;
end
%}
y0 = position - slp2;
y1 = y0+0.0001;
z0 = R*sqrt(1-(y0/R)^2);
z1 = R*sqrt(1-(y1/R)^2);
z_bottom = R*sqrt(1-(slp2/R)^2);

% Surface normal of lens in lens coordinate
normal_in_lens = [(z1-z0) 0 -(y1-y0)];%*10000;
normal_in_lens = normal_in_lens/norm(normal_in_lens);

% Transform to world coordinate
%normal_in_lens = [normal_in_lens(1)*cosine, normal_in_lens(1)*sine, normal_in_lens(3)];
normal_in_lens = [normal_in_lens(1)*cosine, normal_in_lens(1)*sine, normal_in_lens(3)];
% Transform from world coordinate to pixel coordinate
%[normal] = world2pixel(normal_in_lens);
normal = [-normal_in_lens(2) normal_in_lens(1) normal_in_lens(3)];
% The height is defined from lens top to base bottom, this value is same
% for all cooridnate
height = (z0-z_bottom) + base;

% Store back to sdata
sdata.normal = normal;
sdata.height = height;