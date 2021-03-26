# Contents

Contains scripts used to analyze behavioral and EEG data.


Steps for EEG preprocessing:

1. All time periods before the start and after the end of each block are removed (fixations still included)
2. Fieldtrip preProcessing functions:
    - Demean
    - Detrend
    - Bsfilter (butterworth): [58 62; 118 122; 178 182]
    - Hpfilter (butterworth): 0.5 Hz
    - Lpfilter (butterworth): 150 Hz 
    - Removed channels - EMG1, EMG2, MastL, MastR, TP9 (cap mastoid), TP10 (cap mastoid) 
3. Identify bad channels using two-step process: 
    - Automatically identify channels that saturated or have large variance
    - Manually look at timecourse and topos of all channels
4. Remove bad channels and interpolate data using mean of neighboring channels (based on a 10-10 system template) 
5. ICA:
    - runica
    - ft_rejectcomponent
6. Lpfilter (butterworth): 58 Hz
7. Common Average Rereference

