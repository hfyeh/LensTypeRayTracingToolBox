function [ img ] = rgb2lum( img, gamma )
img = (double(img)./255).^2.2;
end