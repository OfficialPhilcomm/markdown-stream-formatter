class MarkdownStreamFormatter
  RESET = "\e[0m"
  TITLE = "\e[33m"
  CODE = "\e[32m"
  BOLD = "\e[1m"
  ITALIC = "\e[3m"
  QUOTE = "\e[32m\e[1m"

  def initialize
    @line_buffer = ""
    @title = false
    @bold = false
    @italic = false
    @quote = false
    @code = false
  end

  def next(chunk)
    return unless chunk

    chunk.lines.map do |line|
      line = titleize(line)
      line = boldify(line)
      line = italicize(line)
      line = quotify(line)
      line = codify(line)

      if line.end_with? "\n"
        @title = false
        @bold = false
        @italic = false
        @quote = false if @line_buffer.size == 0 && line == "\n"
        @code = false

        @line_buffer = ""
        line += RESET
      else
        @line_buffer += line
      end

      line
    end.join
  end

  private

  def titleize(line)
    if @line_buffer.empty? && line.match(/\A\s*[#]{1,5}/)
      @title = true

      "#{TITLE}#{line}"
    end || line
  end

  def boldify(line)
    while line.include? "**"
      line.sub! "**", @bold ? RESET + current_ansi(bold: !@bold) : BOLD

      @bold = !@bold
    end

    line
  end

  def italicize(line)
    while line.include? "*"
      line.sub! "*", @italic ? RESET + current_ansi(italic: !@italic) : ITALIC

      @italic = !@italic
    end

    line
  end

  def quotify(line)
    if @quote && @line_buffer.size == 0 && line != "\n"
      line = "#{QUOTE}┃  #{RESET}#{line}"
    elsif @line_buffer.size == 0 && line.match(/\A\s*>/)
      @quote = true

      line.sub! ">", "#{QUOTE}┃ #{RESET}"
    end

    line
  end

  def codify(line)
    line.gsub! "`" do |match|
      new_sub = @code ? "`" + RESET + current_ansi(code: !@code) : CODE + "`"

      @code = !@code

      new_sub
    end

    line
  end

  def current_ansi(bold: nil, italic: nil, code: nil)
    style = ""

    style << TITLE if @title
    style << BOLD if (bold.nil? ? @bold : bold)
    style << ITALIC if (italic.nil? ? @italic : italic)
    style << CODE if (code.nil? ? @code : code)

    style
  end
end
