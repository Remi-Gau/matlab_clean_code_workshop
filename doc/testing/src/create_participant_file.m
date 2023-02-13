function filename = create_participant_file(subject_nb, task_name, run_nb)
    % (C) Copyright 2023 Remi Gau
    assert(isnumeric(run_nb), 'run number should be a number');

    if isnumeric(subject_nb)
        subject_nb = num2str(subject_nb);
    end

    filename = ['sub-' subject_nb, ...
                '_task-' task_name, ...
                '_run-' num2str(run_nb) '.csv'];

    if false
        disp(filename);
    end

end
