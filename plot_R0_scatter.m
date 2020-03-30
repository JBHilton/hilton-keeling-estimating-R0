% This script generates the scatter plot which appears in Figure 3 of our
% paper.

cdc_tbl = readtable("master_outputs/cdc_scaling.csv");
no_sus_tbl = readtable("master_outputs/no_sus_scaling.csv");

niger_loc = find(ismember(cdc_tbl.Country,'Niger'));
italy_loc = find(ismember(cdc_tbl.Country,'Italy'));
monaco_loc = find(ismember(cdc_tbl.Country,'Monaco'));
china_loc = find(ismember(cdc_tbl.Country,'China'));
other_locs = 1:length(cdc_tbl.Country);
other_locs([niger_loc,italy_loc,monaco_loc,china_loc])=[];
niger_coords = 2.4*[no_sus_tbl.ScalingFactor(niger_loc),cdc_tbl.ScalingFactor(niger_loc)];
italy_coords = 2.4*[no_sus_tbl.ScalingFactor(italy_loc),cdc_tbl.ScalingFactor(italy_loc)];
monaco_coords = 2.4*[no_sus_tbl.ScalingFactor(monaco_loc),cdc_tbl.ScalingFactor(monaco_loc)];
china_coords = 2.4*[no_sus_tbl.ScalingFactor(china_loc),cdc_tbl.ScalingFactor(china_loc)];

fig = figure('units','normalized','outerposition',[0 0 1 1]);
plot(2.4*no_sus_tbl.ScalingFactor(other_locs),2.4*cdc_tbl.ScalingFactor(other_locs),'rx','MarkerSize',10);
hold on
plot([niger_coords(1),italy_coords(1),monaco_coords(1),china_coords(1)],...
    [niger_coords(2),italy_coords(2),monaco_coords(2),china_coords(2)],'k.','MarkerSize',12);
xlim([0 8]);
ylim([0 8]);
text(niger_coords(1)+0.05,niger_coords(2)+0.06,'Niger','fontsize',14);
text(italy_coords(1)+0.05,italy_coords(2)+0.06,'Italy','fontsize',14);
text(monaco_coords(1)+0.05,monaco_coords(2)+0.06,'Monaco','fontsize',14);
text(china_coords(1)+0.05,china_coords(2)+0.06,'China','fontsize',14);
xlabel('Basic reproductive ratio R_0 from null model');
ylabel('Basic reproductive ratio R_0 from fitted model');
axis square;
set(gca,'fontsize',16);