% Door gambling task - Split Redo neg (142) according to following choice 08/02/2017

% + splitting 121, 122, 141 matching trial count across conditions, per sbj
% discarding high-no (1422) sbjs 10, 15, 24 (and 17 excluded)

% updated for new sample 7 sbj                                 14/08/2017
% discarding high-no (1422) sbjs 27, 30

clc
clear

pathin = 'C:\Users\gdavide\Documents\MATLAB\dg_workspace16\Door gambling redos'
% first sample 
% pathout = 'C:\Users\gdavide\Documents\MATLAB\dg_workspace16\Door gambling redos\splitted\redo not redo'
% new sample
pathout = 'C:\Users\gdavide\Documents\MATLAB\dg_workspace16\Door gambling redos\splitted\new sample 7\redo not redo'

% first sample 
% sn = [7:9 11:14 16 18:23 25 26]     % whole sample[7:26]
% new sample
sn = [28 29 31:33]

cd (pathin)
% first sample
%limit = xlsread('trialcountDGR_1428.xls')            %trial count for the 4 cond precomputed with this script 
% new sample
% limit = xlsread('trialcountDGR_fake7.xls') 
limit = xlsread('trialcountDGR_1428_new7.xls')

% preallocating space / avoiding empty data for zero conditions
redoyes = zeros(20,52) %(sbjs, max redo before rej)
redono = zeros(20,52)
count = zeros(20,2)

% for i = (1:16)
for i = (1:5)


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
    if EEG.trials > min(limit(i,1:4))
    EEG = pop_select(EEG, 'trial', randsample(1:size(EEG.data,3), min(limit(i,1:4))))
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
    if EEG.trials > min(limit(i,1:4))
    EEG = pop_select(EEG, 'trial', randsample(1:size(EEG.data,3), min(limit(i,1:4))))
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
    if EEG.trials > min(limit(i,1:4))
    EEG = pop_select(EEG, 'trial', randsample(1:size(EEG.data,3), min(limit(i,1:4))))
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
    if EEG.trials > min(limit(i,1:4))
    EEG = pop_select(EEG, 'trial', randsample(1:size(EEG.data,3), min(limit(i,1:4))))
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
    if EEG.trials > min(limit(i,1:4))
    EEG = pop_select(EEG, 'trial', randsample(1:size(EEG.data,3), min(limit(i,1:4))))
    EEG = eeg_checkset( EEG );
    end
EEG = pop_saveset( EEG, 'filename',['h' num2str(sn(i)) '_122.set'],'filepath',pathout);
[ALLEEG EEG] = eeg_store(ALLEEG, EEG, CURRENTSET);
count(i,cond) = EEG.trials

end

% save trial count
% xlswrite(['C:\Users\gdavide\Documents\MATLAB\dg_workspace16\Door gambling redos\trialcountDGRredo_yes_no_matched.xls'],count);
xlswrite(['C:\Users\gdavide\Documents\MATLAB\dg_workspace16\Door gambling redos\trialcountDGR_1428_new7_matched.xls'],count);

eeglab redraw;

