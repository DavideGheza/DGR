% Door gambling task - FB  Splitting                    29/11/2016
% ------------------------------------------------ updated 17/01/17 

% matching trial count across conditions, based on 6 basic conditions

% EEG = pop_select(EEG, 'trial', randsample(1:size(EEG.data,3), numTrials))

% updated for new sample 7 sbj                                 11/08/2017

clc     
clear

pathin = 'C:\Users\gdavide\Documents\MATLAB\dg_workspace16\Door gambling redos'
pathout = 'C:\Users\gdavide\Documents\MATLAB\dg_workspace16\Door gambling redos\splitted\new sample 7'

% first sample     
% sn = [7:26]
% new sample 
sn = [27:33];

% optional: % -> random selecting n trials that equals the size of least numerous
% condition(s) (here, 36)
% limit = 360      % (max) trial count in the least numerous condition
cd (pathin)
% limit = xlsread('trialcountDGR.xls')            %trial count precomputed with this script without limits
limit = xlsread('trialcountDGR_new7.xls')
%limit = xlsread('trialcountDGR_fake7.xls')        %fake count limit to count all trials

for i = [1:7]


cond = 0

[ALLEEG EEG CURRENTSET ALLCOM] = eeglab;
EEG = pop_loadset('filename',['h' num2str(sn(i)) '_fir_noepoch_ica_CueFb_pruned_rej.set'],'filepath',pathin);
[ALLEEG, EEG, CURRENTSET] = eeg_store( ALLEEG, EEG, 0 );
EEG = eeg_checkset( EEG );

%111
cond = cond + 1
EEG = pop_selectevent( EEG, 'type',111,'deleteevents','off','deleteepochs','on','invertepochs','off');
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1,'gui','off'); 
EEG = eeg_checkset( EEG );
    if EEG.trials > min(limit(i,1:6))
    EEG = pop_select(EEG, 'trial', randsample(1:size(EEG.data,3), min(limit(i,1:6))))
    EEG = eeg_checkset( EEG );
    end
% EEG = pop_saveset( EEG, 'filename',['h' num2str(sn(i)) '_111.set'],'filepath',pathout);
[ALLEEG EEG] = eeg_store(ALLEEG, EEG, CURRENTSET);
count(i,cond) = EEG.trials

%112
cond = cond + 1
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1,'retrieve',1,'study',0); 
EEG = eeg_checkset( EEG );
EEG = pop_selectevent( EEG, 'type',112,'deleteevents','off','deleteepochs','on','invertepochs','off');
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 2,'gui','off'); 
EEG = eeg_checkset( EEG );
    if EEG.trials > min(limit(i,1:6))
    EEG = pop_select(EEG, 'trial', randsample(1:size(EEG.data,3), min(limit(i,1:6))))
    EEG = eeg_checkset( EEG );
    end
% EEG = pop_saveset( EEG, 'filename',['h' num2str(sn(i)) '_112.set'],'filepath',pathout);
[ALLEEG EEG] = eeg_store(ALLEEG, EEG, CURRENTSET);
count(i,cond) = EEG.trials

%121
cond = cond + 1
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1,'retrieve',1,'study',0); 
EEG = eeg_checkset( EEG );
EEG = pop_selectevent( EEG, 'type',121,'deleteevents','off','deleteepochs','on','invertepochs','off');
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 2,'gui','off'); 
EEG = eeg_checkset( EEG );
    if EEG.trials > min(limit(i,1:6))
    EEG = pop_select(EEG, 'trial', randsample(1:size(EEG.data,3), min(limit(i,1:6))))
    EEG = eeg_checkset( EEG );
    end
% EEG = pop_saveset( EEG, 'filename',['h' num2str(sn(i)) '_121.set'],'filepath',pathout);
[ALLEEG EEG] = eeg_store(ALLEEG, EEG, CURRENTSET);
count(i,cond) = EEG.trials

%122
cond = cond + 1
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1,'retrieve',1,'study',0); 
EEG = eeg_checkset( EEG );
EEG = pop_selectevent( EEG, 'type',122,'deleteevents','off','deleteepochs','on','invertepochs','off');
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 2,'gui','off'); 
EEG = eeg_checkset( EEG );
    if EEG.trials > min(limit(i,1:6))
    EEG = pop_select(EEG, 'trial', randsample(1:size(EEG.data,3), min(limit(i,1:6))))
    EEG = eeg_checkset( EEG );
    end
% EEG = pop_saveset( EEG, 'filename',['h' num2str(sn(i)) '_122.set'],'filepath',pathout);
[ALLEEG EEG] = eeg_store(ALLEEG, EEG, CURRENTSET);
count(i,cond) = EEG.trials

%131
cond = cond + 1
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1,'retrieve',1,'study',0); 
EEG = eeg_checkset( EEG );
EEG = pop_selectevent( EEG, 'type',131,'deleteevents','off','deleteepochs','on','invertepochs','off');
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 2,'gui','off'); 
EEG = eeg_checkset( EEG );
    if EEG.trials > min(limit(i,1:6))
    EEG = pop_select(EEG, 'trial', randsample(1:size(EEG.data,3), min(limit(i,1:6))))
    EEG = eeg_checkset( EEG );
    end
% EEG = pop_saveset( EEG, 'filename',['h' num2str(sn(i)) '_131.set'],'filepath',pathout);
[ALLEEG EEG] = eeg_store(ALLEEG, EEG, CURRENTSET);
count(i,cond) = EEG.trials

%132
cond = cond + 1
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1,'retrieve',1,'study',0); 
EEG = eeg_checkset( EEG );
EEG = pop_selectevent( EEG, 'type',132,'deleteevents','off','deleteepochs','on','invertepochs','off');
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 2,'gui','off'); 
EEG = eeg_checkset( EEG );
    if EEG.trials > min(limit(i,1:6))
    EEG = pop_select(EEG, 'trial', randsample(1:size(EEG.data,3), min(limit(i,1:6))))
    EEG = eeg_checkset( EEG );
    end
% EEG = pop_saveset( EEG, 'filename',['h' num2str(sn(i)) '_132.set'],'filepath',pathout);
[ALLEEG EEG] = eeg_store(ALLEEG, EEG, CURRENTSET);
count(i,cond) = EEG.trials

%141
cond = cond + 1
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1,'retrieve',1,'study',0); 
EEG = eeg_checkset( EEG );
EEG = pop_selectevent( EEG, 'type',141,'deleteevents','off','deleteepochs','on','invertepochs','off');
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 2,'gui','off'); 
EEG = eeg_checkset( EEG );
    if EEG.trials > min(limit(i,1:6))
    EEG = pop_select(EEG, 'trial', randsample(1:size(EEG.data,3), min(limit(i,1:6))))
    EEG = eeg_checkset( EEG );
    end
% EEG = pop_saveset( EEG, 'filename',['h' num2str(sn(i)) '_141.set'],'filepath',pathout);
[ALLEEG EEG] = eeg_store(ALLEEG, EEG, CURRENTSET);
count(i,cond) = EEG.trials

%142
cond = cond + 1
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1,'retrieve',1,'study',0); 
EEG = eeg_checkset( EEG );
EEG = pop_selectevent( EEG, 'type',142,'deleteevents','off','deleteepochs','on','invertepochs','off');
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 2,'gui','off'); 
EEG = eeg_checkset( EEG );
    if EEG.trials > min(limit(i,1:6))
    EEG = pop_select(EEG, 'trial', randsample(1:size(EEG.data,3), min(limit(i,1:6))))
    EEG = eeg_checkset( EEG );
    end
% EEG = pop_saveset( EEG, 'filename',['h' num2str(sn(i)) '_142.set'],'filepath',pathout);
[ALLEEG EEG] = eeg_store(ALLEEG, EEG, CURRENTSET);
count(i,cond) = EEG.trials

%161
cond = cond + 1
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1,'retrieve',1,'study',0); 
EEG = eeg_checkset( EEG );
EEG = pop_selectevent( EEG, 'type',161,'deleteevents','off','deleteepochs','on','invertepochs','off');
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 2,'gui','off'); 
EEG = eeg_checkset( EEG );
    if EEG.trials > min(limit(i,1:6))
    EEG = pop_select(EEG, 'trial', randsample(1:size(EEG.data,3), min(limit(i,1:6))))
    EEG = eeg_checkset( EEG );
    end
% EEG = pop_saveset( EEG, 'filename',['h' num2str(sn(i)) '_161.set'],'filepath',pathout);
[ALLEEG EEG] = eeg_store(ALLEEG, EEG, CURRENTSET);
count(i,cond) = EEG.trials

%162
cond = cond + 1
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1,'retrieve',1,'study',0); 
EEG = eeg_checkset( EEG );
EEG = pop_selectevent( EEG, 'type',162,'deleteevents','off','deleteepochs','on','invertepochs','off');
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 2,'gui','off'); 
EEG = eeg_checkset( EEG );
    if EEG.trials > min(limit(i,1:6))
    EEG = pop_select(EEG, 'trial', randsample(1:size(EEG.data,3), min(limit(i,1:6))))
    EEG = eeg_checkset( EEG );
    end
% EEG = pop_saveset( EEG, 'filename',['h' num2str(sn(i)) '_162.set'],'filepath',pathout);
[ALLEEG EEG] = eeg_store(ALLEEG, EEG, CURRENTSET);
count(i,cond) = EEG.trials

eeglab redraw;


end

% xlswrite(['C:\Users\gdavide\Documents\MATLAB\dg_workspace16\Door gambling redos\trialcountDGR_new7.xls'],count);
% xlswrite(['C:\Users\gdavide\Documents\MATLAB\dg_workspace16\Door gambling redos\trialcountDGR_new7_matched.xls'],count);