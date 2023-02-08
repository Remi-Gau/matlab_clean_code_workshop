% Script to:
% - run all the moxunit tests on the McGurk analysis code
% - generate an coverage HTM and XML report
% - create a log file to report if any test failed (used in CI)

folderToCover = fullfile(pwd, 'src');
testFolder = fullfile(pwd, 'tests');

success = moxunit_runtests(testFolder, ...
                           '-verbose', ...
                           '-recursive', ...
                           '-with_coverage', ...
                           '-cover', folderToCover, ...
                           '-cover_xml_file', 'coverage.xml', ...
                           '-cover_html_dir', fullfile(pwd, 'coverage_html'));

if success
    system('echo 0 > test_report.log');
else
    system('echo 1 > test_report.log');
end
