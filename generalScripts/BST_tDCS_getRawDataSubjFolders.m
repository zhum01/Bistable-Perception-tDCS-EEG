function [rawDataSubjFolders] = BST_tDCS_getRawDataSubjFolders()
% returns cell for each subject containing subject folder and subject number
BST_tDCS_setAllDirectories;

rawDataSubjFolders = { ...
 {{[vars.BST_tDCS_allRawDataDir 'sub01/tDCS_sessions/session1/post-tDCS/' vars.BST_tDCS_eegRawDataDir]  ,1}
  {[vars.BST_tDCS_allRawDataDir 'sub01/tDCS_sessions/session2/post-tDCS/' vars.BST_tDCS_eegRawDataDir]  ,1}
  {[vars.BST_tDCS_allRawDataDir 'sub01/tDCS_sessions/session3/post-tDCS/' vars.BST_tDCS_eegRawDataDir]  ,1}}...
 
 {{[vars.BST_tDCS_allRawDataDir 'sub02/tDCS_sessions/session1/post-tDCS/' vars.BST_tDCS_eegRawDataDir]  ,2}
  {[vars.BST_tDCS_allRawDataDir 'sub02/tDCS_sessions/session2/post-tDCS/' vars.BST_tDCS_eegRawDataDir]  ,2}
  {[vars.BST_tDCS_allRawDataDir 'sub02/tDCS_sessions/session3/post-tDCS/' vars.BST_tDCS_eegRawDataDir]  ,2}}
 
 {{[vars.BST_tDCS_allRawDataDir 'sub03/tDCS_sessions/session1/post-tDCS/' vars.BST_tDCS_eegRawDataDir]  ,3}
  {[vars.BST_tDCS_allRawDataDir 'sub03/tDCS_sessions/session2/post-tDCS/' vars.BST_tDCS_eegRawDataDir]  ,3}
  {[vars.BST_tDCS_allRawDataDir 'sub03/tDCS_sessions/session3/post-tDCS/' vars.BST_tDCS_eegRawDataDir]  ,3}}
  
 {{[vars.BST_tDCS_allRawDataDir 'sub04/tDCS_sessions/session1/post-tDCS/' vars.BST_tDCS_eegRawDataDir]  ,4}
  {[vars.BST_tDCS_allRawDataDir 'sub04/tDCS_sessions/session2/post-tDCS/' vars.BST_tDCS_eegRawDataDir]  ,4}
  {[vars.BST_tDCS_allRawDataDir 'sub04/tDCS_sessions/session3/post-tDCS/' vars.BST_tDCS_eegRawDataDir]  ,4}} 
  
 {{[vars.BST_tDCS_allRawDataDir 'sub05/tDCS_sessions/session1/post-tDCS/' vars.BST_tDCS_eegRawDataDir]  ,5}
  {[vars.BST_tDCS_allRawDataDir 'sub05/tDCS_sessions/session2/post-tDCS/' vars.BST_tDCS_eegRawDataDir]  ,5}
  {[vars.BST_tDCS_allRawDataDir 'sub05/tDCS_sessions/session3/post-tDCS/' vars.BST_tDCS_eegRawDataDir]  ,5}}
  
 {{[vars.BST_tDCS_allRawDataDir 'sub06/tDCS_sessions/session1/post-tDCS/' vars.BST_tDCS_eegRawDataDir]  ,6}
  {[vars.BST_tDCS_allRawDataDir 'sub06/tDCS_sessions/session2/post-tDCS/' vars.BST_tDCS_eegRawDataDir]  ,6}
  {[vars.BST_tDCS_allRawDataDir 'sub06/tDCS_sessions/session3/post-tDCS/' vars.BST_tDCS_eegRawDataDir]  ,6}}
  
 {{[vars.BST_tDCS_allRawDataDir 'sub07/tDCS_sessions/session1/post-tDCS/' vars.BST_tDCS_eegRawDataDir]  ,7}
  {[vars.BST_tDCS_allRawDataDir 'sub07/tDCS_sessions/session2/post-tDCS/' vars.BST_tDCS_eegRawDataDir]  ,7}
  {[vars.BST_tDCS_allRawDataDir 'sub07/tDCS_sessions/session3/post-tDCS/' vars.BST_tDCS_eegRawDataDir]  ,7}}
  
 {{[vars.BST_tDCS_allRawDataDir 'sub08/tDCS_sessions/session1/post-tDCS/' vars.BST_tDCS_eegRawDataDir]  ,8}
  {[vars.BST_tDCS_allRawDataDir 'sub08/tDCS_sessions/session2/post-tDCS/' vars.BST_tDCS_eegRawDataDir]  ,8}
  {[vars.BST_tDCS_allRawDataDir 'sub08/tDCS_sessions/session3/post-tDCS/' vars.BST_tDCS_eegRawDataDir]  ,8}}
  
 {{[vars.BST_tDCS_allRawDataDir 'sub09/tDCS_sessions/session1/post-tDCS/' vars.BST_tDCS_eegRawDataDir]  ,9}
  {[vars.BST_tDCS_allRawDataDir 'sub09/tDCS_sessions/session2/post-tDCS/' vars.BST_tDCS_eegRawDataDir]  ,9}
  {[vars.BST_tDCS_allRawDataDir 'sub09/tDCS_sessions/session3/post-tDCS/' vars.BST_tDCS_eegRawDataDir]  ,9}}
  
 {{[vars.BST_tDCS_allRawDataDir 'sub10/tDCS_sessions/session1/post-tDCS/' vars.BST_tDCS_eegRawDataDir]  ,10}
  {[vars.BST_tDCS_allRawDataDir 'sub10/tDCS_sessions/session2/post-tDCS/' vars.BST_tDCS_eegRawDataDir]  ,10}
  {[vars.BST_tDCS_allRawDataDir 'sub10/tDCS_sessions/session3/post-tDCS/' vars.BST_tDCS_eegRawDataDir]  ,10}}
  
 {{[vars.BST_tDCS_allRawDataDir 'sub11/tDCS_sessions/session1/post-tDCS/' vars.BST_tDCS_eegRawDataDir]  ,11}
  {[vars.BST_tDCS_allRawDataDir 'sub11/tDCS_sessions/session2/post-tDCS/' vars.BST_tDCS_eegRawDataDir]  ,11}
  {[vars.BST_tDCS_allRawDataDir 'sub11/tDCS_sessions/session3/post-tDCS/' vars.BST_tDCS_eegRawDataDir]  ,11}}
  
 {{[vars.BST_tDCS_allRawDataDir 'sub12/tDCS_sessions/session1/post-tDCS/' vars.BST_tDCS_eegRawDataDir]  ,12}
  {[vars.BST_tDCS_allRawDataDir 'sub12/tDCS_sessions/session2/post-tDCS/' vars.BST_tDCS_eegRawDataDir]  ,12}
  {[vars.BST_tDCS_allRawDataDir 'sub12/tDCS_sessions/session3/post-tDCS/' vars.BST_tDCS_eegRawDataDir]  ,12}}
  
 {{[vars.BST_tDCS_allRawDataDir 'sub13/tDCS_sessions/session1/post-tDCS/' vars.BST_tDCS_eegRawDataDir]  ,13}
  {[vars.BST_tDCS_allRawDataDir 'sub13/tDCS_sessions/session2/post-tDCS/' vars.BST_tDCS_eegRawDataDir]  ,13}
  {[vars.BST_tDCS_allRawDataDir 'sub13/tDCS_sessions/session3/post-tDCS/' vars.BST_tDCS_eegRawDataDir]  ,13}}
  
 {{[vars.BST_tDCS_allRawDataDir 'sub14/tDCS_sessions/session1/post-tDCS/' vars.BST_tDCS_eegRawDataDir]  ,14}
  {[vars.BST_tDCS_allRawDataDir 'sub14/tDCS_sessions/session2/post-tDCS/' vars.BST_tDCS_eegRawDataDir]  ,14}
  {[vars.BST_tDCS_allRawDataDir 'sub14/tDCS_sessions/session3/post-tDCS/' vars.BST_tDCS_eegRawDataDir]  ,14}}
  
 {{[vars.BST_tDCS_allRawDataDir 'sub15/tDCS_sessions/session1/post-tDCS/' vars.BST_tDCS_eegRawDataDir]  ,15}
  {[vars.BST_tDCS_allRawDataDir 'sub15/tDCS_sessions/session2/post-tDCS/' vars.BST_tDCS_eegRawDataDir]  ,15}
  {[vars.BST_tDCS_allRawDataDir 'sub15/tDCS_sessions/session3/post-tDCS/' vars.BST_tDCS_eegRawDataDir]  ,15}}
  
 {{[vars.BST_tDCS_allRawDataDir 'sub16/tDCS_sessions/session1/post-tDCS/' vars.BST_tDCS_eegRawDataDir]  ,16}
  {[vars.BST_tDCS_allRawDataDir 'sub16/tDCS_sessions/session2/post-tDCS/' vars.BST_tDCS_eegRawDataDir]  ,16}
  {[vars.BST_tDCS_allRawDataDir 'sub16/tDCS_sessions/session3/post-tDCS/' vars.BST_tDCS_eegRawDataDir]  ,16}}
  
 {{[vars.BST_tDCS_allRawDataDir 'sub17/tDCS_sessions/session1/post-tDCS/' vars.BST_tDCS_eegRawDataDir]  ,17}
  {[vars.BST_tDCS_allRawDataDir 'sub17/tDCS_sessions/session2/post-tDCS/' vars.BST_tDCS_eegRawDataDir]  ,17}
  {[vars.BST_tDCS_allRawDataDir 'sub17/tDCS_sessions/session3/post-tDCS/' vars.BST_tDCS_eegRawDataDir]  ,17}}
  
 {{[vars.BST_tDCS_allRawDataDir 'sub18/tDCS_sessions/session1/post-tDCS/' vars.BST_tDCS_eegRawDataDir]  ,18}
  {[vars.BST_tDCS_allRawDataDir 'sub18/tDCS_sessions/session2/post-tDCS/' vars.BST_tDCS_eegRawDataDir]  ,18}
  {[vars.BST_tDCS_allRawDataDir 'sub18/tDCS_sessions/session3/post-tDCS/' vars.BST_tDCS_eegRawDataDir]  ,18}}
  
 {{[vars.BST_tDCS_allRawDataDir 'sub19/tDCS_sessions/session1/post-tDCS/' vars.BST_tDCS_eegRawDataDir]  ,19}
  {[vars.BST_tDCS_allRawDataDir 'sub19/tDCS_sessions/session2/post-tDCS/' vars.BST_tDCS_eegRawDataDir]  ,19}
  {[vars.BST_tDCS_allRawDataDir 'sub19/tDCS_sessions/session3/post-tDCS/' vars.BST_tDCS_eegRawDataDir]  ,19}}
  
 {{[vars.BST_tDCS_allRawDataDir 'sub20/tDCS_sessions/session1/post-tDCS/' vars.BST_tDCS_eegRawDataDir]  ,20}
  {[vars.BST_tDCS_allRawDataDir 'sub20/tDCS_sessions/session2/post-tDCS/' vars.BST_tDCS_eegRawDataDir]  ,20}
  {[vars.BST_tDCS_allRawDataDir 'sub20/tDCS_sessions/session3/post-tDCS/' vars.BST_tDCS_eegRawDataDir]  ,20}}
  
 {{[vars.BST_tDCS_allRawDataDir 'sub21/tDCS_sessions/session1/post-tDCS/' vars.BST_tDCS_eegRawDataDir]  ,21}
  {[vars.BST_tDCS_allRawDataDir 'sub21/tDCS_sessions/session2/post-tDCS/' vars.BST_tDCS_eegRawDataDir]  ,21}
  {[vars.BST_tDCS_allRawDataDir 'sub21/tDCS_sessions/session3/post-tDCS/' vars.BST_tDCS_eegRawDataDir]  ,21}}
  
 {{[vars.BST_tDCS_allRawDataDir 'sub22/tDCS_sessions/session1/post-tDCS/' vars.BST_tDCS_eegRawDataDir]  ,22}
  {[vars.BST_tDCS_allRawDataDir 'sub22/tDCS_sessions/session2/post-tDCS/' vars.BST_tDCS_eegRawDataDir]  ,22}
  {[vars.BST_tDCS_allRawDataDir 'sub22/tDCS_sessions/session3/post-tDCS/' vars.BST_tDCS_eegRawDataDir]  ,22}}
  
 {{[vars.BST_tDCS_allRawDataDir 'sub23/tDCS_sessions/session1/post-tDCS/' vars.BST_tDCS_eegRawDataDir]  ,23}
  {[vars.BST_tDCS_allRawDataDir 'sub23/tDCS_sessions/session2/post-tDCS/' vars.BST_tDCS_eegRawDataDir]  ,23}
  {[vars.BST_tDCS_allRawDataDir 'sub23/tDCS_sessions/session3/post-tDCS/' vars.BST_tDCS_eegRawDataDir]  ,23}}
  
 {{[vars.BST_tDCS_allRawDataDir 'sub24/tDCS_sessions/session1/post-tDCS/' vars.BST_tDCS_eegRawDataDir]  ,24}
  {[vars.BST_tDCS_allRawDataDir 'sub24/tDCS_sessions/session2/post-tDCS/' vars.BST_tDCS_eegRawDataDir]  ,24}
  {[vars.BST_tDCS_allRawDataDir 'sub24/tDCS_sessions/session3/post-tDCS/' vars.BST_tDCS_eegRawDataDir]  ,24}}};


end



