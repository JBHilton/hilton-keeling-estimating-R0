% This script estimates the scaling factor on R0 for each country, relative
% to the Chinese estimate of R0. This is based on the susceptibility
% profile calculated from the data reported by Yang et al.

sigma = readmatrix("data/sus_profile_yang.csv");

[~,Country1]=xlsfinfo('data/MUestimates_all_locations_1.xlsx');
[~,Country2]=xlsfinfo('data/MUestimates_all_locations_2.xlsx');
Country=[Country1, Country2]';
ScalingFactor=zeros(length(Country),1);

for i=1:length(Country1)
    k = table2array(readtable('data/MUestimates_all_locations_1.xlsx','Sheet',Country1{i}));
    age_mat=diag(sigma)*k;
    ScalingFactor(i)=eigs(age_mat,1);
end
for i=1:length(Country2)
    k = table2array(readtable('data/MUestimates_all_locations_2.xlsx','Sheet',Country2{i},'ReadVariableNames',0)); % Last option required because of formatting in seconds file
    age_mat=diag(sigma)*k;
    ScalingFactor(length(Country1)+i)=eigs(age_mat,1);
end

T=table(Country,ScalingFactor);

% If you want to plot/save the data, use the following lines to make the
% names consistent with those used in the shape files for the world map plots:

% consensus_names = readcell("data/consensus_names.csv");
% T.Country = consensus_names;

% writetable(T,"data/yang_scaling.csv");