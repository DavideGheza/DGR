%% Populating study   (from Katharina)          15-Feb-2017

clear all
eeglab
% first sample
% filepath = 'C:\Users\gdavide\Documents\MATLAB\dg_workspace16\Door gambling redos\splitted\redo not redo\extended';
% new sample 7
filepath = 'C:\Users\gdavide\Documents\MATLAB\dg_workspace16\Door gambling redos\splitted\new sample 7\redo not redo\extended';

cd(filepath)
Files = dir('*.set'); 
Files = {Files.name}';

for ifile = 1: length(Files)
if  any(findstr('61', char(Files(ifile))) >= 1) || any(findstr('62', char(Files(ifile))) >= 1)        %discard 161 162
    Files{ifile} = {};
end
end
Files(all(cellfun(@isempty, Files),2),:)=[];

Names = strrep(Files, '.set','');             % trim unuseful part of string  
for iNam= 1: size(Names,1);
    Names(iNam, 1:2)=strsplit(char(Names(iNam)), '_');          % Split into two cells, one for subject, one for Condition
end

%  load /home/user5/Documents/Workfiles/Groups_DG  %group definition(Katharina)

for ifile = 1:length(Files)
 % indexGroup = cell2mat(Groups (:,1)) == str2num(char(strrep(Names(ifile, 1), 'Subject', '')));
 designAdd =  {'index' ifile 'load' char(Files(ifile)) 'subject' char(Names(ifile,1)) 'condition' char(Names(ifile,2))};     % 'group' char(Groups(indexGroup, 2))
 design(1,ifile) =  {designAdd};
end

% dip = {'dipselect', 0.15};
% design(1,length(Files)) = {dip};         -- this overwrite the last cell!

[STUDY ALLEEG] = std_editset(STUDY, [], 'commands', design );

STUDY = pop_savestudy(STUDY, EEG)



%% All ERSPS file will be saved in this folder, move it later to another one!

