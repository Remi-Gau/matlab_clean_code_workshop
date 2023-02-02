function AnalyseDataNew

%

% Returns a {5,1,rMAX} cell where rMAX is the total number of run

% {1,1} contains the trial number and the type of stimuli presented on this trial
% Trials(i,1:5) = [i p Choice n m RT Resp RespCat];
% i		 is the trial number
% p		 is the trial number in the current block
% Choice	 contains the type of stimuli presented on this trial : 0--> Congruent, 1--> Incongruent, 2--> Counterphase.
% n 		 is the variable that says what kind of block came before the present one. Equals to 666 if there was no previous block. : 0--> Congruent, 1--> Incongruent, 2--> Counterphase.
% m 		 is the variable that says the length of the block that came before the present one. Equals to 666 if there was no previous block.
% RT
% Resp
% RespCat	 For Congruent trials : 1 --> Hit; 0 --> Miss // For Incongruent trials : 1 --> Hit; 0 --> Miss // For McGurk trials : 0 --> McGurk effect worked; 0 --> Miss


% {2,1} contains the name of the stim used
% {3,1} contains the level of noise used for this stimuli
% {4,1} contains the absolute path of the corresponding movie to be played
% {5,1} contains the absolute path of the corresponding sound to be played


% TO DO :
%	- add a way to analyze just one trial

clc
clear all
close all


n=1;


	
MatFilesList = dir ('Results*.mat');

SizeMatFilesList = size(MatFilesList,1);

SavedGroupMat = strcat('Group_Results.mat');

Subject_Lists = {};
GroupResponses = [];

GroupRT = [];

GroupMissed = [];

GroupNbValidTrials = [];

GroupNbMcGURKinCON = [];
GroupNbMcGURKinINC = [];

GroupStimByStimAllResults = cell(SizeMatFilesList+1,6);
GroupStimByStimAllResults = {'', 'Auditory Be - Visual Ge', 'Auditory Bi - Visual Gi', 'Auditory Pa - Visual Ka', 'Auditory Pe - Visual Ke', 'Auditory Pi - Visual Ki'};

GroupStimByStim(1).name = 'Auditory Be - Visual Ge';
GroupStimByStim(2).name = 'Auditory Bi - Visual Gi';
GroupStimByStim(3).name = 'Auditory Pa - Visual Ka';
GroupStimByStim(4).name = 'Auditory Pe - Visual Ke';
GroupStimByStim(5).name = 'Auditory Pi - Visual Ki';

for i=1:5
    GroupStimByStim(i).results = cell(1,2);
end



figure(n)
n=n+1;

for Subject=1:SizeMatFilesList
	
	load(MatFilesList(Subject).name);
	
	Subject_Lists{Subject} = SubjID;
    GroupStimByStimAllResults{end+1,1} = SubjID;
	
	GroupNbValidTrials = [GroupNbValidTrials ; NbValidTrials];
    
    GroupNbMcGURKinCON = [GroupNbMcGURKinCON ; NbMcGURKinCON];
    
    GroupNbMcGURKinINC = [GroupNbMcGURKinINC ; NbMcGURKinINC];
	
	subplot(1,SizeMatFilesList,Subject)
	hold on
	bar([1], [ McGURKinCON_Correct ], 'g' )
	bar([2], [ McGURKinINC_Correct ], 'r' )
	errorbar([1], McGURKinCON_Correct, [nanstd(ResponsesCell{3,1}(1,3:end)./sum(ResponsesCell{3,1}(1:2,3:end)))], 'k')
	errorbar([2], McGURKinINC_Correct, [nanstd(ResponsesCell{3,2}(1,3:end)./sum(ResponsesCell{3,2}(1:2,3:end)))], 'k')
	
	
	set(gca,'tickdir', 'out', 'xtick', 1:2 , 'xticklabel', [' ';' '], 'ticklength', [0.005 0], 'fontsize', 13);
	
	axis([0.5 2.5 0 1])
	
	if Subject==1
		ylabel 'Ratio of McGurk answers';
	end
	
	if Subject==SizeMatFilesList
		legend(['In a CON Block';'In a INC Block'], 'Location', 'NorthEast')
	end
	
	GroupResponses(Subject,:) = [McGURKinCON_Correct McGURKinINC_Correct McGURKinCON_Correct-McGURKinINC_Correct CONinCON_Correct INCinINC_Correct ];
	
	GroupRT(Subject,:) = [RT_CON_OK RT_INC_OK RT_McGURK_OK_inCON_TOTAL RT_McGURK_OK_inINC_TOTAL RT_McGURK_NO_inCON_TOTAL RT_McGURK_NO_inINC_TOTAL];

    GroupMissed = [GroupMissed ; Missed];
    
    for i=1:NbMcMovies
        
        A = (McGurkStimByStimRespRecap{i,2}(:,1)./sum(McGurkStimByStimRespRecap{i,2},2))';
        
        switch McGurkStimByStimRespRecap{i,1}
            case 'V_Ge_A_Be'
                WichStim=1;
            case 'V_Gi_A_Bi'
                WichStim=2;
            case 'V_Ka_A_Pa'
                WichStim=3;                
            case 'V_Ke_A_Pe'
                WichStim=4;
            case 'V_Ki_A_Pi'
                WichStim=5;
        end
        
        GroupStimByStim(WichStim).results{1,1}{end+1,1} = SubjID;
        GroupStimByStim(WichStim).results{1,2}(end+1,:) = A;
        
        GroupStimByStimAllResults{end,WichStim+1} = A;
    end
        
        
end

[a,b] = size(GroupStimByStimAllResults)

for i=2:a
    for j=2:b
        if isempty(GroupStimByStimAllResults{i,j});
            GroupStimByStimAllResults{i,j}=NaN(1,2);
        end
    end
end



figure(n)
n=n+1;

for i=1:5

	subplot(1,5,i)
    
    t = title(GroupStimByStim(i).name);
    set(t,'fontsize',15);
    
	hold on
	bar([1], [ nanmean(GroupStimByStim(i).results{1,2}(:,1)) ], 'g' )
	bar([2], [ nanmean(GroupStimByStim(i).results{1,2}(:,2)) ], 'r' )
	errorbar([1], nanmean(GroupStimByStim(i).results{1,2}(:,1)), nanstd(GroupStimByStim(i).results{1,2}(:,1)), 'k')
	errorbar([2], nanmean(GroupStimByStim(i).results{1,2}(:,2)), nanstd(GroupStimByStim(i).results{1,2}(:,2)), 'k')

	set(gca,'tickdir', 'out', 'xtick', 1:2 , 'xticklabel', ['CON';'INC'], 'ticklength', [0.005 0], 'fontsize', 15);
	
	axis([0.5 2.5 0 1]) 

end

subplot(1,5,1)
ylabel 'Proportion of McGurk answers';


figure(n)
n=n+1;

for i=1:5

	subplot(1,5,i)
    
    t = title(GroupStimByStim(i).name);
    set(t,'fontsize',15);
    
	hold on
    for j=1:length(GroupStimByStim(i).results{1,2})
        plot([1 2], [ GroupStimByStim(i).results{1,2}(j,1) GroupStimByStim(i).results{1,2}(j,2)], 'k' )
    end
    
    label = strcat('n = ', num2str(length(GroupStimByStim(i).results{1,2})))
    
    xlabel (label)
		
	set(gca,'tickdir', 'out', 'xtick', 1:2 , 'xticklabel', ['CON';'INC'], 'ticklength', [0.005 0], 'fontsize', 15);
	
	axis([0.5 2.5 0 1]) 

end

subplot(1,5,1)
ylabel 'Proportion of McGurk answers';





fprintf('\n')

disp('MISSED')
fprintf('%6.3f +/- %6.3f \n', nanmean(GroupMissed), nanstd(GroupMissed) )

fprintf('\n\n\n')

disp('RESPONSES')
fprintf('\n')
disp('McGurk answers in CON blocks')
fprintf('%6.3f +/- %6.3f \n', nanmean(GroupResponses(:,1)), nanstd(GroupResponses(:,1)) ) 
disp('McGurk answers in INC blocks')
fprintf('%6.3f +/- %6.3f \n', nanmean(GroupResponses(:,2)), nanstd(GroupResponses(:,2)) ) 
disp('Differences in McGurk answers in between CON and INC blocks')
fprintf('%6.3f +/- %6.3f \n', nanmean(GroupResponses(:,3)), nanstd(GroupResponses(:,3)) ) 
[h,p] = ttest(GroupResponses(:,1),GroupResponses(:,2),0.05,'right');
if h==1
    fprintf('Different from 0 with p = %6.6f \n\n', p)
end

fprintf('\n')

for i=1:5
    disp(GroupStimByStim(i).name)
    disp('McGurk answers in CON blocks')
    fprintf('%6.3f +/- %6.3f \n', nanmean(GroupStimByStim(i).results{1,2}(:,1)), nanstd(GroupStimByStim(i).results{1,2}(:,1)))
    disp('McGurk answers in INC blocks')
    fprintf('%6.3f +/- %6.3f \n', nanmean(GroupStimByStim(i).results{1,2}(:,2)), nanstd(GroupStimByStim(i).results{1,2}(:,2)))
    [h,p] = ttest(GroupStimByStim(i).results{1,2}(:,1), GroupStimByStim(i).results{1,2}(:,2), 0.05, 'right');
    if h==1
        fprintf('Different with p = %6.6f \n\n', p)
    end
    fprintf('\n')
end

fprintf('\n')

disp('Correct answers on CON trial in CON blocks')
fprintf('%6.3f +/- %6.3f \n', nanmean(GroupResponses(:,4)), nanstd(GroupResponses(:,4)) ) 
disp('Correct answers on INC trial in INC blocks')
fprintf('%6.3f +/- %6.3f \n', nanmean(GroupResponses(:,5)), nanstd(GroupResponses(:,5)) ) 

fprintf('\n\n\n')

disp('REACTION TIMES')
fprintf('\n')
disp('Congruent in CON blocks')
fprintf('%6.3f +/- %6.3f \n', nanmean(GroupRT(:,1)), nanstd(GroupRT(:,1)) )
disp('Incongruent in INC blocks')
fprintf('%6.3f +/- %6.3f \n', nanmean(GroupRT(:,2)), nanstd(GroupRT(:,2)) )
[h,p] = ttest(GroupRT(:,1), GroupRT(:,2), 0.05, 'both');
if h==1
    fprintf('Different from from each other with p = %6.6f \n\n', p)
end

fprintf('\n')

disp('McGurk answers in CON blocks')
fprintf('%6.3f +/- %6.3f \n\n', nanmean(GroupRT(:,3)), nanstd(GroupRT(:,3)) )
disp('McGurk answers in INC blocks')
fprintf('%6.3f +/- %6.3f \n\n', nanmean(GroupRT(:,4)), nanstd(GroupRT(:,4)) )

disp('Non McGurk answers in CON blocks')
fprintf('%6.3f +/- %6.3f \n\n', nanmean(GroupRT(:,5)), nanstd(GroupRT(:,5)) )
disp('Non McGurk answers in INC blocks')
fprintf('%6.3f +/- %6.3f \n\n', nanmean(GroupRT(:,6)), nanstd(GroupRT(:,6)) )



Subject_Lists=Subject_Lists'
GroupNbValidTrials
GroupNbMcGURKinCON
GroupNbMcGURKinINC
GroupMissed
GroupResponses
GroupRT
GroupStimByStimAllResults




figure(1) 
print(gcf, 'Figures.ps', '-dpsc2'); % Print figures in ps format
for i=2:(n-1)
	figure(i)
	print(gcf, 'Figures.ps', '-dpsc2', '-append'); 
end

for i=1:(n-1)
	figure(i)
	print(gcf, strcat('Fig', num2str(i) ,'.eps'), '-depsc'); % Print figures in vector format
end


SavedGroupTxt = strcat('Group_Results.csv');

fid = fopen (SavedGroupTxt, 'w');

fprintf (fid, 'Reaction times for the whole group \n');
fprintf (fid, 'Subject, RT_CON, RT_INC, RT_McGURK_OK_inCON, RT_McGURK_OK_inINC, RT_McGURK_NO_inCON, RT_McGURK_NO_inINC \n\n');
for Subject=1:SizeMatFilesList
    fprintf (fid, '%s,', Subject_Lists{Subject});
	fprintf (fid, '%6.3f,', GroupRT(Subject,:));
    fprintf (fid, '\n');
end

fprintf (fid, '\n\n\n');

fprintf (fid, 'Responses for all McGurk movies \n');
for i=1:6
    fprintf (fid, '%s, ,', GroupStimByStimAllResults{1,i});
end
fprintf (fid, '\n');
for i=1:SizeMatFilesList
    fprintf (fid, '%s,', GroupStimByStimAllResults{i+1,1}); 
    for j=2:6
        fprintf (fid, '%6.3f,', GroupStimByStimAllResults{i+1,j});
    end
    fprintf (fid, '\n');
end

fclose (fid);


clear A B C AVOffsetMat List MaxBlockLengthMAC MaxBlockLengthMAI Run SizeList Trials ans i j n t vblS Color fid
