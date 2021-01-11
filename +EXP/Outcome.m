%{
# 
outcome                     : varchar(32)                    # 
%}


classdef Outcome < dj.Lookup
    properties
        contents = {
            'hit'
            'miss'
            'ignore'
            'response'
            }
    end
end