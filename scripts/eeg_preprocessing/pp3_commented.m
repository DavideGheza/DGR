% ------------------------------------------------
% Pre processing pipeline                          author: Davide Gheza
% (Gambling Task Redos)            
% with filtering, ICA on continuous data
% ------------------------------------------------
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% pt. 3/3 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clearvars %-except archive;


for i= [] %[sbj indexes] 

[ALLEEG EEG CURRENTSET ALLCOM] = eeglab;
% load pt.2 files
EEG = pop_loadset('filename',['h' num2str(i) '_fir_noepoch_ica_CueFb_pruned.set'],'filepath','C:\\Users\\gdavide\\Documents\\MATLAB\\dg_workspace16\\Door gambling redos\\');
[ALLEEG, EEG, CURRENTSET] = eeg_store( ALLEEG, EEG, 0 );
% remove mean of epoch, again (to be sure ICA pruning did not affect baseline)
EEG = pop_rmbase( EEG, [-250    0]);    
% automatic artifact rejection
EEG = pop_eegthresh(EEG,1,[1:64] ,-90,90,-0.700,0.700,1,0); % extreme values +- 90uv
EEG = pop_rejtrend(EEG,1,[1:64] ,500,90,0.3,1,0,0);         % abnodmal trends
% manual artifact rejection 
eeglab redraw               %(debug until next line and visual inspect data + select bad trials before continuing)
% merge automatic and manual selections
EEG = eeg_rejsuperpose( EEG, 1, 1, 1, 1, 1, 1, 1, 1);
% print total rejected trials
sum(EEG.reject.rejglobal)       
% store marked trials indexes
archive = EEG.reject.rejglobal;
% reject marked trials
EEG = pop_rejepoch( EEG, EEG.reject.rejglobal ,0);
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1,'overwrite','off','gui','off'); 
EEG = eeg_checkset( EEG );
% save marked trials indexes
csvwrite(['C:\Users\gdavide\Documents\MATLAB\dg_workspace16\Door gambling redos\rejarchiveDGR_' num2str(i) '.csv'],archive);         %saving rej trial list
% save out pt. 3 (clean data)
EEG = pop_saveset( EEG, 'filename',['h' num2str(i) '_fir_noepoch_ica_CueFb_pruned_rej.set'],'filepath','C:\\Users\\gdavide\\Documents\\MATLAB\\dg_workspace16\\Door gambling redos\\');
[ALLEEG EEG] = eeg_store(ALLEEG, EEG, CURRENTSET);
EEG = eeg_checkset( EEG );


end