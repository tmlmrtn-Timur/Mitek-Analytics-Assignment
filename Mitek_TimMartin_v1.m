%% A.   Matlab code to plot Data and Config csv files

% This section uses a plot function defined in plot_file.m
% function plot_file(data_file, config_file, output_file)
% Three different test datasets are defined below and plotted in this
% script
% Three png plots test1_output.png, test2_output.png, and test3_output.png
% are included in the submission of this assignment

% Test dataset #1 - Only with mean plot

data1 = table(["2025-01-01"; "2025-01-02"; "2025-01-03"; "2025-01-04"], ...
    [5; 12; 31; 76], ...
    'VariableNames', {'Date', 'Values'});

writetable(data1, 'test1_data.csv');

config1 = {
    'mean_line', 'yes', 'Show mean line';
    'trend_line', 'no', 'Do not show trend line';
    'xlabel', 'Date', 'Time axis';
    'ylabel', 'Values', 'No units'
    };

configTable1 = cell2table(config1);
writetable(configTable1, 'test1_config.csv', 'WriteVariableNames', false);

% Plot Test dataset #1
plot_file('test1_data.csv', 'test1_config.csv', 'test1_output.png');

% Test dataset #2 - Only with linear fit plot

data2 = table(["2025-04-01"; "2025-04-02"; "2025-04-03"; "2025-04-04"], ...
    [400; 420; 450; 464], ...
    'VariableNames', {'Date', 'Values'});
writetable(data2, 'test2_data.csv');

config2 = {
    'mean_line', 'no', 'Do not show mean line';
    'trend_line', 'yes', 'Show trend line';
    'xlabel', 'Date', 'Time axis';
    'ylabel', 'Values', 'No units'
    };

configTable2 = cell2table(config2);
writetable(configTable2, 'test2_config.csv', 'WriteVariableNames', false);

% Plot Test dataset #2
plot_file('test2_data.csv', 'test2_config.csv', 'test2_output.png');


% Test dataset #3 - Combined plot with mean and linear fit

data3 = table(["2025-06-01"; "2025-06-02"; "2025-06-03"; "2025-06-04"], ...
    [30; 32; 29; 33], ...
    'VariableNames', {'Date', 'Values'});
writetable(data3, 'test3_data.csv');


config3 = {
    'mean_line', 'yes', 'Show mean line';
    'trend_line', 'yes', 'Show trend line';
    'xlabel', 'Time', 'Time of Day';
    'ylabel', 'Values', 'No units'
    };

configTable3 = cell2table(config3);
writetable(configTable3, 'test3_config.csv', 'WriteVariableNames', false);

plot_file('test3_data.csv', 'test3_config.csv', 'test3_output.png');

%% B. Test Data
% Generate 50 point sequence as daily values for cosine function with 60-day period.
% the cosine shall have amplitude 1. Add random noise with standard deviation of 1 to the data.

N = 50;  % Number of daily points
P = 60;  % Period, number of days
A = 1;   % Amplitude
noise_std = 1;  % random noise standard deviation
t = (1:N)';  % Time column vector from 1 to N

cos_fun = A * cos((2*pi / P) * t);  % Cosine function without noise

cos_fun_noise = cos_fun + noise_std * randn(N, 1);  % Cosine function with noise

figure(2)  % Plot of Test Data (part B)
plot(t, cos_fun_noise, 'b.-', 'DisplayName', 'Noisy Function'); hold on;
plot(t, cos_fun, 'r--', 'LineWidth', 1.5, 'DisplayName', 'Cosine Function without noise');
xlabel('Day');
ylabel('Value');
title('Noisy Cosine Function with 60-Day Period');
legend;
grid on;

%% C. Data Trending algorithm
% Implement what you can of

clear
n = 20; % number of samples
x = (1:n)'; % n samples
y = x;  % intiating observed values vector
for i = 1:n
    y(i) = x(i) + randn(1); % sample observed values with random noise
end
%%  - linear trend regression
[coeffs_1, S_1] = polyfit(x, y, 1);  % Linear polynomial regression

[y_fit_1, delta_1] = polyval(coeffs_1, x, S_1);  %

figure(3);
plot(x, y, 'bo-', 'LineWidth', 1.5); hold on;
plot(x, y_fit_1, 'r--', 'LineWidth', 2);
xlabel('Samples');
ylabel('Value');
title('Linear Trend Regression');
legend('Observed Data', 'Linear Regression');
grid on;
text(mean(x), max(y), sprintf('R^2 = %.4f', S_1.rsquared), ...
    'FontSize', 12, 'Color', 'magenta', 'HorizontalAlignment', 'center');


%%  - 3rd order polynomial trend regression
[coeffs_3, S_3] = polyfit(x, y, 3);  % Third order polynomial regression

[y_fit_3, delta_3] = polyval(coeffs_3, x, S_3);  %

figure(4);
plot(x, y, 'bo-', 'LineWidth', 1.5); hold on;
plot(x, y_fit_3, 'r--', 'LineWidth', 2);
xlabel('Samples');
ylabel('Value');
title('Third order polynomial regression');
legend('Observed Data', 'Third order polynomial regression');
grid on;
text(mean(x), max(y), sprintf('R^2 = %.4f', S_3.rsquared), ...
    'FontSize', 12, 'Color', 'magenta', 'HorizontalAlignment', 'center');

%%  - nonparametric ridge regression provided by Hoderick-Prescott filter

% Loading data from previously used test1_data.csv
data = readtable('test1_data.csv'); % Reads the csv file into a table
dates = datetime(data{:,1}, 'InputFormat', 'yyyy-MM-dd'); % Converts first column (dates) to datetime

values = data{:,2}; % Extracts second column (Values) as numeric values
n = length(values); % number of data points
lambda = 100000;  % Smoothing parameter for daily data
% Common value for quarterly data; higher = smoother trend

I = speye(n); % Identity matrix for size n x n
D = diff(I, 2);  % Second-order difference matrix (n-2 x n)

% Trend component equivalent to ridge regression with a penalty on
% curvature
trend = (I + lambda * (D' * D)) \ values;
cycle = values - trend; % Cyclical component, the difference between data values and the trend

figure(5); % Plot of HP-filter on test1_data.csv
plot(dates, values, 'k-o', 'DisplayName', 'Original'); hold on;
plot(dates, trend, 'b-', 'LineWidth', 2, 'DisplayName', 'Trend');
plot(dates, cycle, 'r--', 'DisplayName', 'Cycle');
legend('Location','best'); grid on;
title('Hodrick–Prescott filter Applied to test1\_data.csv');
xlabel('Date'); ylabel('Value');

% Now implementing HP-filter on noisy cosine function defined above
% cos_fun_noise = cos_fun + noise_std * randn(N, 1);
N = 50;  % Number of daily points
P = 60;  % Period, number of days
A = 1;   % Amplitude
noise_std = 1;  % random noise standard deviation
t = (1:N)';  % Time column vector from 1 to N

cos_fun = A * cos((2*pi / P) * t);  % Cosine function without noise

cos_fun_noise = cos_fun + noise_std * randn(N, 1);  % Cosine function with noise

I2 = speye(N);         % Identity matrix
D2 = diff(I2, 2);        % Second-order difference matrix (N-2 x N)

% Solve for the smooth trend component
trend2 = (I2 + lambda * (D2' * D2)) \ cos_fun_noise;

% Compute the cyclical component (residuals)
cycle2 = cos_fun_noise - trend2;

figure(6); % Plot of HP-filter on noisy cosine data
plot(t, cos_fun_noise, 'k-o', 'DisplayName', 'Noisy Cosine'); hold on;
plot(t, trend2, 'b-', 'LineWidth', 2, 'DisplayName', 'HP Trend');
plot(t, cycle2, 'r--', 'DisplayName', 'Cycle');
legend('Location','best'); grid on;
xlabel('Day'); ylabel('Value');
title('Hodrick–Prescott filter Applied to Noisy Cosine Data');

