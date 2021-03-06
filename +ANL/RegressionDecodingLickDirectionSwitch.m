%{
# Decoding tongue kinematic based on the regression mode
-> EXP.Session
-> ANL.TongueTuning1DType
-> ANL.LickDirectionType
-> ANL.OutcomeTypeDecoding
-> ANL.FlagBasicTrialsDecoding
-> ANL.RegressionTime4
flag_lick_direction_switch     :int                        # 1 if the lick direction have switched relative to the previous lick, 0 otherwise
---
number_of_licks_with_switch                     :int          # per session for computing regression
rsq_linear_regression_t                         : blob       # rsquare (coefficient of determination) based on linear regression computed at one time and projected at various times
t_for_decoding                                  : blob       #
%}


classdef RegressionDecodingLickDirectionSwitch < dj.Computed
    properties
        
        keySource = ((EXP.Session  & EPHYS.Unit & ANL.Video1stLickTrial) *ANL.LickDirectionType *  (ANL.FlagBasicTrialsDecoding & 'flag_use_basic_trials_decoding=0') * (ANL.OutcomeTypeDecoding & 'outcome_trials_for_decoding="all"')* (ANL.TongueTuning1DType & 'tuning_param_name="lick_horizoffset" or tuning_param_name="lick_rt_video_onset" or tuning_param_name="lick_peak_x"') )*ANL.RegressionTime4;
    end
    methods(Access=protected)
        function makeTuples(self, key)
            k=key;
            k.regression_time_start=round(0,4);
            
            
            
            if strcmp(k.lick_direction,'all')
                k=rmfield(k,'lick_direction');
            end
            
            
            k.tongue_estimation_type='tip';
            
            if k.flag_use_basic_trials_decoding==1
                k.trialtype_left_and_right_no_distractors=1;
            end
            
            if ~strcmp(k.outcome_trials_for_decoding,'all')
                k.outcome=k.outcome_trials_for_decoding;
            end
            
            
            rel_behav= EXP.TrialID & ((EXP.BehaviorTrial * EXP.TrialName  * ANL.TrialTypeGraphic* ANL.VideoLickSwitchTrial	)   & k  & 'early_lick="no early"' );
            if rel_behav.count==0
                return
            end
            
            rel_all_lick= (ANL.VideoLickSwitchTrial & k ) & rel_behav;
            
            for i_f=0:1:1
                key.flag_lick_direction_switch=i_f;
                k.flag_lick_direction_switch=i_f;
                rel_all_lick= (ANL.VideoLickSwitchTrial & k ) & rel_behav;
                fn_regression_decoding_lick_direction_switch (key,self, rel_all_lick)
            end
        end
    end
end