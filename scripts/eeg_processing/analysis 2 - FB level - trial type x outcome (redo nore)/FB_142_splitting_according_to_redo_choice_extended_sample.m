% Door gambling task - Split Redo neg according to following choice 08/02/2017
%                                                           updated 05/07/2017

% + splitting 121, 122, 141 matching trial count across conditions, per sbj


% + extended sample
% (recovering high-no (1422) sbjs 10, 15, 24 (17 excluded))
% --> trial count matching regardless of 1428 count                   

% updated for new sample 7 sbj                                 15/08/2017
% (recovering high-no (1422) sbjs 27, 30)
% --> trial count matching regardless of 1428 count        

clc
clear

% first sample
% pathin = 'C:\Users\gdavide\Documents\MATLAB\dg_workspace16\Door gambling redos'
% pathout = 'C:\Users\gdavide\Documents\MATLAB\dg_workspace16\Door gambling redos\splitted\redo not redo\extended'
% sn = [10 15 24]     % whole sample[7:26]
% 
% cd (pathin)
% limit = xlsread('trialcountDGR_high1422.xls')            %trial count for the 4 cond precomputed with this script 

% new sample 7
pathin = 'C:\Users\gdavide\Documents\MATLAB\dg_workspace16\Door gambling redos'
pathout = 'C:\Users\gdavide\Documents\MATLAB\dg_workspace16\Door gambling redos\splitted\new sample 7\redo not redo\extended'
sn = [27 30]     

cd (pathin)
% limit = xlsread('trialcountDGR_fake7.xls')                   % first run (unlimited trial count, just to count trials)
limit = xlsread('trialcountDGR_high1422_new7.xls')            % second run  


% preallocating space / avoiding empty data for zero conditions
redoyes = zeros(length(sn),52) %(sbjs, max redo before rej)
redono = zeros(length(sn),52)
count = zeros(length(sn),5)

for i = (1:length(sn))


cond = 0

[ALLEEG EEG CURRENTSET ALLCOM] = eeglab;
EEG = pop_loadset('filename',['h' num2str(sn(i)) '_fir_noepoch_ica_CueFb_pruned_rej.set'],'filepath',pathin);
EEG = eeg_checkset( EEG );
[ALLEEG, EEG, CURRENTSET] = eeg_store( ALLEEG, EEG, 0 );
EEG = pop_selectevent( EEG, 'type',142,'deleteevents','off','deleteepochs','on','invertepochs','off');
[ALLEEG, EEG, CURRENTSET] = pop_newset(ALLEEG, EEG, 1,'gui','off');
EEG = eeg_checkset( EEG );

% selecting 142 according to choice trigger (228 yes, 222 no)


for n = 1:length(EEG.epoch)
        
    if      EEG.urevent(1,(EEG.epoch(1,n).eventurevent{1,2})).type == 142 & EEG.urevent(1,(EEG.epoch(1,n).eventurevent{1,2})+2).type == 228;
            redoyes(i,n) = n; % report only contidions-true-epochs (others are filled with zeros)
    else
            EEG.urevent(1,(EEG.epoch(1,n).eventurevent{1,2})).type == 142 & EEG.urevent(1,(EEG.epoch(1,n).eventurevent{1,2})+2).type == 222;
            redono(i,n) = n;
    end
    
 
end

%1428   redo-neg followed by yes
cond = cond + 1
if any(redoyes(i,:)) ~= 0;

% select redoyes '1428' trials and save out
EEG = pop_selectevent( EEG, 'epoch', redoyes(i,:) ,'deleteevents','off','deleteepochs','on','invertepochs','off');   %'renametype','1428',
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 2,'gui','off');
EEG = eeg_checkset( EEG );
    if EEG.trials > min(limit(i,3:5))
    EEG = pop_select(EEG, 'trial', randsample(1:size(EEG.data,3), min(limit(i,3:5))))
    EEG = eeg_checkset( EEG );
    end
EEG = pop_saveset( EEG, 'filename',['h' num2str(sn(i)) '_1428.set'],'filepath',pathout);
[ALLEEG EEG] = eeg_store(ALLEEG, EEG, CURRENTSET);
count(i,cond) = EEG.trials
end



%1422   redo-neg followed by no 
% (exploratory - lower trial count, 3 sbjs only)

cond = cond + 1
if any(redono(i,:)) ~= 0;
    
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 2,'retrieve',2,'study',0); 
EEG = eeg_checkset( EEG );

% select redono '1422' trials and save out
EEG = pop_selectevent( EEG, 'epoch', redono(i,:) ,'deleteevents','off','deleteepochs','on','invertepochs','off');   %'renametype','1422',
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 3,'gui','off');
EEG = eeg_checkset( EEG );
    if EEG.trials > min(limit(i,3:5))
    EEG = pop_select(EEG, 'trial', randsample(1:size(EEG.data,3), min(limit(i,3:5))))
    EEG = eeg_checkset( EEG );
    end
EEG = pop_saveset( EEG, 'filename',['h' num2str(sn(i)) '_1422.set'],'filepath',pathout);
[ALLEEG EEG] = eeg_store(ALLEEG, EEG, CURRENTSET);
count(i,cond) = EEG.trials
end


%% 141
cond = cond + 1
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 4,'retrieve',1,'study',0); 
EEG = eeg_checkset( EEG );
EEG = pop_selectevent( EEG, 'type',141,'deleteevents','off','deleteepochs','on','invertepochs','off');
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 5,'gui','off'); 
EEG = eeg_checkset( EEG );
    if EEG.trials > min(limit(i,3:5))
    EEG = pop_select(EEG, 'trial', randsample(1:size(EEG.data,3), min(limit(i,3:5))))
    EEG = eeg_checkset( EEG );
    end
EEG = pop_saveset( EEG, 'filename',['h' num2str(sn(i)) '_141.set'],'filepath',pathout);
[ALLEEG EEG] = eeg_store(ALLEEG, EEG, CURRENTSET);
count(i,cond) = EEG.trials


%121
cond = cond + 1
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 6,'retrieve',1,'study',0); 
EEG = eeg_checkset( EEG );
EEG = pop_selectevent( EEG, 'type',121,'deleteevents','off','deleteepochs','on','invertepochs','off');
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 7,'gui','off'); 
EEG = eeg_checkset( EEG );
    if EEG.trials > min(limit(i,3:5))
    EEG = pop_select(EEG, 'trial', randsample(1:size(EEG.data,3), min(limit(i,3:5))))
    EEG = eeg_checkset( EEG );
    end
EEG = pop_saveset( EEG, 'filename',['h' num2str(sn(i)) '_121.set'],'filepath',pathout);
[ALLEEG EEG] = eeg_store(ALLEEG, EEG, CURRENTSET);
count(i,cond) = EEG.trials

%122
cond = cond + 1
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 8,'retrieve',1,'study',0); 
EEG = eeg_checkset( EEG );
EEG = pop_selectevent( EEG, 'type',122,'deleteevents','off','deleteepochs','on','invertepochs','off');
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 9,'gui','off'); 
EEG = eeg_checkset( EEG );
    if EEG.trials > min(limit(i,3:5))
    EEG = pop_select(EEG, 'trial', randsample(1:size(EEG.data,3), min(limit(i,3:5))))
    EEG = eeg_checkset( EEG );
    end
EEG = pop_saveset( EEG, 'filename',['h' num2str(sn(i)) '_122.set'],'filepath',pathout);
[ALLEEG EEG] = eeg_store(ALLEEG, EEG, CURRENTSET);
count(i,cond) = EEG.trials

end

% save trial count

% First sample
% first run (total trial count)
% xlswrite(['C:\Users\gdavide\Documents\MATLAB\dg_workspace16\Door gambling redos\trialcountDGR_high1422.xls'],count);
% second run (trial count matched for sbj, across conditions)
% xlswrite(['C:\Users\gdavide\Documents\MATLAB\dg_workspace16\Door gambling redos\trialcountDGRredo_yes_no_matched_regardless1428_high1422.xls'],count);

% new sample 7
% first run (total trial count)
% xlswrite(['C:\Users\gdavide\Documents\MATLAB\dg_workspace16\Door gambling redos\trialcountDGR_high1422_new7.xls'],count);
% second run (trial count matched for sbj, across conditions)
xlswrite(['C:\Users\gdavide\Documents\MATLAB\dg_workspace16\Door gambling redos\trialcountDGRredo_yes_no_matched_regardless1428_high1422_new7.xls'],count);


eeglab redraw;

