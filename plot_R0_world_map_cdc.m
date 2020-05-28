% This script generates the map which appears as Figure 2 of our paper.

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
tbl = readtable("master_outputs/cdc_scaling.csv", opts);
 
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
 
% for i=1:length(M)
%     if isfinite(Q(i))
%         SF=1+log(ScalingFactor(Q(i)))/log(2); SF(SF<0)=0; SF(SF>2)=2;
%         if SF<1
%             COLOUR(i,:)=[0 1 0]+SF^2*([0 0 1]-[0 1 0]);
%         else
%             COLOUR(i,:)=[0 0 1] + (SF-1)^2*([1 0 0]-[0 0 1]);
%         end
%     else
%         COLOUR(i,:)=[0.7 0.7 0.7];
%     end
% end
 
% SF=[0:0.02:2];
% for i=1:length(SF)
%     if SF(i)<1
%         Cmap(i,:)=[0 1 0]+SF(i)^2*([0 0 1]-[0 1 0]);
%     else
%         Cmap(i,:)=[0 0 1] + (SF(i)-1)^2*([1 0 0]-[0 0 1]);
%     end
% end

Cmap = [165,0,38; 215,48,39; 244,109,67; 253,174,97; 254,224,144; 255,255,191; 224,243,248; 171,217,233; 116,173,209; 69,117,180; 49,54,149];
Cmap = Cmap(end:-1:1,:)/max(max(Cmap));
Cmap = [Cmap(1,:)-(Cmap(2,:)-Cmap(1,:)); Cmap];
Cmap(1,2) = 0;

R0 = 2.4;
R0_range = 1:0.25:3.75;
for i=1:length(M)
    if isfinite(Q(i))
        if R0*ScalingFactor(Q(i))<min(R0_range)
        	COLOUR(i,:) = Cmap(1,:);
        else
            colour_loc(Q(i)) = find(R0_range<=R0*ScalingFactor(Q(i)),1,'last');
            COLOUR(i,:) = Cmap(colour_loc(Q(i)),:);
        end
    else
        COLOUR(i,:)=[0.7 0.7 0.7];
    end
end

%%
fig = figure('units','normalized','outerposition',[0 0 1 1]);
faceColors = makesymbolspec("Polygon",{"INDEX", [1 length(M)], "FaceColor",COLOUR,"LineStyle","-"});
mapshow(M,"SymbolSpec",faceColors);
axis([-180 180 -60 90]);
colormap(Cmap); caxis([1 4]); h=colorbar; set(h,"YTick",1:5,"XTickLabel",{"1","2","3","4+"});
set(get(h,"Ylabel"),"String","Basic reproductive ratio R_0");
set(gca,'fontsize',16)
axis off