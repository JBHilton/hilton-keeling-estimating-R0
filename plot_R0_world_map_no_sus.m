% This script generates the map which appears as Figure 1 of our paper.

%% Setup the Import Options
opts = delimitedTextImportOptions("NumVariables", 2);
 
% Specify range and delimiter
opts.DataLines = [2, Inf];
opts.Delimiter = ",";
 
% Specify column names and types
opts.VariableNames = ["Country", "ScalingFactor"];
opts.VariableTypes = ["string", "double"];
opts = setvaropts(opts, 1, "WhitespaceRule", "preserve");
opts = setvaropts(opts, 1, "EmptyFieldRule", "auto");
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";
 
% Import the data
tbl = readtable("master_outputs/no_sus_scaling.csv", opts);
 
% Convert to output type
Country = tbl.Country;
ScalingFactor = tbl.ScalingFactor;
 
% Clear temporary variables
clear opts tbl
 
%%
M=shaperead("inputs/ne_50m_admin_0_countries_lakes/ne_50m_admin_0_countries_lakes_newnames");
 
%%
success_count=0;
for i=1:length(M)
    Z=strncmp(M(i).NAME_EN,Country,15);
    m=find(Z==1);
    if isempty(m)
        % need to do more to find country
        Z=strcmp(M(i).ABBREV,Country);
        m=find(Z==1);
    end
    
    if isempty(m)
        % need to do EVEN more to find country
        fprintf(1,"Cannot match to %d = %s\n",i, M(i).NAME_EN);
        Q(i)=NaN;
    else
        Q(i)=m;
        success_count=success_count+1;
    end
end
 
Q(4)=149; Q(76)=110;
 
for i=1:length(M)
    if isfinite(Q(i))
        SF=1+log(ScalingFactor(Q(i)))/log(2); SF(SF<0)=0; SF(SF>2)=2;
        if SF<1
            COLOUR(i,:)=[0 1 0]+SF^2*([0 0 1]-[0 1 0]);
        else
            COLOUR(i,:)=[0 0 1] + (SF-1)^2*([1 0 0]-[0 0 1]);
        end
    else
        COLOUR(i,:)=[0.7 0.7 0.7];
    end
end
 
SF=[0:0.02:2];
for i=1:length(SF)
    if SF(i)<1
        Cmap(i,:)=[0 1 0]+SF(i)^2*([0 0 1]-[0 1 0]);
    else
        Cmap(i,:)=[0 0 1] + (SF(i)-1)^2*([1 0 0]-[0 0 1]);
    end
end
 
%%
fig = figure('units','normalized','outerposition',[0 0 1 1]);
faceColors = makesymbolspec("Polygon",{"INDEX", [1 length(M)], "FaceColor",COLOUR,"LineStyle","-"});
mapshow(M,"SymbolSpec",faceColors);
axis([-180 180 -60 90]);
colormap(Cmap); caxis([1+log(25/48)/log(2) 1+log(50/24)/log(2)]); h=colorbar; set(h,"YTick",1+log((25/24)*([0.5 0.6 0.8 1 1.2 1.6 2]))/log(2),"XTickLabel",{"1.25","1.5","2","2.5","3","4","5+"});
set(get(h,"Ylabel"),"String","Basic reproductive ratio R_0");
set(gca,'fontsize',16)
axis off