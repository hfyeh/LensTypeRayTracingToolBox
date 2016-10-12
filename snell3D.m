% =========================================================================
% 3-dimensional Snell's law
% =========================================================================
% 這個程式只能處理 isotropic-isotropic, isotropic-anisotropic, anisotropic-isotropic三種情況
% 光由介質一入射到介質二
% 介質二若為anisotropic則nout為1x2陣列,置入[ne, no]
% 若為isotropic則放該層折射率n
% Perform refraction and transmission in the sitation mentioned above
% Input: 1. sdata in media 1
%        2. normal vector of the interface
%        3. thickness in media 2
%        4. refractive index of media 2 (if anisotropic, input 1x2 array)
% Output: sdata in media 2
function [sdata] = snell3D(sdata, normal, thickness, nout, d)

% 入射光在介面的分量
%ki_tang = sdata.k - dot(sdata.k,normal)*normal;
ki_tang = sdata.k - sum(sdata.k.*normal)*normal;

% 判斷介質二為均向或非均向
if length(nout)>1 && nout(2) ~= nout(1)
    % 非均向
    nz = dot(normal,d);
    ki_tangz = dot(ki_tang,d);
    A1 = nz^2;
    A2 = norm(cross(normal,d))^2;
    B1 = 2*nz*ki_tangz;
    B2 = norm(ki_tang+normal)^2 - norm(ki_tang)^2 - 1 - B1;
    C1 = ki_tangz^2;
    C2 = norm(cross(ki_tang,d))^2;
    A = A1/nout(2)^2+A2/nout(1)^2;
    B = B1/nout(2)^2+B2/nout(1)^2;
    C = C1/nout(2)^2+C2/nout(1)^2-1;
    kout = ki_tang + (-B+sqrt(B^2-4*A*C))/2/A*normal;
else
    % 均向
    kout = ki_tang + sqrt(nout(1)^2-(norm(ki_tang))^2)*normal;
end

% 全反射發生時,程式輸出訊息,程式中止(應避免全反射發生)
if ~isreal(kout)
    error('Total reflection exists, rays perform total reflection are reset to zero incident!!!');
end

% 存入介質二中的波向量
sdata.k = kout;

% 利用介質二的波向量計算光在介質二中的位置變化,並將光在介質二底部的位置儲存
t = -thickness/kout(3);
kout = kout*t;
sdata.r = sdata.r + kout(1:2);