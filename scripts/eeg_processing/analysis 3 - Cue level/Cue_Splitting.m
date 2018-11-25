% Door gambling task - Cue  Splitting                    09/01/2018


% matching trial count across regolar or special conditions

% EEG = pop_select(EEG, 'trial', randsample(1:size(EEG.data,3), numTrials))

% all 26 subjects (including low redoers) - to correlate type effect vs redo rate

clc     
clear

pathin = 'C:\Users\gdavide\Documents\MATLAB\dg_workspace16\Door gambling redos'
pathout = 'C:\Users\gdavide\Documents\MATLAB\dg_workspace16\Door gambling redos\splitted - Cue'

% whole sample (17 excluded)     
sn = [7:16 18:33];


cd (pathin)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% change %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% limit = NaN(length(sn),2);          %fake count limit to count all trials
% limit = xlsread('trialcountDGR_Cue_26_reg_spec.xls')       %trial count precomputed with this script with fake limits

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% start %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for i = [1:26]


cond = 0

[ALLEEG EEG CURRENTSET ALLCOM] = eeglab;
EEG = pop_loadset('filename',['h' num2str(sn(i)) '_fir_noepoch_ica_CueFb_pruned_rej.set'],'filepath',pathin);
[ALLEEG, EEG, CURRENTSET] = eeg_store( ALLEEG, EEG, 0 );
EEG = eeg_checkset( EEG );

%21 22 (regular)
cond = cond + 1
EEG = pop_selectevent( EEG, 'type',[21 22],'deleteevents','off','deleteepochs','on','invertepochs','off');
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1,'gui','off'); 
EEG = eeg_checkset( EEG );
    if EEG.trials > min(limit(i,1:2))
    EEG = pop_select(EEG, 'trial', randsample(1:size(EEG.data,3), min(limit(i,1:2))))
    EEG = eeg_checkset( EEG );
    end
% EEG = pop_saveset( EEG, 'filename',['h' num2str(sn(i)) '_2122.set'],'filepath',pathout);
[ALLEEG EEG] = eeg_store(ALLEEG, EEG, CURRENTSET);
count(i,cond) = EEG.trials

%42 42 (special)
cond = cond + 1
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1,'retrieve',1,'study',0); 
EEG = eeg_checkset( EEG );
EEG = pop_selectevent( EEG, 'type',[41 42],'deleteevents','off','deleteepochs','on','invertepochs','off');
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 2,'gui','off'); 
EEG = eeg_checkset( EEG );
    if EEG.trials > min(limit(i,1:2))
    EEG = pop_select(EEG, 'trial', randsample(1:size(EEG.data,3), min(limit(i,1:2))))
    EEG = eeg_checkset( EEG );
    end
% EEG = pop_saveset( EEG, 'filename',['h' num2str(sn(i)) '_4142.set'],'filepath',pathout);
[ALLEEG EEG] = eeg_store(ALLEEG, EEG, CURRENTSET);
count(i,cond) = EEG.trials


eeglab redraw;


end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% change %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% xlswrite(['C:\Users\gdavide\Documents\MATLAB\dg_workspace16\Door gambling redos\trialcountDGR_Cue_26_reg_spec.xls'],count);
% xlswrite(['C:\Users\gdavide\Documents\MATLAB\dg_workspace16\Door gambling redos\trialcountDGR_Cue_26_reg_spec_matched.xls'],count);