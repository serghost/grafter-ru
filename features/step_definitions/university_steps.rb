Given /^these are the following universities:$/ do |table|
  table.hashes.each do |attributes|
    @university = Factory.create(:university, attributes)
  end
end
