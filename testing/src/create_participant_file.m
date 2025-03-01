function filename = create_participant_file(subject_nb, task_name, run_nb)
    % Create a partcipant CSV filename for a subject, task, run
    %

    % (C) Copyright 2023 Remi Gau

    % use assert for input parameter validation
    assert(isnumeric(run_nb), 'run number should be a number');

    % convert any eventual numeric value into a char
    if isnumeric(subject_nb)
        subject_nb = num2str(subject_nb);
    end

    filename = ['sub-' subject_nb, ...
                '_task-' task_name, ...
                '_run-' num2str(run_nb) '.csv'];

end
