File.read(ARGV[0]).scan(/(hit)\s[[:digit:]]*0\s+(.*?)\s+(.*)/) { |f,s,t| puts "#{t} #{f} #{s}" }
