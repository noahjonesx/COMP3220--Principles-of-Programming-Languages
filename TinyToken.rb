#
#  Class Token - Encapsulates the tokens in TINY
#
#   @type - the type of token (Category)
#   @text - the text the token represents (Lexeme)
#
class Token
	attr_accessor :type
	attr_accessor :text

# This is the only part of this class that you need to 
# modify.
	EOF = "eof" #done
	LPAREN = "(" #done
	RPAREN = ")" #done
	ADDOP  = "+" #done
	SUBOP = "-" #done
	MULTOP = "*" #done
	DIVOP = "/" #done
	EQOP = "=" #done
	WS = "whitespace" #done
	NM = "numeric" #added ##########
	ID = "ID" #
	PRT = "PRINT"
	UNKNOWN = "Unknown"
	#
	#
	# OTHER LANGUAGE TOKENS
	#
	#
# add the rest of the tokens needed based on the grammar
# specified in the Scanner class "TinyScanner.rb"

#constructor
	def initialize(type,text)
		@type = type
		@text = text
	end
	
	def get_type
		return @type
	end
	
	def get_text
		return @text
	end
	
# to string method
	def to_s
		return "#{@type} #{@text}"
	end
end
