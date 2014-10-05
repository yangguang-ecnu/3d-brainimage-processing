function [ result ] = isfunction( function_string )
% Returns whether function_string is a known function. 
result = 0;  
% If it's a keyword, I'd say 'yes'. Although some might dispute this. 
if iskeyword(function_string) 
    result = 1; 
else
    fh = str2func(function_string); 
    f = functions(fh); 
    % If it's a function, functions() will return the file it's in. 
    if (~isempty(f.file)) 
        result = 1; 
    else
        result = 0; 
    end
end
end