Given /^these are the following prices:$/ do |table|
  table.hashes.each do |attributes|
    @university.prices.create!(attributes)
  end
end
