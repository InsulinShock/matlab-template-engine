classdef Token
    %TOKEN Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        type TemplateEngine.TokenType
        value string
        line int64
        column int64
    end
    
    methods
        function obj = Token(type, value, line, column)
            obj.type = type;
            
            switch obj.type
                case TemplateEngine.TokenType.EXPRESSION
                    obj.value = strtrim(value);
                case TemplateEngine.TokenType.VALUE
                    obj.value = strtrim(value);
                otherwise
                    obj.value = value;
            end   
            
            obj.line = line;
            obj.column = column;
        end        
    end
end
