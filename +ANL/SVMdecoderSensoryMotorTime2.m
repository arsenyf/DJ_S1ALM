%{
#
-> EXP.Session
sensory_or_motor            : varchar(200)                  # decoding sensory or motor infornation (i.e the identiy of the stimulus or the response)
flag_include_distractor_trials: smallint                    # 0 - no distractor trials included, 1 - distractor trials are included
---
number_of_trials_svm        : int                           # number of trials used to train/test SVM (the total number of labeled trials)
svm_performance_mean_time_mat                  : longblob                  # mean performance of an svm classifier trained at each trial time and tested at all other times
time_vector_svm             : longblob                      # time vector with bins for which the performance was computed
%}


classdef SVMdecoderSensoryMotorTime2 < dj.Computed
    properties
        keySource = EXP.Session & EPHYS.TrialSpikes
    end
    methods(Access=protected)
        function makeTuples(self, key)
            tic
            key.flag_include_distractor_trials=1;
            key.sensory_or_motor='motor';
            [t,perf_time_mat,smallest_set_num]  = fn_SVM_performance_sensory_motor_time(key);
            if (~isempty(perf_time_mat) && smallest_set_num>4)
               key.svm_performance_mean_time_mat = perf_time_mat;
                key.time_vector_svm = t;
                key.number_of_trials_svm = smallest_set_num*4;
                insert(self,key)
            end
            
            key.sensory_or_motor='sensory';
            [t,perf_time_mat,smallest_set_num] =  fn_SVM_performance_sensory_motor_time(key);
             if (~isempty(perf_time_mat) && smallest_set_num>4)
               key.svm_performance_mean_time_mat = perf_time_mat;
                key.time_vector_svm = t;
                key.number_of_trials_svm = smallest_set_num*4;
                insert(self,key)
            end
            
            key.flag_include_distractor_trials=0;
            key.sensory_or_motor='motor';
            [t,perf_time_mat,smallest_set_num] =  fn_SVM_performance_sensory_motor(key);
             if (~isempty(perf_time_mat) && smallest_set_num>4)
               key.svm_performance_mean_time_mat = perf_time_mat;
                key.time_vector_svm = t;
                key.number_of_trials_svm = smallest_set_num*4;
                insert(self,key)
            end
            
            key.sensory_or_motor='sensory';
            [t,perf_time_mat,smallest_set_num] =  fn_SVM_performance_sensory_motor(key);
             if (~isempty(perf_time_mat) && smallest_set_num>4)
               key.svm_performance_mean_time_mat = perf_time_mat;
                key.time_vector_svm = t;
                key.number_of_trials_svm = smallest_set_num*4;
                insert(self,key)
             end
            
            toc
        end
        
    end
end
