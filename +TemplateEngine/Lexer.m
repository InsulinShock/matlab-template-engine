classdef Lexer < handle
    %LEXER Summary of this class goes here
    %   Detailed explanation goes here
    
    properties (Access = private)
        openValue string = "{{";
        closeValue string = "}}";
        openExpression string = "{{#";
        closeExpression string = "}}";
    end
    
    properties (Access = private)
        line int64 = 1;
        column int64 = 1;
    end
    
    properties (SetAccess = immutable)
        template string;
    end
    
    properties (Access = private)
        dynamicTemplate string;
    end
    
    methods
        function obj = Lexer(template)
            %LEXER Construct an instance of this class
            %   Detailed explanation goes here
            obj.template = template;
            obj.dynamicTemplate = obj.template;
        end
                
        function token = nextToken(obj)
            obj.dynamicTemplate
            
            strA = extractBefore(obj.dynamicTemplate,"{{#");
            strB = extractBefore(obj.dynamicTemplate,"{{");
            
            if strlength(strA) == 0
                value = extractBetween(obj.dynamicTemplate,"{{#","}}");
                obj.dynamicTemplate = extractAfter(obj.dynamicTemplate,"}}");
                token = TemplateEngine.Token(TemplateEngine.TokenType.EXPRESSION,value(1),obj.line,obj.column);
                return;
            end
            
            if strlength(strB) == 0
                value = extractBetween(obj.dynamicTemplate,"{{","}}");
                obj.dynamicTemplate = extractAfter(obj.dynamicTemplate,"}}");
                token = TemplateEngine.Token(TemplateEngine.TokenType.VALUE,value(1),obj.line,obj.column);
                return;
            end
                        
            if strlength(strA) <= strlength(strB)
                token = TemplateEngine.Token(TemplateEngine.TokenType.TEXT,strA,obj.line,obj.column);
                obj.dynamicTemplate = extractAfter(obj.dynamicTemplate,strlength(strA));
                return
            end
            
            if strlength(strA) > strlength(strB)
                token = TemplateEngine.Token(TemplateEngine.TokenType.TEXT,strB,obj.line,obj.column);
                obj.dynamicTemplate = extractAfter(obj.dynamicTemplate,strlength(strB));
                return
            end
                  
            token = TemplateEngine.Token(TemplateEngine.TokenType.ENDOFFILE,obj.dynamicTemplate,obj.line,obj.column);            
                        
        end
            
    end
end

