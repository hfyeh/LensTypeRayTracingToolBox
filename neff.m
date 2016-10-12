% Find effective n
function [n]= neff(ne, no, d, k)
k = k/norm(k);
dot_k_d = dot(k,d);
n = ne*no/sqrt( no^2*(1-(dot_k_d)^2) + (ne*dot_k_d)^2);