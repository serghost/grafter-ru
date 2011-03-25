Factory.define :university do |university|
  city = City.first.nil? ? 1 : City.first.id

  university.city_id city
end
