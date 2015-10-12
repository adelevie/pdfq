def __main__(argv)
  if argv[1] == "version"
    puts "v#{Pdfq::VERSION}"
  else
    pdftk_string = get_stdin_from_pipe
    result = parse_pdftk_string(pdftk_string)
    json_string = JSON.generate(result, {pretty_print: true})

    IO.puts json_string
  end
end

def get_stdin_from_pipe
  string = ""
  while line = gets
    string = string + line
  end

  string
end

def parse_pdftk_string(pdftk_string)
  fields = pdftk_string.split("---")
  fields.shift
  result = fields.map do |field|
    lines = field.split("\n")
    lines.reject! {|line| line.empty?}
    hash = {}
    lines.each do |line|
      chunks = line.split(": ")
      hash[chunks[0]] = chunks[1]
    end

    hash
  end

  result
end
