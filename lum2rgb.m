function [ img ] = lum2rgb( img )
img = uint8((img).^(1/2.2).*255);
end