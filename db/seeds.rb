# Add cities to department from russia db
db_path = File.expand_path("../russia.json", __FILE__)
russia_db = open(db_path).read
JSON::parse(russia_db).each do |item|
  department = Department.create!(:title => item["department"])
  item["cities"].each do |city|
    department.cities.create!(:city_title => city)
  end
end
