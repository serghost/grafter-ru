module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in web_steps.rb
  #
  def path_to(page_name)
    case page_name

    when /the home\s?page/
      '/'

    when /the university page for "([^"]*)"/
      university_path University.find_by_short($1)

    when /the edit page for price with lesson "([^"]*)" and personal "([^"]*)"/
      # FIXME oh my... this is very dirty code
      lesson_id = Lesson.where("title ILIKE ?", $1).limit(1)[0].id
      teacher_id = Teacher.where("personal ILIKE ?", $2).limit(1)[0].id

      price = Price.where("lesson_id = ? AND teacher_id = ?", lesson_id, teacher_id).limit(1)[0]

      edit_university_price_path(price.university_id, price)

    else
      begin
        page_name =~ /the (.*) page/
        path_components = $1.split(/\s+/)
        self.send(path_components.push('path').join('_').to_sym)
      rescue Object => e
        raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
          "Now, go and add a mapping in #{__FILE__}"
      end
    end
  end
end

World(NavigationHelpers)
