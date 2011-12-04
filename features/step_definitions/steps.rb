Given /^I am an unauthenticated user$/ do
end

When /^I visit the home page$/ do
  visit '/'
end

When /^I fill in "([^"]*)" with "([^"]*)"$/ do |label, value|
  fill_in label, :with => value
end

When /^I click "([^"]*)"$/ do |button_or_link|
  click_on button_or_link
end

Then /^I should be logged in$/ do
  page.should have_content("Signed in successfully")
end

Then /^I should see "([^"]*)"$/ do |text|
  page.should have_content(text)
end

