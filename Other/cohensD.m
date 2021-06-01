function d = cohensD(a,b)
d = (mean(b) - mean(a))/sqrt(((std(a)^2) + (std(b)^2))/2);
end