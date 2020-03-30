% Plots population pyramids for China, Italy, Niger

niger_pyr = readtable("inputs/Niger-2019.csv");
china_pyr = readtable("inputs/China-2019.csv");
italy_pyr = readtable("inputs/Italy-2019.csv");

niger_pop = sum(niger_pyr.M)+sum(niger_pyr.F);
niger_male = niger_pyr.M/sum(niger_pop);
niger_female = niger_pyr.F/sum(niger_pop);


china_pop = sum(china_pyr.M)+sum(china_pyr.F);
china_male = china_pyr.M/sum(china_pop);
china_female = china_pyr.F/sum(china_pop);

italy_pop = sum(italy_pyr.M)+sum(italy_pyr.F);
italy_male = italy_pyr.M/sum(italy_pop);
italy_female = italy_pyr.F/sum(italy_pop);

figure
subplot(1,3,1);
barh([-niger_male niger_female],'stacked')
xlim([-0.11 0.11]);
ylim([0.5 21.5]);
xticks(-0.1:0.05:0.1)
xticklabels({'10%','5%','0','5%','10%'})
yticks([1:1:21])
yticklabels(niger_pyr.Age)
xlabel('Proportion of population (males | females)')
ylabel('Age')
title('Niger')
pbaspect([4 5 1])
set(gca,'TickLength',[0 0],'FontSize',12)

subplot(1,3,2);
barh([-china_male china_female],'stacked')
xlim([-0.11 0.11]);
ylim([0.5 21.5]);
xticks(-0.1:0.05:0.1)
xticklabels({'10%','5%','0','5%','10%'})
yticks([1:1:21])
yticklabels(china_pyr.Age)
xlabel('Proportion of population (males | females)')
title('China')
pbaspect([4 5 1])
set(gca,'TickLength',[0 0],'FontSize',12)

subplot(1,3,3);
barh([-italy_male italy_female],'stacked')
xlim([-0.11 0.11]);
ylim([0.5 21.5]);
xticks(-0.1:0.05:0.1)
xticklabels({'10%','5%','0','5%','10%'})
yticks([1:1:21])
yticklabels(italy_pyr.Age)
xlabel('Proportion of population (males | females)')
title('Italy')
pbaspect([4 5 1])
set(gca,'TickLength',[0 0],'FontSize',12)