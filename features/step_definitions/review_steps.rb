Given /^these are the followng reviews:$/ do |table|
  table.hashes.each do |attributes|
    attributes["kind"] = Review::REVIEW_KINDS[attributes["kind"]]
    @university.reviews.create!(attributes)
  end
end
