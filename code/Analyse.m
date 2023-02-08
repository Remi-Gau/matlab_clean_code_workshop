function Analyse

%

% Returns a {5,1,rMAX} cell where rMAX is the total number of run

% {1,1} contains the trial number and the type of stimuli presented on this trial
% Trials(i,1:5) = [i p Choice n m RT Resp RespCat];
% i		 is the trial number
% p		 is the trial number in the current block
% TrialOnset
% BlockType
% Choice	 contains the type of stimuli presented on this trial : 0--> Congruent, 1--> Incongruent, 2--> Counterphase.
% RT
% Resp
% RespCat	 For Congruent trials : 1 --> Hit; 0 --> Miss // For Incongruent trials : 1 --> Hit; 0 --> Miss // For McGurk trials : 0 --> McGurk effect worked; 0 --> Miss


% {2,1} contains the name of the stim used
% {3,1} contains the level of noise used for this stimuli
% {4,1} contains the absolute path of the corresponding movie to be played
% {5,1} contains the absolute path of the corresponding sound to be played


clc
clear all
close all

% KbName('UnifyKeyNames');


% Figure counter
n=1;


cd Behavioral


try

ResultsFilesList = dir ('Subject*.mat');
SizeFilesList = size(ResultsFilesList,1);
NbRunsDone = SizeFilesList;

% Compile all the trials of all the runs
TotalTrials = cell(2,1);
for RunNb=1:SizeFilesList
    
    ResultsFilesList = dir ('Subject*.mat');

	load(ResultsFilesList(RunNb).name);
    
	TotalTrials{1,1} = [TotalTrials{1,1} ; Trials{1,1}];
	TotalTrials{2,1} = [TotalTrials{2,1} ; Trials{2,1}];
    NoiseRangeCompil(:,:,RunNb) = NoiseRange;
end;

NbTrials = length(TotalTrials{1,1}(:,1));

if exist('NoiseRange')==0
	NoiseRange = zeros(1, NbMcMovies);
end


%--------------------------------------------- FIGURE --------------------------------------------------------
% A first quick figure to have look at the different reactions times
figure(n)
n = n+1;

scatter(15*TotalTrials{1,1}(:,5)+TotalTrials{1,1}(:,2) , TotalTrials{1,1}(:,6))
xlabel 'Trial Number'
ylabel 'Response Time'
set(gca,'tickdir', 'out', 'xtick', [1 16 31] ,'xticklabel', 'Congruent|Incongruent|McGurk', 'ticklength', [0.002 0], 'fontsize', 13)
axis 'tight'
set(gca,'ylim', [-.5 10])


%------------------------------------------------------------------------------------------------------------------


StimByStimRespRecap = cell(1,2,3);
McGurkStimByStimRespRecap = cell(NbMcMovies,2);

for i=1:NbMcMovies
	StimByStimRespRecap{1,1,3}(i,:) = McMoviesDirList(i).name(1:end-4);
	StimByStimRespRecap{1,2,3} = zeros(i,7,NbTrialsPerBlock,NbBlockType);
    
    McGurkStimByStimRespRecap{i,2} = zeros(NbBlockType,2);
    McGurkStimByStimRespRecap{i,1} = McMoviesDirList(i).name(1:end-4);
end

for i=1:NbIncongMovies
	StimByStimRespRecap{1,1,1}(i,:) = CongMoviesDirList(i).name(1:end-4); % Which stimuli
	StimByStimRespRecap{1,2,1} = zeros(i,7,NbTrialsPerBlock,NbBlockType); % What answers
    
    CONStimByStimRespRecap{i,2} = zeros(2,1);
    CONStimByStimRespRecap{i,1} = CongMoviesDirList(i).name(1:end-4);

	StimByStimRespRecap{1,1,2}(i,:) = IncongMoviesDirList(i).name(1:end-4);
	StimByStimRespRecap{1,2,2} = zeros(i,7,NbTrialsPerBlock,NbBlockType);
    
    INCStimByStimRespRecap{i,2} = zeros(2,1);
    INCStimByStimRespRecap{i,1} = IncongMoviesDirList(i).name(1:end-4);
end


ReactionTimesCell = cell(3, 2, NbBlockType);


ResponsesCell = cell(3, NbBlockType);
for i=1:NbBlockType*3
	ResponsesCell{i}=zeros(2,NbTrialsPerBlock);
end


% PriorResponse=zeros(2,8,2);
% 
% TimeSinceLastCell=cell(2,2);


for i=1:NbTrials
    
	if TotalTrials{1,1}(i,6)>0.5 % & TotalTrials{1,1}(i,6)<2.9      % Skips trials where answer came after responses window or with impossible RT (negative or before the beginning of the movie)
		
		Context = TotalTrials{1,1}(i,4); % What block we are in
				
		TrialType = TotalTrials{1,1}(i,5); % What type of trial this is
				
		if TotalTrials{1,1}(i,8)==1
			switch TrialType
				case 0
					RightResp = 1;
				case 1
					RightResp = 1;
				case 2
					RightResp = 2;
			end
        elseif TotalTrials{1,1}(i,8)==0
			switch TrialType
				case 0
					RightResp = 2;
				case 1
					RightResp = 2;
				case 2
					RightResp = 1;
            end
        else
           RightResp = 2;
		end
		
		
% 		if TrialType==2	
% 
% 			From = TotalTrials{1,1}(i-1,5);
% 			GoingBack = 1;
% 
% 			while TotalTrials{1,1}(i-GoingBack,5)==From
% 				GoingBack=GoingBack+1;
% 				if GoingBack==i || GoingBack>11
% 				    break
% 				end
% 			end
% 
% 			PriorResponse(RightResp,GoingBack-1,Context+1)=PriorResponse(RightResp,GoingBack-1,Context+1)+1;
% 			
% 			
% 			TimeSinceLast = TotalTrials{1,1}(i,3)-TotalTrials{1,1}(i-1,3);
% 			
% 			if From==2
% 				From=TotalTrials{1,1}(i-2,5);
% 				TimeSinceLast = TotalTrials{1,1}(i,3)-TotalTrials{1,1}(i-2,3);
% 			end
% 			
% 			TimeSinceLastCell{From+1,RightResp}= [TimeSinceLastCell{From+1,RightResp} TimeSinceLast];
% 
% 		end
		
		
		
		RT = TotalTrials{1,1}(i,6);

        if ismac 	
            switch KbName( TotalTrials{1,1}(i,7) ) % Check responses given
                case RespB
                Resp = 1;

                case RespD
                Resp = 2;

                case RespG
                Resp = 3;

                case RespK
                Resp = 4;

                case RespP
                Resp = 5;

                case RespT
                Resp = 6;	

                otherwise
                Resp = 7;
            end
        else
            Resp = 7;  
        end
            
		
		switch TrialType
			case 0
				WhichStim = find( strcmp (cellstr( repmat(TotalTrials{2,1}(i,:), NbCongMovies, 1) ), StimByStimRespRecap{1,1,TrialType+1}) );
			case 1
				WhichStim = find( strcmp (cellstr( repmat(TotalTrials{2,1}(i,:), NbIncongMovies, 1) ), StimByStimRespRecap{1,1,TrialType+1}) );
			case 2
				WhichStim = find( strcmp (cellstr( repmat(TotalTrials{2,1}(i,:), NbMcMovies, 1) ), StimByStimRespRecap{1,1,TrialType+1}) );
		end
		
	
		if TotalTrials{1,1}(i,8)~=999
			ResponsesCell{TrialType+1,Context+1}(RightResp, TotalTrials{1,1}(i,2)) = ResponsesCell{TrialType+1,Context+1}(RightResp, TotalTrials{1,1}(i,2)) + 1;
		end
			
		StimByStimRespRecap{1,2,TrialType+1}(WhichStim,Resp,TotalTrials{1,1}(i,2),Context+1) = StimByStimRespRecap{1,2,TrialType+1}(WhichStim,Resp,TotalTrials{1,1}(i,2),Context+1) + 1;
		
		if TotalTrials{1,1}(i,8)~=999
			ReactionTimesCell{TrialType+1,RightResp, Context+1} = [ReactionTimesCell{TrialType+1, RightResp, Context+1} RT];
        end
        
        if TotalTrials{1,1}(i,8)~=999 
            switch TrialType
                case 2
                    McGurkStimByStimRespRecap{WhichStim,2}(Context+1,RightResp) = McGurkStimByStimRespRecap{WhichStim,2}(Context+1,RightResp) + 1;
                case 1
                    INCStimByStimRespRecap{WhichStim,2}(RightResp) = INCStimByStimRespRecap{WhichStim,2}(RightResp) + 1;
                case 0
                    CONStimByStimRespRecap{WhichStim,2}(RightResp) = CONStimByStimRespRecap{WhichStim,2}(RightResp) + 1;
                    
            end
        end
            
		
		
		
	end
end


clear TrialType Context RT RightResp i WhichStim Resp NoiseRange

disp('%%%%%%%%%%%%')
disp('% RESULSTS %')
disp('%%%%%%%%%%%%')
fprintf('\n\n\n')

NoiseRangeCompil(3,1:4,:)

NbTrials

NbValidTrials = NbTrials-length([find(TotalTrials{1,1}(:,7)==999)'])

fprintf('\n\n')
disp('RESPONSES')

Missed = length( [find(TotalTrials{1,1}(:,7)==999)'] ) / length (TotalTrials{1,1}(:,6))

fprintf('\n\n')
fprintf('Mc Gurk \n\n')

NbMcGURKinCON = sum(sum(ResponsesCell{3,1}(1:2,:)))
NbMcGURKinINC = sum(sum(ResponsesCell{3,2}(1:2,:)))

McGURKinCON_Correct = sum(ResponsesCell{3,1}(1,:))/sum(sum(ResponsesCell{3,1}(1:2,:)))
McGURKinINC_Correct = sum(ResponsesCell{3,2}(1,:))/sum(sum(ResponsesCell{3,2}(1:2,:)))

for i=1:NbMcMovies
    disp(McGurkStimByStimRespRecap{i,1})
    disp(McGurkStimByStimRespRecap{i,2}(:,1)./sum(McGurkStimByStimRespRecap{i,2},2))
end

fprintf('\n\n')
fprintf('INCONGRUENT \n\n')

NbINC = sum(sum(ResponsesCell{2,2}(1:2,:)))
INCinINC_Correct = sum(ResponsesCell{2,2}(1,:))/sum(sum(ResponsesCell{2,2}(1:2,:)))

for i=1:NbIncongMovies
    disp(INCStimByStimRespRecap{i,1})
    disp(INCStimByStimRespRecap{i,2}(1)/sum(INCStimByStimRespRecap{i,2}))
end

fprintf('\n\n')
fprintf('CONGRUENT \n\n')

NbCON = sum(sum(ResponsesCell{1,1}(1:2,:)))
CONinCON_Correct = sum(ResponsesCell{1,1}(1,:))/sum(sum(ResponsesCell{1,1}(1:2,:)))

for i=1:NbIncongMovies
    disp(CONStimByStimRespRecap{i,1})
    disp(CONStimByStimRespRecap{i,2}(1)/sum(CONStimByStimRespRecap{i,2}))
end


%--------------------------------------------- FIGURE --------------------------------------------------------
figure(n)
n=n+1;


% Plots histograms for % correct for all the McGurk trials
hold on
bar([1], [ McGURKinCON_Correct ], 'g' )
bar([2], [ McGURKinINC_Correct ], 'r' )
errorbar([1], McGURKinCON_Correct, [std(ResponsesCell{3,1}(1,3:end)./sum(ResponsesCell{3,1}(1:2,3:end)))], 'k')
errorbar([2], McGURKinINC_Correct, [std(ResponsesCell{3,2}(1,3:end)./sum(ResponsesCell{3,2}(1:2,3:end)))], 'k')
t=title ('McGurk');
set(t,'fontsize',15);
set(gca,'tickdir', 'out', 'xtick', 1:2 ,'xticklabel', ['In a CON Block';'In a INC Block'], 'ticklength', [0.005 0], 'fontsize', 13);
legend(['In a CON Block';'In a INC Block'], 'Location', 'SouthEast')
axis([0.5 2.5 0 1])



figure(n)
n=n+1;

% Plots histograms for % correct for all the McGurk trials
hold on
plot([ResponsesCell{3,1}(1,:)./sum(ResponsesCell{3,1}(1:2,:))], 'g')
plot([ResponsesCell{3,2}(1,:)./sum(ResponsesCell{3,2}(1:2,:))], 'r')
t=title ('McGurk');
set(t,'fontsize',15);
axis('tight')
set(gca,'tickdir', 'out', 'xtick', 1:max(NbTrialsPerBlock) ,'xticklabel', 1:max(NbTrialsPerBlock), 'ticklength', [0.005 0], 'fontsize', 13, 'ylim', [0 1]);
legend(['In a CON Block';'In a INC Block'], 'Location', 'SouthEast')


% figure(n)
% n=n+1;
% subplot(211)
% hist(TimeSinceLastCell{1,1})
% subplot(212)
% hist(TimeSinceLastCell{1,2})
% 
% figure(n)
% n=n+1;
% subplot(211)
% hist(TimeSinceLastCell{2,1})
% subplot(212)
% hist(TimeSinceLastCell{2,2})

fprintf('\n\n')
disp('REACTION TIMES')

fprintf('\n\n')
ReactionTimesCell

% ReactionTimesCell{TrialType+1,RightResp, Context+1}

fprintf('\n\n')
fprintf('CONGRUENT \n\n')
RT_CON_OK = nanmedian(ReactionTimesCell{1,1,1})
RT_CON_NO = nanmedian(ReactionTimesCell{1,2,1})

fprintf('\n\n')
fprintf('INCONGRUENT \n\n')
RT_INC_OK = nanmedian(ReactionTimesCell{2,1,2})
RT_INC_NO = nanmedian(ReactionTimesCell{2,2,2})

fprintf('\n\n')
fprintf('Mc Gurk \n\n')
RT_McGURK_OK_inCON_TOTAL = nanmedian(ReactionTimesCell{3,1,1})
RT_McGURK_OK_inINC_TOTAL = nanmedian(ReactionTimesCell{3,1,2})

RT_McGURK_NO_inCON_TOTAL = nanmedian(ReactionTimesCell{3,2,1})
RT_McGURK_NO_inINC_TOTAL = nanmedian(ReactionTimesCell{3,2,2})

 

%--------------------------------------------- FIGURE --------------------------------------------------------
figure(n)
n = n+1;

for j=1:NbMcMovies

    subplot (2,4,j)

    for i=1:max(NbTrialsPerBlock)
        Temp = StimByStimRespRecap{1,2,3}(j,:,i,1);
        G (i,:) = Temp/sum(Temp);
    end

    bar(G, 'stacked')
    
    t=title (StimByStimRespRecap{1,1,3}(j,:));
    set(t,'fontsize',15);
    set(gca,'tickdir', 'out', 'xtick', 1:max(NbTrialsPerBlock) ,'xticklabel', 1:max(NbTrialsPerBlock), 'ticklength', [0.005 0], 'fontsize', 13)
    axis 'tight'

end

for j=1:NbMcMovies

    subplot (2,4,j+NbMcMovies)

    for i=1:max(NbTrialsPerBlock)
        Temp = StimByStimRespRecap{1,2,3}(j,:,i,2);
        G (i,:) = Temp/sum(Temp);
    end

    bar(G, 'stacked')
    
    set(t,'fontsize',15);
    set(gca,'tickdir', 'out', 'xtick', 1:max(NbTrialsPerBlock) ,'xticklabel', 1:max(NbTrialsPerBlock), 'ticklength', [0.005 0], 'fontsize', 13)
    axis 'tight'

end

legend(['b'; 'd'; 'g'; 'k'; 'p'; 't'; ' '])

subplot (2,4,1)
ylabel 'After CON';

subplot (2,4,5)
ylabel 'After INC';



%--------------------------------------------- PRINTING & SAVING --------------------------------------------------------
if (IsOctave==0)

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
    
else
	% Prints the results in a vector graphic file !!!
	% Find a way to loop this as well !!!
    	for i=1:(n-1)
    		figure(i)  	   	
    		print(gcf, strcat('Fig', num2str(i) ,'.svg'), '-dsvg'); % Print figures in vector format
	    	print(gcf, strcat('Fig', num2str(i) ,'.pdf'), '-dpdf'); % Print figures in pdf format
    	end;
end;


clear G Color i n List Trials legend t Temp X Y

SavedMat = strcat('Results_', SubjID, '.mat');

% Saving the data
save (SavedMat);


cd ..


catch
cd ..
lasterror
end


function value = IsOctave()
 value = false;

























