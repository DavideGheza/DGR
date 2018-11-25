% ------------------------------------------------
% Pre processing pipeline                          author: Davide Gheza
% (Gambling Task Redos)            
% with filtering, ICA on continuous data
% ------------------------------------------------
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% pt. 2/3 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clearvars -except ComparchiveDGR;
clc;
% sasica config file
load cfg;


for i= [] %[sbj indexes] 


[ALLEEG EEG CURRENTSET ALLCOM] = eeglab;
% load pt.1 files
EEG = pop_loadset('filename',['h' num2str(i) '_fir_noepoch_ica.set'],'filepath','C:\\Users\\gdavide\\Documents\\MATLAB\\dg_workspace16\\Door gambling redos\\');
[ALLEEG, EEG, CURRENTSET] = eeg_store( ALLEEG, EEG, 0 );
EEG = eeg_checkset( EEG );
% Epoching (after ICA) --> optional - see notes
EEG = pop_epoch( EEG, {  '11'  '12'  '21'  '22'  '31'  '32'  '41'  '42'  '61'  '62'  '111'  '112'  '121'  '122'  '131'  '132'  '141'  '142'  '161'  '162'  }, [-2  2], 'newname', 'BDF file epochs', 'epochinfo', 'yes');   % cue: '11'  '12'  '21'  '22'  '31'  '32'  '41'  '42'  '61'  '62'  
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1,'overwrite','on','gui','off'); 
EEG = eeg_checkset( EEG );
% remove pre-event baseline (my default for ERPs - innocuous on t/f)
EEG = pop_rmbase( EEG, [-250    0]);        
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1,'overwrite','on','gui','off'); 
EEG = eeg_checkset( EEG );
%% if ica2 is needed, run it after epoching and continue from here
% ICA component selection for pruning:
% a) Automatic Sasica selection, according to cfg file (optional aid)
% eeg_SASICA(EEG,cfg)
% b) Manual ICA component selection
pop_eegplot( EEG, 1, 1, 1);
pop_eegplot( EEG, 0, 1, 1);
pop_selectcomps(EEG, [1:68] );
eeglab redraw;                  % (debug until next line and select components here before continuing)
% Saving selected components indexes
ComparchiveDGR (i, :) = EEG.reject.gcompreject;     % store comp removed 
% Reject marked components (pruning)
EEG = pop_subcomp( EEG, [], 0);
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1,'overwrite','on','gui','off'); 
EEG = eeg_checkset( EEG );
% Save out pt.2
EEG = pop_saveset( EEG, 'filename',['h' num2str(i) '_fir_noepoch_ica_CueFb_pruned.set'],'filepath','C:\\Users\\gdavide\\Documents\\MATLAB\\dg_workspace16\\Door gambling redos\\');
[ALLEEG EEG] = eeg_store(ALLEEG, EEG, CURRENTSET);
eeglab redraw;


end

%save rej components 
xlswrite(['C:\Users\gdavide\Documents\MATLAB\dg_workspace16\Door gambling redos\\ComparchiveDGR.xls'],ComparchiveDGR,1);
