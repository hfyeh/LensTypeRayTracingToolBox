function [k, L_k, k_log, L_k_log] = spatial_frequency(L_map, VD, hslp, horizontal_N, cutoff_L, cutoff_f)

[ix,iy] = size(L_map);
tot = ix*iy;
L_k = fft2(L_map);
L_k = fftshift(L_k);
L_k = L_k/tot;

% Unit conversion
%per_deg_const =  VD*10000*tand(1)/hslp/horizontal_N;
per_deg_const = 1/atand((hslp*horizontal_N/2)/VD)/2;

center = abs(L_k(fix(ix/2)+1,fix(iy/2)+1));
L_k(fix(ix/2+1),fix(iy/2+1)) = 0.0000001;
for i=1:ix
    for j=1:iy
        L_k(i,j) = abs(L_k(i,j))/center;
        k(i,j) = norm([i-fix(ix/2+1),j-fix(iy/2+1)]);
    end
end

k = k*per_deg_const;

% Convert matrix to array
k = k(:);
L_k = L_k(:);

% Natural log
k_log = log(k);
L_k_log = -log(L_k);

% Find L_k that is smaller than cutoff_L;
position = find(L_k_log<cutoff_L);

k = k(position);
L_k = L_k(position);
k_log = k_log(position);
L_k_log = L_k_log(position);

position = find(k<cutoff_f);

k = k(position);
L_k = L_k(position);
k_log = k_log(position);
L_k_log = L_k_log(position);