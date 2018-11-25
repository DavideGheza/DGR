% Door gambling task - Cue fft analyses                    11/01/2018


% all 26 subjects (including low redoers) - to correlate type effect vs redo rate

clc     
clear

pathin = 'C:\Users\gdavide\Documents\MATLAB\dg_workspace16\Door gambling redos\splitted - Cue\'
pathout = 'C:\Users\gdavide\Documents\MATLAB\dg_workspace16\Door gambling redos\splitted - Cue\'

% whole sample (17 excluded)     
sn = [7:16 18:33];


cd (pathin)



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% DEFINE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% defining band %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
band = 2;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%% defining band ranges (Hz) %%%%%%%%%%%%%%%%%%%%%%%
if band == 1
   blimit = [0; 3.9];     % delta   
   blabel = 'delta';
elseif band == 2
    blimit = [4; 8];    % theta  
    blabel = 'FMT';
elseif band == 3        
    blimit = [8; 13];   % alpha   
    blabel = 'alpha';
elseif band == 4         
    blimit = [15;30];   % beta  
    blabel = 'beta';
elseif band == 5       
    blimit = [30;45];    % gamma
    blabel = 'gamma';
end

    
c = 0;


% initializing matrices

xsbjdata = zeros(64,1541);        % 2nd dim is fft points - change according to epoch lenght (design) = (sr/2) / (1/epoch length in sample points)
ysbjdata = zeros(64,1541);  
xdata = zeros(length(sn),64,1541); 
ydata = zeros(length(sn),64,1541); 

% counter for xls sheets
c = c+1;

% importing
for i = 1:length(sn)
    
x = importdata (['design1_h',num2str(sn(i)),'_2122.datspec']);
y = importdata (['design1_h',num2str(sn(i)),'_4142.datspec']);

% filling the 2D matrice with chann data
for chan = 1:64
    channame = ['chan' num2str(chan) ];
    xsbjdata(chan,:) = x.(channame);
    ysbjdata(chan,:) = y.(channame);
end
% filling the 3D matrice with sbj data

xdata(i,:,:) = xsbjdata;
ydata(i,:,:) = ysbjdata;


end

% subset data in the frequency range of interest
xdataband = xdata(:,:,dsearchn(x.freqs,blimit(1)):dsearchn(x.freqs,blimit(2)));
ydataband = ydata(:,:,dsearchn(y.freqs,blimit(1)):dsearchn(y.freqs,blimit(2)));


% normalization (Smith et al., 2017 IJP)
% 1) divide power at each channel by the summed power across all channels
xsummedpower = squeeze(sum(mean(xdataband,3),2));
ysummedpower = squeeze(sum(mean(ydataband,3),2));

xscaleddata = bsxfun(@rdivide,mean(xdataband,3),xsummedpower);
yscaleddata = bsxfun(@rdivide,mean(ydataband,3),ysummedpower);

% 2) normalize across channel, within sbj 
xzdata = zscore(xscaleddata,1,2);
yzdata = zscore(yscaleddata,1,2);

xzout = [x.labels(1:64);num2cell(xzdata)];
yzout = [x.labels(1:64);num2cell(yzdata)];



% % Save out - normalized single channel data
% xlswrite([pathout,blabel,'_26_Cue_fft_normalized.xls'],[xzout,yzout]);





% plot topography (z scores)

figure
subplot(1,2,1);
EEG.chanlocs = readlocs('channs.locs');
topoplot(mean(xzdata,1),EEG.chanlocs,'plotchans',[1:64]);    %,'maplimits',[-4 4] / 'maxmin'  ,'electrodes','ptslabels'
cbh = colorbar;
set(get(cbh,'xlabel'),'string','Z scores','FontSize',12);
set(gca,'FontSize', 12)
title(['Regular trial - ' blabel],'Fontsize', 14,'FontName','Arial')

subplot(1,2,2);
EEG.chanlocs = readlocs('channs.locs');
topoplot(mean(yzdata,1),EEG.chanlocs,'plotchans',[1:64]);    %,'maplimits',[-4 4] / 'maxmin'  ,'electrodes','ptslabels'
cbh = colorbar;
set(get(cbh,'xlabel'),'string','Z scores','FontSize',12);
set(gca,'FontSize', 12)
title(['Special trial - ' blabel],'Fontsize', 14,'FontName','Arial')




%%
%%%%%%%%%%%%%%%%%%%%%%%%%% Cue locked ERPs - CNV %%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 24/01/2017 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% all 26 subjects (including low redoers) 

clc     
clear

pathin = 'C:\Users\gdavide\Documents\MATLAB\dg_workspace16\Door gambling redos\splitted - Cue\'
pathout = 'C:\Users\gdavide\Documents\MATLAB\dg_workspace16\Door gambling redos\splitted - Cue\'

% whole sample (17 excluded)     
sn = [7:16 18:33];


cd (pathin)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% DEFINE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% defining band %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
chanlabel = 'Cz';  %['Cz','FCz','Fz','FC3','FC4']
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

c = 0;


% initializing matrices

xsbjdata = zeros(64,2048);        % 2nd dim is fft points - change according to epoch lenght (design) = (sr/2) / (1/epoch length in sample points)
ysbjdata = zeros(64,2048);  
xdata = zeros(length(sn),64,2048); 
ydata = zeros(length(sn),64,2048); 

% counter for xls sheets
c = c+1;

% importing time series (ERPs)
for i = 1:length(sn)
    
x = importdata (['design1_h',num2str(sn(i)),'_2122.daterp']);
y = importdata (['design1_h',num2str(sn(i)),'_4142.daterp']);

% filling the 2D matrices with chann data
for chan = 1:64
    channame = ['chan' num2str(chan) ];
    xsbjdata(chan,:) = x.(channame);
    ysbjdata(chan,:) = y.(channame);
end
% filling the 3D matrices with sbj data

xdata(i,:,:) = xsbjdata;
ydata(i,:,:) = ysbjdata;


end

% select chan

xchandata = xdata(:,strcmp(x.labels,chanlabel),:);
ychandata = ydata(:,strcmp(x.labels,chanlabel),:);

% compute SEM (std error of the mean) for plot shading

xsterr = std(squeeze(xchandata),0,1)/sqrt(length(sn));
ysterr = std(squeeze(ychandata),0,1)/sqrt(length(sn));

% grandaverage (across sbj)

xgndavg = squeeze(mean(xchandata,1));
ygndavg = squeeze(mean(ychandata,1));

% plot CNV at Cz

figure;

hold on

% plot ERP 

plot(x(1,1).times,xgndavg,'Color',[0.1 0.1 0.1],'LineWidth',3); 

plot(x(1,1).times,ygndavg,'Color',[0.8 0.15 0.15],'LineWidth',3); 

% plot SE of the mean

jbfill(x(1,1).times,(xgndavg'+xsterr),(xgndavg'-xsterr),[0.1 0.1 0.1],[0.1 0.1 0.1],0,0.2)
jbfill(x(1,1).times,(ygndavg'+ysterr),(ygndavg'-ysterr),[0.8 0.15 0.15],[0.8 0.15 0.15],0,0.2)

% set stuff

set(gca,'xlim',[-250 2000],'YDir','reverse', 'FontSize', 22);     
xlabel('Time (ms)','FontSize',22,'FontName','Arial')
ylabel('Amplitude (µV)','FontSize',22,'FontName','Arial')
title('CNV','FontSize',26,'FontName','Arial')     

hlegend = legend('Regular trial','Special trial');
set(hlegend, 'Fontsize', 22)

% set dsahed 0 line
dasx = [-250 2000];
dasy = [0 0];
line(dasx,dasy,'Color',[0.7 0.7 0.7],'LineStyle','-','LineWidth',2)
dasz = [0 0];
dasw = [-5 5];
line(dasz,dasw,'Color',[0.7 0.7 0.7],'LineStyle','-','LineWidth',2)


% Save out CNV - mean amplitude 1000 - 2000 ms cue-locked

CNVreg = mean(xchandata(:,:,dsearchn(x(1,1).times',1000):dsearchn(x(1,1).times',2000),:));
CNVspec = mean(ychandata(:,:,dsearchn(x(1,1).times',1000):dsearchn(x(1,1).times',2000),:));

CNV = [CNVreg;CNVspec];

% xlswrite([pathout,'CNV_Cz_reg_spec_final26.xls'],CNV);

