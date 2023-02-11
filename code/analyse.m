function analyse(cfg)

    % (C) Copyright 2023 Remi Gau

    % Trials {5,1,rMAX} cell where rMAX is the total number of run
    %
    % {1,1} contains the trial number and the type of stimuli presented on this trial
    %           Trials(i,1:5) = [i p Choice n m RT Resp RespCat];
    %           i      is the trial number
    %           p      is the trial number in the current block
    %           TrialOnset
    %           BlockType
    %           Choice     contains the type of stimuli presented on this trial
    %                 0--> Congruent,
    %                 1--> Incongruent,
    %                 2--> Counterphase.
    %           RT
    %           Resp
    %           RespCat
    %                 For Congruent trials :
    %                     1 --> Hit;
    %                     0 --> Miss
    %                 For Incongruent trials :
    %                     1 --> Hit;
    %                     0 --> Miss
    %                 For McGurk trials :
    %                     1 --> McGurk effect worked;
    %                     0 --> Miss
    %
    % {2,1} contains the name of the stim used
    % {3,1} contains the level of noise used for this stimuli
    % {4,1} contains the absolute path of the corresponding movie to be played
    % {5,1} contains the absolute path of the corresponding sound to be played

    cfg.visible = 'off';
    if cfg.verbose
        cfg.visible = 'on';
    end

    cd Behavioral;

    ResultsFilesList = dir ('Subject*.mat');
    SizeFilesList = size(ResultsFilesList, 1);
    NbRunsDone = SizeFilesList;

    TotalTrials = cell(2, 1);
    for RunNb = 1:SizeFilesList

        ResultsFilesList = dir ('Subject*.mat');

        load(ResultsFilesList(RunNb).name);

        TotalTrials{1, 1} = [TotalTrials{1, 1}; Trials{1, 1}];
        TotalTrials{2, 1} = [TotalTrials{2, 1}; Trials{2, 1}];
        NoiseRangeCompil(:, :, RunNb) = NoiseRange;
    end

    NbTrials = length(TotalTrials{1, 1}(:, 1));

    %% initialize variables
    StimByStimRespRecap = cell(1, 2, 3);
    McGurkStimByStimRespRecap = cell(NbMcMovies, 2);

    for i = 1:NbMcMovies
        % Which stimuli
        StimByStimRespRecap{1, 1, 3}(i, :) = McMoviesDirList(i).name(1:end - 4);
        McGurkStimByStimRespRecap{i, 1} = McMoviesDirList(i).name(1:end - 4);
        % What answers
        McGurkStimByStimRespRecap{i, 2} = zeros(NbBlockType, 2);
    end

    for i = 1:NbIncongMovies
        % Which stimuli
        StimByStimRespRecap{1, 1, 1}(i, :) = CongMoviesDirList(i).name(1:end - 4);
        StimByStimRespRecap{1, 1, 2}(i, :) = IncongMoviesDirList(i).name(1:end - 4);
        CONStimByStimRespRecap{i, 1} = CongMoviesDirList(i).name(1:end - 4);
        INCStimByStimRespRecap{i, 1} = IncongMoviesDirList(i).name(1:end - 4);
        % What answers
        CONStimByStimRespRecap{i, 2} = zeros(2, 1);
        INCStimByStimRespRecap{i, 2} = zeros(2, 1);
    end

    StimByStimRespRecap{1, 2, 1} = zeros(NbIncongMovies, 7, NbTrialsPerBlock, NbBlockType);
    StimByStimRespRecap{1, 2, 2} = zeros(NbIncongMovies, 7, NbTrialsPerBlock, NbBlockType);
    StimByStimRespRecap{1, 2, 3} = zeros(NbMcMovies, 7, NbTrialsPerBlock, NbBlockType);

    %% process trials

    [StimByStimRespRecap, ...
     McGurkStimByStimRespRecap, ...
     INCStimByStimRespRecap, ...
     CONStimByStimRespRecap, ...
     ReactionTimesCell, ...
     ResponsesCell] = process_trials(cfg, TotalTrials, ...
                                     NbCongMovies, NbIncongMovies, NbMcMovies, ...
                                     StimByStimRespRecap, ...
                                     McGurkStimByStimRespRecap, ...
                                     INCStimByStimRespRecap, ...
                                     CONStimByStimRespRecap, NbBlockType, NbTrialsPerBlock);

    %%
    NbValidTrials = NbTrials - length(find(TotalTrials{1, 1}(:, 7) == 999)');

    Missed = length(find(TotalTrials{1, 1}(:, 7) == 999)') / ...
                length(TotalTrials{1, 1}(:, 6));

    NbMcGURKinCON = sum(sum(ResponsesCell{3, 1}(1:2, :)));
    NbMcGURKinINC = sum(sum(ResponsesCell{3, 2}(1:2, :)));

    McGURKinCON_Correct = sum(ResponsesCell{3, 1}(1, :)) / ...
                            sum(sum(ResponsesCell{3, 1}(1:2, :)));
    McGURKinINC_Correct = sum(ResponsesCell{3, 2}(1, :)) / ...
                            sum(sum(ResponsesCell{3, 2}(1:2, :)));

    NbINC = sum(sum(ResponsesCell{2, 2}(1:2, :)));
    INCinINC_Correct = sum(ResponsesCell{2, 2}(1, :)) / ...
                        sum(sum(ResponsesCell{2, 2}(1:2, :)));

    NbCON = sum(sum(ResponsesCell{1, 1}(1:2, :)));
    CONinCON_Correct = sum(ResponsesCell{1, 1}(1, :)) / ...
                        sum(sum(ResponsesCell{1, 1}(1:2, :)));

    %% reaction time

    RT_CON_OK = nanmedian(ReactionTimesCell{1, 1, 1});
    RT_CON_NO = nanmedian(ReactionTimesCell{1, 2, 1});

    RT_INC_OK = nanmedian(ReactionTimesCell{2, 1, 2});
    RT_INC_NO = nanmedian(ReactionTimesCell{2, 2, 2});

    RT_McGURK_OK_inCON_TOTAL = nanmedian(ReactionTimesCell{3, 1, 1});
    RT_McGURK_OK_inINC_TOTAL = nanmedian(ReactionTimesCell{3, 1, 2});

    RT_McGURK_NO_inCON_TOTAL = nanmedian(ReactionTimesCell{3, 2, 1});
    RT_McGURK_NO_inINC_TOTAL = nanmedian(ReactionTimesCell{3, 2, 2});

    %% display results
    if cfg.verbose
        display_results(NoiseRangeCompil, ...
                        NbTrials, NbValidTrials, Missed, ...
                        NbMcGURKinCON, NbMcGURKinINC, McGURKinCON_Correct, McGURKinINC_Correct, ...
                        NbMcMovies, McGurkStimByStimRespRecap, ...
                        NbINC, INCinINC_Correct, NbIncongMovies, INCStimByStimRespRecap, ...
                        NbCON, CONinCON_Correct, CONStimByStimRespRecap);

        display_reaction_time_results(ReactionTimesCell, ...
                                      RT_CON_OK, RT_CON_NO, ...
                                      RT_INC_OK, RT_INC_NO, ...
                                      RT_McGURK_OK_inCON_TOTAL, RT_McGURK_OK_inINC_TOTAL, ...
                                      RT_McGURK_NO_inCON_TOTAL, RT_McGURK_NO_inINC_TOTAL);
    end

    %% figures
    figure_reaction_time(cfg, TotalTrials);
    print_figure();

    histogram_percent_correct_mc_gurk(cfg, McGURKinCON_Correct, McGURKinINC_Correct, ResponsesCell);
    print_figure();

    plot_mc_gurk_responses_across_blocks(cfg, ResponsesCell, NbTrialsPerBlock);
    print_figure();

    figure_response_type_across_block_for_gurk_movies(cfg, NbMcMovies, NbTrialsPerBlock, StimByStimRespRecap);
    print_figure();

    %% Save
    % TODO
    % once refactoring is done, just save the required values.
    clear Color i n List Trials legend X Y figure_counter cfg reaction_time_sec;
    clear  i NoiseRange;
    j = NbMcMovies;
    ans = [];
    SavedMat = strcat('Results_', SubjID, '.mat');
    save (SavedMat);

    cd ..;

end

function value = nb_trials(TotalTrials)

    value = length(TotalTrials{1, 1}(:, 1));

end

function [StimByStim, McGurkStim, IncStim, ConStim, ReactionTimes, Responses] = process_trials(cfg, TotalTrials, ...
                                                                                               NbCongMovies, NbIncongMovies, NbMcMovies, ...
                                                                                               StimByStim, ...
                                                                                               McGurkStim, ...
                                                                                               IncStim, ...
                                                                                               ConStim, NbBlockType, NbTrialsPerBlock)

    ReactionTimes = cell(3, 2, NbBlockType);

    Responses = cell(3, NbBlockType);
    for i = 1:NbBlockType * 3
        Responses{i} = zeros(2, NbTrialsPerBlock);
    end

    for i = 1:nb_trials(TotalTrials)

        reaction_time_sec = TotalTrials{1, 1}(i, 6);
        if reaction_time_sec <= cfg.reaction_time_threshold
            continue
        end

        TrialType = TotalTrials{1, 1}(i, 5);

        switch TrialType
            case 0
                WhichStim = which_stim_for_this_trial(TotalTrials, i, NbCongMovies, StimByStim, TrialType);
            case 1
                WhichStim = which_stim_for_this_trial(TotalTrials, i, NbIncongMovies, StimByStim, TrialType);
            case 2
                WhichStim = which_stim_for_this_trial(TotalTrials, i, NbMcMovies, StimByStim, TrialType);

        end

        Context = TotalTrials{1, 1}(i, 4);

        TrialNumberInBlock = TotalTrials{1, 1}(i, 2);

        RightResp = correct_response(TotalTrials, i, TrialType);

        Resp = response_given(TotalTrials, i);

        StimByStim{1, 2, TrialType + 1}(WhichStim, Resp, TrialNumberInBlock, Context + 1) = ...
            StimByStim{1, 2, TrialType + 1}(WhichStim, Resp, TrialNumberInBlock, Context + 1) + 1;

        if TotalTrials{1, 1}(i, 8) == 999
            continue
        end

        switch TrialType
            case 2
                McGurkStim{WhichStim, 2}(Context + 1, RightResp) = ...
                    McGurkStim{WhichStim, 2}(Context + 1, RightResp) + 1;
            case 1
                IncStim{WhichStim, 2}(RightResp) = ...
                    IncStim{WhichStim, 2}(RightResp) + 1;
            case 0
                ConStim{WhichStim, 2}(RightResp) = ...
                    ConStim{WhichStim, 2}(RightResp) + 1;

        end

        Responses{TrialType + 1, Context + 1}(RightResp, TrialNumberInBlock) = ...
            Responses{TrialType + 1, Context + 1}(RightResp, TrialNumberInBlock) + 1;

        RT = TotalTrials{1, 1}(i, 6);
        ReactionTimes{TrialType + 1, RightResp, Context + 1} = ...
            [ReactionTimes{TrialType + 1, RightResp, Context + 1} RT];

    end

end

function WhichStim = which_stim_for_this_trial(TotalTrials, i, NbMovies, StimByStimRespRecap, TrialType)
    WhichStim = find(strcmp(cellstr(repmat(TotalTrials{2, 1}(i, :), ...
                                           NbMovies, ...
                                           1)), ...
                            StimByStimRespRecap{1, 1, TrialType + 1}));
end

function RightResp = correct_response(TotalTrials, i, TrialType)
    RightResp = 2;
    if TotalTrials{1, 1}(i, 8) == 1
        switch TrialType
            case 0
                RightResp = 1;
            case 1
                RightResp = 1;
            case 2
                RightResp = 2;
        end
    elseif TotalTrials{1, 1}(i, 8) == 0
        switch TrialType
            case 0
                RightResp = 2;
            case 1
                RightResp = 2;
            case 2
                RightResp = 1;
        end
    end
end

function Resp = response_given(TotalTrials, i)
    Resp = 7;
    if ismac
        switch KbName(TotalTrials{1, 1}(i, 7))
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
        end
    end
end

function display_results(NoiseRangeCompil, NbTrials, NbValidTrials, Missed, ...
                         NbMcGURKinCON, NbMcGURKinINC, McGURKinCON_Correct, McGURKinINC_Correct, NbMcMovies, McGurkStimByStimRespRecap, ...
                         NbINC, INCinINC_Correct, NbIncongMovies, INCStimByStimRespRecap, ...
                         NbCON, CONinCON_Correct, CONStimByStimRespRecap)
    fprintf('\n\n');
    disp(NoiseRangeCompil(3, 1:4, :));
    disp(NbTrials);
    disp(NbValidTrials);

    fprintf('\n\n');
    disp('RESPONSES');
    disp(Missed);

    fprintf('\n\n');
    disp('Mc Gurk');
    disp(NbMcGURKinCON);
    disp(NbMcGURKinINC);
    disp(McGURKinCON_Correct);
    disp(McGURKinINC_Correct);
    for i = 1:NbMcMovies
        disp(McGurkStimByStimRespRecap{i, 1});
        disp(McGurkStimByStimRespRecap{i, 2}(:, 1) ./ sum(McGurkStimByStimRespRecap{i, 2}, 2));
    end

    fprintf('\n\n');
    disp('INCONGRUENT');
    disp(NbINC);
    disp(INCinINC_Correct);
    for i = 1:NbIncongMovies
        disp(INCStimByStimRespRecap{i, 1});
        disp(INCStimByStimRespRecap{i, 2}(1) / sum(INCStimByStimRespRecap{i, 2}));
    end

    fprintf('\n\n');
    disp('CONGRUENT');
    disp(NbCON);
    disp(CONinCON_Correct);
    for i = 1:NbIncongMovies
        disp(CONStimByStimRespRecap{i, 1});
        disp(CONStimByStimRespRecap{i, 2}(1) / sum(CONStimByStimRespRecap{i, 2}));
    end
end

function display_reaction_time_results(ReactionTimesCell, RT_CON_OK, RT_CON_NO, RT_INC_OK, RT_INC_NO, RT_McGURK_OK_inCON_TOTAL, RT_McGURK_OK_inINC_TOTAL, RT_McGURK_NO_inCON_TOTAL, RT_McGURK_NO_inINC_TOTAL)
    fprintf('\n\n');
    disp('REACTION TIMES');

    fprintf('\n\n');
    disp(ReactionTimesCell);

    fprintf('\n\n');
    fprintf('CONGRUENT \n\n');
    disp(RT_CON_OK);
    disp(RT_CON_NO);

    fprintf('\n\n');
    fprintf('INCONGRUENT \n\n');
    disp(RT_INC_OK);
    disp(RT_INC_NO);

    fprintf('\n\n');
    fprintf('Mc Gurk \n\n');
    disp(RT_McGURK_OK_inCON_TOTAL);
    disp(RT_McGURK_OK_inINC_TOTAL);

    disp(RT_McGURK_NO_inCON_TOTAL);
    disp(RT_McGURK_NO_inINC_TOTAL);
end

function figure_response_type_across_block_for_gurk_movies(cfg, NbMcMovies, NbTrialsPerBlock, StimByStimRespRecap)

    figure('name', 'response_type_across_block_for_gurk_movies', ...
           'visible', cfg.visible, ...
           'position', cfg.position);

    for j = 1:NbMcMovies

        subplot (2, 4, j);

        for i = 1:max(NbTrialsPerBlock)
            tmp = StimByStimRespRecap{1, 2, 3}(j, :, i, 1);
            G(i, :) = tmp / sum(tmp); %#ok<*AGROW>
        end
        bar(G, 'stacked');

        set(gca, ...
            'xtick', 1:max(NbTrialsPerBlock), ...
            'xticklabel', 1:max(NbTrialsPerBlock));
        set_axis();

    end

    for j = 1:NbMcMovies

        subplot (2, 4, j + NbMcMovies);

        for i = 1:max(NbTrialsPerBlock)
            tmp = StimByStimRespRecap{1, 2, 3}(j, :, i, 2);
            G(i, :) = tmp / sum(tmp);
        end
        bar(G, 'stacked');

        t = title (StimByStimRespRecap{1, 1, 3}(j, :));
        set(t, 'fontsize', 15);
        set(gca, ...
            'xtick', 1:max(NbTrialsPerBlock), ...
            'xticklabel', 1:max(NbTrialsPerBlock));
        set_axis();

    end

    legend(['b'; 'd'; 'g'; 'k'; 'p'; 't'; ' ']);

    subplot (2, 4, 1);
    ylabel 'After CON';

    subplot (2, 4, 5);
    ylabel 'After INC';
end

function  plot_mc_gurk_responses_across_blocks(cfg, ResponsesCell, NbTrialsPerBlock)

    figure('name', 'mc_gurk_responses_across_blocks', ...
           'visible', cfg.visible, ...
           'position', cfg.position);

    hold on;

    plot(ResponsesCell{3, 1}(1, :) ./ sum(ResponsesCell{3, 1}(1:2, :)), 'g');
    plot(ResponsesCell{3, 2}(1, :) ./ sum(ResponsesCell{3, 2}(1:2, :)), 'r');

    t = title ('McGurk');
    set(t, 'fontsize', 15);
    set(gca, ...
        'xtick', 1:max(NbTrialsPerBlock), ...
        'xticklabel', 1:max(NbTrialsPerBlock), ...
        'ylim', [0 1]);
    set_axis();
    legend(['In a CON Block'; 'In a INC Block'], 'Location', 'SouthEast');
end

function histogram_percent_correct_mc_gurk(cfg, McGURKinCON_Correct, McGURKinINC_Correct, ResponsesCell)

    figure('name', 'percent_correct_mc_gurk', ...
           'visible', cfg.visible, ...
           'position', cfg.position);

    hold on;

    bar(1, McGURKinCON_Correct, 'g');
    bar(2, McGURKinINC_Correct, 'r');
    errorbar(1, McGURKinCON_Correct, std(ResponsesCell{3, 1}(1, 3:end) ./ ...
                                         sum(ResponsesCell{3, 1}(1:2, 3:end))), 'k');
    errorbar(2, McGURKinINC_Correct, std(ResponsesCell{3, 2}(1, 3:end) ./ ...
                                         sum(ResponsesCell{3, 2}(1:2, 3:end))), 'k');

    t = title ('McGurk');
    set(t, 'fontsize', 15);

    set(gca, ...
        'xtick', 1:2, ...
        'xticklabel', ['In a CON Block'; 'In a INC Block']);
    set_axis();

    legend(['In a CON Block'; 'In a INC Block'], 'Location', 'SouthEast');

    axis([0.5 2.5 0 1]);
end

function figure_reaction_time(cfg, TotalTrials)

    figure('name', 'reaction_time', ...
           'visible', cfg.visible, ...
           'position', cfg.position);

    scatter(15 * TotalTrials{1, 1}(:, 5) + TotalTrials{1, 1}(:, 2), TotalTrials{1, 1}(:, 6));

    xlabel 'Trial Number';
    ylabel 'Response Time';
    set(gca, ...
        'xtick', [1 16 31], ...
        'xticklabel', 'Congruent|Incongruent|McGurk', ...
        'ylim', [-.5 10]);
    set_axis();

end

function set_axis()
    axis('tight');
    set(gca, ...
        'tickdir', 'out', ...
        'ticklength', [0.005 0], ...
        'fontsize', 13, ...
        'ylim', [0 1]);
end

function print_figure()
    handle = gcf;
    print(gcf, strcat('figure_', handle.Name, '.eps'), '-depsc');
end
