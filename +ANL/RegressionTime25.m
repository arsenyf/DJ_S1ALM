%{
#
regression_time_start                   : decimal(8,4)                    #

%}


classdef RegressionTime25 < dj.Lookup
    properties
        contents = {
            -0.2500
            -0.2000
            -0.1500
            -0.1000
            -0.0500
            0
            0.0500
            0.1000
            0.1500
            0.2000
            0.2500
            }
    end
end