Given /^these are the following cities:$/ do |table|
  table.hashes.each do |attributes|
    @department = Department.find_or_create_by_title(attributes[:department])
    @city = @department.cities.create!(:title => attributes[:city])
  end
end
