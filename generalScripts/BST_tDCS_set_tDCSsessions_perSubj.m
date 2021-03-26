%% list the session numbers that will be analyzed for each subject (rows are subject number)
% the order the sessions are listed in determines how they are grouped
% (each column is grouped together for across-subject analyses)

%% deblinded conditions:

vars.tDCSsessions = {{'session2', 'session1', 'session3'}...    % 1
                     {'session1', 'session3', 'session2'}...    % 2
                     {'session3', 'session2', 'session1'}...    % 3
                     {'session2', 'session3', 'session1'}...    % 4
                     {'session3', 'session2', 'session1'}...    % 5
                     {'session1', 'session3', 'session2'}...    % 6
                     {'session1', 'session2', 'session3'}...    % 7
                     {'session3', 'session1', 'session2'}...    % 8
                     {'session1', 'session2', 'session3'}...    % 9
                     {'session3', 'session1', 'session2'}...    % 10
                     {'session2', 'session3', 'session1'}...    % 11
                     {'session2', 'session1', 'session3'}...    % 12
                     {'session1', 'session2', 'session3'}...    % 13
                     {'session1', 'session2', 'session3'}...    % 14
                     {'session3', 'session2', 'session1'}...    % 15
                     {'session3', 'session1', 'session2'}...    % 16
                     {'session2', 'session1', 'session3'}...    % 17
                     {'session3', 'session1', 'session2'}...    % 18
                     {'session2', 'session3', 'session1'}...    % 19
                     {'session1', 'session3', 'session2'}...    % 20
                     {'session2', 'session1', 'session3'}...    % 21
                     {'session2', 'session3', 'session1'}...    % 22
                     {'session1', 'session3', 'session2'}...    % 23
                     {'session3', 'session2', 'session1'}};     % 24
                 
                 
vars.targetRegions ={{'IFG', 'OCC', 'sham'}...                   % 1
                     {'IFG', 'OCC', 'sham'}...                   % 2
                     {'IFG', 'OCC', 'sham'}...                   % 3
                     {'IFG', 'OCC', 'sham'}...                   % 4
                     {'IFG', 'OCC', 'sham'}...                   % 5
                     {'IFG', 'OCC', 'sham'}...                   % 6
                     {'IFG', 'OCC', 'sham'}...                   % 7
                     {'IFG', 'OCC', 'sham'}...                   % 8
                     {'IFG', 'OCC', 'sham'}...                   % 9
                     {'IFG', 'OCC', 'sham'}...                   % 10
                     {'IFG', 'OCC', 'sham'}...                   % 11
                     {'IFG', 'OCC', 'sham'}...                   % 12
                     {'IFG', 'OCC', 'sham'}...                   % 13
                     {'IFG', 'OCC', 'sham'}...                   % 14
                     {'IFG', 'OCC', 'sham'}...                   % 15
                     {'IFG', 'OCC', 'sham'}...                   % 16
                     {'IFG', 'OCC', 'sham'}...                   % 17
                     {'IFG', 'OCC', 'sham'}...                   % 18
                     {'IFG', 'OCC', 'sham'}...                   % 19
                     {'IFG', 'OCC', 'sham'}...                   % 20
                     {'IFG', 'OCC', 'sham'}...                   % 21
                     {'IFG', 'OCC', 'sham'}...                   % 22
                     {'IFG', 'OCC', 'sham'}...                   % 23
                     {'IFG', 'OCC', 'sham'}};                    % 24
                 
%% still blinded (chronological)

% vars.tDCSsessions = {{'session1', 'session2', 'session3'}...    % 1
%                      {'session1', 'session2', 'session3'}...    % 2
%                      {'session1', 'session2', 'session3'}...    % 3
%                      {'session1', 'session2', 'session3'}...    % 4
%                      {'session1', 'session2', 'session3'}...    % 5
%                      {'session1', 'session2', 'session3'}...    % 6
%                      {'session1', 'session2', 'session3'}...    % 7
%                      {'session1', 'session2', 'session3'}...    % 8
%                      {'session1', 'session2', 'session3'}...    % 9
%                      {'session1', 'session2', 'session3'}...    % 10
%                      {'session1', 'session2', 'session3'}...    % 11
%                      {'session1', 'session2', 'session3'}...    % 12
%                      {'session1', 'session2', 'session3'}...    % 13
%                      {'session1', 'session2', 'session3'}...    % 14
%                      {'session1', 'session2', 'session3'}...    % 15
%                      {'session1', 'session2', 'session3'}...    % 16
%                      {'session1', 'session2', 'session3'}...    % 17
%                      {'session1', 'session2', 'session3'}...    % 18
%                      {'session1', 'session2', 'session3'}...    % 19
%                      {'session1', 'session2', 'session3'}...    % 20
%                      {'session1', 'session2', 'session3'}...    % 21
%                      {'session1', 'session2', 'session3'}...    % 22
%                      {'session1', 'session2', 'session3'}...    % 23
%                      {'session1', 'session2', 'session3'}};     % 24
%                  
%                  
% vars.targetRegions ={{'OCC', 'IFG', 'IFG'}...                   % 1
%                      {'IFG', 'OCC', 'OCC'}...                   % 2
%                      {'OCC', 'OCC', 'IFG'}...                   % 3
%                      {'IFG', 'IFG', 'OCC'}...                   % 4
%                      {'IFG', 'OCC', 'IFG'}...                   % 5
%                      {'IFG', 'IFG', 'OCC'}...                   % 6
%                      {'IFG', 'OCC', 'IFG'}...                   % 7
%                      {'OCC', 'OCC', 'IFG'}...                   % 8
%                      {'IFG', 'OCC', 'OCC'}...                   % 9
%                      {'OCC', 'IFG', 'IFG'}...                   % 10
%                      {'OCC', 'IFG', 'OCC'}...                   % 11
%                      {'OCC', 'IFG', 'OCC'}...                   % 12
%                      {'IFG', 'OCC', 'IFG'}...                   % 13
%                      {'IFG', 'OCC', 'OCC'}...                   % 14
%                      {'IFG', 'OCC', 'IFG'}...                   % 15
%                      {'OCC', 'OCC', 'IFG'}...                   % 16
%                      {'OCC', 'IFG', 'OCC'}...                   % 17
%                      {'OCC', 'IFG', 'IFG'}...                   % 18
%                      {'OCC', 'IFG', 'OCC'}...                   % 19
%                      {'IFG', 'OCC', 'OCC'}...                   % 20
%                      {'OCC', 'IFG', 'IFG'}...                   % 21
%                      {'IFG', 'IFG', 'OCC'}...                   % 22
%                      {'IFG', 'IFG', 'OCC'}...                   % 23
%                      {'OCC', 'OCC', 'IFG'}};                    % 24







                 
                 
                 
                 
                 
                 