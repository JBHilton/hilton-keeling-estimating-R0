% This script generates the scatter plot which appears in Figure 3 of our
% paper.

cdc_tbl = readtable("master_outputs/cdc_scaling.csv");
no_sus_tbl = readtable("master_outputs/no_sus_scaling.csv");

niger_loc = find(ismember(cdc_tbl.Country,'Niger'));
italy_loc = find(ismember(cdc_tbl.Country,'Italy'));
monaco_loc = find(ismember(cdc_tbl.Country,'Monaco'));
niger_coords = 2.4*[no_sus_tbl.ScalingFactor(niger_loc)+0.05,cdc_tbl.ScalingFactor(niger_loc)+0.05];
italy_coords = 2.4*[no_sus_tbl.ScalingFactor(italy_loc)+0.05,cdc_tbl.ScalingFactor(italy_loc)+0.05];
monaco_coords = 2.4*[no_sus_tbl.ScalingFactor(monaco_loc)+0.05,cdc_tbl.ScalingFactor(monaco_loc)+0.05];

fig = figure('units','normalized','outerposition',[0 0 1 1]);
plot(2.4*no_sus_tbl.ScalingFactor,2.4*cdc_tbl.ScalingFactor,'rx','MarkerSize',10);
xlim([0 8]);
ylim([0 8]);
text(niger_coords(1),niger_coords(2),'Niger','fontsize',14);
text(italy_coords(1),italy_coords(2),'Italy','fontsize',14);
text(monaco_coords(1),monaco_coords(2),'Monaco','fontsize',14);
xlabel('Basic reproductive ratio R_0 from null model');
ylabel('Basic reproductive ratio R_0 from fitted model');
axis square;
set(gca,'fontsize',16);