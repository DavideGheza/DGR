% ------------------------------------------------
% Pre processing pipeline                          author: Davide Gheza
% (Gambling Task Redos)            
% with filtering, ICA on continuous data
% ------------------------------------------------
% notes
% 1) epoch length and parameters are tailored for t/f analyses (long epochs)
% 
% 2) filtering: 
% in principle, the lighter the filter, the less distortion
% in practice, at least high-pass FIR filter @ 0.05 hz - reduce slow
% drifts, without blunting late ERP compontents / slow oscillations - cf. 10.1111/j.1469-8986.2010.01009.x
% In alternative or addition, removing the mean of each epoch
% --> 2 sec epoching + remove epoch mean + run ICA + pre-event baseline
% "It's not nearly as selective as a "true" high pass filter but it
% doesn't distort the ERP waveforms as much either.  Moreover we've
% found that the procedure described above massively improves the
% reliability of ICA when compared to standard ERP prestimulus
% baselines"
% Groppe, D.M., Makeig, S., & Kutas, M. (2009) Identifying reliable independent components via split-half comparisons. NeuroImage, 45, pp.1199-1211.
% cf. https://sccn.ucsd.edu/pipermail/eeglablist/2011/004389.html
%
% 3) about ICA on continuous data: 
% cleaning continuous data can be handy when the same dataset has to be
% epoched according to different events within the same trial.
% The latter would generate overlapping epochs and data redundancy, that 
% would mess up with a following ICA decomposition. 
% On the other hand, ICA on continuous data(before epoching)runs over 
% potentially highly noisy sections of the recording, likely failing in 
% artifactual components separation
%                                   Solutions
% a) manual trimming of big artifacts on continuous data + run ICA on continuous data + epoching + ICA pruning.
% b) (manual trimming - opt) + epoching + ICA + ica pruning -> for each timelocking event 
% the second approach is computationally lighter and faster (ICA on much less
% data), but requires re-iterating ICA as many time-locking events.
% (in most cases, you are interested in only one)
% bottom line: here I implemented a), but I would recommend b) 
% -> reorder as you like!
% 
% 
% ------------------------------------------------
% based on EEGLAB history file generated on the 10-Jan-2017
% ------------------------------------------------
% updated 29-Jan-2017 
% ------------------------------------------------
%               STEPS
% pp1:
% Import in EEGlab
% re-reference to mastoids (virtually linked)
% delete silent channels
% load channel locations
% resampling (if needed)
% filtering - fir filter - high pass and low pass separately
% run ICA (continuous data)
% pp2:
% epoching
% baseline correction
% prune ICA components (and store indexes)
% pp3:
% semi-automatic final artifact rejection: a) extreme values threshold b)
% abnormal trends c) visual inspection (muscular and slow drifts)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% pt. 1/3 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc;
clear;
close all; 

eeglab;

for i = [] % [sbj indexes] 
    
% Import data
%            if biosemi format
EEG = pop_biosig(['C:\Users\gdavide\Documents\Tasks\DoorGambling\DGR redos data\eeg data\h' num2str(i) '.bdf']);
%            if eeglab format 
% EEG = pop_loadset('filename',['h' num2str(i) '.set'],'filepath','C:\\Users\\gdavide\\Documents\\MATLAB\\dg_workspace16\\');
EEG = eeg_checkset( EEG );
% Reference (mastoids or any other - but for avg ref: re-reference AFTER whole preprocessing)
EEG = pop_reref( EEG, [65 66] );            % fill in your mastoid channels
EEG = eeg_checkset( EEG );
% discard silent (empty) channels (if any)
EEG = pop_select( EEG,'nochannel',{'EXG7' 'EXG8'});
EEG = eeg_checkset( EEG );
% load channel locations 
EEG = pop_editset(EEG, 'chanlocs', 'C:\\Users\\gdavide\\Documents\\MATLAB\\68Jas.ced'); % here for biosemi 64
EEG = eeg_checkset( EEG );   
% you may want to inspect the data and manually remove huge artefact
eeglab redraw              % (debug until next line, visual inspect data and select noisy bits + mark "reject" before continuing)
% filtering (FIR filter)
EEG = pop_eegfiltnew(EEG, [], 0.05, 33792, true, [], 0);
EEG = eeg_checkset( EEG );
EEG = pop_eegfiltnew(EEG, [], 35, 194, 0, [], 0);
EEG = eeg_checkset( EEG );
% epoching (before ICA) --> optional - see notes
% EEG = pop_epoch( EEG, {  '11'  '12'  '21'  '22'  '31'  '32'  '41'  '42'  '61'  '62'  '111'  '112'  '121'  '122'  '131'  '132'  '141'  '142'  '161'  '162'  }, [-1  1], 'newname', 'BDF file epochs', 'epochinfo', 'yes');
% EEG = eeg_checkset( EEG );
% EEG = pop_rmbase( EEG, []); % [] -> remove entire epoch mean - see notes
% EEG = eeg_checkset( EEG );
% if bad channel(s) need(s) interpolation: exclude bad channels from ICA, and
% interpolate them after ICA pruning --> (debug until here, run ICA from interface excluding bad channel from input, save out manually)
EEG = pop_runica(EEG, 'extended',1,'interupt','on');
EEG = eeg_checkset( EEG );
% save out pt.1
EEG = pop_saveset( EEG, 'filename',['h' num2str(i) '_fir_noepoch_ica.set'],'filepath','C:\\Users\\gdavide\\Documents\\MATLAB\\dg_workspace16\\Door gambling redos\\');
EEG = eeg_checkset( EEG );

end





