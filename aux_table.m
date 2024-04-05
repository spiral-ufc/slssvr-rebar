%% Local Sparse LSSVR Model for Predicting Mechanical Properties in Rebar Manufacturing

close all;          % Close all windows
clear;          % Clear all variables
clc;            % Clear command window
format short;  % Output data style (float)


r_squared_1 = load('results/locallssvr_r_squared_1.dat');
r_squared_2 = load('results/locallssvr_r_squared_2.dat');
r_squared_3 = load('results/locallssvr_r_squared_3.dat');
r_squared_4 = load('results/locallssvr_r_squared_4.dat');

number_of_operations_1 = load('results/locallssvr_number_of_operations_1.dat');
number_of_operations_2 = load('results/locallssvr_number_of_operations_2.dat');
number_of_operations_3 = load('results/locallssvr_number_of_operations_3.dat');
number_of_operations_4 = load('results/locallssvr_number_of_operations_4.dat');

time_of_operations_1 = load('results/locallssvr_time_of_operations_1.dat');
time_of_operations_2 = load('results/locallssvr_time_of_operations_2.dat');
time_of_operations_3 = load('results/locallssvr_time_of_operations_3.dat');
time_of_operations_4 = load('results/locallssvr_time_of_operations_4.dat');

r_squared_1s = load('results/slocallssvr_r_squared_1.dat');
r_squared_2s = load('results/slocallssvr_r_squared_2.dat');
r_squared_3s = load('results/slocallssvr_r_squared_3.dat');
r_squared_4s = load('results/slocallssvr_r_squared_4.dat');

number_of_operations_1s = load('results/slocallssvr_number_of_operations_1.dat');
number_of_operations_2s = load('results/slocallssvr_number_of_operations_2.dat');
number_of_operations_3s = load('results/slocallssvr_number_of_operations_3.dat');
number_of_operations_4s = load('results/slocallssvr_number_of_operations_4.dat');

time_of_operations_1s = load('results/slocallssvr_time_of_operations_1.dat');
time_of_operations_2s = load('results/slocallssvr_time_of_operations_2.dat');
time_of_operations_3s = load('results/slocallssvr_time_of_operations_3.dat');
time_of_operations_4s = load('results/slocallssvr_time_of_operations_4.dat');
%%
clc
mean(r_squared_1(:,1), 1) 
std(r_squared_1(:,1),0, 1)

mean(r_squared_2(:,1), 1) 
std(r_squared_2(:,1),0, 1)

mean(r_squared_3(:,1), 1) 
std(r_squared_3(:,1),0, 1)

mean(r_squared_4(:,1), 1) 
std(r_squared_4(:,1),0, 1)
%%
clc
mean(r_squared_1s(:,1), 1) 
std(r_squared_1s(:,1),0, 1)

mean(r_squared_2s(:,1), 1) 
std(r_squared_2s(:,1),0, 1)

mean(r_squared_3s(:,1), 1) 
std(r_squared_3s(:,1),0, 1)

mean(r_squared_4s(:,1), 1) 
std(r_squared_4s(:,1),0, 1)
%%
clc
mean(r_squared_1s(:,2), 1) 
std(r_squared_1s(:,2),0, 1)
mean(number_of_operations_1s(:,2), 1) 
std(number_of_operations_1s(:,2),0, 1)

mean(r_squared_2s(:,2), 1) 
std(r_squared_2s(:,2),0, 1)
mean(number_of_operations_2s(:,2), 1) 
std(number_of_operations_2s(:,2),0, 1)

mean(r_squared_3s(:,2), 1) 
std(r_squared_3s(:,2),0, 1)
mean(number_of_operations_3s(:,2), 1) 
std(number_of_operations_3s(:,2),0, 1)

mean(r_squared_4s(:,2), 1) 
std(r_squared_4s(:,2),0, 1)
mean(number_of_operations_4s(:,2), 1) 
std(number_of_operations_4s(:,2),0, 1)
%%
clc
mean(r_squared_1s(:,10), 1) 
std(r_squared_1s(:,10),0, 1)
mean(number_of_operations_1s(:,10), 1) 
std(number_of_operations_1s(:,10),0, 1)

mean(r_squared_2s(:,10), 1) 
std(r_squared_2s(:,10),0, 1)
mean(number_of_operations_2s(:,10), 1) 
std(number_of_operations_2s(:,10),0, 1)

mean(r_squared_3s(:,10), 1) 
std(r_squared_3s(:,10),0, 1)
mean(number_of_operations_3s(:,10), 1) 
std(number_of_operations_3s(:,10),0, 1)

mean(r_squared_4s(:,10), 1) 
std(r_squared_4s(:,10),0, 1)
mean(number_of_operations_4s(:,10), 1) 
std(number_of_operations_4s(:,10),0, 1)



