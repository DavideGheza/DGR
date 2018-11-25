General description: this folder contains the scripts for the pre-processing, that is the first steps to be applied on RAW eeg data, before 
actual processing (e.g. ERP or time/frequency analysis). 

This pipeline relies on EEGlab functions (Delorme, A., Makeig, S., 2004. EEGLAB: an open source toolbox for analysis of single-trial EEG dynamics 
including independent component analysis. J. Neurosci. Methods 134, 9–21. doi:10.1016/j.jneumeth.2003.10.009)

The pipeline is divided in three blocks, corresponding to the *.m script files. At each block, a file will be saved, to be loaded by the following one.


******************************************************************************************************************************************************

file name: pp1_commented.m

description: MATLAB script containing the first preprocessing functions: 
% Import in EEGlab
% re-reference to mastoids (virtually linked)
% delete silent channels
% load channel locations
% resampling (if needed)
% filtering - fir filter - high pass and low pass separately
% run ICA (continuous data)

See the comments in the code for details. This file include a description of the whole pipeline, covering also pp2 and pp3.

******************************************************************************************************************************************************

file name: pp2_commented.m

description: MATLAB script containing the second block of preprocessing functions: 
% epoching
% baseline correction
% prune ICA components (and store indexes)

See the comments in the code for details.

******************************************************************************************************************************************************

file name: pp3_commented.m

description: MATLAB script containing the third block of preprocessing functions: 
% semi-automatic final artifact rejection, based on 
	a) extreme values threshold
	b) abnormal trends 
	c) visual inspection (muscular and slow drifts)

See the comments in the code for details.

******************************************************************************************************************************************************

file names: 68Jas.ced

description: file with electrode coordinates on the scalp.

******************************************************************************************************************************************************

file name: Triggers255.txt

description: List and description of triggers.

******************************************************************************************************************************************************


