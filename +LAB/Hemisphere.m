%{
# 
hemisphere   :  varchar(12)
%}


classdef Hemisphere < dj.Lookup
     properties
        contents = {
            'left'
            'right'
            }
    end
end