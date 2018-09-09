When("I search for {string}") do |string|
  visit "/"
  fill_in "lst-ib", with: string
  click_on "Google Search", match: :first
end
