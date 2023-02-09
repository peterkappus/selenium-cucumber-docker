Given('I accept cookies') do
  visit "/"
  click_on "Accept all"
end

When("I search for {string}") do |string|
  visit "/"
  fill_in "q", with: string
  click_on "Google Search", match: :first
end

Then("I should see {string}") do |string|
  page.should have_content(string)
end

Then("I should NOT see {string}") do |string|
  page.should_not have_content(string)
end

# a handy debugging step you can use in your scenarios to invoke 'pry' mid-scenario and poke around
When('I debug') do
  binding.pry
end