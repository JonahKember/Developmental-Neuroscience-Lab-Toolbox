function y = heavi(x)
%% Heaviside Step Function
% For use in calculating directed PLI.

y = zeros(1,length(x));

for n = 1:length(x)
    if x(n) < 0
        y(n) = 0;
    elseif x(n) == 0
        y(n) = .5;
    elseif x(n) > 0
        y(n) = 1;
    end 
end
end