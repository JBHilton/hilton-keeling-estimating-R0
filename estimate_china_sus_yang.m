% We want to estimate the age-specific susceptibility of coronavirus based on
% the age distribution of cases in China and the contact matrix estimated
% for China in Prem et al. 2017

k_china = readmatrix('data/MUestimates_all_locations_1.xlsx','China'); % Load contact matrix with 16 age classes

prem_bds = 0:5:80; % Define age boundaries used in contact data

tbl=readtable("data/yang_data.csv"); % Load case data

% The next loop converts age data into an age-structured histogram
cases_by_age=zeros(1,ceil(length(tbl.CaseAge)/5));
for i=1:20
    cases_by_age(i)=sum(tbl.Cases((tbl.CaseAge>=5*(i-1))&(tbl.CaseAge<5*i)));
end
cases_by_age(length(prem_bds)-1)=sum(cases_by_age(length(prem_bds)-1:end));
cases_by_age=cases_by_age(1:length(prem_bds)-1);

% Now infer sigma using the formula from our Supplementary Information
sigma=zeros(length(prem_bds)-1,1);
for i=1:length(sigma)
    sigma(i)=cases_by_age(i)/(cases_by_age*k_china(:,i));
end

% writematrix(sigma,"data/sus_profile_yang.csv");