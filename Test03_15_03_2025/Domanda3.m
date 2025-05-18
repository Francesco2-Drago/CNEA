clear
close all
clc

condA = 1e10;
bNorm = 10;
resNorm = 1e-11;

errRelStima = condA * (resNorm / bNorm)