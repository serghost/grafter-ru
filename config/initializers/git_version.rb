begin
  VERSION_OF_GRAFTER = open("#{File.expand_path("../../../", __FILE__)}/.git/refs/heads/master").read
rescue Exception => e
  puts e
end
