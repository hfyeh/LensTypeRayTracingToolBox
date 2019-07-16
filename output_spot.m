function [Y, left_boundary, right_boundary] = output_spot(X, slp, T)

if length(T)<10
    T = ones(size(X));
end
T = T/length(T);

slp = round(slp);

max_value = max(X);
min_value = min(X);

leftside = 0;
rightside = slp;

for i=1:20
    if max_value > rightside || min_value < leftside
        leftside = leftside - 500;
        rightside = rightside + 500;
    end
end

Y=zeros((rightside-leftside)*10+1,2);
Y(:,1) = [leftside:0.1:rightside]';

spot = [accumarray(dsearchn(Y(:,1),X), T); 0];

left_boundary = min(Y(spot>0));
right_boundary = max(Y(spot>0));
left_n = find(Y(:,1)==left_boundary)-1;
right_n = find(Y(:,1)==right_boundary)+1;
if left_n == 0
    disp('s');
end
Y = [Y(left_n:right_n,1), spot(left_n:right_n)];

Y = Y';

%{
% Record value
for i=1:length(X)
    for j=1:Y_length
        if Y(j,1) == X(i);
            Y(j,2) = Y(2,j)+T(i);
        end
    end
end
%accumarray
%}

%{
Y=zeros(2,rightside-leftside+1);

% Record positions
Y(1,:) = [leftside:rightside];


% Record value
for i=1:length(X)
    for j=1:rightside-leftside+1
        if Y(1,j) == X(i);
            Y(2,j) = Y(2,j)+T(i);
        end
    end
end
%}
