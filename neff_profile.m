function [n]= neff_profile(ne, no, qin, N_x, N_y, N_z, k)
    temp = zeros(size(N_z));
    numel_z = size(N_z,1);
    numel_x = size(N_z,2);
if nargin == 7
    for i=1:numel_z
        for j=1:numel_x
            d = [N_x(i,j), N_y(i,j), N_z(i,j)];
            k = k/norm(k);
            dot_k_d = dot(k,d);
            temp(i,j) = ne*no/sqrt( no^2*(1-(dot_k_d)^2) + (ne*dot_k_d)^2);
        end
    end
    n = sum(temp)/numel_z;
elseif nargin == 6
    k = [sin(qin) 0 cos(qin)];
    for i=1:numel_z
        for j=1:numel_x
            d = [N_x(i,j), N_y(i,j), N_z(i,j)];
            dot_k_d = dot(k,d);
            temp(i,j) = ne*no/sqrt( no^2*(1-(dot_k_d)^2) + (ne*dot_k_d)^2);
        end
    end
    n = sum(temp)/numel_z;
elseif nargin == 3
    k = [sin(qin) 0 cos(qin)];
    d = [0 0 1];
    dot_k_d = dot(k,d);
	n = ne*no/sqrt( no^2*(1-(dot_k_d)^2) + (ne*dot_k_d)^2);
end