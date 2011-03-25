Factory.define :university do |university|
  department = Department.find_or_create_by_title "Moscow department"
  city = City.find_or_create_by_title(:title => "Moscow", :department => department)

  university.city_id city
end
