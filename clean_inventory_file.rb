#author: alain dejoux
require 'optparse'

class CleanFile
  attr_reader :count
  attr_writer :count, :content

  MAX_COUNT=5

  def initialize(file, directory)
    unless File.file?(file)
      puts "not a file #{file}"
      exit 1
    end
    unless File.directory?(directory)
      puts "not a directory"
      exit 1
    end

    @file=File.basename(file)
    @directory=directory
    @content=""
    @index=0
    @count=0
  end


  def add_content(content)
    @content << content
    @count+=1
    write_file if @count == MAX_COUNT
  end

  def write_file
    @index+=1
    @count=0
    new_file=@file.gsub('_unix_inventory', "-#{@index}")
    f=File.open([@directory,new_file].join('/'), 'w')
    f.write "<servers>\n"
    f.write @content
    f.write "</servers>\n"
    f.close
    @content=""
  end
end

file=""
directory=""
version=0.1

opt_parser = OptionParser.new do |opts|
  opts.banner = "Usage: clean_inventory_file.rb [-f file] [-d directory] [-h] [-v]"

  opts.on('-f file', '--file=file', 'file') do |v|
    file = v
  end

  opts.on('-d directory', '--directory=directory', 'directory') do |v|
    directory = v
  end

  opts.on( '-h', '--help', 'Display this screen' ) do
    puts opts
    exit
  end

  opts.on_tail( '-v', '--version', 'Display tool version' ) do
    puts "version : #{version}"
    exit
  end
end
opt_parser.parse!


previous_line="fgdkjsk"

excerpt=false
matched=false
content=""

cleaner=CleanFile.new(file, directory)

File.open(file, 'rb').each do |line|
  line.sub!(/\r/, '')
  next if line.eql? previous_line
  if line.chomp.match(/^<server>$/)
    excerpt=true
  end

  content << line if excerpt

  if match_result=line.match(/<version>(\S+)<\/version>/)
    if match_result[1].to_f > 2.4
      matched=true
    end
  end

  if line.chomp.match(/^<\/server>$/)
    excerpt=false
    if matched
      cleaner.add_content content
    end
    matched=false
    content=""
  end
  previous_line=line
end

cleaner.write_file

File.unlink(file)

