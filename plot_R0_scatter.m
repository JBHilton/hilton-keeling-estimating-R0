% This script generates the scatter plot which appears in Figure 3 of our
% paper.

yang_tbl = readtable("data/yang_scaling.csv");
no_sus_tbl = readtable("data/no_sus_scaling.csv");

niger_loc = find(ismember(yang_tbl.Country,'Niger'));
poland_loc = find(ismember(yang_tbl.Country,'Poland'));
niger_coords = 2.4*[no_sus_tbl.ScalingFactor(niger_loc)+0.05,yang_tbl.ScalingFactor(niger_loc)+0.05];
poland_coords = 2.4*[no_sus_tbl.ScalingFactor(poland_loc)+0.05,yang_tbl.ScalingFactor(poland_loc)+0.05];

fig = figure('units','normalized','outerposition',[0 0 1 1]);
plot(2.4*no_sus_tbl.ScalingFactor,2.4*yang_tbl.ScalingFactor,'rx','MarkerSize',10);
xlim([0 8]);
ylim([0 8]);
text(niger_coords(1),niger_coords(2),'Niger','fontsize',14);
text(poland_coords(1),poland_coords(2),'Poland','fontsize',14);
xlabel('Basic reproductive ratio R_0 without age-specific infectivity');
ylabel('Basic reproductive ratio R_0 with age-specific infectivity');
axis square;
set(gca,'fontsize',16);