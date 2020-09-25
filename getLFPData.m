%%%% Author - Aamir Abbasi
%%%% LC Data Analysis
%%%% SCRIPT TO READ LFP SIGNALS
%% ------------------------------------------------------------------------------------------------------------------------------
clc; clear; close;
disp('running...');
root = 'Z:\Riera Lab\LC Recordings\PD_342\'; % Modify the root and savepath based on the location of your data
savepath = 'Z:\Riera Lab\LC Recordings\PD_342\';
cd(root);
blocks = {'PD_342-200924-*'}; % Here the name of folders where you have recorded the data from a single animal will be defined
chans = [2]; % You can add more channels to this vector by doing something like this [1,2,...]
tic;
for j=1:length(blocks)
  blockNames = dir(blocks{j});
  for i = 1:length(blockNames)
    blockpath = [root,blockNames(i).name,'\'];
    disp(blockpath);
    for ch = 1:length(chans)
      
      % Read data from LFP1 gizmo
      raw = TDTbin2mat(blockpath,'STORE','LFP1','CHANNEL',chans(ch));
      
      % Extract data
      lfp = raw.streams.LFP1.data;
      fs  = raw.streams.LFP1.fs;
      
      % Save in respective TDT blocks
      save([savepath, blockNames(i).name,'\LFP.mat'],'lfp','fs');
 
    end
  end
end
runTime = toc;
disp(['done! time elapsed (hours) - ', num2str(runTime/3600)]);
