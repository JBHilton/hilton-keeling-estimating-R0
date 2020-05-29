# hilton-keeling-estimating-R0
The code in this repository accompanies our upcoming paper "Estimation of country-level basic reproductive ratios for novelCoronavirus (COVID-19) using synthetic contact matrices". A preprint version of this paper is available at https://www.medrxiv.org/content/10.1101/2020.02.26.20028167v1. Some of our notation has changed between the preprint and the submission version of the paper. In particular, the age-specific susceptibility is now denoted by sigma rather than z.

estimate_scaling_by_country_no_sus.m. generates a set of scaling factors on R0 assuming a null, purely contact intensity-based model using the country-level contact matrices stored in inputs/MUestimates_all_locations_1.xlsx and inputs/MUestimates_all_locations_2.xlsx.

estimate_rho_cdc.m generates a set of estimates for rho = sigma*d, the age-stratified scaling on contact intensity in a model with age-specific susceptibility and/or detection, given the China CDC weekly data stored in inputschina_cdc_data.mat.

estimate_scaling_by_country_cdc.m generates a set of scaling factors on R0 assuming age-specific susceptibility/detection based on the estimate of rho generated in estimate_rho_cdc.m.

plot_R0_world_map_no_sus.m plots a map of estimated R0 values by country based on the scaling factors estimated in estimate_scaling_by_country_no_sus.m and assuming a China-specific R0 of 2.4.

plot_R0_world_map_cdc.m plots a map of estimated R0 values by country based on the scaling factors estimated in estimate_scaling_by_country_cdc.m and assuming a China-specific R0 of 2.4.

plot_R0_scatter.m plots the two sets of estimated scaling factors against one another on a scatter plot.

run_all.m runs the above scripts, generating the results reported in our paper.

The function scaling_to_R0.m produces a table of estimated R0 values given a user-specified China-specific R0 and a table of scaling factors.

The function aggregate_contact_matrix.m is used to produce an age-specific contact matrix for China along age class boundaries consistent with those used in the China CDC Weekly data.
