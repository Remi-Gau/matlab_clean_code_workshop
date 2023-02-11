function group_level(config)

    % (C) Copyright 2023 Remi Gau

    % {5,1,rMAX} cell where rMAX is the total number of run
    %
    % {1,1} contains the trial number and the type of stimuli presented on this trial
    % Trials(i,1:5) = [i p Choice n m RT Resp RespCat];
    % i      is the trial number
    % p      is the trial number in the current block
    % Choice     contains the type of stimuli presented on this trial :
    %               0--> Congruent,
    %               1--> Incongruent,
    % n          is the variable that says what kind of block came before the present one.
    %               Equals to 666 if there was no previous block. :
    %               0--> Congruent,
    %               1--> Incongruent,
    % m          is the variable that says the length of the block that came before the present one.
    %               Equals to 666 if there was no previous block.
    % RT
    % Resp
    % RespCat   For Congruent trials
    %               1 --> Hit;
    %               0 --> Miss
    %           For Incongruent trials
    %               1 --> Hit
    %               0 --> Miss
    %           For McGurk trials
    %               1 --> McGurk effect worked;
    %               0 --> Miss
    %
    % {2,1} contains the name of the stim used
    % {3,1} contains the level of noise used for this stimuli
    % {4,1} contains the absolute path of the corresponding movie to be played
    % {5,1} contains the absolute path of the corresponding sound to be played

    % TO DO :
    %   - add a way to analyze just one trial

    config.visible = 'off';
    if config.verbose
        config.visible = 'on';
    end

    MatFilesList = dir('Results*.mat');
    SizeMatFilesList = size(MatFilesList, 1);

    Subject_Lists = {};
    GroupResponses = [];

    GroupRT = [];

    GroupMissed = [];

    GroupNbValidTrials = [];

    GroupNbMcGURKinCON = [];
    GroupNbMcGURKinINC = [];

    GroupStimByStimAllResults = { ...
                                 '', ...
                                 'Auditory Be - Visual Ge', ...
                                 'Auditory Bi - Visual Gi', ...
                                 'Auditory Pa - Visual Ka', ...
                                 'Auditory Pe - Visual Ke', ...
                                 'Auditory Pi - Visual Ki'};

    GroupStimByStim(1).name = 'Auditory Be - Visual Ge';
    GroupStimByStim(2).name = 'Auditory Bi - Visual Gi';
    GroupStimByStim(3).name = 'Auditory Pa - Visual Ka';
    GroupStimByStim(4).name = 'Auditory Pe - Visual Ke';
    GroupStimByStim(5).name = 'Auditory Pi - Visual Ki';

    for i = 1:numel(GroupStimByStim)
        GroupStimByStim(i).results = cell(1, 2);
    end

    for Subject = 1:SizeMatFilesList

        load(MatFilesList(Subject).name);

        Subject_Lists{Subject, 1} = SubjID; %#ok<*AGROW>
        GroupStimByStimAllResults{end + 1, 1} = SubjID;

        GroupNbValidTrials = [GroupNbValidTrials; NbValidTrials];

        GroupNbMcGURKinCON = [GroupNbMcGURKinCON; NbMcGURKinCON];

        GroupNbMcGURKinINC = [GroupNbMcGURKinINC; NbMcGURKinINC];

        GroupResponses(Subject, :) = [McGURKinCON_Correct, ...
                                      McGURKinINC_Correct, ...
                                      McGURKinCON_Correct - McGURKinINC_Correct, ...
                                      CONinCON_Correct, ...
                                      INCinINC_Correct];

        GroupRT(Subject, :) = [RT_CON_OK, ...
                               RT_INC_OK, ...
                               RT_McGURK_OK_inCON_TOTAL, ...
                               RT_McGURK_OK_inINC_TOTAL, ...
                               RT_McGURK_NO_inCON_TOTAL, ...
                               RT_McGURK_NO_inINC_TOTAL];

        GroupMissed = [GroupMissed; Missed];

        for i = 1:NbMcMovies

            A = (McGurkStimByStimRespRecap{i, 2}(:, 1) ./ ...
                 sum(McGurkStimByStimRespRecap{i, 2}, 2))';

            switch McGurkStimByStimRespRecap{i, 1}
                case 'V_Ge_A_Be'
                    WichStim = 1;
                case 'V_Gi_A_Bi'
                    WichStim = 2;
                case 'V_Ka_A_Pa'
                    WichStim = 3;
                case 'V_Ke_A_Pe'
                    WichStim = 4;
                case 'V_Ki_A_Pi'
                    WichStim = 5;
            end

            GroupStimByStim(WichStim).results{1, 1}{end + 1, 1} = SubjID;
            GroupStimByStim(WichStim).results{1, 2}(end + 1, :) = A;

            GroupStimByStimAllResults{end, WichStim + 1} = A;
        end

    end

    %%
    figure('name', 'proportion_mc_gurk_answers_per_subject', ...
           'visible', config.visible, ...
           'position', config.position);

    for Subject = 1:SizeMatFilesList

        load(MatFilesList(Subject).name);

        subplot(1, SizeMatFilesList, Subject);
        hold on;
        bar(1, McGURKinCON_Correct, 'g');
        bar(2, McGURKinINC_Correct, 'r');
        errorbar(1, McGURKinCON_Correct, ...
                 nanstd(ResponsesCell{3, 1}(1, 3:end) ./ ...
                        sum(ResponsesCell{3, 1}(1:2, 3:end))), ...
                 'k');
        errorbar(2, McGURKinINC_Correct, ...
                 nanstd(ResponsesCell{3, 2}(1, 3:end) ./ ...
                        sum(ResponsesCell{3, 2}(1:2, 3:end))), ...
                 'k');

        set(gca, 'xtick', 1:2, 'xticklabel', [' '; ' '], 'ytick', []);
        set_axis();
        axis([0.5 2.5 0 1.2]);

        if Subject == 1
            ylabel 'Ratio of McGurk answers';
            set(gca, 'ytick', 0:0.1:1);
        end

        if Subject == SizeMatFilesList
            legend(['In a CON Block'; 'In a INC Block'], 'Location', 'NorthEast');
        end
    end

    print_figure();

    %%
    [a, b] = size(GroupStimByStimAllResults);

    for i = 2:a
        for j = 2:b
            if isempty(GroupStimByStimAllResults{i, j})
                GroupStimByStimAllResults{i, j} = NaN(1, 2);
            end
        end
    end

    %%
    figure_proportion_mc_gurk_answers(config, GroupStimByStim);
    print_figure();

    figure_proportion_mc_gurk_answers_spaghetti(config, GroupStimByStim);
    print_figure();

    %%

    if config.verbose
        disp('MISSED');
        fprintf('%6.3f +/- %6.3f \n', nanmean(GroupMissed), nanstd(GroupMissed));
        print_mean_std(GroupRT(:, 6));

        display_response_results(GroupResponses, GroupStimByStim);

        disp('Correct answers on CON trial in CON blocks');
        print_mean_std(GroupResponses(:, 4));
        disp('Correct answers on INC trial in INC blocks');
        print_mean_std(GroupResponses(:, 5));

        display_reation_time_results(GroupRT);

        GroupNbValidTrials;
        GroupNbMcGURKinCON;
        GroupNbMcGURKinINC;
        GroupMissed;
        GroupResponses;
        GroupRT;
        GroupStimByStimAllResults;
    end

    %%
    figure(1);
    print(gcf, 'Figures.ps', '-dpsc2');
    for i = 1:(figure_counter - 1)
        figure(i);
        print(gcf, strcat('Fig', num2str(i), '.eps'), '-depsc');
    end

    %%
    save_to_csv(Subject_Lists, GroupRT, GroupStimByStimAllResults);

    SavedGroupMat = strcat('Group_Results.mat');
    save(SavedGroupMat);
end

function figure_proportion_mc_gurk_answers(cfg, GroupStimByStim)

    figure('name', 'proportion_mc_gurk_answers', ...
           'visible', cfg.visible, ...
           'position', cfg.position);

    for i = 1:numel(GroupStimByStim)

        subplot(1, numel(GroupStimByStim), i);

        t = title(GroupStimByStim(i).name);
        set(t, 'fontsize', 15);

        hold on;

        values = GroupStimByStim(i).results{1, 2};

        bar(1, nanmean(values(:, 1)), 'g');
        errorbar(1, nanmean(values(:, 1)), nanstd(values(:, 1)), 'k');
        bar(2, nanmean(values(:, 2)), 'r');
        errorbar(2, nanmean(values(:, 2)), nanstd(values(:, 2)), 'k');

        set(gca, ...
            'xtick', 1:2, ...
            'xticklabel', ['CON'; 'INC']);
        set_axis();
        axis([0.5 2.5 0 1]);

    end

    subplot(1, numel(GroupStimByStim), 1);
    ylabel 'Proportion of McGurk answers';

end

function figure_proportion_mc_gurk_answers_spaghetti(cfg, GroupStimByStim)

    figure('name', 'proportion_mc_gurk_answers_spaghetti', ...
           'visible', cfg.visible, ...
           'position', cfg.position);

    for i = 1:numel(GroupStimByStim)

        subplot(1, numel(GroupStimByStim), i);

        t = title(GroupStimByStim(i).name);
        set(t, 'fontsize', 15);

        hold on;
        for Subject = 1:length(GroupStimByStim(i).results{1, 2})
            plot([1 2], [GroupStimByStim(i).results{1, 2}(Subject, 1), ...
                         GroupStimByStim(i).results{1, 2}(Subject, 2)], 'k');
        end

        label = strcat('n = ', num2str(length(GroupStimByStim(i).results{1, 2})));
        xlabel(label);

        set(gca, ...
            'xtick', 1:2, ...
            'xticklabel', ['CON'; 'INC']);
        set_axis();
        axis([0.5 2.5 0 1]);
    end

    subplot(1, 5, 1);
    ylabel 'Proportion of McGurk answers';

end

function display_response_results(GroupResponses, GroupStimByStim)
    disp('RESPONSES');
    disp('McGurk answers in CON blocks');
    print_mean_std(GroupResponses(:, 1));
    disp('McGurk answers in INC blocks');
    print_mean_std(GroupResponses(:, 2));
    disp('Differences in McGurk answers in between CON and INC blocks');
    print_mean_std(GroupResponses(:, 3));
    [h, p] = ttest(GroupResponses(:, 1), GroupResponses(:, 2), 0.05, 'right');
    if h == 1
        fprintf('Different from 0 with p = %6.6f\n', p);
    end

    for i = 1:numel(GroupStimByStim)
        disp(GroupStimByStim(i).name);
        disp('McGurk answers in CON blocks');
        print_mean_std(GroupStimByStim(i).results{1, 2}(:, 1));
        disp('McGurk answers in INC blocks');
        print_mean_std(GroupStimByStim(i).results{1, 2}(:, 2));
        [h, p] = ttest(GroupStimByStim(i).results{1, 2}(:, 1), GroupStimByStim(i).results{1, 2}(:, 2), 0.05, 'right');
        if h == 1
            fprintf('Different with p = %6.6f \n\n', p);
        end
        fprintf('\n');
    end
    disp('Correct answers on CON trial in CON blocks');
    print_mean_std(GroupResponses(:, 4));
    disp('Correct answers on INC trial in INC blocks');
    print_mean_std(GroupResponses(:, 5));
end

function display_reation_time_results(GroupRT)
    disp('REACTION TIMES');
    disp('Congruent in CON blocks');
    print_mean_std(GroupRT(:, 1));
    disp('Incongruent in INC blocks');
    print_mean_std(GroupRT(:, 2));
    [h, p] = ttest(GroupRT(:, 1), GroupRT(:, 2), 0.05, 'both');
    if h == 1
        fprintf('Different from from each other with p = %6.6f \n\n', p);
    end
    disp('McGurk answers in CON blocks');
    print_mean_std(GroupRT(:, 3));
    disp('McGurk answers in INC blocks');
    print_mean_std(GroupRT(:, 4));
    disp('Non McGurk answers in CON blocks');
    print_mean_std(GroupRT(:, 5));
    disp('Non McGurk answers in INC blocks');
    print_mean_std(GroupRT(:, 6));
end

function print_mean_std(values)
    fprintf('%6.3f +/- %6.3f \n', nanmean(values), nanstd(values));
end

function save_to_csv(Subject_Lists, GroupRT, GroupStimByStimAllResults)
    SavedGroupTxt = 'Group_Results.csv';
    fid = fopen(SavedGroupTxt, 'w');

    fprintf (fid, 'Reaction times for the whole group \n');
    headers = {'Subject', ...
               'RT_CON', ...
               'RT_INC', ...
               'RT_McGURK_OK_inCON', ...
               'RT_McGURK_OK_inINC', ...
               'RT_McGURK_NO_inCON', ...
               'RT_McGURK_NO_inINC \n\n'};
    fprintf (fid, strjoin(headers, ', '));
    for Subject = 1:numel(Subject_Lists)
        fprintf (fid, '%s,', Subject_Lists{Subject});
        fprintf (fid, '%6.3f,', GroupRT(Subject, :));
        fprintf (fid, '\n');
    end

    fprintf (fid, '\n');

    fprintf (fid, 'Responses for all McGurk movies \n');
    for i = 1:6
        fprintf (fid, '%s, ,', GroupStimByStimAllResults{1, i});
    end
    fprintf (fid, '\n');
    for i = 1:numel(Subject_Lists)
        fprintf (fid, '%s,', GroupStimByStimAllResults{i + 1, 1});
        for j = 2:6
            fprintf (fid, '%6.3f,', GroupStimByStimAllResults{i + 1, j});
        end
        fprintf (fid, '\n');
    end

    fclose (fid);

end

function print_figure()
    handle = gcf;
    print(gcf, ...
          ['figure_', handle.Name, '.eps'], ...
          '-depsc');
end
