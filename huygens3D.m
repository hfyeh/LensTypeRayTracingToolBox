function [sdata] = huygens3D(sdata, nout, thickness, d)
normal = [0 0 -1];
ki_tang = [sdata.k(1:2) 0];

if nargin == 4
    gradn = [sdata.grad_n 0];
    ko_tang = ki_tang+gradn*d;
else
    ko_tang = ki_tang;
end
kout = ko_tang + sqrt(nout^2-(norm(ko_tang))^2)*normal;
if ~isreal(kout)
    disp('Total reflection exists, rays perform total reflection are reset to zero incident!!!');
    kout = [0 0 -nout];
end
sdata.k = kout;

t = -thickness/kout(3);
kout = kout*t;
sdata.r = sdata.r + kout(1:2);