%% Local Sparse LSSVR Model for Predicting Mechanical Properties in Rebar Manufacturing
close all;          % Close all windows
clear;          % Clear all variables
clc;            % Clear command window



r_squared_1 = load('results/lssvr_r_squared_1.dat');
r_squared_2 = load('results/lssvr_r_squared_2.dat');
r_squared_3 = load('results/lssvr_r_squared_3.dat');
r_squared_4 = load('results/lssvr_r_squared_4.dat');

r_squared_1kd = load('results/kmedoidslssvr_r_squared_1.dat');
r_squared_2kd = load('results/kmedoidslssvr_r_squared_2.dat');
r_squared_3kd = load('results/kmedoidslssvr_r_squared_3.dat');
r_squared_4kd = load('results/kmedoidslssvr_r_squared_4.dat');

r_squared_1km = load('results/kmeanslssvr_r_squared_1.dat');
r_squared_2km = load('results/kmeanslssvr_r_squared_2.dat');
r_squared_3km = load('results/kmeanslssvr_r_squared_3.dat');
r_squared_4km = load('results/kmeanslssvr_r_squared_4.dat');

r_squared_1ald = load('results/aldlssvr_r_squared_1.dat');
r_squared_2ald = load('results/aldlssvr_r_squared_2.dat');
r_squared_3ald = load('results/aldlssvr_r_squared_3.dat');
r_squared_4ald = load('results/aldlssvr_r_squared_4.dat');

r_squared_1rd = load('results/randlssvr_r_squared_1.dat');
r_squared_2rd = load('results/randlssvr_r_squared_2.dat');
r_squared_3rd = load('results/randlssvr_r_squared_3.dat');
r_squared_4rd = load('results/randlssvr_r_squared_4.dat');


end_point = 60;
font_size = 16;
color_c = {"#77AC30", "#4DBEEE","#A2142F", "#EDB120"};


%%
f = figure;  
f.Position = [10 10 1800 700]; 
hold on
yline(mean(r_squared_1, 1), '-','DisplayName','FULL (1040 SV)')
yline(mean(r_squared_1, 1) - std(r_squared_1,0, 1), '--', 'HandleVisibility','off')
yline(mean(r_squared_1, 1) + std(r_squared_1,0, 1), '--', 'HandleVisibility','off')

e = errorbar(mean(r_squared_1rd(:,1:end_point), 1), std(r_squared_1rd(:,1:end_point),0, 1),'.-', 'color',color_c{1},'DisplayName','RANDOM SELECTION');
e.Line.LineWidth = 2;
e.MarkerSize = 16;
e = errorbar(mean(r_squared_1ald(:,1:end_point), 1), std(r_squared_1ald(:,1:end_point),0, 1),'.-', 'color',color_c{2},'DisplayName','ALD4P');
e.Line.LineWidth = 2;
e.MarkerSize = 16;
e = errorbar(mean(r_squared_1km(:,1:end_point), 1), std(r_squared_1km(:,1:end_point),0, 1),'.-', 'color',color_c{3},'DisplayName','KMEANS');
e.Line.LineWidth = 2;
e.MarkerSize = 16;
e = errorbar(mean(r_squared_1kd(:,1:end_point), 1), std(r_squared_1kd(:,1:end_point),0, 1),'.-', 'color',color_c{4},'DisplayName','KMEDOIDS');
e.Line.LineWidth = 2;
e.MarkerSize = 16;
xticks(1:end_point)
xticklabels(string(1030:-10:(1040-(end_point)*10)))
ylim([0.72, 0.88])
% set(gca,'xticklabel',[])
title('UTS')
ylabel('R^2');
xlabel('Number of Support Vectors');
legend
% grid on
set(gca, 'FontName','Times New Roman', 'FontSize', font_size);

f = figure;  
f.Position = [10 10 1800 700]; 
hold on
yline(mean(r_squared_2, 1), '-','DisplayName','FULL (1040 SV)')
yline(mean(r_squared_2, 1) - std(r_squared_2,0, 1), '--', 'HandleVisibility','off')
yline(mean(r_squared_2, 1) + std(r_squared_2,0, 1), '--', 'HandleVisibility','off')
e = errorbar(mean(r_squared_2rd(:,1:end_point), 1), std(r_squared_2rd(:,1:end_point),0, 1),'.-', 'color',color_c{1},'DisplayName','RANDOM SELECTION');
e.Line.LineWidth = 2;
e.MarkerSize = 16;
e = errorbar(mean(r_squared_2ald(:,1:end_point), 1), std(r_squared_2ald(:,1:end_point),0, 1),'.-', 'color',color_c{2},'DisplayName','ALD4P');
e.Line.LineWidth = 2;
e.MarkerSize = 16;
e = errorbar(mean(r_squared_2km(:,1:end_point), 1), std(r_squared_2km(:,1:end_point),0, 1),'.-', 'color',color_c{3},'DisplayName','KMEANS');
e.Line.LineWidth = 2;
e.MarkerSize = 16;
e = errorbar(mean(r_squared_2kd(:,1:end_point), 1), std(r_squared_2kd(:,1:end_point),0, 1),'.-', 'color',color_c{4},'DisplayName','KMEDOIDS');
e.Line.LineWidth = 2;
e.MarkerSize = 16; 
xticks(1:end_point)
xticklabels(string(1030:-10:(1040-(end_point)*10)))
ylim([0.55, 0.85])
% set(gca,'xticklabel',[])
title('YS')
ylabel('R^2');
xlabel('Number of Support Vectors');
legend
% grid on
set(gca, 'FontName','Times New Roman', 'FontSize', font_size);

f = figure;  
f.Position = [10 10 1800 700]; 
hold on
yline(mean(r_squared_3, 1), '-','DisplayName','FULL (1040 SV)')
yline(mean(r_squared_3, 1) - std(r_squared_3,0, 1), '--', 'HandleVisibility','off')
yline(mean(r_squared_3, 1) + std(r_squared_3,0, 1), '--', 'HandleVisibility','off')
e = errorbar(mean(r_squared_3rd(:,1:end_point), 1), std(r_squared_3rd(:,1:end_point),0, 1),'.-', 'color',color_c{1},'DisplayName','RANDOM SELECTION');
e.Line.LineWidth = 2;
e.MarkerSize = 16;
e = errorbar(mean(r_squared_3ald(:,1:end_point), 1), std(r_squared_3ald(:,1:end_point),0, 1),'.-', 'color',color_c{2},'DisplayName','ALD4P');
e.Line.LineWidth = 2;
e.MarkerSize = 16;
e = errorbar(mean(r_squared_3km(:,1:end_point), 1), std(r_squared_3km(:,1:end_point),0, 1),'.-', 'color',color_c{3},'DisplayName','KMEANS');
e.Line.LineWidth = 2;
e.MarkerSize = 16;
e = errorbar(mean(r_squared_3kd(:,1:end_point), 1), std(r_squared_3kd(:,1:end_point),0, 1),'.-', 'color',color_c{4},'DisplayName','KMEDOIDS');
e.Line.LineWidth = 2;
e.MarkerSize = 16;
xticks(1:end_point)
xticklabels(string(1030:-10:(1040-(end_point)*10)))
ylim([0.8, 0.92])
% set(gca,'xticklabel',[])
title('UTS/YS')
ylabel('R^2');
xlabel('Number of Support Vectors');
legend
% grid on
set(gca, 'FontName','Times New Roman', 'FontSize', font_size);

f = figure;  
f.Position = [10 10 1800 700]; 
hold on
yline(mean(r_squared_4, 1), '-','DisplayName','FULL (1040 SV)')
yline(mean(r_squared_4, 1) - std(r_squared_4,0, 1), '--', 'HandleVisibility','off')
yline(mean(r_squared_4, 1) + std(r_squared_4,0, 1), '--', 'HandleVisibility','off')
e = errorbar(mean(r_squared_4rd(:,1:end_point), 1), std(r_squared_4rd(:,1:end_point),0, 1),'.-', 'color',color_c{1},'DisplayName','RANDOM SELECTION');
e.Line.LineWidth = 2;
e.MarkerSize = 16;
e = errorbar(mean(r_squared_4ald(:,1:end_point), 1), std(r_squared_4ald(:,1:end_point),0, 1),'.-', 'color',color_c{2},'DisplayName','ALD4P');
e.Line.LineWidth = 2;
e.MarkerSize = 16;
e = errorbar(mean(r_squared_4km(:,1:end_point), 1), std(r_squared_4km(:,1:end_point),0, 1),'.-', 'color',color_c{3},'DisplayName','KMEANS');
e.Line.LineWidth = 2;
e.MarkerSize = 16;
e = errorbar(mean(r_squared_4kd(:,1:end_point), 1), std(r_squared_4kd(:,1:end_point),0, 1),'.-', 'color',color_c{4},'DisplayName','KMEDOIDS');
e.Line.LineWidth = 2;
e.MarkerSize = 16;
xticks(1:end_point)
xticklabels(string(1030:-10:(1040-(end_point)*10)))
ylim([0.6, 0.77])
% set(gca,'xticklabel',[])
title('PE')
ylabel('R^2');
xlabel('Number of Support Vectors');
legend
% grid on
set(gca, 'FontName','Times New Roman', 'FontSize', font_size);

% output 650 850 610 640
