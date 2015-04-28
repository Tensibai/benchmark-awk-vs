File.read(ARGV[1]).scan(/(hit)\s[[:digit:]]*0\s+(.*?)\s+(.*)/) { |f,s,t| puts "#{t} #{f} #{s}" }
