def __main__(argv)
  if argv[1] == "version"
    puts "v#{Pdfq::VERSION}"
  elsif argv[1] == "buttons"
    pdftk_string = get_stdin_from_pipe
    buttons = get_buttons_from_pdftk_string(pdftk_string)
    json_string = JSON.generate(buttons, {pretty_print: true})

    IO.puts json_string
  elsif argv[1] == "json_to_fdf"
    json_string = get_stdin_from_pipe
    fdf = convert_json_to_fdf(json_string)

    IO.puts fdf
  elsif argv[1] == "get"
    value = get(argv)

    IO.puts value
  elsif argv[1] == "set"
    result = set(argv)

    IO.puts result
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

def get_buttons_from_pdftk_string(pdftk_string)
  fields = parse_pdftk_string(pdftk_string)
  buttons = fields.select {|f| f['FieldType'] == 'Button'}

  buttons
end

def get(argv)
  path = argv[3]
  field = argv[2]
  pdftk_string = `pdftk #{path} dump_data_fields`
  fields = parse_pdftk_string(pdftk_string)
  field = fields.select {|f| f['FieldName'] == field}.first
  value = field['FieldValue']

  value
end

def set(argv)
  path = argv[4]
  output = argv[5]
  field = argv[2]
  value = argv[3]

  hash = {}
  hash[field] = value
  fdf = convert_hash_to_fdf(hash)
  file = Tempfile.new 'pdfq'
  file.write(fdf)

  pdftk_response = `pdftk #{path} fill_form #{file.path} output #{output}`

  pdftk_response
end

def convert_hash_to_fdf(hash)
  keys = hash.keys
  fdf_header = [
    "%FDF-1.2",
    "1 0 obj",
    "<<",
    "/FDF << /Fields ["
  ].join("\n")
  fdf_body = ""
  keys.each do |key|
    value = hash[key]
    fdf_body = fdf_body + "<< /V (#{value})/T (#{key}) >> \n"
  end
  fdf_footer = [
    "] >>",
    ">>",
    "endobj",
    "trailer",
    "<<",
    "/Root 1 0 R",
    ">>",
    "%%EOF"
  ].join("\n")

  fdf_header + fdf_body + fdf_footer
end

def convert_json_to_fdf(json_string)
  hash = JSON.parse(json_string)
  fdf = convert_hash_to_fdf(hash)

  fdf
end
