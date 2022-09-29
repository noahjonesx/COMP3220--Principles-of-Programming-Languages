# https://www.cs.rochester.edu/~brown/173/readings/05_grammars.txt
#
#  "TINY" Grammar
#
# PGM        -->   STMT+
# STMT       -->   ASSIGN   |   "print"  EXP
# ASSIGN     -->   ID  "="  EXP
# EXP        -->   TERM   ETAIL
# ETAIL      -->   "+" TERM   ETAIL  | "-" TERM   ETAIL | EPSILON
# TERM       -->   FACTOR  TTAIL
# TTAIL      -->   "*" FACTOR TTAIL  | "/" FACTOR TTAIL | EPSILON
# FACTOR     -->   "(" EXP ")" | INT | ID
# ID         -->   ALPHA+
# ALPHA      -->   a  |  b  | … | z  or
#                  A  |  B  | … | Z
# INT        -->   DIGIT+
# DIGIT      -->   0  |  1  | …  |  9
# WHITESPACE -->   Ruby Whitespace

#
#  Parser Class
#
load "Token.rb"
load "Lexer.rb"
class Parser < Scanner
	#errors??????????
	def initialize(filename)
    	super(filename)
    	consume()
   	end
   	
	def consume()
      	@lookahead = nextToken()
      	while(@lookahead.type == Token::WS)
        	@lookahead = nextToken()
      	end
   	end
  	
	def match(dtype)
      	if (@lookahead.type != dtype)
         	puts "Expected #{dtype} found #{@lookahead.text}"
				@errors += 1
      	end
      	consume()
   	end
   	
	def program()
			@errors = 0;
      	while( @lookahead.type != Token::EOF)
			statement()  
      	end
			puts "There were #{@errors} parse errors found." # fix to x amt 
   	end

	def statement()
		puts "Entering STMT Rule"
		if (@lookahead.type == Token::PRINT)
			puts "Found PRINT Token: #{@lookahead.text}"
			match(Token::PRINT)
			exp()
		else
			assign()
		end
		
		puts "Exiting STMT Rule"
	end

	def assign()
		puts "Entering ASSGN Rule"
		if (@lookahead.type == Token::ID)
			puts "Found ID Token: #{@lookahead.text}"
		end
		match(Token::ID)
		if (@lookahead.type == Token::ASSGN)
			puts "Found ASSGN Token: #{@lookahead.text}"
		end
		match(Token::ASSGN)
		exp()
		puts "Exiting ASSGN Rule"
	end

	def exp() 
		puts "Entering EXP Rule"
		term()
		etail()
		puts "Exiting EXP Rule"
	end

	def etail() #parses addition and subtraction operations
		puts "Entering ETAIL Rule"
		if (@lookahead.type == Token::ADDOP)
			puts "Found ADDOP Token: #{@lookahead.text}"
			match(Token::ADDOP)
			term()
			etail()
		elsif (@lookahead.type == Token::SUBOP)
			puts "Found SUBOP Token: #{@lookahead.text}"
			match(Token::SUBOP)
			term()
			etail()
		else
			puts "Did not find ADDOP or SUBOP Token, choosing EPSILON production"
		end

		puts "Exiting ETAIL Rule"
	end

	def term()
		puts "Entering TERM Rule"
		factor()
		ttail()
		puts "Exiting TERM Rule"
	end

	def ttail() #Parses multiplication and division operators
		puts "Entering TTAIL Rule"
		if (@lookahead.type == Token::MULTOP)
			puts "Found MULTOP Token:  #{@lookahead.text}"
			match(Token::MULTOP)
			factor()
			ttail()
		elsif (@lookahead.type == Token::DIVOP)
			puts "Found DIVOP Token: #{@lookahead.text}"
			match (Token::DIVOP)
			factor()
			ttail()
		else
			puts "Did not find MULTOP or DIVOP Token, choosing EPSILON production"
		end
		puts "Exiting TTAIL Rule"
	end

	def factor()
		puts "Entering FACTOR Rule"
		if (@lookahead.type == Token::LPAREN)
			puts "Found LPAREN Token: #{@lookahead.text}"
			match(Token::LPAREN)
			exp()
			if (@lookahead.type == Token::RPAREN)
				puts "Found RPAREN Token: #{@lookahead.text}"
			end
			match(Token::RPAREN)
		elsif (@lookahead.type == Token::INT)
			puts "Found INT Token: #{@lookahead.text}"
			match(Token::INT)
		elsif (@lookahead.type == Token::ID)
			puts "Found ID Token: #{@lookahead.text}"
			match(Token::ID)
			#another else to cover other match cases????????????????????????
		else
			puts "Expected ( or INT or ID found #{@lookahead.type}"
			@errors += 1
		end
		puts "Exiting FACTOR Rule"
	end


	#working
# = , id x||Y, ( , +
	#not working 
# int, ) , - , / 
#	def id()

	#enter code, this one is diff 
#	def alpha() 
	#enter code 
#	def int() 
	#enter code, this one is different 
#	def digit() 
	#enter code =
#	def whitespace() 
   #enter code
end #possibly ends statement()