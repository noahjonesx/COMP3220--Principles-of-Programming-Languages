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
#                  
# ID         -->   ALPHA+
# ALPHA      -->   a  |  b  | … | z  or 
#                  A  |  B  | … | Z
# INT        -->   DIGIT+ n
# DIGIT      -->   0  |  1  | …  |  9
# WHITESPACE -->   Ruby Whitespace

#
#  Class Scanner - Reads a TINY program and emits tokens
#

#load token class???

class Scanner 
# Constructor - Is passed a file to scan and outputs a token
#               each time nextToken() is invoked.
#   @c        - A one character lookahead 
def initialize(filename)
	# Need to modify this code so that the program
	# doesn't abend if it can't open the file but rather
	# displays an informative message

	#ensure file exists
	if File.exist?(filename)
	#if so, open it!
		@f = File.open(filename,'r:utf-8')
	
	# Go ahead and read in the first character in the source
	# code file (if there is one) so that you can begin
	# lexing the source code file 
	if (! @f.eof?) #if not at end of file
		@c = @f.getc() #look ahead using 'c' to next char 
	else
		@c = "eof" #when reaching the end of the file...
		@f.close() #close the file
	end
else #otherwise, if not reaching the end of the file
	puts "Error: File does not exist" #print error msg #file does not exist or cannot be opened 
	###modd below
	@c = "eof"
	end
	
end

	
	# Method nextCh() returns the next character in the file
	def nextCh()
		if (! @f.eof?) #if it is not the end of file
			# @c == class variable used for one-spot look-ahead
			@c = @f.getc() #look ahead to next 'ch' in file
		else
			@c = "eof" #otherwise, it is the end-of-file (eof)
		end
		
		return @c  #might not need accord to ???
		#print what we find ^?^
	end
	# Method nextToken() reads characters in the file and returns
	# the next token
	# You should also print what you find. Follow the format from the
	# example given in the instructions.


	#return Token.new(Token::Unknown, "unknown") for other tokens?
	def nextToken() 
		#if at end of file
		if @c == "eof"
			#return end of file token 
			return Token.new(Token::EOF,"eof")
			#begin individual token defns
			#######################################
		elsif (whitespace?(@c))
			str =""
		
			while whitespace?(@c)
				str += @c
				nextCh()
			end
		
			return Token.new(Token::WS,str)
				###################################

		elsif (letter?(@c))
			str = ''

			while letter?(@c)
					str += @c
					nextCh()
			end

			#different token if string == 'print'
			if (str == "print")
			#return print token 
				return Token.new(Token::PRT,str)
			end
			#otherwise, token == id
			return Token.new(Token::ID,str)

		
		elsif numeric?(@c)
				str = ''
			while numeric?(@c) 
				str += @c
				nextCh()
			end
			#return numeric token 
			return Token.new(Token::NM,str)  ######## int?  ## change in grammar too, if so

	elsif (@c == "+")
		#call nextCh()
		nextCh()
		#return token
		return Token.new(Token::ADDOP, "+")

	elsif (@c == "-")
		nextCh()
		return Token.new(Token::SUBOP, "-")

	elsif (@c == "*")
		nextCh()
		return Token.new(Token::MULTOP, "*")

	elsif (@c == "/")
		nextCh()
		return Token.new(Token::DIVOP, "/")

	elsif (@c == "(")
		nextCh()
		return Token.new(Token::LPAREN, "(")

	elsif (@c == ")")
		nextCh()
		return Token.new(Token::RPAREN, ")")

	elsif (@c == "=")
		nextCh()
		return Token.new(Token::EQOP, "=")

			#letter?
			#numeric?
			#=
			#
			#(
			#)
			#+ add op
			#- sub op	
			#* div op
			#/ mult op
			#else -> nextCh() // prevents returning null
	
		# elsif ...
		# more code needed here! complete the code here 
		# so that your lexer can correctly recognize,
		# display and return all tokens
		# in our grammar that we found in the source code file
		
		# FYI: You don't HAVE to just stick to if statements
		# any type of selection statement "could" work. We just need
		# to be able to programatically identify tokens that we 
		# encounter in our source code file.
		
		# don't want to give back nil token!
		# remember to include some case to handle
		# unknown or unrecognized tokens.
		# below I make the token that you should pass back
	else
		nextCh()
		Token.new("unknown","unknown")
		end
	
end
#
# Helper methods for Scanner
#
def letter?(lookAhead)
	lookAhead =~ /^[a-z]|[A-Z]$/
end

def numeric?(lookAhead)
	lookAhead =~ /^(\d)+$/
end

def whitespace?(lookAhead)
	lookAhead =~ /^(\s)+$/
end
end

