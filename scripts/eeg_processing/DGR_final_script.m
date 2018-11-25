% DGR - Door gambling redo - final script -                     18/08/2017
% part 1: ERPs - prob x outcome
% part 2: ERSP - prob x outcome
% part 3: ERPs - redo x outcome
% part 4: ERSP - redo x outcome
% part 5: ERPs - redo x outcome extended low redo
% part 6: ERSP - redo x outcome extended low redo


%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%% part 1 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%% ERPs - prob x outcome %%%%%%%%%%%%%%%%%%%%%%%%%

% FRN peak 2 peak 2 peak                           updated 06/02/2017

% + Poster cuttingEEG figures                       updated 13/06/2017

% + RewP Short (235 285) from collap localiz deltaRewP updated 28/04/2017

% + RewP Short from average FCz Cz                             09/05/2017


clc
clear

%%%%%%%% Define ERP type: FRN ppp @FCz= 1 \ RewP short @FCz Cz = 2 %%%%%%%%

ERPtype = 1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure;

% zeroing counter
c = 0;

% define sbjs
sn = [7:16 18:33]       

% conditions one = 111 | 112     two = 121 | 122     three = 131 | 132

for cond = [1 2]         % cf. to last digit of condition: 1 pos 2 neg

% initializing matrices
tred = zeros(2048,length(sn));
tref = zeros(2048,length(sn));
treh = zeros(2048,length(sn));
% counter for xls sheets
c = c+1;

% importing
for i = [1:length(sn)]      
x(i) = importdata (['C:\Users\gdavide\Documents\MATLAB\dg_workspace16\Door gambling redos\splitted\merged datasets - final 26 sample\prob x outcome\design2_h' num2str(sn(i)) '_11' num2str(cond) '.daterp']);
y(i) = importdata (['C:\Users\gdavide\Documents\MATLAB\dg_workspace16\Door gambling redos\splitted\merged datasets - final 26 sample\prob x outcome\design2_h' num2str(sn(i)) '_12' num2str(cond) '.daterp']);
z(i) = importdata (['C:\Users\gdavide\Documents\MATLAB\dg_workspace16\Door gambling redos\splitted\merged datasets - final 26 sample\prob x outcome\design2_h' num2str(sn(i)) '_13' num2str(cond) '.daterp']);

% filling the 2d matrices
if ERPtype == 1                     %(FCz)
    tred(:,i) = x(i).chan47;
    tref(:,i) = y(i).chan47;
    treh(:,i) = z(i).chan47;
elseif ERPtype == 2                 %(Cz + FCz)
    tred(:,i) = (x(i).chan48 + x(i).chan47)/2;   
    tref(:,i) = (y(i).chan48 + y(i).chan47)/2;
    treh(:,i) = (z(i).chan48 + z(i).chan47)/2;
        
end
    
end

% averaging on the 2nd dimension (subjects) and put pos / neg in a struct
one{cond} = mean(tred,2);
two{cond} = mean(tref,2);
three{cond} = mean(treh,2);



% door gambling redos - extracting individual scores - mean amplitude ERP   % 25/01/2017
if ERPtype == 1   
% peak to peak to peak (Sallet, 2013: max P170, min FRN, max P3) (FB) / ?-? (RT)
onem = min(tred(dsearchn(x(1,1).times',200):dsearchn(x(1,1).times',350),:))...
    - (max(tred(dsearchn(x(1,1).times',150):dsearchn(x(1,1).times',250),:))...
    + max(tred(dsearchn(x(1,1).times',250):dsearchn(x(1,1).times',600),:)))/2

twom = min(tref(dsearchn(x(1,1).times',200):dsearchn(x(1,1).times',350),:))...
    - (max(tref(dsearchn(x(1,1).times',150):dsearchn(x(1,1).times',250),:))...
    + max(tref(dsearchn(x(1,1).times',250):dsearchn(x(1,1).times',600),:)))/2

threem = min(treh(dsearchn(x(1,1).times',200):dsearchn(x(1,1).times',350),:))...
    - (max(treh(dsearchn(x(1,1).times',150):dsearchn(x(1,1).times',250),:))...
    + max(treh(dsearchn(x(1,1).times',250):dsearchn(x(1,1).times',600),:)))/2

xlscomb = [onem;twom;threem]
 
% xlswrite(['C:\Users\gdavide\Documents\MATLAB\dg_workspace16\Door gambling redos\splitted\merged datasets - final 26 sample\final26_HC_filter_Fb_FCz_ERPs_ppp.xls'],xlscomb,(c));

elseif ERPtype == 2  
    
% RewP Short @ Cz (Novak & Foti 2015 - mean in 235-285ms window)
onemRewPshort = mean(tred(dsearchn(x(1,1).times',235):dsearchn(x(1,1).times',285),:))
twomRewPshort = mean(tref(dsearchn(x(1,1).times',235):dsearchn(x(1,1).times',285),:))
threemRewPshort = mean(treh(dsearchn(x(1,1).times',235):dsearchn(x(1,1).times',285),:))

RewPshort = [onemRewPshort;twomRewPshort;threemRewPshort]

% xlswrite(['C:\Users\gdavide\Documents\MATLAB\dg_workspace16\Door gambling redos\splitted\merged datasets - final 26 sample\final26_HC_filter_Fb_Cz_FCz_RewPshort.xls'],RewPshort,(c));

end

% others ERP algorithms (change chan accordingly)

% % RewP @ Cz (Threadgill 2016 - mean in 250-350ms window)
% onemRewP = mean(tred(dsearchn(x(1,1).times',250):dsearchn(x(1,1).times',350),:))
% twomRewP = mean(tref(dsearchn(x(1,1).times',250):dsearchn(x(1,1).times',350),:))
% threemRewP = mean(treh(dsearchn(x(1,1).times',250):dsearchn(x(1,1).times',350),:))
%
% RewPcomb = [onemRewP;twomRewP;threemRewP]
%
% xlswrite(['C:\Users\gdavide\Documents\MATLAB\dg_workspace16\Door gambling redos\splitted\merged datasets - final 26 sample\final26_HC_filter_Fb_Cz_RewP.xls'],RewPcomb,(c));
% 
% 
% % P3 @ Cz (Gajewski 2008 - peak in 300-500ms window)
% onemP3 = max(tred(dsearchn(x(1,1).times',300):dsearchn(x(1,1).times',500),:))
% twomP3 = max(tref(dsearchn(x(1,1).times',300):dsearchn(x(1,1).times',500),:))
% threemP3 = max(treh(dsearchn(x(1,1).times',300):dsearchn(x(1,1).times',500),:))
% 
% P3comb = [onemP3;twomP3;threemP3]
%
% xlswrite([C:\Users\gdavide\Documents\MATLAB\dg_workspace16\Door gambling redos\splitted\merged datasets - final 26 sample\final26_HC_filter_Fb_Cz_P3.xls'],P3comb,(c));




% test plot
figure
plot(x(1,1).times,tred,'Color',[1 0 0]); 
set(gca,'xlim',[-200 500],'YDir','normal');     
xlabel('Time (ms)','FontSize',12,'FontName','Arial')
end


% subtracting conditions

% controlling for expectancy
unex = three{1,2} - one{1,1};
exp = one{1,2} -  three{1,1};
neut = two{1,2} - two{1,1}

% % % controlling for valence (unex - ex)
% pos = one{1,1} - three{1,1};
% neg = three{1,2} - one{1,2};
% % basic contrast
% neut = two{1,1} - two{1,2}
% 
% % mixed - controlling for probability
% one = one{1,2} - one{1,1};
% two = two{1,2} - two{1,1};
% three = three{1,2} - three{1,1};


plot(x(1,1).times,unex,'Color',[1 0 0]); 
set(gca,'xlim',[-200 500],'YDir','normal');     
xlabel('Time (ms)','FontSize',12,'FontName','Arial')
% set(gca,'xtick',1:18:300,'xticklabel',{round(x(1,2).times(1,1:18:300))})

hold on

plot(x(1,1).times,exp,'Color',[0 1 0]); 
set(gca,'xlim',[-200 500],'YDir','normal');     
xlabel('Time (ms)','FontSize',12,'FontName','Arial')
% set(gca,'xtick',1:18:300,'xticklabel',{round(x(1,2).times(1,1:18:300))})

hold on

plot(x(1,1).times,neut,'Color',[0 0 1]); 
set(gca,'xlim',[-200 500],'YDir','normal');     
xlabel('Time (ms)','FontSize',12,'FontName','Arial')
% set(gca,'xtick',1:18:300,'xticklabel',{round(x(1,2).times(1,1:18:300))})

title('controlling for expectancy','FontSize',12,'FontName','Arial')

legend('unex neg - unex pos','exp neg - exp pos','neut neg - neut pos')



% finding negative peak in time window

t = (x(1,1).times(dsearchn(three{1,1},min(three{1,1}(dsearchn(x(1,1).times',230):dsearchn(x(1,1).times',280))))))


% plot for Poster cuttingEEG: ERPs outcome x expectancy

figure;

plot(x(1,1).times,one{1,2},'Color',[0.8 0.45 0.45],'LineWidth',3); 
hold on
plot(x(1,1).times,two{1,2},'Color',[0.8 0.3 0.3],'LineWidth',3); 
plot(x(1,1).times,three{1,2},'Color',[0.8 0.15 0.15],'LineWidth',3); 
plot(x(1,1).times,three{1,1},'Color',[0.7 0.7 0.7],'LineWidth',3,'LineStyle','--'); 
plot(x(1,1).times,two{1,1},'Color',[0.4 0.4 0.4],'LineWidth',3,'LineStyle','--'); 
plot(x(1,1).times,one{1,1},'Color',[0.1 0.1 0.1],'LineWidth',3,'LineStyle','--'); 

set(gca,'xlim',[-100 500],'YDir','reverse', 'FontSize', 17);     
xlabel('Time (ms)','FontSize',17,'FontName','Arial')
ylabel('Amplitude (µV)','FontSize',17,'FontName','Arial')
title('FRN','FontSize',26,'FontName','Arial')      % original title: FB outcome * expectancy - FCz

hlegend = legend('No-rew Exp','No-rew No-exp','No-rew Unex','Reward Exp','Reward No-exp','Reward Unex')
set(hlegend, 'Fontsize', 17)

% set dsahed 0 line
dasx = [-100 500];
dasy = [0 0];
line(dasx,dasy,'Color',[0.7 0.7 0.7],'LineStyle','-','LineWidth',2)
dasz = [0 0];
dasw = [-5 20];
line(dasz,dasw,'Color',[0.7 0.7 0.7],'LineStyle','-','LineWidth',2)


%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%% part 2 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%% ERSP - prob x outcome %%%%%%%%%%%%%%%%%%%%%%%%%

% Door gambling task - FB  contrasts  ERSP              29/11/2016
%                                               updated 20/01/2017
% + Delta cluster CPz CP1 CP2 CP3 CP4           updated 11/04/2017
% + Delta cluster CPz CP1 CP2                   updated 17/04/2017
% + high Beta                                   updated 30/08/2017

clc
clear

%%%%% defining band - theta @FCz = 1 \ delta @ CPZCP1CP2CP3CP4 = 2 %%%%%%%%
%%%%%%%%%%%%%%%%%%%% \ high beta @ FCzFzFC1FC2, 250-350ms = 3 %%%%%%%%%%%%%

band = 3;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% defining band ranges (Hz)
if band == 1
    blimit = [4; 8];
elseif band == 2
    blimit = [0.8; 3.9];
elseif band == 3
    blimit = [20; 35];
end

% defining time range
if band == 1 || band == 2
    time = [200;400];
elseif band == 3
    time = [250;350];
end

c = 0;
sn = [7:16 18:33]       % escluding sbj 17

% conditions one = 111 | 112     two = 121 | 122     three = 131 | 132

for cond = [1 2] 

    
% initializing matrices
tred = zeros(75,200,length(sn));
tref = zeros(75,200,length(sn));
treh = zeros(75,200,length(sn));
% counter for xls sheets
c = c+1;

% importing
for i = [1:length(sn)]
x(i) = importdata (['C:\Users\gdavide\Documents\MATLAB\dg_workspace16\Door gambling redos\splitted\merged datasets - final 26 sample\prob x outcome\\design2_h' num2str(sn(i)) '_11' num2str(cond) '.datersp']);
y(i) = importdata (['C:\Users\gdavide\Documents\MATLAB\dg_workspace16\Door gambling redos\splitted\merged datasets - final 26 sample\prob x outcome\\design2_h' num2str(sn(i)) '_12' num2str(cond) '.datersp']);
z(i) = importdata (['C:\Users\gdavide\Documents\MATLAB\dg_workspace16\Door gambling redos\splitted\merged datasets - final 26 sample\prob x outcome\\design2_h' num2str(sn(i)) '_13' num2str(cond) '.datersp']);

% filling the 3d matrices

if band == 1

tred(:,:,i) = (x(i).chan47_ersp);  % Fz: 38 FCz: 47
tref(:,:,i) = (y(i).chan47_ersp);
treh(:,:,i) = (z(i).chan47_ersp);

elseif band == 2
%(cluster of 5 parietal channels for delta) 
tred(:,:,i) = ((x(i).chan32_ersp)+(x(i).chan19_ersp)+(x(i).chan18_ersp)+(x(i).chan56_ersp)+(x(i).chan55_ersp))/5;  % FCz: 47 FC1: 11 FC2: 46 Fz: 38 CPz: 32 CP1: 19 CP3: 18 CP2: 56 CP4: 55
tref(:,:,i) = ((y(i).chan32_ersp)+(y(i).chan19_ersp)+(y(i).chan18_ersp)+(y(i).chan56_ersp)+(y(i).chan55_ersp))/5;
treh(:,:,i) = ((z(i).chan32_ersp)+(z(i).chan19_ersp)+(z(i).chan18_ersp)+(z(i).chan56_ersp)+(z(i).chan55_ersp))/5;

elseif band == 3
% % cluster of 4 frontal channel for high beta - FCz Fz FC1 FC2 
tred(:,:,i) = ((x(i).chan47_ersp)+(x(i).chan38_ersp)+(x(i).chan11_ersp)+(x(i).chan46_ersp))/4;
tref(:,:,i) = ((y(i).chan47_ersp)+(y(i).chan38_ersp)+(y(i).chan11_ersp)+(y(i).chan46_ersp))/4;
treh(:,:,i) = ((z(i).chan47_ersp)+(z(i).chan38_ersp)+(z(i).chan11_ersp)+(z(i).chan46_ersp))/4;

% others combination of channels

% % FCz + Fz for high Beta    
% tred(:,:,i) = ((x(i).chan47_ersp)+(x(i).chan38_ersp))/2;  
% tref(:,:,i) = ((y(i).chan47_ersp)+(y(i).chan38_ersp))/2;
% treh(:,:,i) = ((z(i).chan47_ersp)+(z(i).chan38_ersp))/2;

%(cluster of 3 parietal channels for delta) 
% tred(:,:,i) = ((x(i).chan32_ersp)+(x(i).chan19_ersp)+(x(i).chan56_ersp))/3;  % FCz: 47 FC1: 11 FC2: 46 Fz: 38 CPz: 32 CP1: 19 CP3: 18 CP2: 56 CP4: 55
% tref(:,:,i) = ((y(i).chan32_ersp)+(y(i).chan19_ersp)+(y(i).chan56_ersp))/3;
% treh(:,:,i) = ((z(i).chan32_ersp)+(z(i).chan19_ersp)+(z(i).chan56_ersp))/3;

% %(cluster of frontocentral channels for theta)
% tred(:,:,i) = ((x(i).chan47_ersp)+(x(i).chan11_ersp)+(x(i).chan46_ersp)+(x(i).chan38_ersp))/4;  % FCz: 47 FC1: 11 FC2: 46 Fz: 38 CPz: 32 CP1: 19 CP3: 18 CP2: 56 CP4: 55
% tref(:,:,i) = ((y(i).chan47_ersp)+(y(i).chan11_ersp)+(y(i).chan46_ersp)+(y(i).chan38_ersp))/4;
% treh(:,:,i) = ((z(i).chan47_ersp)+(z(i).chan11_ersp)+(z(i).chan46_ersp)+(z(i).chan38_ersp))/4;
end

end

% averaging on the 3rd dimension (subjects) and put pos / neg in a struct
one{cond} = mean(tred,3);
two{cond} = mean(tref,3);
three{cond} = mean(treh,3);




% door gambling redos - extracting individual scores - mean ERPS   % 26/01/2017
% theta freqs 4-8, times 200-400 (FB) / ?-? (RT)
% delta freqs 0.8-3.9, times 200-400 (FB) / ?-? (RT)
onem = squeeze(mean(mean(tred(dsearchn(x(1,1).freqs',blimit(1)):dsearchn(x(1,1).freqs',blimit(2)),dsearchn(x(1,1).times',time(1)):dsearchn(x(1,1).times',time(2)),:))))
twom = squeeze(mean(mean(tref(dsearchn(x(1,1).freqs',blimit(1)):dsearchn(x(1,1).freqs',blimit(2)),dsearchn(x(1,1).times',time(1)):dsearchn(x(1,1).times',time(2)),:))))
threm = squeeze(mean(mean(treh(dsearchn(x(1,1).freqs',blimit(1)):dsearchn(x(1,1).freqs',blimit(2)),dsearchn(x(1,1).times',time(1)):dsearchn(x(1,1).times',time(2)),:))))
xlscomb = [onem,twom,threm]

if band == 1
% xlswrite(['C:\Users\gdavide\Documents\MATLAB\dg_workspace16\Door gambling redos\splitted\merged datasets - final 26 sample\final26_HC_Fb_FCz_ERSP_4_8_200_400.xls'],xlscomb,(c));
elseif band == 2
% xlswrite(['C:\Users\gdavide\Documents\MATLAB\dg_workspace16\Door gambling redos\splitted\merged datasets - final 26 sample\final26_HC_Fb_CPzCP1CP2CP3CP4_ERSP_0.8_3.9_200_400.xls'],xlscomb,(c));
elseif band == 3
% xlswrite(['C:\Users\gdavide\Documents\MATLAB\dg_workspace16\Door gambling redos\splitted\merged datasets - final 26 sample\final26_HC_Fb_FCzFzFC1FC2_ERSP_20_35_250_350.xls'],xlscomb,(c));

end



end
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% fig. 4/5/6 panels B - ERSP Topography and collapsed localzier  30/08/2017
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                         

clc
clear


%%%%% defining param - theta @FCz = 1 \ delta @ CPZCP1CP2CP3CP4 = 2 %%%%%%%
%%%%%%%%%%%%%%%%%%%% \ high beta @ FCzFzFC1FC2, 250-350ms = 3 %%%%%%%%%%%%%

band = 3;
induced = 2; % options: 1 = induced (not computed yet) | 2 = total

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% defining band ranges (Hz)
if band == 1
    blimit = [4; 8];
elseif band == 2
    blimit = [0.8; 3.9];
elseif band == 3
    blimit = [20; 35];
end

% defining time range
if band == 1 || band == 2
    time = [200;400];
elseif band == 3
    time = [250;350];
end

% defining path
if induced == 1 
    pathin = 'C:\Users\gdavide\Documents\MATLAB\dg_workspace16\Door gambling redos\splitted\merged datasets - final 26 sample\prob x outcome';
    pathout = 'C:\Users\gdavide\Documents\MATLAB\dg_workspace16\Door gambling redos\splitted\merged datasets - final 26 sample\prob x outcome';
else
    pathin = 'C:\Users\gdavide\Documents\MATLAB\dg_workspace16\Door gambling redos\splitted\merged datasets - final 26 sample\prob x outcome';
    pathout = 'C:\Users\gdavide\Documents\MATLAB\dg_workspace16\Door gambling redos\splitted\merged datasets - final 26 sample\prob x outcome';
end

cd (pathin)

c = 0;
sn = [7:16 18:33]       % escluding sbj 17

% conditions        pos = 111 | 121 | 131    neg = 112 | 122 | 132

% importing

% initializing matrices
ones = zeros(2,75,200,64);
twos = zeros(2,75,200,64);
threes = zeros(2,75,200,64);

for cond = [1 2] 
    
    % initializing matrices
one = zeros(75,200,64,length(sn));
two = zeros(75,200,64,length(sn));
three = zeros(75,200,64,length(sn));

for i = (1:length(sn))
    
x(i) = importdata (['design' num2str(induced) '_h' num2str(sn(i)) '_11' num2str(cond) '.datersp']);

y(i) = importdata (['design' num2str(induced) '_h' num2str(sn(i)) '_12' num2str(cond) '.datersp']);

z(i) = importdata (['design' num2str(induced) '_h' num2str(sn(i)) '_13' num2str(cond) '.datersp']);

% filling the 3d matrices with 64 channels
for channo = 1:64
    chaname = ['chan' num2str(channo) '_ersp'];
    threex(:,:,channo)= x(i).(chaname);
    threey(:,:,channo)= y(i).(chaname);
    threez(:,:,channo)= z(i).(chaname);
end

% filling the 4d matrices with subj

one(:,:,:,i) = threex;
two(:,:,:,i) = threey;
three(:,:,:,i) = threez;

end
% averaging on the 4th dimension (subjects) and put in another 4d matrix
% cond, freq, time, chan

ones(cond,:,:,:) = squeeze(mean(one,4));
twos(cond,:,:,:) = squeeze(mean(two,4));
threes(cond,:,:,:) = squeeze(mean(three,4));

end

% collapsing expectancy levels (doors)

pos = squeeze(ones(1,:,:,:) + twos(1,:,:,:) + threes(1,:,:,:))/3;
neg = squeeze(ones(2,:,:,:) + twos(2,:,:,:) + threes(2,:,:,:))/3;

dif = pos - neg;
avg = (pos + neg) /2;
% topoplot 

% average on the 1st and 2nd dimensions (freq and time)
topodif = squeeze(mean(mean(dif(dsearchn(x(1,1).freqs',blimit(1)):dsearchn(x(1,1).freqs',blimit(2)),dsearchn(x(1,1).times',time(1)):dsearchn(x(1,1).times',time(2)),:))));

topopos = squeeze(mean(mean(pos(dsearchn(x(1,1).freqs',blimit(1)):dsearchn(x(1,1).freqs',blimit(2)),dsearchn(x(1,1).times',time(1)):dsearchn(x(1,1).times',time(2)),:))));
toponeg = squeeze(mean(mean(neg(dsearchn(x(1,1).freqs',blimit(1)):dsearchn(x(1,1).freqs',blimit(2)),dsearchn(x(1,1).times',time(1)):dsearchn(x(1,1).times',time(2)),:))));

topoavg = squeeze(mean(mean(avg(dsearchn(x(1,1).freqs',blimit(1)):dsearchn(x(1,1).freqs',blimit(2)),dsearchn(x(1,1).times',time(1)):dsearchn(x(1,1).times',time(2)),:))));



figure;
% preparing topo
EEG.chanlocs = readlocs('channs.locs')
%color limits
if band == 2 || band == 3
    lim(1) = max(topopos);
    lim(2) = min(toponeg);
elseif band == 1
    lim(1) = max(toponeg);
    lim(2) = min(topopos);
end

subplot(2,3,1);
topoplot(topopos,EEG.chanlocs,'plotchans',[1:64],'maplimits',[lim(2) lim(1)] );    %,'maplimits',[-4 4] / 'maxmin'  ,'electrodes','ptslabels'
cbh = colorbar;
set(get(cbh,'xlabel'),'string','dB','FontSize',12);
set(gca,'FontSize', 12)
title('reward','Fontsize', 14,'FontName','Arial')
subplot(2,3,2);
topoplot(toponeg,EEG.chanlocs,'plotchans',[1:64],'maplimits',[lim(2) lim(1)] );    %,'maplimits',[-4 4] / 'maxmin'  ,'electrodes','ptslabels'
colorbar
title('no-reward','Fontsize', 14,'FontName','Arial')
subplot(2,3,3);
topoplot(topoavg,EEG.chanlocs,'plotchans',[1:64],'maplimits',[lim(2) lim(1)] );    %,'maplimits',[-4 4] / 'maxmin'  ,'electrodes','ptslabels'
colorbar
title('average','Fontsize', 14,'FontName','Arial')
subplot(2,3,4);
topoplot(topodif,EEG.chanlocs,'plotchans',[1:64])%,'maplimits',[lim(2) lim(1)] );    %,'maplimits',[-4 4] / 'maxmin'  ,'electrodes','ptslabels'
colorbar
title('difference','Fontsize', 14,'FontName','Arial')




%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%% part 3 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%% ERPs - redo x outcome %%%%%%%%%%%%%%%%%%%%%%%%%

% Door gambling task - FB  contrasts  ERPs              29/11/2016
% Redo vs non redo                              updated 23/02/2017

% RewP and P3 + FRN (peak to peak to peak)      updated 06/04/2017

% + FRN and RewP figures                        updated 19/04/2017
%           --- change chan for FRN or RewP !! ---

% + RewP Short (235 285) from collap localiz deltaRewP updated 27/04/2017

% + RewP Short from average FCz Cz                             05/05/2017

clc
clear


%%%%%%%%%%% Define ERP type: FRN ppp @FCz = 1 \ RewP short @FCz Cz = 2 %%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%% P3 @Pz = 3 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

ERPtype = 2;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

pathin = 'C:\Users\gdavide\Documents\MATLAB\dg_workspace16\Door gambling redos\splitted\merged datasets - final 26 sample\redo nore'
pathout = 'C:\Users\gdavide\Documents\MATLAB\dg_workspace16\Door gambling redos\splitted\merged datasets - final 26 sample\redo nore'
cd (pathin)

c = 0;

% define sbjs
sn = [7:9 11:14 16 18:23 25 26 28 29 31:33];    

% conditions        nonredo = 121 | 122     redo = 141 | 1428

for cond = [1 2] 

    
% initializing matrices
tred = zeros(2048,length(sn));
tref = zeros(2048,length(sn));

% counter for xls sheets
c = c+1;

% importing
for i = (1:length(sn));
    if any ([7:9 11:14 16 18:23 25 26] == sn(i));          % load 'design1'
        x(i) = importdata (['design1_h' num2str(sn(i)) '_12' num2str(cond) '.daterp']);
        if cond == 1
            y(i) = importdata (['design1_h' num2str(sn(i)) '_14' num2str(cond) '.daterp']);
        else
            y(i) = importdata (['design1_h' num2str(sn(i)) '_14' num2str(cond) '8.daterp']);
        end
    elseif any ([28 29 31:33] == sn(i));                   % load 'design2'
        x(i) = importdata (['design2_h' num2str(sn(i)) '_12' num2str(cond) '.daterp']);
        if cond == 1
            y(i) = importdata (['design2_h' num2str(sn(i)) '_14' num2str(cond) '.daterp']);
        else
            y(i) = importdata (['design2_h' num2str(sn(i)) '_14' num2str(cond) '8.daterp']);
        end
    end

% filling the 2d matrices
if ERPtype == 1                     %(FCz)
    tred(:,i) = x(i).chan47;
    tref(:,i) = y(i).chan47;  % FCz: 47 FC1: 11 FC2: 46 Fz: 38 CPz: 32 CP1: 19 CP3: 18 CP2: 56 CP4: 55 Cz: 48
elseif ERPtype == 2                 %(Cz + FCz)
    tred(:,i) = (x(i).chan48 + x(i).chan47)/2;
    tref(:,i) = (y(i).chan48 + y(i).chan47)/2;
elseif ERPtype == 3                 %(Pz)
    tred(:,i) = x(i).chan31;
    tref(:,i) = y(i).chan31;
    
end

end

% (Grand)averaging on the 2nd dimension (subjects) and put pos / neg in a struct
nore{cond} = mean(tred,2);
redo{cond} = mean(tref,2);


% door gambling redos - extracting individual scores - ERPS   % 24/02/2017

if ERPtype == 1   
% FRN peak to peak to peak (Sallet, 2013: max P170, min FRN, max P3) (FB)
    noreFRN = min(tred(dsearchn(x(1,1).times',200):dsearchn(x(1,1).times',350),:))...
    - (max(tred(dsearchn(x(1,1).times',150):dsearchn(x(1,1).times',250),:))...
    + max(tred(dsearchn(x(1,1).times',250):dsearchn(x(1,1).times',600),:)))/2

    redoFRN = min(tref(dsearchn(x(1,1).times',200):dsearchn(x(1,1).times',350),:))...
    - (max(tref(dsearchn(x(1,1).times',150):dsearchn(x(1,1).times',250),:))...
    + max(tref(dsearchn(x(1,1).times',250):dsearchn(x(1,1).times',600),:)))/2
    FRNcomb = [noreFRN;redoFRN]
% xlswrite(['C:\Users\gdavide\Documents\MATLAB\dg_workspace16\Door gambling redos\splitted\merged datasets - final 26 sample\final21_HC_Fb_redo_nore_FCz_FRN ppp.xls'],FRNcomb,(c));

elseif ERPtype == 2    
% RewP Short @ Cz + FCz (Novak & Foti 2015 - mean in 235-285ms window)
    noreRewPshort = mean(tred(dsearchn(x(1,1).times',235):dsearchn(x(1,1).times',285),:))
    redoRewPshort = mean(tref(dsearchn(x(1,1).times',235):dsearchn(x(1,1).times',285),:))
    RewPshort = [noreRewPshort;redoRewPshort]
% xlswrite(['C:\Users\gdavide\Documents\MATLAB\dg_workspace16\Door gambling redos\splitted\merged datasets - final 26 sample\final21_HC_Fb_redo_nore_Cz_FCz_RewPshort.xls'],RewPshort,(c));

elseif ERPtype == 3   
% P3 @ Pz (see Holroyd & Krigolson 2007 - peak in 300-500ms window)
noreP3 = max(tred(dsearchn(x(1,1).times',300):dsearchn(x(1,1).times',500),:))
redoP3 = max(tref(dsearchn(x(1,1).times',300):dsearchn(x(1,1).times',500),:))
P3comb = [noreP3;redoP3]
% xlswrite(['C:\Users\gdavide\Documents\MATLAB\dg_workspace16\Door gambling redos\splitted\merged datasets - final 26 sample\final21_HC_Fb_redo_nore_Pz_P3.xls'],P3comb,(c));

end

% others ERP algorithms (change chan accordingly)

% RewP @ Cz (Threadgill 2016 - mean in 250-350ms window)
% noreRewP = mean(tred(dsearchn(x(1,1).times',250):dsearchn(x(1,1).times',350),:))
% redoRewP = mean(tref(dsearchn(x(1,1).times',250):dsearchn(x(1,1).times',350),:))
% RewPcomb = [noreRewP;redoRewP]
% xlswrite(['C:\Users\gdavide\Documents\MATLAB\dg_workspace16\Door gambling redos\splitted\merged datasets - final 26 sample\final21_HC_Fb_redo_nore_Cz_RewP.xls'],RewPcomb,(c));



end

% subtracting conditions
% RewP contrast
dredo = redo{1,1} - redo{1,2};
dnore = nore{1,1} -  nore{1,2};

figure;
plot(x(1,1).times,dredo,'Color',[1 0 0]); 
set(gca,'xlim',[-200 700],'YDir','reverse');     
xlabel('Time (ms)','FontSize',12,'FontName','Arial')
% set(gca,'xtick',1:18:300,'xticklabel',{round(x(1,2).times(1,1:18:300))})



hold on

plot(x(1,1).times,dnore,'Color',[0 1 0]); 
set(gca,'xlim',[-200 700],'YDir','reverse');     
xlabel('Time (ms)','FontSize',12,'FontName','Arial')
% set(gca,'xtick',1:18:300,'xticklabel',{round(x(1,2).times(1,1:18:300))})

title('RewP contrast','FontSize',12,'FontName','Arial')

legend('RewP redo','RewP nore')


% redo contrast
% pos = redo{1,1} - nore{1,1};
% neg = redo{1,2} -  nore{1,2};
% 
% figure;
% plot(x(1,1).times,neg,'Color',[1 0 0]); 
% set(gca,'xlim',[-200 500],'YDir','normal');     
% xlabel('Time (ms)','FontSize',12,'FontName','Arial')
% % set(gca,'xtick',1:18:300,'xticklabel',{round(x(1,2).times(1,1:18:300))})
% 
% 
% 
% hold on
% 
% plot(x(1,1).times,pos,'Color',[0 1 0]); 
% set(gca,'xlim',[-200 500],'YDir','normal');     
% xlabel('Time (ms)','FontSize',12,'FontName','Arial')
% % set(gca,'xtick',1:18:300,'xticklabel',{round(x(1,2).times(1,1:18:300))})
% 
% title('redo contrast','FontSize',12,'FontName','Arial')
% 
% legend('neg redo - no redo','pos redo - no redo')
% 
% 

if ERPtype == 1 % || ERPtype == 2

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% fig. 2 - FRN @ FCz - redo                                 19/04/2017
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure;
plot(x(1,1).times,nore{1,1},'Color',[0 0.5 0],'LineWidth',4);
set(gca,'xlim',[-200 700],'YDir','reverse'); 
xlabel('Time (ms)','FontSize',15,'FontName','Arial')
ylabel('Amplitude (µV)','FontSize',15,'FontName','Arial')
% set(gca,'xtick',1:18:300,'xticklabel',{round(x(1,2).times(1,1:18:300))})

hold on
plot(x(1,1).times,nore{1,2},'Color','red','LineWidth',4); 
set(gca,'xlim',[-200 700],'YDir','reverse');
xlabel('Time (ms)','FontSize',15,'FontName','Arial')
ylabel('Amplitude (µV)','FontSize',15,'FontName','Arial')
% set(gca,'xtick',1:18:300,'xticklabel',{round(x(1,2).times(1,1:18:300))})

hold on
plot(x(1,1).times,redo{1,1},'Color',[0 0.5 0],'LineWidth',4, 'Linestyle', '--'); 
set(gca,'xlim',[-200 700],'YDir','reverse');
xlabel('Time (ms)','FontSize',15,'FontName','Arial')
ylabel('Amplitude (µV)','FontSize',15,'FontName','Arial')
% set(gca,'xtick',1:18:300,'xticklabel',{round(x(1,2).times(1,1:18:300))})

hold on
plot(x(1,1).times,redo{1,2},'Color','red','LineWidth',4, 'Linestyle', '--'); 
set(gca,'xlim',[-200 700],'YDir','reverse');
xlabel('Time (ms)','FontSize',15,'FontName','Arial')
ylabel('Amplitude (µV)','FontSize',15,'FontName','Arial')
% set(gca,'xtick',1:18:300,'xticklabel',{round(x(1,2).times(1,1:18:300))})

% set dsahed 0 line
dasx = [-200 700];
dasy = [0 0];
line(dasx,dasy,'Color',[0.7 0.7 0.7],'LineStyle',':','LineWidth',4)
dasz = [0 0];
dasw = [-5 20];
line(dasz,dasw,'Color',[0.7 0.7 0.7],'LineStyle',':','LineWidth',4)

title('FRN','FontSize',18,'FontName','Arial')

hlegend = legend('Regular pos FB','Regular neg FB','Redo pos FB', 'Redo neg FB')
set(hlegend, 'Fontsize', 15)

elseif ERPtype == 2

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% fig. 3 - RewP @ Cz + FCz - redo 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure;
subplot(1,2,1)
plot(x(1,1).times,nore{1,1},'Color',[0 0 0.5],'LineWidth',4);
set(gca,'xlim',[-200 700],'YDir','reverse','FontSize', 17,'xtick',-200:100:700); 
xlabel('Time (ms)','FontSize',17,'FontName','Arial')
ylabel('Amplitude (µV)','FontSize',17,'FontName','Arial')
% set(gca,'xtick',1:18:300,'xticklabel',{round(x(1,2).times(1,1:18:300))})

hold on
plot(x(1,1).times,nore{1,2},'Color',[0.5 0.5 0.7],'LineWidth',4); 

plot(x(1,1).times,redo{1,1},'Color',[0 0 0.5],'LineWidth',4,'LineStyle','--');

plot(x(1,1).times,redo{1,2},'Color',[0.5 0.5 0.7],'LineWidth',4,'LineStyle','--'); 



% set dsahed 0 line
dasx = [-200 700];
dasy = [0 0];
line(dasx,dasy,'Color',[0.7 0.7 0.7],'LineStyle','-','LineWidth',2)
dasz = [0 0];
dasw = [-5 20];
line(dasz,dasw,'Color',[0.7 0.7 0.7],'LineStyle','-','LineWidth',2)
% set dsahed 235 285ms line
dasa = [235 235];
dasb = [0 20];
line(dasa,dasb,'Color',[0.7 0.7 0.7],'LineStyle','--','LineWidth',2)
dasc = [285 285];
dasd = [0 20];
line(dasc,dasd,'Color',[0.7 0.7 0.7],'LineStyle','--','LineWidth',2)

title('RewP','FontSize',26,'FontName','Arial')      % original title: RewP - Outcome x trial type

hlegend = legend('Regular reward','Regular no-reward','Special reward','Special no-reward')
set(hlegend, 'Fontsize', 17)


% RewP contrast
subplot(1,2,2)

dredo = redo{1,1} - redo{1,2};
dnore = nore{1,1} -  nore{1,2};

plot(x(1,1).times,dnore,'Color',[0.2 0.2 0.2],'LineWidth',4,'LineStyle','-.');
set(gca,'xlim',[-200 700],'YDir','reverse','FontSize', 17,'xtick',-200:100:700); 
xlabel('Time (ms)','FontSize',17,'FontName','Arial')
ylabel('Amplitude (µV)','FontSize',17,'FontName','Arial')
hold on
plot(x(1,1).times,dredo,'Color',[1 0 0],'LineWidth',4,'LineStyle','-.'); 

% set dsahed 0 line
dasx = [-200 700];
dasy = [0 0];
line(dasx,dasy,'Color',[0.7 0.7 0.7],'LineStyle','-','LineWidth',2)
dasz = [0 0];
dasw = [-5 20];
line(dasz,dasw,'Color',[0.7 0.7 0.7],'LineStyle','-','LineWidth',2)
% set dsahed 235 285ms line
dasa = [235 235];
dasb = [0 20];
line(dasa,dasb,'Color',[0.7 0.7 0.7],'LineStyle','--','LineWidth',2)
dasc = [285 285];
dasd = [0 20];
line(dasc,dasd,'Color',[0.7 0.7 0.7],'LineStyle','--','LineWidth',2)

title('\Delta RewP','FontSize',26,'FontName','Arial')  % original title: \Delta RewP - trial type

hlegend = legend('\Delta RewP regular','\Delta RewP special')
set(hlegend, 'Fontsize', 17)


elseif ERPtype == 3

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% fig. ? - P3 @ Pz - redo  -  to check for P3 effects        28/08/2017
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure;
plot(x(1,1).times,nore{1,1},'Color',[0 0.8 0],'LineWidth',4);
set(gca,'xlim',[-200 700],'YDir','reverse'); 
xlabel('Time (ms)','FontSize',15,'FontName','Arial')
ylabel('Amplitude (µV)','FontSize',15,'FontName','Arial')
% set(gca,'xtick',1:18:300,'xticklabel',{round(x(1,2).times(1,1:18:300))})

hold on
plot(x(1,1).times,nore{1,2},'Color','red','LineWidth',4); 
set(gca,'xlim',[-200 700],'YDir','reverse');
xlabel('Time (ms)','FontSize',15,'FontName','Arial')
ylabel('Amplitude (µV)','FontSize',15,'FontName','Arial')
% set(gca,'xtick',1:18:300,'xticklabel',{round(x(1,2).times(1,1:18:300))})

hold on
plot(x(1,1).times,redo{1,1},'Color',[0 0.5 0],'LineWidth',4); 
set(gca,'xlim',[-200 700],'YDir','reverse');
xlabel('Time (ms)','FontSize',15,'FontName','Arial')
ylabel('Amplitude (µV)','FontSize',15,'FontName','Arial')
% set(gca,'xtick',1:18:300,'xticklabel',{round(x(1,2).times(1,1:18:300))})

hold on
plot(x(1,1).times,redo{1,2},'Color',[0.5 0 0],'LineWidth',4); 
set(gca,'xlim',[-200 700],'YDir','reverse');
xlabel('Time (ms)','FontSize',15,'FontName','Arial')
ylabel('Amplitude (µV)','FontSize',15,'FontName','Arial')
% set(gca,'xtick',1:18:300,'xticklabel',{round(x(1,2).times(1,1:18:300))})

% set dsahed 0 line
dasx = [-200 700];
dasy = [0 0];
line(dasx,dasy,'Color',[0.7 0.7 0.7],'LineStyle',':','LineWidth',4)
dasz = [0 0];
dasw = [-2 16];
line(dasz,dasw,'Color',[0.7 0.7 0.7],'LineStyle',':','LineWidth',4)

title('FRN','FontSize',18,'FontName','Arial')

hlegend = legend('Regular pos FB','Regular neg FB', 'Redo pos FB', 'Redo neg FB')
set(hlegend, 'Fontsize', 15)

end 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                        % fig. 3 - RewP topoplot 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%      Topoplot RewP  - 235 to 285 ms -                              19/04/2017
% Door gambling task - FB  contrasts  ERPs              
% Redo vs non redo                             


clc
clearvars -except ERPtype


pathin = 'C:\Users\gdavide\Documents\MATLAB\dg_workspace16\Door gambling redos\splitted\merged datasets - final 26 sample\redo nore'
pathout = 'C:\Users\gdavide\Documents\MATLAB\dg_workspace16\Door gambling redos\splitted\merged datasets - final 26 sample\redo nore'
cd (pathin)

figure;

if ERPtype == 1 || ERPtype == 2 
time = [235; 285]; % time window for FRN and RewP
elseif ERPtype == 3
time = [320; 340];  % time window for P3
end

c = 0;

% define sbjs
sn = [7:9 11:14 16 18:23 25 26 28 29 31:33]; 
   
% conditions        nonredo = 121 | 122     redo = 141 | 1428

for cond = [1 2] 

    
% initializing matrices
dux = zeros(2048,64);
duy = zeros(2048,64);

% counter for xls sheets
c = c+1;

% importing
for i = [1:length(sn)]
    if any ([7:9 11:14 16 18:23 25 26] == sn(i));          % load 'design1'   
        x(i) = importdata (['design1_h' num2str(sn(i)) '_12' num2str(cond) '.daterp']);
        if cond == 1
            y(i) = importdata (['design1_h' num2str(sn(i)) '_14' num2str(cond) '.daterp']);
        else
            y(i) = importdata (['design1_h' num2str(sn(i)) '_14' num2str(cond) '8.daterp']);
        end
    elseif any ([28 29 31:33] == sn(i));                   % load 'design2'
        x(i) = importdata (['design2_h' num2str(sn(i)) '_12' num2str(cond) '.daterp']);
        if cond == 1
            y(i) = importdata (['design2_h' num2str(sn(i)) '_14' num2str(cond) '.daterp']);
        else
            y(i) = importdata (['design2_h' num2str(sn(i)) '_14' num2str(cond) '8.daterp']);
        end
    end

% filling the 2d matrices with 64 channels
for channo = 1:64
    chaname = ['chan' num2str(channo)]
    dux(:,channo)= x(i).(chaname);
    duy(:,channo)= y(i).(chaname);
end

% filling the 3d matrices with sbjs

tred(:,:,i) = dux;
tref(:,:,i) = duy;  
end

% averaging on the 3th dimension (subjects)
reg = mean(tred,3);
spec = mean(tref,3);

% subtracting trial type
dif = spec - reg;

   
% preparing topo
EEG.chanlocs = readlocs('channs.locs')
% define timing
topo_time = (dsearchn(x(1,1).times',time(1))):(dsearchn(x(1,1).times',time(2)))

% Average amplitude in defined time window in order to topoplot 
% + store pos and neg cond
reg_topo(cond,:,:) = reg(topo_time,:);        %subselect times

spec_topo(cond,:,:) = spec(topo_time,:);        %subselect times

end
reg_amp(:,:) = squeeze(mean(reg_topo,2));            %average times - get a vector (chans) per cond
spec_amp(:,:) = squeeze(mean(spec_topo,2));            %average times - get a vector (chans) per cond

reg_topo_dif = reg_amp(1,:) - reg_amp(2,:);     % valence difference
spec_topo_dif = spec_amp(1,:) - spec_amp(2,:);

%Plot

subplot(1,2,1);
topoplot(reg_topo_dif,EEG.chanlocs,'plotchans',[1:64],'maplimits',[-1 9] );    %,'maplimits',[-4 4] / 'maxmin'  ,'electrodes','ptslabels'
cbh = colorbar;
set(get(cbh,'xlabel'),'string','\muV','FontSize',14);
set(gca,'FontSize', 14)
title('\Delta RewP regular','Fontsize', 14,'FontName','Arial')
subplot(1,2,2);
topoplot(spec_topo_dif,EEG.chanlocs,'plotchans',[1:64],'maplimits',[-1 9] );    %,'maplimits',[-4 4] / 'maxmin'  ,'electrodes','ptslabels'
cbh = colorbar;
set(get(cbh,'xlabel'),'string','\muV','FontSize',14);
set(gca,'FontSize', 14)
title('\Delta RewP special','Fontsize', 14,'FontName','Arial')


%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%% part 4 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%% ERSP - redo x outcome %%%%%%%%%%%%%%%%%%%%%%%%%

% Door gambling task - FB  contrasts  ERSP              29/11/2016
% Redo vs non redo                              updated 17/02/2017

% + theta and delta figures                     updated 19/04/2017
% + high Beta                                           20/08/2017          
    
clc
clear

%%%%% defining band - theta @FCz = 1 \ delta @ CPZCP1CP2CP3CP4 = 2 %%%%%%%%
%%%%%%%%%%%%%%%%%%% \ high Beta @ FCzFzFC1FC2, 250-350ms = 3 %%%%%%%%%%%%%%
band = 1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% defining band ranges (Hz)
if band == 1
    blimit = [4; 8];
elseif band == 2
    blimit = [0.8; 3.9];
elseif band == 3
    blimit = [20; 35];
end

% defining time range
if band == 1 || band == 2
    time = [200;400];
elseif band == 3
    time = [250;350];
end

figure;

pathin = 'C:\Users\gdavide\Documents\MATLAB\dg_workspace16\Door gambling redos\splitted\merged datasets - final 26 sample\redo nore'
pathout = 'C:\Users\gdavide\Documents\MATLAB\dg_workspace16\Door gambling redos\splitted\merged datasets - final 26 sample\redo nore'
cd (pathin)

c = 0;

% define sbjs
sn = [7:9 11:14 16 18:23 25 26 28 29 31:33];    

% conditions        nonredo = 121 | 122     redo = 141 | 1428

for cond = [1 2] 

    
% initializing matrices
tred = zeros(75,200,length(sn));
tref = zeros(75,200,length(sn));

% counter for xls sheets
c = c+1;

% importing
for i = [1:length(sn)]
    if any ([7:9 11:14 16 18:23 25 26] == sn(i));          % load 'design1'
        x(i) = importdata (['design1_h' num2str(sn(i)) '_12' num2str(cond) '.datersp']);
        if cond == 1
            y(i) = importdata (['design1_h' num2str(sn(i)) '_14' num2str(cond) '.datersp']);
        else
            y(i) = importdata (['design1_h' num2str(sn(i)) '_14' num2str(cond) '8.datersp']);
        end
    elseif any ([28 29 31:33] == sn(i));                   % load 'design2'
        x(i) = importdata (['design2_h' num2str(sn(i)) '_12' num2str(cond) '.datersp']);
        if cond == 1
            y(i) = importdata (['design2_h' num2str(sn(i)) '_14' num2str(cond) '.datersp']);
        else
            y(i) = importdata (['design2_h' num2str(sn(i)) '_14' num2str(cond) '8.datersp']);
        end
    end
    
% filling the 3d matrices

if band == 1
    % single channel for theta - FCz 
    tred(:,:,i) = (x(i).chan47_ersp);
    tref(:,:,i) = (y(i).chan47_ersp);

elseif band == 2
    % (cluster of parietal channels for delta) 
    tred(:,:,i) = ((x(i).chan32_ersp)+(x(i).chan19_ersp)+(x(i).chan18_ersp)+(x(i).chan56_ersp)+(x(i).chan55_ersp))/5;  % FCz: 47 FC1: 11 FC2: 46 Fz: 38 CPz: 32 CP1: 19 CP3: 18 CP2: 56 CP4: 55
    tref(:,:,i) = ((y(i).chan32_ersp)+(y(i).chan19_ersp)+(y(i).chan18_ersp)+(y(i).chan56_ersp)+(y(i).chan55_ersp))/5;
elseif band == 3
% (cluster of frontal channels for high beta - FCz Fz FC1 FC2)
tred(:,:,i) = ((x(i).chan47_ersp)+(x(i).chan38_ersp)+(x(i).chan11_ersp)+(x(i).chan46_ersp))/4;
tref(:,:,i) = ((y(i).chan47_ersp)+(y(i).chan38_ersp)+(y(i).chan11_ersp)+(y(i).chan46_ersp))/4;
end

% others combination of channels
% % FCz + Fz for high Beta 
% tred(:,:,i) = ((x(i).chan47_ersp)+(x(i).chan38_ersp))/2;
% tref(:,:,i) = ((y(i).chan47_ersp)+(y(i).chan38_ersp))/2;    
%(cluster of frontocentral channels for theta)
% tred(:,:,i) = ((x(i).chan47_ersp)+(x(i).chan11_ersp)+(x(i).chan46_ersp)+(x(i).chan38_ersp))/4;  % FCz: 47 FC1: 11 FC2: 46 Fz: 38 CPz: 32 CP1: 19 CP3: 18 CP2: 56 CP4: 55
% tref(:,:,i) = ((y(i).chan47_ersp)+(y(i).chan11_ersp)+(y(i).chan46_ersp)+(y(i).chan38_ersp))/4;

end

% averaging on the 3rd dimension (subjects) and put pos / neg in a struct
nore{cond} = mean(tred,3);
redo{cond} = mean(tref,3);




% door gambling redos - extracting individual scores - mean ERPS   % 26/01/2017
% theta freqs 4-8, times 200-400 (FB) / ?-? (RT)
% delta freqs 0.8-3.9, times 200-400 (FB) / ?-? (RT)
norem = squeeze(mean(mean(tred(dsearchn(x(1,1).freqs',blimit(1)):dsearchn(x(1,1).freqs',blimit(2)),dsearchn(x(1,1).times',time(1)):dsearchn(x(1,1).times',time(2)),:))))
redom = squeeze(mean(mean(tref(dsearchn(x(1,1).freqs',blimit(1)):dsearchn(x(1,1).freqs',blimit(2)),dsearchn(x(1,1).times',time(1)):dsearchn(x(1,1).times',time(2)),:))))
xlscomb = [norem,redom]

if band == 1
% xlswrite(['C:\Users\gdavide\Documents\MATLAB\dg_workspace16\Door gambling redos\splitted\merged datasets - final 26 sample\final21_HC_Fb_redo_nore_FCz_ERSP_4_8_200_400.xls'],xlscomb,(c));
elseif band == 2
% xlswrite(['C:\Users\gdavide\Documents\MATLAB\dg_workspace16\Door gambling redos\splitted\merged datasets - final 26 sample\final21_HC_Fb_redo_nore_CPzCP1CP2CP3CP4_ERSP_0.8_3.9_200_400.xls'],xlscomb,(c));
elseif band == 3
% xlswrite(['C:\Users\gdavide\Documents\MATLAB\dg_workspace16\Door gambling redos\splitted\merged datasets - final 26 sample\final21_HC_Fb_redo_nore_FCzFzFC1FC2_ERSP_20_35_250_350.xls'],xlscomb,(c));

end


end

% subtracting conditions

% % redo contrast
% pos = redo{1,1} - nore{1,1};
% neg = redo{1,2} -  nore{1,2};
% 
% subplot(2,1,1);
% imagesc(x(1,1).times,[],neg);      %x(1,1).freqs,
% colorbar;
% set(gca,'clim',[-2 2],'xlim',[-500 600],'YDir','normal');     %'clim',[-2 2],       [-200 500]    'ylim',[2 45],
% xlabel('Time (ms)','FontSize',12,'FontName','Arial')
% ylabel('Frequency (hz)','FontSize',12,'FontName','Arial')
% % set(gca,'xtick',1:18:300,'xticklabel',{round(x(1,2).times(1,1:18:300))})
% set(gca,'ytick',1:10:75,'yticklabel',{round(x(1,1).freqs(1,1:10:75))})
% title('neg redo - no redo','FontSize',12,'FontName','Arial')
% 
% hold on
% 
% subplot(2,1,2);
% imagesc(x(1,1).times,[],pos);      %x(1,1).freqs,
% colorbar;
% set(gca,'clim',[-2 2],'xlim',[-500 600],'YDir','normal');     %'clim',[-3 3.5],       [-200 500]    'ylim',[2 45],
% xlabel('Time (ms)','FontSize',12,'FontName','Arial')
% ylabel('Frequency (hz)','FontSize',12,'FontName','Arial')
% % set(gca,'xtick',1:18:300,'xticklabel',{round(x(1,2).times(1,1:18:300))})
% set(gca,'ytick',1:10:75,'yticklabel',{round(x(1,1).freqs(1,1:10:75))})
% title('pos redo - no redo','FontSize',12,'FontName','Arial')
% % 


if band == 1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Fig 4    - theta @ FCz - type x valence       19/04/2017
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

timein = - 250;
timeout = 550;
freqin = 1.5;           % freqin = 3;     (for strict theta plot)
freqout = 35;           % freqout = 16;
clim = [-4.5 4.5]       % [-4.2 4.2]

% 1
subplot(2,2,1);
imagesc(x(1,1).times,[],nore{1,1});      %x(1,1).freqs,
cbh = colorbar;
set(get(cbh,'xlabel'),'string','dB','FontSize',17);
set(gca,'clim',clim,'xlim',[timein timeout],'YDir','normal');    
%xlabel('Time (ms)','FontSize',17,'FontName','Arial')
ylabel('Frequency (hz)','FontSize',17,'FontName','Arial')
% set(gca,'xtick',1:18:200,'xticklabel',{round(x(1,2).times(1,1:18:200))})
set(gca,'ytick',1:5:75,'yticklabel',{round((x(1,1).freqs(1,1:5:75))*10)/10}, 'ylim',[dsearchn(x(1,1).freqs',freqin) dsearchn(x(1,1).freqs', freqout)],'FontSize', 17)
%title('Regular - positive FB','FontSize',12,'FontName','Arial')

% set dsahed 0 line
dasz = [0 0];
dasw = [dsearchn(x(1,1).freqs',0) dsearchn(x(1,1).freqs', 35)];
line(dasz,dasw,'Color',[0.5 0.5 0.5],'LineStyle',':','LineWidth',2)
% set band line
dasx = [timein timeout];
dasy = [dsearchn(x(1,1).freqs', 4) dsearchn(x(1,1).freqs', 4)];     % 3.7
line(dasx,dasy,'Color',[0.4 0.4 0.4],'LineStyle','-','LineWidth',1)
dasx = [timein timeout];
dasy = [dsearchn(x(1,1).freqs', 8); dsearchn(x(1,1).freqs', 8)];
line(dasx,dasy,'Color',[0.4 0.4 0.4],'LineStyle','-','LineWidth',1)

% 2
subplot(2,2,2);
imagesc(x(1,1).times,[],nore{1,2});      %x(1,1).freqs,
cbh = colorbar;
set(get(cbh,'xlabel'),'string','dB','FontSize',17);
set(gca,'clim',clim,'xlim',[timein timeout],'YDir','normal');    
%xlabel('Time (ms)','FontSize',17,'FontName','Arial')
%ylabel('Frequency (hz)','FontSize',17,'FontName','Arial')
% set(gca,'xtick',1:18:200,'xticklabel',{round(x(1,2).times(1,1:18:200))})
set(gca,'ytick',1:5:75,'yticklabel',{round((x(1,1).freqs(1,1:5:75))*10)/10}, 'ylim',[dsearchn(x(1,1).freqs',freqin) dsearchn(x(1,1).freqs', freqout)],'FontSize', 17)
%title('Regular - negative FB','FontSize',12,'FontName','Arial')

% set dsahed 0 line
dasz = [0 0];
dasw = [dsearchn(x(1,1).freqs',0) dsearchn(x(1,1).freqs', 35)];
line(dasz,dasw,'Color',[0.5 0.5 0.5],'LineStyle',':','LineWidth',2)
% set band line
dasx = [timein timeout];
dasy = [dsearchn(x(1,1).freqs', 4) dsearchn(x(1,1).freqs', 4)];
line(dasx,dasy,'Color',[0.4 0.4 0.4],'LineStyle','-','LineWidth',1)
dasx = [timein timeout];
dasy = [dsearchn(x(1,1).freqs', 8); dsearchn(x(1,1).freqs', 8)];
line(dasx,dasy,'Color',[0.4 0.4 0.4],'LineStyle','-','LineWidth',1)

% 3
subplot(2,2,3);
imagesc(x(1,1).times,[],redo{1,1});      %x(1,1).freqs,
cbh = colorbar;
set(get(cbh,'xlabel'),'string','dB','FontSize',17);
set(gca,'clim',clim,'xlim',[timein timeout],'YDir','normal');    
xlabel('Time (ms)','FontSize',17,'FontName','Arial')
ylabel('Frequency (hz)','FontSize',17,'FontName','Arial')
% set(gca,'xtick',1:18:200,'xticklabel',{round(x(1,2).times(1,1:18:200))})
set(gca,'ytick',1:5:75,'yticklabel',{round((x(1,1).freqs(1,1:5:75))*10)/10}, 'ylim',[dsearchn(x(1,1).freqs',freqin) dsearchn(x(1,1).freqs', freqout)],'FontSize', 17)
%title('Special - positive FB','FontSize',12,'FontName','Arial')

% set dsahed 0 line
dasz = [0 0];
dasw = [dsearchn(x(1,1).freqs',0) dsearchn(x(1,1).freqs', 35)];
line(dasz,dasw,'Color',[0.5 0.5 0.5],'LineStyle',':','LineWidth',2)
% set band line
dasx = [timein timeout];
dasy = [dsearchn(x(1,1).freqs', 4) dsearchn(x(1,1).freqs', 4)];
line(dasx,dasy,'Color',[0.4 0.4 0.4],'LineStyle','-','LineWidth',1)
dasx = [timein timeout];
dasy = [dsearchn(x(1,1).freqs', 8); dsearchn(x(1,1).freqs', 8)];
line(dasx,dasy,'Color',[0.4 0.4 0.4],'LineStyle','-','LineWidth',1)

% 4
subplot(2,2,4);
imagesc(x(1,1).times,[],redo{1,2});      %x(1,1).freqs,
cbh = colorbar;
set(get(cbh,'xlabel'),'string','dB','FontSize',17);
set(gca,'clim',clim,'xlim',[timein timeout],'YDir','normal');    
xlabel('Time (ms)','FontSize',17,'FontName','Arial')
%ylabel('Frequency (hz)','FontSize',17,'FontName','Arial')
% set(gca,'xtick',1:18:200,'xticklabel',{round(x(1,2).times(1,1:18:200))})
set(gca,'ytick',1:5:75,'yticklabel',{round((x(1,1).freqs(1,1:5:75))*10)/10}, 'ylim',[dsearchn(x(1,1).freqs',freqin) dsearchn(x(1,1).freqs', freqout)],'FontSize', 17)
%title('Special - negative FB','FontSize',12,'FontName','Arial')

% set dsahed 0 line
dasz = [0 0];
dasw = [dsearchn(x(1,1).freqs',0) dsearchn(x(1,1).freqs', 35)];
line(dasz,dasw,'Color',[0.5 0.5 0.5],'LineStyle',':','LineWidth',2)
% set band line
dasx = [timein timeout];
dasy = [dsearchn(x(1,1).freqs', 4) dsearchn(x(1,1).freqs', 4)];
line(dasx,dasy,'Color',[0.4 0.4 0.4],'LineStyle','-','LineWidth',1)
dasx = [timein timeout];
dasy = [dsearchn(x(1,1).freqs', 8); dsearchn(x(1,1).freqs', 8)];
line(dasx,dasy,'Color',[0.4 0.4 0.4],'LineStyle','-','LineWidth',1)

elseif band == 2
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Fig 5    - delta @ CPz CP1 CP2 CP3 CP4 - type x valence   19/04/2017
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

timein = - 250;
timeout = 550;
freqin = 0.8;
freqout = 6;
clim = [-5.2 5.2]

% 1
subplot(2,2,1);
imagesc(x(1,1).times,[],nore{1,1});      %x(1,1).freqs,
cbh = colorbar;
set(get(cbh,'xlabel'),'string','dB','FontSize',17);
set(gca,'clim',clim,'xlim',[timein timeout],'YDir','normal');    
% xlabel('Time (ms)','FontSize',17,'FontName','Arial')
ylabel('Frequency (hz)','FontSize',17,'FontName','Arial')
% set(gca,'xtick',1:18:200,'xticklabel',{round(x(1,2).times(1,1:18:200))})
set(gca,'ytick',1:5:75,'yticklabel',{round((x(1,1).freqs(1,1:5:75))*10)/10}, 'ylim',[dsearchn(x(1,1).freqs',freqin) dsearchn(x(1,1).freqs', freqout)],'FontSize', 17)
% title('Regular - positive FB','FontSize',12,'FontName','Arial')


% set dsahed 0 line
dasz = [0 0];
dasw = [dsearchn(x(1,1).freqs',0) dsearchn(x(1,1).freqs', 35)];
line(dasz,dasw,'Color',[0.5 0.5 0.5],'LineStyle',':','LineWidth',2)
% set band line
dasx = [timein timeout];
dasy = [dsearchn(x(1,1).freqs', 3.9) dsearchn(x(1,1).freqs', 3.9)];
line(dasx,dasy,'Color',[0.4 0.4 0.4],'LineStyle','-','LineWidth',1)
dasx = [timein timeout];
dasy = [dsearchn(x(1,1).freqs', 8); dsearchn(x(1,1).freqs', 8)];
line(dasx,dasy,'Color',[0.4 0.4 0.4],'LineStyle','-','LineWidth',1)

% 2
subplot(2,2,2);
imagesc(x(1,1).times,[],nore{1,2});      %x(1,1).freqs,
cbh = colorbar;
set(get(cbh,'xlabel'),'string','dB','FontSize',17);
set(gca,'clim',clim,'xlim',[timein timeout],'YDir','normal');    
% xlabel('Time (ms)','FontSize',17,'FontName','Arial')
% ylabel('Frequency (hz)','FontSize',17,'FontName','Arial')
% set(gca,'xtick',1:18:200,'xticklabel',{round(x(1,2).times(1,1:18:200))})
set(gca,'ytick',1:5:75,'yticklabel',{round((x(1,1).freqs(1,1:5:75))*10)/10}, 'ylim',[dsearchn(x(1,1).freqs',freqin) dsearchn(x(1,1).freqs', freqout)],'FontSize', 17)
% title('Regular - negative FB','FontSize',12,'FontName','Arial')

% set dsahed 0 line
dasz = [0 0];
dasw = [dsearchn(x(1,1).freqs',0) dsearchn(x(1,1).freqs', 35)];
line(dasz,dasw,'Color',[0.5 0.5 0.5],'LineStyle',':','LineWidth',2)
% set band line
dasx = [timein timeout];
dasy = [dsearchn(x(1,1).freqs', 3.9) dsearchn(x(1,1).freqs', 3.9)];
line(dasx,dasy,'Color',[0.4 0.4 0.4],'LineStyle','-','LineWidth',1)
dasx = [timein timeout];
dasy = [dsearchn(x(1,1).freqs', 8); dsearchn(x(1,1).freqs', 8)];
line(dasx,dasy,'Color',[0.4 0.4 0.4],'LineStyle','-','LineWidth',1)

% 3
subplot(2,2,3);
imagesc(x(1,1).times,[],redo{1,1});      %x(1,1).freqs,
cbh = colorbar;
set(get(cbh,'xlabel'),'string','dB','FontSize',17);
set(gca,'clim',clim,'xlim',[timein timeout],'YDir','normal');    
xlabel('Time (ms)','FontSize',17,'FontName','Arial')
ylabel('Frequency (hz)','FontSize',17,'FontName','Arial')
% set(gca,'xtick',1:18:200,'xticklabel',{round(x(1,2).times(1,1:18:200))})
set(gca,'ytick',1:5:75,'yticklabel',{round((x(1,1).freqs(1,1:5:75))*10)/10}, 'ylim',[dsearchn(x(1,1).freqs',freqin) dsearchn(x(1,1).freqs', freqout)],'FontSize', 17)
% title('Special - positive FB','FontSize',12,'FontName','Arial')

% set dsahed 0 line
dasz = [0 0];
dasw = [dsearchn(x(1,1).freqs',0) dsearchn(x(1,1).freqs', 35)];
line(dasz,dasw,'Color',[0.5 0.5 0.5],'LineStyle',':','LineWidth',2)
% set band line
dasx = [timein timeout];
dasy = [dsearchn(x(1,1).freqs', 3.9) dsearchn(x(1,1).freqs', 3.9)];
line(dasx,dasy,'Color',[0.4 0.4 0.4],'LineStyle','-','LineWidth',1)
dasx = [timein timeout];
dasy = [dsearchn(x(1,1).freqs', 8); dsearchn(x(1,1).freqs', 8)];
line(dasx,dasy,'Color',[0.4 0.4 0.4],'LineStyle','-','LineWidth',1)

% 4
subplot(2,2,4);
imagesc(x(1,1).times,[],redo{1,2});      %x(1,1).freqs,
cbh = colorbar;
set(get(cbh,'xlabel'),'string','dB','FontSize',17);
set(gca,'clim',clim,'xlim',[timein timeout],'YDir','normal');    
xlabel('Time (ms)','FontSize',17,'FontName','Arial')
% ylabel('Frequency (hz)','FontSize',17,'FontName','Arial')
% set(gca,'xtick',1:18:200,'xticklabel',{round(x(1,2).times(1,1:18:200))})
set(gca,'ytick',1:5:75,'yticklabel',{round((x(1,1).freqs(1,1:5:75))*10)/10}, 'ylim',[dsearchn(x(1,1).freqs',freqin) dsearchn(x(1,1).freqs', freqout)],'FontSize', 17)
% title('Special - negative FB','FontSize',12,'FontName','Arial')

% set dsahed 0 line
dasz = [0 0];
dasw = [dsearchn(x(1,1).freqs',0) dsearchn(x(1,1).freqs', 35)];
line(dasz,dasw,'Color',[0.5 0.5 0.5],'LineStyle',':','LineWidth',2)
% set band line
dasx = [timein timeout];
dasy = [dsearchn(x(1,1).freqs', 3.9) dsearchn(x(1,1).freqs', 3.9)];
line(dasx,dasy,'Color',[0.4 0.4 0.4],'LineStyle','-','LineWidth',1)
dasx = [timein timeout];
dasy = [dsearchn(x(1,1).freqs', 8); dsearchn(x(1,1).freqs', 8)];
line(dasx,dasy,'Color',[0.4 0.4 0.4],'LineStyle','-','LineWidth',1)

elseif band == 3
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Fig 6    - high Beta @ FCz Fz - type x valence   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

timein = - 250;
timeout = 550;
freqin = 15;
freqout = 35;
clim = [-2.7 2.7]

% 1
subplot(2,2,1);
imagesc(x(1,1).times,[],nore{1,1});      %x(1,1).freqs,
cbh = colorbar;
set(get(cbh,'xlabel'),'string','dB','FontSize',17);
set(gca,'clim',clim,'xlim',[timein timeout],'YDir','normal');    
% xlabel('Time (ms)','FontSize',17,'FontName','Arial')
ylabel('Frequency (hz)','FontSize',17,'FontName','Arial')
% set(gca,'xtick',1:18:200,'xticklabel',{round(x(1,2).times(1,1:18:200))})
set(gca,'ytick',1:3:75,'yticklabel',{round(x(1,1).freqs(1,1:3:75))}, 'ylim',[dsearchn(x(1,1).freqs',freqin) dsearchn(x(1,1).freqs', freqout)],'FontSize', 17)
% title('Regular - positive FB','FontSize',12,'FontName','Arial')

% set dsahed 0 line
dasz = [0 0];
dasw = [dsearchn(x(1,1).freqs',0) dsearchn(x(1,1).freqs', 35)];
line(dasz,dasw,'Color',[0.5 0.5 0.5],'LineStyle',':','LineWidth',2)
% set band line
dasx = [timein timeout];
dasy = [dsearchn(x(1,1).freqs', 20) dsearchn(x(1,1).freqs', 20)];
line(dasx,dasy,'Color',[0.4 0.4 0.4],'LineStyle','-','LineWidth',1)
dasx = [timein timeout];
dasy = [dsearchn(x(1,1).freqs', 8); dsearchn(x(1,1).freqs', 8)];
line(dasx,dasy,'Color',[0.4 0.4 0.4],'LineStyle','-','LineWidth',1)

% 2
subplot(2,2,2);
imagesc(x(1,1).times,[],nore{1,2});      %x(1,1).freqs,
cbh = colorbar;
set(get(cbh,'xlabel'),'string','dB','FontSize',17);
set(gca,'clim',clim,'xlim',[timein timeout],'YDir','normal');    
% xlabel('Time (ms)','FontSize',17,'FontName','Arial')
% ylabel('Frequency (hz)','FontSize',17,'FontName','Arial')
% set(gca,'xtick',1:18:200,'xticklabel',{round(x(1,2).times(1,1:18:200))})
set(gca,'ytick',1:3:75,'yticklabel',{round(x(1,1).freqs(1,1:3:75))}, 'ylim',[dsearchn(x(1,1).freqs',freqin) dsearchn(x(1,1).freqs', freqout)],'FontSize', 17)
% title('Regular - negative FB','FontSize',12,'FontName','Arial')

% set dsahed 0 line
dasz = [0 0];
dasw = [dsearchn(x(1,1).freqs',0) dsearchn(x(1,1).freqs', 35)];
line(dasz,dasw,'Color',[0.5 0.5 0.5],'LineStyle',':','LineWidth',2)
% set band line
dasx = [timein timeout];
dasy = [dsearchn(x(1,1).freqs', 20) dsearchn(x(1,1).freqs', 20)];
line(dasx,dasy,'Color',[0.4 0.4 0.4],'LineStyle','-','LineWidth',1)
dasx = [timein timeout];
dasy = [dsearchn(x(1,1).freqs', 8); dsearchn(x(1,1).freqs', 8)];
line(dasx,dasy,'Color',[0.4 0.4 0.4],'LineStyle','-','LineWidth',1)

% 3
subplot(2,2,3);
imagesc(x(1,1).times,[],redo{1,1});      %x(1,1).freqs,
cbh = colorbar;
set(get(cbh,'xlabel'),'string','dB','FontSize',17);
set(gca,'clim',clim,'xlim',[timein timeout],'YDir','normal');    
xlabel('Time (ms)','FontSize',17,'FontName','Arial')
ylabel('Frequency (hz)','FontSize',17,'FontName','Arial')
% set(gca,'xtick',1:18:200,'xticklabel',{round(x(1,2).times(1,1:18:200))})
set(gca,'ytick',1:3:75,'yticklabel',{round(x(1,1).freqs(1,1:3:75))}, 'ylim',[dsearchn(x(1,1).freqs',freqin) dsearchn(x(1,1).freqs', freqout)],'FontSize', 17)
% title('Special - positive FB','FontSize',12,'FontName','Arial')

% set dsahed 0 line
dasz = [0 0];
dasw = [dsearchn(x(1,1).freqs',0) dsearchn(x(1,1).freqs', 35)];
line(dasz,dasw,'Color',[0.5 0.5 0.5],'LineStyle',':','LineWidth',2)
% set band line
dasx = [timein timeout];
dasy = [dsearchn(x(1,1).freqs', 20) dsearchn(x(1,1).freqs', 20)];
line(dasx,dasy,'Color',[0.4 0.4 0.4],'LineStyle','-','LineWidth',1)
dasx = [timein timeout];
dasy = [dsearchn(x(1,1).freqs', 8); dsearchn(x(1,1).freqs', 8)];
line(dasx,dasy,'Color',[0.4 0.4 0.4],'LineStyle','-','LineWidth',1)

% 4
subplot(2,2,4);
imagesc(x(1,1).times,[],redo{1,2});      %x(1,1).freqs,
cbh = colorbar;
set(get(cbh,'xlabel'),'string','dB','FontSize',17);
set(gca,'clim',clim,'xlim',[timein timeout],'YDir','normal');    
xlabel('Time (ms)','FontSize',17,'FontName','Arial')
% ylabel('Frequency (hz)','FontSize',17,'FontName','Arial')
% set(gca,'xtick',1:18:200,'xticklabel',{round(x(1,2).times(1,1:18:200))})
set(gca,'ytick',1:3:75,'yticklabel',{round(x(1,1).freqs(1,1:3:75))}, 'ylim',[dsearchn(x(1,1).freqs',freqin) dsearchn(x(1,1).freqs', freqout)],'FontSize', 17)
% title('Special - negative FB','FontSize',12,'FontName','Arial')

% set dsahed 0 line
dasz = [0 0];
dasw = [dsearchn(x(1,1).freqs',0) dsearchn(x(1,1).freqs', 35)];
line(dasz,dasw,'Color',[0.5 0.5 0.5],'LineStyle',':','LineWidth',2)
% set band line
dasx = [timein timeout];
dasy = [dsearchn(x(1,1).freqs', 20) dsearchn(x(1,1).freqs', 20)];
line(dasx,dasy,'Color',[0.4 0.4 0.4],'LineStyle','-','LineWidth',1)
dasx = [timein timeout];
dasy = [dsearchn(x(1,1).freqs', 8); dsearchn(x(1,1).freqs', 8)];
line(dasx,dasy,'Color',[0.4 0.4 0.4],'LineStyle','-','LineWidth',1)

end

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%% part 5 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%% ERPs - redo x outcome extended low redo %%%%%%%%%%%%%%%

% Door gambling task - FB  contrasts  ERPs              29/11/2016
% Redo vs non redo                              updated 23/02/2017

% RewP and P3 + FRN (peak to peak to peak)      updated 06/04/2017

% + FRN and RewP figures                        updated 19/04/2017
%           --- change chan for FRN or RewP !! ---

% + RewP Short (235 285) from collap localiz deltaRewP updated 27/04/2017

% + RewP Short from average FCz Cz                      05/05/2017


% for EXTENDED SAMPLE (5 sbj low 1428, so looking at reward FB and RewP only) 
% reporting 1428 although very noisy (low trial count)  05/07/2017

clc
clear


%%%%%%%%%%% Define ERP type: FRN ppp @FCz = 1 \ RewP short @FCz Cz = 2 %%%%%%%%%

ERPtype = 2;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

pathin = 'C:\Users\gdavide\Documents\MATLAB\dg_workspace16\Door gambling redos\splitted\merged datasets - final 26 sample\redo nore\extended - low redo'
pathout = 'C:\Users\gdavide\Documents\MATLAB\dg_workspace16\Door gambling redos\splitted\merged datasets - final 26 sample\redo nore\extended - low redo'
cd (pathin)

c = 0;

% define sbjs
sn = [10 15 24 27 30];    

% conditions        nonredo = 121 | 122     redo = 141 | 1428

for cond = [1 2] 

    
% initializing matrices
tred = zeros(2048,length(sn));
tref = zeros(2048,length(sn));

% counter for xls sheets
c = c+1;

% importing
for i = (1:length(sn));
    x(i) = importdata (['design1_h' num2str(sn(i)) '_12' num2str(cond) '.daterp']);
    if cond == 1
        y(i) = importdata (['design1_h' num2str(sn(i)) '_14' num2str(cond) '.daterp']);
    else
        y(i) = importdata (['design1_h' num2str(sn(i)) '_14' num2str(cond) '8.daterp']);
    end
    

% filling the 2d matrices
if ERPtype == 1                     %(FCz)
    tred(:,i) = x(i).chan47;
    tref(:,i) = y(i).chan47;  % FCz: 47 FC1: 11 FC2: 46 Fz: 38 CPz: 32 CP1: 19 CP3: 18 CP2: 56 CP4: 55 Cz: 48
elseif ERPtype == 2                 %(Cz + FCz)
    tred(:,i) = (x(i).chan48 + x(i).chan47)/2;
    tref(:,i) = (y(i).chan48 + y(i).chan47)/2;
    
end

end

% (Grand)averaging on the 2nd dimension (subjects) and put pos / neg in a struct
nore{cond} = mean(tred,2);
redo{cond} = mean(tref,2);


% door gambling redos - extracting individual scores - ERPS   % 24/02/2017

if ERPtype == 1   
% FRN peak to peak to peak (Sallet, 2013: max P170, min FRN, max P3) (FB)
    noreFRN = min(tred(dsearchn(x(1,1).times',200):dsearchn(x(1,1).times',350),:))...
    - (max(tred(dsearchn(x(1,1).times',150):dsearchn(x(1,1).times',250),:))...
    + max(tred(dsearchn(x(1,1).times',250):dsearchn(x(1,1).times',600),:)))/2

    redoFRN = min(tref(dsearchn(x(1,1).times',200):dsearchn(x(1,1).times',350),:))...
    - (max(tref(dsearchn(x(1,1).times',150):dsearchn(x(1,1).times',250),:))...
    + max(tref(dsearchn(x(1,1).times',250):dsearchn(x(1,1).times',600),:)))/2
    FRNcomb = [noreFRN;redoFRN]
% xlswrite(['C:\Users\gdavide\Documents\MATLAB\dg_workspace16\Door gambling redos\splitted\merged datasets - final 26 sample\final5_HC_Fb_redo_nore_lowredo_FCz_FRN ppp.xls'],FRNcomb,(c));

elseif ERPtype == 2    
% RewP Short @ Cz (Novak & Foti 2015 - mean in 235-285ms window)
    noreRewPshort = mean(tred(dsearchn(x(1,1).times',235):dsearchn(x(1,1).times',285),:))
    redoRewPshort = mean(tref(dsearchn(x(1,1).times',235):dsearchn(x(1,1).times',285),:))
    RewPshort = [noreRewPshort;redoRewPshort]
% xlswrite(['C:\Users\gdavide\Documents\MATLAB\dg_workspace16\Door gambling redos\splitted\merged datasets - final 26 sample\final5_HC_Fb_redo_nore_lowredo_Cz_FCz_RewPshort.xls'],RewPshort,(c));

end

% others ERP algorithms (change chan accordingly)

% RewP @ Cz (Threadgill 2016 - mean in 250-350ms window)
% noreRewP = mean(tred(dsearchn(x(1,1).times',250):dsearchn(x(1,1).times',350),:))
% redoRewP = mean(tref(dsearchn(x(1,1).times',250):dsearchn(x(1,1).times',350),:))
% RewPcomb = [noreRewP;redoRewP]
% xlswrite(['C:\Users\gdavide\Documents\MATLAB\dg_workspace16\Door gambling redos\splitted\merged datasets - final 26 sample\final21_HC_Fb_redo_nore_lowredo_Cz_RewP.xls'],RewPcomb,(c));

% P3 @ Cz (Gajewski 2008 - peak in 300-500ms window)
% noreP3 = max(tred(dsearchn(x(1,1).times',300):dsearchn(x(1,1).times',500),:))
% redoP3 = max(tref(dsearchn(x(1,1).times',300):dsearchn(x(1,1).times',500),:))
% P3comb = [noreP3;redoP3]
% xlswrite(['C:\Users\gdavide\Documents\MATLAB\dg_workspace16\Door gambling redos\splitted\merged datasets - final 26 sample\final21_HC_Fb_redo_nore_lowredo_Cz_P3.xls'],P3comb,(c));


end

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%% part 6 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%% ERSP - redo x outcome extended low redo %%%%%%%%%%%%%%%

% Door gambling task - FB  contrasts  ERSP              29/11/2016
% Redo vs non redo                              updated 17/02/2017

% + theta and delta figures                     updated 19/04/2017
% + high Beta (exploratory)                             20/08/2017          

% for EXTENDED SAMPLE (5 sbj low 1428, so looking at reward FB and Delta only) 
% reporting 1428 although very noisy (low trial count)  05/07/2017    

clc
clear

%%%%% defining band - theta @FCz = 1 \ delta @ CPZCP1CP2CP3CP4 = 2 %%%%%%%%
%%%%%%%%%%%%%%%%%%% \ high Beta @ FCz Fz FC1 FC2, 250-350ms = 3 %%%%%%%%%%%
band = 3;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% defining band ranges (Hz)
if band == 1
    blimit = [4; 8];
elseif band == 2
    blimit = [0.8; 3.9];
elseif band == 3
    blimit = [20; 35];
end

% defining time range
if band == 1 || band == 2
    time = [200;400];
elseif band == 3
    time = [250;350];
end

pathin = 'C:\Users\gdavide\Documents\MATLAB\dg_workspace16\Door gambling redos\splitted\merged datasets - final 26 sample\redo nore\extended - low redo'
pathout = 'C:\Users\gdavide\Documents\MATLAB\dg_workspace16\Door gambling redos\splitted\merged datasets - final 26 sample\redo nore\extended - low redo'
cd (pathin)

c = 0;

% define sbjs
sn = [10 15 24 27 30];     

% conditions        nonredo = 121 | 122     redo = 141 | 1428

for cond = [1 2] 

    
% initializing matrices
tred = zeros(75,200,length(sn));
tref = zeros(75,200,length(sn));

% counter for xls sheets
c = c+1;

% importing
for i = [1:length(sn)]  
    x(i) = importdata (['design1_h' num2str(sn(i)) '_12' num2str(cond) '.datersp']);
    if cond == 1
        y(i) = importdata (['design1_h' num2str(sn(i)) '_14' num2str(cond) '.datersp']);
    else
        y(i) = importdata (['design1_h' num2str(sn(i)) '_14' num2str(cond) '8.datersp']);
    end

    
% filling the 3d matrices

    if band == 1
        % single channel for theta - FCz 
        tred(:,:,i) = (x(i).chan47_ersp);
        tref(:,:,i) = (y(i).chan47_ersp);

    elseif band == 2
        %(cluster of parietal channels for delta) 
        tred(:,:,i) = ((x(i).chan32_ersp)+(x(i).chan19_ersp)+(x(i).chan18_ersp)+(x(i).chan56_ersp)+(x(i).chan55_ersp))/5;  % FCz: 47 FC1: 11 FC2: 46 Fz: 38 CPz: 32 CP1: 19 CP3: 18 CP2: 56 CP4: 55
        tref(:,:,i) = ((y(i).chan32_ersp)+(y(i).chan19_ersp)+(y(i).chan18_ersp)+(y(i).chan56_ersp)+(y(i).chan55_ersp))/5;

    elseif band == 3
        % single channel for high beta - FCz Fz FC1 FC2 
        tred(:,:,i) = ((x(i).chan47_ersp)+(x(i).chan38_ersp)+(x(i).chan11_ersp)+(x(i).chan46_ersp))/4;
        tref(:,:,i) = ((y(i).chan47_ersp)+(y(i).chan38_ersp)+(y(i).chan11_ersp)+(y(i).chan46_ersp))/4;

    end


end

% averaging on the 3rd dimension (subjects) and put pos / neg in a struct
nore{cond} = mean(tred,3);
redo{cond} = mean(tref,3);




% door gambling redos - extracting individual scores - mean ERPS   % 26/01/2017
% theta freqs 4-8, times 200-400 (FB) / ?-? (RT)
% delta freqs 0.8-3.9, times 200-400 (FB) / ?-? (RT)
norem = squeeze(mean(mean(tred(dsearchn(x(1,1).freqs',blimit(1)):dsearchn(x(1,1).freqs',blimit(2)),dsearchn(x(1,1).times',time(1)):dsearchn(x(1,1).times',time(2)),:))))
redom = squeeze(mean(mean(tref(dsearchn(x(1,1).freqs',blimit(1)):dsearchn(x(1,1).freqs',blimit(2)),dsearchn(x(1,1).times',time(1)):dsearchn(x(1,1).times',time(2)),:))))
xlscomb = [norem,redom]

if band == 1
% xlswrite(['C:\Users\gdavide\Documents\MATLAB\dg_workspace16\Door gambling redos\splitted\merged datasets - final 26 sample\final5_HC_Fb_redo_nore_lowredo_FCz_ERSP_4_8_200_400.xls'],xlscomb,(c));
elseif band == 2
% xlswrite(['C:\Users\gdavide\Documents\MATLAB\dg_workspace16\Door gambling redos\splitted\merged datasets - final 26 sample\final5_HC_Fb_redo_nore_lowredo_CPzCP1CP2CP3CP4_ERSP_0.8_3.9_200_400.xls'],xlscomb,(c));
elseif band == 3
% xlswrite(['C:\Users\gdavide\Documents\MATLAB\dg_workspace16\Door gambling redos\splitted\merged datasets - final 26 sample\final5_HC_Fb_redo_nore_lowredo_FCzFzFC1FC2_ERSP_20_35_250_350.xls'],xlscomb,(c));

end


end