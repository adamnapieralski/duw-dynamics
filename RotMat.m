function [R]=RotMat(fi)
% macierz rotacji

R=[cos(fi), -sin(fi);
    sin(fi), cos(fi)];