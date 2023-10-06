
Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    Movie.create movie
  end
end

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  # Ensure that e1 occurs before e2.
  # page.body is the entire content of the page as a string.
  expect(page.body.index(e1)).to be < page.body.index(e2)
end

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  rating_list.split(', ').each do |rating|
    step %{I #{uncheck.nil? ? '' : 'un'}check "ratings_#{rating}"}
  end
end

Then /I should see all the movies/ do
  # Make sure that all the movies in the app are visible in the table
  Movie.all.each do |movie|
    step %{I should see "#{movie.title}"}
  end
end

When('I press {string}') do |string|
  click_button(string)
end

Then('the director of {string} should be {string}') do |string, string2|
  movie = Movie.find_by(title: string)
  expect(movie.director).to eq string2
end

Given('I am on the details page for {string}') do |string|
  movie = Movie.find_by(title: string)
  visit movie_path(movie)
end

When('I follow {string}') do |string|
  click_link(string)
end

Then('I should be on the Similar Movies page for {string}') do |string|
  expect(page.current_path).to eq same_director_path(Movie.find_by(title: string))
end

Then('I should see {string}') do |string|
  expect(page).to have_content(string)
end

Then('I should not see {string}') do |string|
  expect(page).not_to have_content(string)
end

Then('I should be on the home page') do
  expect(page.current_path).to eq movies_path
end

When /^I go to the edit page for "(.*)"/ do |movie_name|
  movie = Movie.find_by(title: movie_name)
  visit edit_movie_path(movie)
end

When /^I fill in "(.*)" with "(.*)"/ do |field, value|
  fill_in(field, with: value)
end
