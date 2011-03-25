Given /^there is a university called "([^"]*)" with "([^"]*)" title$/ do |short, title|
  @university = Factory.create(:university, :title => title, :short => short)
end
