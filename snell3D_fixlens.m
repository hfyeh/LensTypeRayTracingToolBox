function [ sdata ] = snell3D_fixlens(sdata, normal, thickness, nout)

ki_tang = sdata.k - sum(sdata.k.*normal)*normal;

kout = ki_tang + sqrt(nout^2-(norm(ki_tang))^2)*normal;

sdata.k = kout;

t = -thickness/kout(3);
kout = kout*t;
sdata.r = sdata.r + kout(1:2);