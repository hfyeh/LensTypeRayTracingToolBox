function [d] = rotation(azimuthal, declination, d0)
% Find director unit vector in world coordinate by giving
% 1. Director azimuthal angle
% 2. Director declination angle
% 本函數有兩種用法
% 第一種:輸入方位角和傾角,可以得出從[1 0 0]起始向量旋轉後的向量,方法是先對y軸轉,再轉z軸
% 第二種:若多輸入起始向量,則declination必須為0,不然會轉錯,這種模式只對z軸作旋轉
if nargin < 3
    d0 = [1 0 0]';
    declination = -declination; % 對-y轉動
else
    d0 = d0';
    if declination ~= 0
        error('Declination angle must be zero for this mode!');
    end
end
T = [cosd(declination)*cosd(azimuthal) -sind(azimuthal) sind(declination)*cosd(azimuthal); ...
        cosd(declination)*sind(azimuthal) cosd(azimuthal) sind(azimuthal)*sind(declination); ...
        -sind(declination) 0 cosd(declination)];
d =T*d0;
d = d';