General description: this folder and its subfolders contain the scripts for the processing of clean, pre-processed EEG datasets.

These Matlab scripts relies on EEGlab functions (Delorme, A., Makeig, S., 2004. EEGLAB: an open source toolbox for analysis of single-trial 
EEG dynamics including independent component analysis. J. Neurosci. Methods 134, 9–21. doi:10.1016/j.jneumeth.2003.10.009)

Each subfolder refers to one of the analysis reported in the ms. For each analysis, the processing pipeline includes:

1) "splitting" each clean, epoched dataset into separate datasets for each subject and condition of interest. ("splitting" script)
2) loading the conditional datasets into a "study" structure. The study structure is an EEGlab file that allows to automatically load into to the 
	EEGlab study GUI the datasets' information for running batch-analyses ("populate_study" script)
3) running the analysis through the study GUI in EEGlab (e.g. t/f analyses), with the parameters defined below
4) loading and post-processing the output data, to reduce dimensionality (e.g. average in a t/f window), plotting and exporting the results.


******************************************************************************************************************************************************

sub folder: analysis 1 - FB level - probability x outcome

description: the folder includes the Matlab scripts for preparing epoched EEG data (FB locked) for ERP and time/frequency analyses
Note: this analysis is done on regular trials only.
 
- FB_Splitting.m 	splits the clean datasets into conditional datasets, according to factors: reward probability (3 levels) x outcome (2 levels)
			balances the amount of trials across conditions (done in 2 runs. First counts trials, second uses min trial count as limit)
			saves out trial count and the conditional datasets
- populate_study.m 	load the conditional datasets saved with the previous script into a study structure

The saved *.study files can be loaded in EEGlab for running the ERP and ERSP (time/frequency) analyses from the GUI:
Parameters for ERP (event related potentials): 'baseline', [-250 0]
Parameters for ERSP (t/f convolution): 'cycles', [2 0.9], 'nfreqs', 75, 'ntimesout', 200, 'freqs', [0.8 35], 'baseline', [-500 -200]

******************************************************************************************************************************************************

sub folder: analysis 2 - FB level - trial type x outcome (redo nore)

description: the folder includes the Matlab scripts for preparing epoched EEG data (FB locked) for ERP and time/frequency analyses
Note: this analysis is done on special ["redo" in the script] and regular ["nore"] trials, no-expectation condition (i.e. 50% reward probability). 
The "splitting" script identifies and discards special no-reward trials that were followed by a negative redo choice [coded as 1422 in the script]. 

For main analyses on highly motivated participants (high %yes, n = 21):

- FB_142_splitting_according_to_redo_choice.m	splits the clean datasets into conditional datasets, according to factors: trial type (2 levels) x outcome (2 levels)
						balances the amount of trials across conditions (done in 2 runs. First counts trials, second uses min trial count as limit)
						saves out trial count and the conditional datasets 
- populate_study_redo_not_redo.m	 	load the conditional datasets saved with the previous script into a study structure

For auxiliary analyses on the whole dataset (n = 26), use instead:
- FB_142_splitting_according_to_redo_choice_extended_sample.m
- populate_study_redo_not_redo_extended_sample.m
Note: ignore special no-reward: for low motivated participants (low %yes), there are too few special no-reward trials followed by positive redo choice [1428]

The saved *.study files can be loaded in EEGlab for running the ERP and ERSP (time/frequency) analyses from the GUI:
Parameters for ERP (event related potentials): 'baseline', [-250 0]
Parameters for ERSP (t/f convolution): 'cycles', [2 0.9], 'nfreqs', 75, 'ntimesout', 200, 'freqs', [0.8 35], 'baseline', [-500 -200]

******************************************************************************************************************************************************

sub folder: analysis 3 - Cue level

description: the folder includes the Matlab scripts for preparing epoched EEG data (Cue locked) for ERP and FFT analyses
Note: this analysis is done on special and regular trials, no-expectation condition (i.e. 50% reward probability). 

- Cue_Splitting.m	splits the clean datasets into conditional datasets, according to factor: trial type (2 levels) 
			balances the amount of trials across conditions (done in 2 runs. First counts trials, second uses min trial count as limit)
			saves out trial count and the conditional datasets 
- populate_study_Cue.m	load the conditional datasets saved with the previous script into a study structure

The saved *.study files can be loaded in EEGlab for running the ERP and FFT analyses from the GUI:
Parameters for ERP (event related potentials): 'baseline', [-250 0]
Parameters for FFT (spectral decomposition): 'specmode', 'psd', 'logtrials', 'off',  'timerange', [0 600], 'freqfac', [10]

******************************************************************************************************************************************************

file name: DGR_final_script.m

description: MATLAB script for post-processing, plotting and exporting ERP and ERSP (time/frequency) results for analyses 1 and 2 (FB level). 

See the comments in the code for details. 

******************************************************************************************************************************************************

file name: Cue_fft_analyses.m

description: MATLAB script for post-processing, plotting and exporting ERP and FFT (spectral decomposition) results for analysis 3 (Cue level). 

See the comments in the code for details.

******************************************************************************************************************************************************