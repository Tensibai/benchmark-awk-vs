File.open(ARGV[0]).readlines.each do |line|
  line.gsub(/(hit)\s[0-9]*0\s+(.*?)\s+(.*)/) { puts "#{$3} #{$1} #{$2}" }
end

