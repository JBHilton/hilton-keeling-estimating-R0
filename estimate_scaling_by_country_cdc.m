rho = readmatrix("master_outputs/rho_estimate_cdc.csv");

prem_bds = 0:5:80; % age classes used in the prem et al study
cdc_bds = 0:10:80; % age classes used in the cdc study, with 80 introduced as upper bound for consistency with prem et al data

aggregator=zeros(length(prem_bds)-1,1); % This matrix stores where each class in finer structure is in coarser structure
for i=1:length(prem_bds)-1
aggregator(i)=find(cdc_bds>=prem_bds(i+1),1)-1;
end
rho_long=sparse(1:length(aggregator),ones(1,length(aggregator)),rho(aggregator));

[~,Country1]=xlsfinfo('inputs/MUestimates_all_locations_1.xlsx');
[~,Country2]=xlsfinfo('inputs/MUestimates_all_locations_2.xlsx');
Country=[Country1, Country2]';
ScalingFactor=zeros(length(Country),1);

for i=1:length(Country1)
    k = table2array(readtable('inputs/MUestimates_all_locations_1.xlsx','Sheet',Country1{i}));
    age_mat=k*diag(rho_long);
    ScalingFactor(i)=eigs(age_mat,1);
end
for i=1:length(Country2)
    k = table2array(readtable('inputs/MUestimates_all_locations_2.xlsx','Sheet',Country2{i},'ReadVariableNames',0)); % Last option required because of formatting in seconds file
    age_mat=k*diag(rho_long);
    ScalingFactor(length(Country1)+i)=eigs(age_mat,1);
end

T=table(Country,ScalingFactor);

consensus_names = readcell("inputs/consensus_names.csv");
T.Country = consensus_names;

writetable(T,"outputs/cdc_scaling.csv");