function data_TrialEvent = Ingest_EXP_TrialEvent (obj, key, iTrials, data_TrialEvent)


% For sanity check - unless there is an early licks the timings/durations should be:
%----------------------------------------------------------------------------------
chirp_dur = 0.015;
% sample_dur = 0.7;
% delay_dur = 2;
go_dur = 0.01;
% chirp1_t = go_t - delay_dur - sample_dur - 2*chirp_dur;
% chirp2_t = go_t - delay_dur - chirp_dur;
% delay_t = go_t - delay_dur;

presample_t = obj.trialPropertiesHash.value{1}(iTrials);
delay_t = obj.trialPropertiesHash.value{2}(iTrials);
go_t = obj.trialPropertiesHash.value{3}(iTrials);
chirp1_t = obj.trialPropertiesHash.value{4}(iTrials);
chirp2_t = obj.trialPropertiesHash.value{5}(iTrials);
sample_t = obj.trialPropertiesHash.value{8}(iTrials);

presample_dur = chirp1_t - presample_t;
sample_dur = chirp2_t-sample_t;
delay_dur = go_t - delay_t;


trial_event_type ={'presample'; 'sample start chirp'; 'sample'; 'sample end chirp'; 'delay'; 'go'};
trial_event_time = [presample_t; chirp1_t; sample_t; chirp2_t; delay_t; go_t];
duration = [presample_dur; chirp_dur; sample_dur; chirp_dur; delay_dur; go_dur];


for iTrialEvent=1:1:numel(trial_event_time)
    data_TrialEvent (end+1) = struct(...
        'subject_id',  key.subject_id, 'session', key.session, 'trial', iTrials, 'trial_event_type',trial_event_type(iTrialEvent), 'trial_event_time',trial_event_time(iTrialEvent), 'duration',duration(iTrialEvent) );
end