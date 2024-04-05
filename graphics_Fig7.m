%% Local Sparse LSSVR Model for Predicting Mechanical Properties in Rebar Manufacturing
close all;          % Close all windows
clear;          % Clear all variables
clc;            % Clear command window



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



end_point = 10;
font_size = 16;
color_c = {'#77AC30', '#4DBEEE','#A2142F', '#EDB120'};
% for step=1:4
%     str = color_c{step};
%     color_c{step} = sscanf(str(2:end),'%2x%2x%2x',[1 3])/255;
% end
% number_of_sv = [660 850 610 640];

% f = figure;  
% f.Position = [10 10 1800 700]; 
% subplot(1,3,1)
% hold on
% yline(mean(r_squared_1(:,1), 1), '-','DisplayName','All SV (1040)')
% e = errorbar(mean(r_squared_1(:,1:end_point), 1), std(r_squared_1(:,1:end_point),0, 1),'.-', 'color',color_c{1},'DisplayName','FULL (1040 SV)');
% e.Line.LineWidth = 2;
% e.MarkerSize = 16;
% e = errorbar(mean(r_squared_1s(:,1:end_point), 1), std(r_squared_1s(:,1:end_point),0, 1),'.-', 'color',color_c{2},'DisplayName','SPARSE (660 SV)');
% e.Line.LineWidth = 2;
% e.MarkerSize = 16;
% ylabel('R^2');
% xlabel('Number of Partition');
% xticks(0:10)
% set(gca, 'FontName','Times New Roman', 'FontSize', font_size);
% 
% subplot(1,3,2)
% hold on
% e = errorbar(mean(number_of_operations_1(:,1:end_point), 1), std(number_of_operations_1(:,1:end_point),0, 1),'.-', 'color',color_c{1},'DisplayName','FULL (1040 SV)');
% e.Line.LineWidth = 2;
% e.MarkerSize = 16;
% e = errorbar(mean(number_of_operations_1s(:,1:end_point), 1), std(number_of_operations_1s(:,1:end_point),0, 1),'.-', 'color',color_c{2},'DisplayName','SPARSE (660 SV)');
% e.Line.LineWidth = 2;
% e.MarkerSize = 16;
% title('UTS')
% ylabel('Number of SV Used in the Prediction');
% xlabel('Number of Partition');
% xticks(0:10)
% set(gca, 'FontName','Times New Roman', 'FontSize', font_size);
% 
% subplot(1,3,3)
% hold on
% e = errorbar(mean(time_of_operations_1(:,1:end_point), 1), std(time_of_operations_1(:,1:end_point),0, 1),'.-', 'color',color_c{1},'DisplayName','FULL (1040 SV)');
% e.Line.LineWidth = 2;
% e.MarkerSize = 16;
% e = errorbar(mean(time_of_operations_1s(:,1:end_point), 1), std(time_of_operations_1s(:,1:end_point),0, 1),'.-', 'color',color_c{2},'DisplayName','SPARSE (660 SV)');
% e.Line.LineWidth = 2;
% e.MarkerSize = 16;
% ylabel('Time Spent in the Prediction');
% xlabel('Number of Partition');
% xticks(0:10)
% legend
% set(gca, 'FontName','Times New Roman', 'FontSize', font_size);
% 
% f = figure;  
% f.Position = [10 10 1800 700]; 
% subplot(1,3,1)
% hold on
% yline(mean(r_squared_2(:,1), 1), '-','DisplayName','All SV (1040)')
% e = errorbar(mean(r_squared_2(:,1:end_point), 1), std(r_squared_2(:,1:end_point),0, 1),'.-', 'color',color_c{1},'DisplayName','FULL (1040 SV)');
% e.Line.LineWidth = 2;
% e.MarkerSize = 16;
% e = errorbar(mean(r_squared_2s(:,1:end_point), 1), std(r_squared_2s(:,1:end_point),0, 1),'.-', 'color',color_c{2},'DisplayName','SPARSE (850 SV)');
% e.Line.LineWidth = 2;
% e.MarkerSize = 16;
% ylabel('R^2');
% xlabel('Number of Partition');
% xticks(0:10)
% set(gca, 'FontName','Times New Roman', 'FontSize', font_size);
% 
% subplot(1,3,2)
% hold on
% e = errorbar(mean(number_of_operations_2(:,1:end_point), 1), std(number_of_operations_2(:,1:end_point),0, 1),'.-', 'color',color_c{1},'DisplayName','FULL (1040 SV)');
% e.Line.LineWidth = 2;
% e.MarkerSize = 16;
% e = errorbar(mean(number_of_operations_2s(:,1:end_point), 1), std(number_of_operations_2s(:,1:end_point),0, 1),'.-', 'color',color_c{2},'DisplayName','SPARSE (850 SV)');
% e.Line.LineWidth = 2;
% e.MarkerSize = 16;
% title('YS')
% ylabel('Number of SV Used in the Prediction');
% xlabel('Number of Partition');
% xticks(0:10)
% set(gca, 'FontName','Times New Roman', 'FontSize', font_size);
% 
% subplot(1,3,3)
% hold on
% e = errorbar(mean(time_of_operations_2(:,1:end_point), 1), std(time_of_operations_2(:,1:end_point),0, 1),'.-', 'color',color_c{1},'DisplayName','FULL (1040 SV)');
% e.Line.LineWidth = 2;
% e.MarkerSize = 16;
% e = errorbar(mean(time_of_operations_2s(:,1:end_point), 1), std(time_of_operations_2s(:,1:end_point),0, 1),'.-', 'color',color_c{2},'DisplayName','SPARSE (850 SV)');
% e.Line.LineWidth = 2;
% e.MarkerSize = 16;
% ylabel('Time Spent in the Prediction');
% xlabel('Number of Partition');
% xticks(0:10)
% legend
% set(gca, 'FontName','Times New Roman', 'FontSize', font_size);
% 
% f = figure;  
% f.Position = [10 10 1800 700]; 
% subplot(1,3,1)
% hold on
% yline(mean(r_squared_3(:,1), 1), '-','DisplayName','All SV (1040)')
% e = errorbar(mean(r_squared_3(:,1:end_point), 1), std(r_squared_3(:,1:end_point),0, 1),'.-', 'color',color_c{1},'DisplayName','FULL (1040 SV)');
% e.Line.LineWidth = 2;
% e.MarkerSize = 16;
% e = errorbar(mean(r_squared_3s(:,1:end_point), 1), std(r_squared_3s(:,1:end_point),0, 1),'.-', 'color',color_c{2},'DisplayName','SPARSE (610 SV)');
% e.Line.LineWidth = 2;
% e.MarkerSize = 16;
% ylabel('R^2');
% xlabel('Number of Partition');
% xticks(0:10)
% set(gca, 'FontName','Times New Roman', 'FontSize', font_size);
% 
% subplot(1,3,2)
% hold on
% e = errorbar(mean(number_of_operations_3(:,1:end_point), 1), std(number_of_operations_3(:,1:end_point),0, 1),'.-', 'color',color_c{1},'DisplayName','FULL (1040 SV)');
% e.Line.LineWidth = 2;
% e.MarkerSize = 16;
% e = errorbar(mean(number_of_operations_3s(:,1:end_point), 1), std(number_of_operations_3s(:,1:end_point),0, 1),'.-', 'color',color_c{2},'DisplayName','SPARSE (610 SV)');
% e.Line.LineWidth = 2;
% e.MarkerSize = 16;
% title('UTS/YS')
% ylabel('Number of SV Used in the Prediction');
% xlabel('Number of Partition');
% xticks(0:10)
% set(gca, 'FontName','Times New Roman', 'FontSize', font_size);
% 
% subplot(1,3,3)
% hold on
% e = errorbar(mean(time_of_operations_3(:,1:end_point), 1), std(time_of_operations_3(:,1:end_point),0, 1),'.-', 'color',color_c{1},'DisplayName','FULL (1040 SV)');
% e.Line.LineWidth = 2;
% e.MarkerSize = 16;
% e = errorbar(mean(time_of_operations_3s(:,1:end_point), 1), std(time_of_operations_3s(:,1:end_point),0, 1),'.-', 'color',color_c{2},'DisplayName','SPARSE (610 SV)');
% e.Line.LineWidth = 2;
% e.MarkerSize = 16;
% ylabel('Time Spent in the Prediction');
% xlabel('Number of Partition');
% xticks(0:10)
% legend
% set(gca, 'FontName','Times New Roman', 'FontSize', font_size);
% 
% f = figure;  
% f.Position = [10 10 1800 700]; 
% subplot(1,3,1)
% hold on
% yline(mean(r_squared_4(:,1), 1), '-','DisplayName','All SV (1040)')
% e = errorbar(mean(r_squared_4(:,1:end_point), 1), std(r_squared_4(:,1:end_point),0, 1),'.-', 'color',color_c{1},'DisplayName','FULL (1040 SV)');
% e.Line.LineWidth = 2;
% e.MarkerSize = 16;
% e = errorbar(mean(r_squared_4s(:,1:end_point), 1), std(r_squared_4s(:,1:end_point),0, 1),'.-', 'color',color_c{2},'DisplayName','SPARSE (640 SV)');
% e.Line.LineWidth = 2;
% e.MarkerSize = 16;
% ylabel('R^2');
% xlabel('Number of Partition');
% xticks(0:10)
% set(gca, 'FontName','Times New Roman', 'FontSize', font_size);
% 
% subplot(1,3,2)
% hold on
% e = errorbar(mean(number_of_operations_4(:,1:end_point), 1), std(number_of_operations_4(:,1:end_point),0, 1),'.-', 'color',color_c{1},'DisplayName','FULL (1040 SV)');
% e.Line.LineWidth = 2;
% e.MarkerSize = 16;
% e = errorbar(mean(number_of_operations_4s(:,1:end_point), 1), std(number_of_operations_4s(:,1:end_point),0, 1),'.-', 'color',color_c{2},'DisplayName','SPARSE (640 SV)');
% e.Line.LineWidth = 2;
% e.MarkerSize = 16;
% title('PE')
% ylabel('Number of SV Used in the Prediction');
% xlabel('Number of Partition');
% xticks(0:10)
% set(gca, 'FontName','Times New Roman', 'FontSize', font_size);
% 
% subplot(1,3,3)
% hold on
% e = errorbar(mean(time_of_operations_4(:,1:end_point), 1), std(time_of_operations_4(:,1:end_point),0, 1),'.-', 'color',color_c{1},'DisplayName','FULL (1040 SV)');
% e.Line.LineWidth = 2;
% e.MarkerSize = 16;
% e = errorbar(mean(time_of_operations_4s(:,1:end_point), 1), std(time_of_operations_4s(:,1:end_point),0, 1),'.-', 'color',color_c{2},'DisplayName','SPARSE (640 SV)');
% e.Line.LineWidth = 2;
% e.MarkerSize = 16;
% ylabel('Time Spent in the Prediction');
% xlabel('Number of Partition');
% xticks(0:10)
% legend
% set(gca, 'FontName','Times New Roman', 'FontSize', font_size);
% 
% %%
% f = figure;
% % colororder({color_c{1},color_c{2}})
% yyaxis left
% hold on
% % yline(mean(r_squared_4(:,1), 1), '-','DisplayName','All SV (1040)')
% e = errorbar(mean(r_squared_4(:,1:end_point), 1), std(r_squared_4(:,1:end_point),0, 1),'.-', 'color',color_c{1},'DisplayName','FULL (1040 SV)');
% e.Line.LineWidth = 2;
% e.MarkerSize = 16;
% e = errorbar(mean(r_squared_4s(:,1:end_point), 1), std(r_squared_4s(:,1:end_point),0, 1),'.-', 'color',color_c{2},'DisplayName','SPARSE (640 SV)');
% e.Line.LineWidth = 2;
% e.MarkerSize = 16;
% ylabel('R^2');
% xlabel('Number of Partition');
% xticks(0:10)
% % ylim([0.6, 0.77])
% set(gca, 'FontName','Times New Roman', 'FontSize', font_size);
% 
% yyaxis right
% hold on
% e = errorbar(mean(number_of_operations_4(:,1:end_point), 1), std(number_of_operations_4(:,1:end_point),0, 1),'.-', 'color',color_c{3},'DisplayName','FULL (1040 SV)');
% e.Line.LineWidth = 2;
% e.MarkerSize = 16;
% e = errorbar(mean(number_of_operations_4s(:,1:end_point), 1), std(number_of_operations_4s(:,1:end_point),0, 1),'.-', 'color',color_c{4},'DisplayName','SPARSE (640 SV)');
% e.Line.LineWidth = 2;
% e.MarkerSize = 16;
% title('PE')
% ylabel('Number of SV Used in the Prediction');
% xlabel('Number of Partition');
% % ylim([0, 2000])
% xticks(0:10)
% set(gca, 'FontName','Times New Roman', 'FontSize', font_size);
% grid
% legend

%%
f = figure;  
f.Position = [10 10 700 760]; 
eachPlotHeightScale = 1.33333;
% myFig = figure 
pos = get(f,'Position');
sp1 = subplot(3,1,1);
hold on
% yline(mean(r_squared_4(:,1), 1), '-','DisplayName','All SV (1040)')
e = errorbar(mean(r_squared_1(:,1:end_point), 1), std(r_squared_1(:,1:end_point),0, 1),'.-', 'color',color_c{1},'DisplayName','FULL (1040 SV)');
e.Line.LineWidth = 2;
e.MarkerSize = 16;
e = errorbar(mean(r_squared_1s(:,1:end_point), 1), std(r_squared_1s(:,1:end_point),0, 1),'.-', 'color',color_c{2},'DisplayName','SPARSE (660 SV)');
e.Line.LineWidth = 2;
e.MarkerSize = 16;
ylabel('R^2');
% xlabel('Number of Partition');
title('UTS')
xticks(0:11)
set(gca, 'XTickLabel', {})
ylim([0.72, 0.88])
grid
set(gca, 'FontName','Times New Roman', 'FontSize', font_size);

sp2 = subplot(3,1,2);
hold on
e = errorbar(mean(number_of_operations_1(:,1:end_point), 1), std(number_of_operations_1(:,1:end_point),0, 1),'.-', 'color',color_c{1},'DisplayName','FULL (1040 SV)');
e.Line.LineWidth = 2;
e.MarkerSize = 16;
e = errorbar(mean(number_of_operations_1s(:,1:end_point), 1), std(number_of_operations_1s(:,1:end_point),0, 1),'.-', 'color',color_c{2},'DisplayName','SPARSE (660 SV)');
e.Line.LineWidth = 2;
e.MarkerSize = 16;
ylabel('Number of SV');
% xlabel('Number of Partition');
xticks(0:11)
set(gca, 'XTickLabel', {})
grid
set(gca, 'FontName','Times New Roman', 'FontSize', font_size);

sp3 = subplot(3,1,3);
hold on
e = errorbar(mean(time_of_operations_1(:,1:end_point), 1), std(time_of_operations_1(:,1:end_point),0, 1),'.-', 'color',color_c{1},'DisplayName','FULL (1040 SV)');
e.Line.LineWidth = 2;
e.MarkerSize = 16;
e = errorbar(mean(time_of_operations_1s(:,1:end_point), 1), std(time_of_operations_1s(:,1:end_point),0, 1),'.-', 'color',color_c{2},'DisplayName','SPARSE (660 SV)');
e.Line.LineWidth = 2;
e.MarkerSize = 16;
ylabel('Time Spent (s)');
xlabel('Number of Clusters (or Models)');
xticks(0:10)
grid
legend
set(gca, 'FontName','Times New Roman', 'FontSize', font_size);

sp3.Position = [sp3.Position(1:3), sp3.Position(4)*eachPlotHeightScale - 0.02];
sp2.Position = [sp2.Position(1), sp3.Position(2) + sp3.Position(4) + 0.02, sp2.Position(3), sp3.Position(4)] ;
sp1.Position = [sp1.Position(1), sp2.Position(2) + sp2.Position(4) + 0.02, sp1.Position(3), sp3.Position(4)];

f = figure;  
f.Position = [10 10 700 760]; 
eachPlotHeightScale = 1.33333;
% myFig = figure 
pos = get(f,'Position');
sp1 = subplot(3,1,1);
hold on
% yline(mean(r_squared_4(:,1), 1), '-','DisplayName','All SV (1040)')
e = errorbar(mean(r_squared_2(:,1:end_point), 1), std(r_squared_2(:,1:end_point),0, 1),'.-', 'color',color_c{1},'DisplayName','FULL (1040 SV)');
e.Line.LineWidth = 2;
e.MarkerSize = 16;
e = errorbar(mean(r_squared_2s(:,1:end_point), 1), std(r_squared_2s(:,1:end_point),0, 1),'.-', 'color',color_c{2},'DisplayName','SPARSE (850 SV)');
e.Line.LineWidth = 2;
e.MarkerSize = 16;
ylabel('R^2');
% xlabel('Number of Partition');
title('YS')
xticks(0:11)
set(gca, 'XTickLabel', {})
ylim([0.55, 0.85])
grid
set(gca, 'FontName','Times New Roman', 'FontSize', font_size);

sp2 = subplot(3,1,2);
hold on
e = errorbar(mean(number_of_operations_2(:,1:end_point), 1), std(number_of_operations_2(:,1:end_point),0, 1),'.-', 'color',color_c{1},'DisplayName','FULL (1040 SV)');
e.Line.LineWidth = 2;
e.MarkerSize = 16;
e = errorbar(mean(number_of_operations_2s(:,1:end_point), 1), std(number_of_operations_2s(:,1:end_point),0, 1),'.-', 'color',color_c{2},'DisplayName','SPARSE (850 SV)');
e.Line.LineWidth = 2;
e.MarkerSize = 16;
ylabel('Number of SV');
% xlabel('Number of Partition');
xticks(0:11)
set(gca, 'XTickLabel', {})
grid
set(gca, 'FontName','Times New Roman', 'FontSize', font_size);

sp3 = subplot(3,1,3);
hold on
e = errorbar(mean(time_of_operations_2(:,1:end_point), 1), std(time_of_operations_2(:,1:end_point),0, 1),'.-', 'color',color_c{1},'DisplayName','FULL (1040 SV)');
e.Line.LineWidth = 2;
e.MarkerSize = 16;
e = errorbar(mean(time_of_operations_2s(:,1:end_point), 1), std(time_of_operations_2s(:,1:end_point),0, 1),'.-', 'color',color_c{2},'DisplayName','SPARSE (850 SV)');
e.Line.LineWidth = 2;
e.MarkerSize = 16;
ylabel('Time Spent (s)');
xlabel('Number of Clusters (or Models)');
xticks(0:10)
grid
legend
set(gca, 'FontName','Times New Roman', 'FontSize', font_size);

sp3.Position = [sp3.Position(1:3), sp3.Position(4)*eachPlotHeightScale - 0.02];
sp2.Position = [sp2.Position(1), sp3.Position(2) + sp3.Position(4) + 0.02, sp2.Position(3), sp3.Position(4)] ;
sp1.Position = [sp1.Position(1), sp2.Position(2) + sp2.Position(4) + 0.02, sp1.Position(3), sp3.Position(4)];


f = figure;  
f.Position = [10 10 700 760]; 
eachPlotHeightScale = 1.33333;
% myFig = figure 
pos = get(f,'Position');
sp1 = subplot(3,1,1);
hold on
% yline(mean(r_squared_4(:,1), 1), '-','DisplayName','All SV (1040)')
e = errorbar(mean(r_squared_3(:,1:end_point), 1), std(r_squared_3(:,1:end_point),0, 1),'.-', 'color',color_c{1},'DisplayName','FULL (1040 SV)');
e.Line.LineWidth = 2;
e.MarkerSize = 16;
e = errorbar(mean(r_squared_3s(:,1:end_point), 1), std(r_squared_3s(:,1:end_point),0, 1),'.-', 'color',color_c{2},'DisplayName','SPARSE (610 SV)');
e.Line.LineWidth = 2;
e.MarkerSize = 16;
ylabel('R^2');
% xlabel('Number of Partition');
title('UTS/YS')
xticks(0:11)
set(gca, 'XTickLabel', {})
ylim([0.8, 0.92])
grid
set(gca, 'FontName','Times New Roman', 'FontSize', font_size);

sp2 = subplot(3,1,2);
hold on
e = errorbar(mean(number_of_operations_3(:,1:end_point), 1), std(number_of_operations_3(:,1:end_point),0, 1),'.-', 'color',color_c{1},'DisplayName','FULL (1040 SV)');
e.Line.LineWidth = 2;
e.MarkerSize = 16;
e = errorbar(mean(number_of_operations_3s(:,1:end_point), 1), std(number_of_operations_3s(:,1:end_point),0, 1),'.-', 'color',color_c{2},'DisplayName','SPARSE (610 SV)');
e.Line.LineWidth = 2;
e.MarkerSize = 16;
ylabel('Number of SV');
% xlabel('Number of Partition');
xticks(0:11)
set(gca, 'XTickLabel', {})
grid
set(gca, 'FontName','Times New Roman', 'FontSize', font_size);

sp3 = subplot(3,1,3);
hold on
e = errorbar(mean(time_of_operations_3(:,1:end_point), 1), std(time_of_operations_3(:,1:end_point),0, 1),'.-', 'color',color_c{1},'DisplayName','FULL (1040 SV)');
e.Line.LineWidth = 2;
e.MarkerSize = 16;
e = errorbar(mean(time_of_operations_3s(:,1:end_point), 1), std(time_of_operations_3s(:,1:end_point),0, 1),'.-', 'color',color_c{2},'DisplayName','SPARSE (610 SV)');
e.Line.LineWidth = 2;
e.MarkerSize = 16;
ylabel('Time Spent (s)');
xlabel('Number of Clusters (or Models)');
xticks(0:10)
grid
legend
set(gca, 'FontName','Times New Roman', 'FontSize', font_size);

sp3.Position = [sp3.Position(1:3), sp3.Position(4)*eachPlotHeightScale - 0.02];
sp2.Position = [sp2.Position(1), sp3.Position(2) + sp3.Position(4) + 0.02, sp2.Position(3), sp3.Position(4)] ;
sp1.Position = [sp1.Position(1), sp2.Position(2) + sp2.Position(4) + 0.02, sp1.Position(3), sp3.Position(4)];


f = figure;  
f.Position = [10 10 700 760]; 
eachPlotHeightScale = 1.33333;
% myFig = figure 
pos = get(f,'Position');
sp1 = subplot(3,1,1);
hold on
% yline(mean(r_squared_4(:,1), 1), '-','DisplayName','All SV (1040)')
e = errorbar(mean(r_squared_4(:,1:end_point), 1), std(r_squared_4(:,1:end_point),0, 1),'.-', 'color',color_c{1},'DisplayName','FULL (1040 SV)');
e.Line.LineWidth = 2;
e.MarkerSize = 16;
e = errorbar(mean(r_squared_4s(:,1:end_point), 1), std(r_squared_4s(:,1:end_point),0, 1),'.-', 'color',color_c{2},'DisplayName','SPARSE (640 SV)');
e.Line.LineWidth = 2;
e.MarkerSize = 16;
ylabel('R^2');
% xlabel('Number of Partition');
title('PE')
xticks(0:11)
set(gca, 'XTickLabel', {})
ylim([0.6, 0.77])
grid
set(gca, 'FontName','Times New Roman', 'FontSize', font_size);

sp2 = subplot(3,1,2);
hold on
e = errorbar(mean(number_of_operations_4(:,1:end_point), 1), std(number_of_operations_4(:,1:end_point),0, 1),'.-', 'color',color_c{1},'DisplayName','FULL (1040 SV)');
e.Line.LineWidth = 2;
e.MarkerSize = 16;
e = errorbar(mean(number_of_operations_4s(:,1:end_point), 1), std(number_of_operations_4s(:,1:end_point),0, 1),'.-', 'color',color_c{2},'DisplayName','SPARSE (640 SV)');
e.Line.LineWidth = 2;
e.MarkerSize = 16;
ylabel('Number of SV');
% xlabel('Number of Partition');
xticks(0:11)
set(gca, 'XTickLabel', {})
grid
set(gca, 'FontName','Times New Roman', 'FontSize', font_size);

sp3 = subplot(3,1,3);
hold on
e = errorbar(mean(time_of_operations_4(:,1:end_point), 1), std(time_of_operations_4(:,1:end_point),0, 1),'.-', 'color',color_c{1},'DisplayName','FULL (1040 SV)');
e.Line.LineWidth = 2;
e.MarkerSize = 16;
e = errorbar(mean(time_of_operations_4s(:,1:end_point), 1), std(time_of_operations_4s(:,1:end_point),0, 1),'.-', 'color',color_c{2},'DisplayName','SPARSE (640 SV)');
e.Line.LineWidth = 2;
e.MarkerSize = 16;
ylabel('Time Spent (s)');
xlabel('Number of Clusters (or Models)');
xticks(0:10)
grid
legend
set(gca, 'FontName','Times New Roman', 'FontSize', font_size);

sp3.Position = [sp3.Position(1:3), sp3.Position(4)*eachPlotHeightScale - 0.02];
sp2.Position = [sp2.Position(1), sp3.Position(2) + sp3.Position(4) + 0.02, sp2.Position(3), sp3.Position(4)] ;
sp1.Position = [sp1.Position(1), sp2.Position(2) + sp2.Position(4) + 0.02, sp1.Position(3), sp3.Position(4)];



