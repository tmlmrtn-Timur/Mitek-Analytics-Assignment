Project Description: 

This project provides a modular MATLAB utility for visualizing time series data from CSV files, with optional overlays for mean and trend lines. 
It also includes a nonparametric smoothing implementation using the Hodrick–Prescott (HP) filter, ideal for decomposing noisy signals into trend and cyclical components.

Functionality Description: plot_file.m
• 	Reads two CSV files: one with time series data, one with plot configuration.
• 	Generates a PNG plot with:
• 	Raw data line
• 	Optional mean line
• 	Optional linear trend line
• 	Custom axis labels and title
HP Filter 
• 	Applies Hodrick–Prescott smoothing to noisy time series
• 	Separates signal into:
• 	Trend: smooth underlying pattern
• 	Cycle: short-term fluctuations

User Instructions: 
1. Prepare Input Files
• 	Data CSV: Two columns — date (ISO format) and value
• 	Config CSV: Three columns — key, value, component  (no header)
2. Run the Plot Function: plot_file('test1_data.csv', 'test1_config.csv', 'test1_output.png');
3. Apply HP Filter

Data Interface Specs:

•  Data File (data.csv)
- Date: of type string, ISO format (e.g., 2025-0101)
- Value: of type double, numeric time series
  
•  Config File (config.csv)
- Keys: mean_line, trend_line, xlabel, ylabel
- Values: yes/no, yes/no, text, text
- Description: Mean line, linear trend line, Label for x-axis, Label for y-axis

Explanation of Results in PNG:
- test1_output.png shows a mean horizontal line in red added to the first Test dataset for Part A of the assignement
  <img width="1243" height="749" alt="test1_output" src="https://github.com/user-attachments/assets/c92dddf5-1857-4128-920b-e212644c57b5" />
  
- test2_output.png shows a trend linear fit line in green added to the second Test dataset for Part A of the assignement
 <img width="1243" height="749" alt="test2_output" src="https://github.com/user-attachments/assets/d159750d-0b13-45ed-99fb-47ffcd6bd288" />
 
- test3_output.png shows both a mean (red) and a trend linear fit (green) added to the third Test dataset for Part A of the assignement
  <img width="1243" height="749" alt="test3_output" src="https://github.com/user-attachments/assets/8591a6f0-1472-4f8a-8f69-b982e8c73008" />

- noisy_cosine_60days.png shows a clean cosine function defined in the assignment along with one with a noise applied to it (Part B of the assignement)
  <img width="1036" height="699" alt="noisy_cosine_60days" src="https://github.com/user-attachments/assets/d6fe461f-d492-4c1f-a840-ddbbddecbbd0" />

- Linear_regression.png shows a plot with a linear fit for Part C of the assignment
  <img width="1041" height="699" alt="Linear_regression" src="https://github.com/user-attachments/assets/d3694f63-838b-49b8-886d-bd328e048cef" />

- Third_order_regression.png shows a plot with a third order polynomial regresssion for Part C of the assignemnt
  <img width="1041" height="699" alt="Third_order_regression" src="https://github.com/user-attachments/assets/466753a4-cfad-4dce-99ea-be4380a70ec4" />

- HP_test1_output.png shows HP-filter plot using the input of Test1 from part A
  <img width="1068" height="698" alt="HP_test1_output" src="https://github.com/user-attachments/assets/b89883d5-5e2a-4d74-b537-577f1327c52a" />

- HP_test_noisy_cosine.png shows HP-filter plot using the input of the noisy cosine function from part B
<img width="1053" height="699" alt="HP_test_noisy_cosine" src="https://github.com/user-attachments/assets/9ae78253-a531-403d-985b-85acab70df56" />





