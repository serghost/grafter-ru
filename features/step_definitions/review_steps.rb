Given /^these are the followng reviews:$/ do |table|
  table.hashes.each do |attributes|
    attributes["kind"] = Review::REVIEW_KINDS[attributes["kind"]]
    @review = @university.reviews.create!(attributes)
    @review.user_id = @user.id
    @review.save
  end
end
