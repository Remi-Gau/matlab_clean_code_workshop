root_dir = '/home/remi/github/matlab_clean_code_workshop/';
data_dir = fullfile(root_dir, 'data');

subjects = dir (fullfile(data_dir, 'sub*'));

for i_sub = 1:numel(subjects)
    cd([data_dir, '/' subjects(i_sub).name])
    Analyse()
end