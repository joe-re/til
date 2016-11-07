Token = Struct.new('Token', :type, :text, :line)

class Lexer
  LTAG = 0
  RTAG = 1
  SLASH = 2
  NAME = 3
  EOF = 4
  EOF_TEXT = nil

  def initialize(input, start_line_no)
    @p = 0
    @c = input[0]
    @line_no = start_line_no
    @input = input
  end

  def next_token
    return Token.new(EOF, EOF_TEXT, @line_no) if @c == EOF_TEXT
    while @c != EOF_TEXT
      case @c
      when ' ' || "\t" || "\r"
        ws
      when "\n"
        @line_no += 1
        consume
      when '<'
        consume
        return Token.new(LTAG, '<', @line_no)
      when '>'
        consume
        return Token.new(RTAG, '>', @line_no)
      when '/'
        consume
        return Token.new(SLASH, '/', @line_no)
      else
        name = ''
        while letter?
          name += @c
          consume
        end
        return Token.new(NAME, name, @line_no)
      end
    end
  end

  def ws
    consume while @c == ' ' || @c == "\t" || @c == "\r"
  end

  def letter?
    @c && !(['<', '>', "\n", '/'].include? @c)
  end

  def consume
    @p += 1
    if @p >= @input.size
      @c = EOF_TEXT
      return
    end
    @c = @input[@p]
  end
end

class HTMLParser
  def initialize(lexer, k)
    @lexer = lexer
    @k = k
    @p = 0
    @lookahead = []
    k.times { consume }
  end

  def fallback
    puts LT(1).line
    raise
  end

  def match(type)
    fallback if LA(1) != type
    consume
    true
  end

  def consume
    @lookahead[@p] = @lexer.next_token
    @p = (@p + 1) % @k
  end

  def LT(i)
    @lookahead[(@p + i - 1) % @k]
  end

  def LA(i)
    LT(i).type
  end

  def tag
    match(Lexer::LTAG)
    start_tag = LT(1).text.split("\s").first
    match(Lexer::NAME)
    match(Lexer::RTAG)
    elements
    need_end_tag = start_tag != 'li' || LA(1) == Lexer::LTAG && LA(2) == Lexer::SLASH && LT(3).text.split("\s").first == 'li'
    if need_end_tag
      match(Lexer::LTAG)
      match(Lexer::SLASH)
      fallback if start_tag != LT(1).text.split("\s").first
      match(Lexer::NAME)
      match(Lexer::RTAG)
    end
  end

  def elements
    element while (LA(1) == Lexer::LTAG && LA(2) == Lexer::NAME) || LA(1) == Lexer::NAME
  end

  def element
    if LA(1) == Lexer::LTAG
      tag
    elsif LA(1) == Lexer::NAME
      match(Lexer::NAME)
    else
      fallback
    end
  end
end

lines = []
line_no = 0
start_html_line_no = 0
found_html_tag = false
while line = gets
  line_no += 1
  if line.include? '<html>'
    found_html_tag = true
    start_html_line_no = line_no
  end
  next unless found_html_tag
  lines.push line
  break if line.include? '</html>'
end

lexer = Lexer.new(lines.join(''), start_html_line_no)
parser = HTMLParser.new(lexer, 3)
begin
  parser.tag
  puts '0'
rescue => e
end
