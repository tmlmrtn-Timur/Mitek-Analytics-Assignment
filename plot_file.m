%% Plot function definition for part A of the assignement

function plot_file(data_file, config_file, output_file)
% % plot_file - Function to produce a plot from data and config CSV files
% Inputs:
%   data_file    - CSV file with two columns: date, value (e.g., 'data.csv')
%   config_file  - CSV file with three columns: key,value,comment (e.g., 'config.csv')
%   output_file  - Filename for saving the PNG plot (e.g., 'output.png')

% Step 1: Check file extensions to make sure the files are .csv files

if ~endsWith(data_file, '.csv') || ~endsWith(config_file, '.csv')
    error('Both data_file and config_file must be .csv files.');
end

% Step 2: Read the data file (.csv)

% Assuming that the first column is date (ISO format) and the second column is numeric value
data = readtable(data_file);  % Creates a data table by reading column-oriented data from data_file
dates = datetime(data{:,1}, 'InputFormat', 'yyyy-MM-dd');  % Converts date data into Matlab's date format
values = data{:,2};

% Step 3: Read the config file (.csv)

% Assuming (per instructions) three columns: key, value, comment
config = readtable(config_file, 'ReadVariableNames', false);  % Treats data assuming no column headers
configMap = containers.Map(config{:,1}, config{:,2}); % Creates a map object (dictionary) with keys and values

% Step 4: Extract config values
config_mean = strcmpi(configMap('mean_line'), 'yes');  % Compares retrieved values associated with...
% ...the key 'mean_line' case-insensitively and stores as a logical variable
config_trend = strcmpi(configMap('trend_line'), 'yes'); % Compares retrieved values associated with...
% ...the key 'trend_line' case-insensitively and stores as a logical variable
xlabelText = configMap('xlabel'); % Assigns retrieved value 'Date' to xlabelText
ylabelText = configMap('ylabel'); % Assigns retrieved value 'Value' to ylabelText

% Step 5: Create the plot

figure('Visible','off'); % not displaying the figure plot
plot(dates, values, 'b-o', 'LineWidth', 4, 'MarkerSize', 6, 'DisplayName', 'Data'); % plots x=dates, y=values as a blue line with circles
% ... at each data point. Label is set in the legend, legend() call will
% appear as "Data"
hold on;  % keeping current plot active to be able to add more plot contents

% Optional: adding Mean Line if needed
if config_mean   % executed if True
    yMean = mean(values);
    yline(yMean, '--r', 'LineWidth', 4, 'DisplayName', 'Mean');  % Adds horizontal red dashed line at the mean value
end

% Optional: adding Trend line (linear fit) if needed
if config_trend  % executed if True
    p = polyfit(datenum(dates), values, 1); % Linear fit line with an input of converted dates into numbers
    trendY = polyval(p, datenum(dates)); % Evaluating the fit ata given x value
    plot(dates, trendY, '--g', 'LineWidth', 4, 'DisplayName', 'Trend');  % plot the fit line as 'Trend'
end

% Step 6: Add Labels, Title and Legend

xlabel(xlabelText);
ylabel(ylabelText);
title([ylabelText ' vs ' xlabelText]); % x and y labels are added to the title
legend('Location','best');  % Legend is automatically placed in the available space
grid on;  % Adding grid for easier user experience

% Step 7: Save the plot as PNG

saveas(gcf, output_file);
close;
end


