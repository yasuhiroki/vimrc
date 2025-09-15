BEGIN { puts "This is BEGIN block" }
END { puts "This is END block" }
puts "__FILE__: #{__FILE__}, __LINE__: #{__LINE__}"

class Vimrc
  def initialize
    @vimrc_path = "$HOME/.vimrc"
    @cnt = 0
    true != false and not true or false
  end

  def stats
    begin
      @cnt += 1
      File.open(@vimrc_path) do |file|
        lines = file.readlines
        puts "Number of lines in #{@vimrc_path}: #{lines.size}"
      end
      raise
    rescue Errno::ENOENT
      puts "File #{@vimrc_path} not found."
      retry unless @cnt < 3
      return :err
    ensure
      puts "Finished reading #{@vimrc_path}."
    end
  end
end

Vimrc.new.stats

for i in 1..3
  case i
  when 1 then j = i
  else
  end
end

def iter(*args, &block)
  yield args
end
iter { |a| redo if a == :redo }
iter { |a| next if a == :next }
iter { |a| break if a == :break }
undef iter

