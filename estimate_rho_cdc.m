% We want to estimate the age-specific susceptibility of coronavirus based on
% the age distribution of cases in China and the contact matrix estimated
% for China in Prem et al. 2017

k_china =  table2array(readtable('inputs/MUestimates_all_locations_1.xlsx','Sheet','China')); % Load contact matrix with 16 age classes

prem_bds = 0:5:80; % age classes used in the prem et al study
cdc_bds = [0:10:80]; % age classes used in the cdc et al study, with 80 introduced as upper bound for consistency with prem et al data
china_pyr_tbl = readtable("inputs/China-2019.csv");
china_pop_pyramid = china_pyr_tbl.M+china_pyr_tbl.F;
k_china=aggregate_contact_matrix( k_china,prem_bds,cdc_bds,china_pop_pyramid);

data=load("inputs/china_cdc_data.mat").china_cdc_data; % Load case data
data(length(cdc_bds)-1)=sum(data(length(cdc_bds)-1:end));
data=data(1:length(cdc_bds)-1);

% Now infer rho using the formula from our Supplementary Information
rho=zeros(length(cdc_bds)-1,1);
for i=1:length(rho)
    rho(i)=data(i)/(data*k_china(:,i));
end

writematrix(rho,"outputs/rho_estimate_cdc.csv");