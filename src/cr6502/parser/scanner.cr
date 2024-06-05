class CPU
  class Scanner
    @source : String
    property tokens : Array(Token) = [] of Token

    @start = 0
    @current = 0
    @line : Int32
    # 0 = decimal, 1 = hex, 2 = binary
    @current_number_type = 0

    def initialize(@source : String, @line : Int32)
    end

    def is_at_end
      return @current >= @source.size - 1
    end

    def scan_tokens
      until is_at_end
        @start = @current
        scan_token
      end

      @tokens << Token.new(TokenType::EOF, "")
      return @tokens
    end

    def advance
      if @current >= @source.size - 1
        raise ScannerException.new("Invalid line on line ##{@line}")
        return '\0'
      else
        return @source[@current += 1]
      end
    end

    def peek
      return '\0' if is_at_end
      return @source[@current]
    end

    def add_token(type : TokenType, literal : Int32 | Nil = nil)
      start = @start
      start += 1 if @start != 0
      text = @source[start..@current]
      @tokens << Token.new(type, text, literal)
    end

    def match(expected : Char)
      return false if is_at_end || @source[@current] != expected
      @current += 1
      return true
    end

    def scan_token
      c = advance
      if @current_number_type != 0
        case @current_number_type
        when 1
          hex
        when 2
          binary
        end

        @current_number_type = 0
      else
        case c
        when '('; add_token(TokenType::LeftParen)
        when ')'; add_token(TokenType::RightParen)
        when '$'; add_token(TokenType::Dollar)
        @current_number_type = 1
        when '%'; add_token(TokenType::Percent)
        @current_number_type = 2
        when '#'; add_token(TokenType::Hash)
        when ','; add_token(TokenType::Comma)
        when 'X'; add_token(TokenType::X)
        when 'Y'; add_token(TokenType::Y)
        when 'x'; add_token(TokenType::X)
        when 'y'; add_token(TokenType::Y)
        when 'A'; add_token(TokenType::A)
        when 'a'; add_token(TokenType::A)
        when ' '
        else
          if c.ascii_number?
            number
          elsif is_alpha(c)
            identifier
          else
            raise ScannerException.new("Unexpected character on line ##{@line}")
          end
        end
      end
    end

    def binary
      start = @start
      start += 1 if @start != 0
      while peek.ascii_number?(2) && !is_at_end
        advance
      end

      num = @source[start..@current]

      if !num.to_i?(2)
        num = num.rchop
        @current -= 1
      end

      if num.to_i?(2)
        add_token(TokenType::Integer, num.to_i(2))
      end
    end

    def hex
      start = @start
      start += 1 if @start != 0
      while peek.ascii_number?(16) && !is_at_end
        advance
      end

      num = @source[start..@current]

      if !num.to_i?(16)
        num = num.rchop
        @current -= 1
      end

      if num.to_i?(16)
        add_token(TokenType::Integer, num.to_i(16))
      end
    end

    def number
      start = @start
      start += 1 if @start != 0
      while peek.ascii_number? && !is_at_end
        advance
      end

      num = @source[start..@current]

      if !num.to_i?
        num = num.rchop
        @current -= 1
      end

      if num.to_i?
        add_token(TokenType::Integer, num.to_i)
      end
    end

    def peek_next
      return '\0' if @current + 1 >= @source.size
      return @source[@current + 1]
    end

    def identifier
      start = @start
      start += 1 if @start != 0
      until KEYWORDS[@source[start..@current].upcase]? || is_at_end
        advance
      end

      text = @source[start..@current]
      type = KEYWORDS[text.upcase]?
      raise ScannerException.new("Invalid command \"#{text.upcase}\" on line ##{@line}") unless type
      # I chose to raise instead of letting it go
      # type = TokenType::Identifier if type == nil
      add_token(type)
    end

    def is_alpha(c : Char)
      return (c >= 'a' && c <= 'z') ||
        (c >= 'A' && c <= 'Z')
    end

    def is_alpha_numeric(c : Char)
      return is_alpha(c) || c.ascii_number?
    end
  end
end
