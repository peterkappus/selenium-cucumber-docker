When("I search for {string}") do |search_string|
  visit "/"
  fill_in "lst-ib", with: search_string
  click_on "Google Search", match: :first
end
