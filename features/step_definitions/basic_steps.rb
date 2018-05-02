
Before do |scenario|
	  #basic auth
	  #obsolete since we now turn off basic auth in test env
	  #page.driver.browser.authorize 'x', 'x'
		#RSpec.configure do |config|
	  #config.before do
	  #  Capybara.current_driver = :selenium
	  #  Capybara.javascript_driver = :selenium
	  #  Capybara.run_server = true
	  #  Capybara.server_port = 7000
	  #  Capybara.app_host = "http://localhost:#{Capybara.server_port}"
	  #end
	#end
end

After do |scenario|
	# pry.binding
end

#travel back to the correct time after runniung a @time_travel tagged step
After('@time_travel') do
  travel_back
end

Given(/^the current date is (.+)$/) do |time_string|
  travel_to(Time.parse(time_string))
end

Then(/^I should see "([^"]*)" within "([^"]*)" (\d+) time(?:s)?$/) do |text, selector, count|  #debug
  all(selector,text: /\A#{text}\z/).count.to_i.should equal? count.to_i
  #find.all(:text=>)
end


Then(/^I should see "([^"]*)" before "([^"]*)"$/) do |first_thing, second_thing|
  #make sure we see the first thing before the second thing...
  body.index(first_thing).should be < body.index(second_thing)
end

When(/^I fill in "([^"]*)" with "([^"]*)"$/) do |field_name, content|
  fill_in field_name, :with=>content
end

#file attach
When(/^I attach "([^"]*)" to the field called "([^"]*)"$/) do |file_path, field_name|
  attach_file(field_name,"#{ENV['RAILS_ROOT']}/#{file_path}")
end

#NOTE: this is custom to work with bootstrap-select-rails select boxes
#This only works because the drop-down in question is the first one.
#hence we can click "Please select" to open the dropdown.
#TODO: make this work for multiple dropdowns
When(/^I select "([^"]*)" from the first dropdown$/) do |option_text|
  click_on "Please select"
  find(:css,"div.dropdown-menu span",:text=>option_text).click
end

def get_all_link_text
	linktxt = ""
	page.all("a").each {|node| linktxt += node.text }
	return linktxt
end

def find_first_link(text)
	all('a',:text=>text,visible:true).to_a.first
end

def find_first_link_in(selector,text)
	return all(selector,text:text).to_a.first
end

def click_random_link_in(selector,text)
	all(selector,:text=>text).to_a.shuffle.first
end

#NOTE: this is only taking the last link right now...
#need a smart way to specify that it should randomise or select one in particular
def handle_modal_window
  #if we have a modal window, randomly select a subject from within
  if(all(".modal-cover .modal").count > 0)
  	node = page.all(".modal-cover .modal li a", :visible=>true).to_a.last
    #node = all(".modal-cover .modal a",:text=>/Select/i).to_a.last
    Kernel.puts "Select last link from modal window: #{node.text}"
    node.click
  end
end


def check_node_for_link(link)
	puts "Link: #{link.text} href: #{link[:href]}"
    link[:href].should(be_true)
end




#STEPS DOWN HERE....

#give us a step definition for "debug"
Then(/(?:I )?debug/) do
	debug
end

#throw a 'debug' command in your step defs to open an PRY session and poke around interactively
def debug
	binding.pry #unless ENV['DEBUG'].to_s.empty?
end

#use a non-capturing group on the 's' so we can say "1 second" or "2 seconds"
Then(/^I wait (\d+) second(?:s)?/) do |seconds|
  sleep seconds.to_i # express the regexp above with the code you wish you had
end

Then(/^I do a screen shot/) do
	screenshot_and_save_page
end


#click on button or link
When(/^I click (?:on )?"([^"]+?)"$/) do |text|
	#click_on text
	#click_on link_to_click
	#for some reason the regular click_on didn't find AngularJS generated links.
	#the custom "find_first_link" method works...
	#node = first("a",text:text)
  #node = first("label",text: text,visible:true) unless node.present?
  #click_button text unless node.present?
	#node.click if node.present?
  click_on text
end

#click on button or link
When(/^I click (?:on )?the label called "([^"]+?)"$/) do |text|
	first("label",text: text).click
end

#click a checkbox
When(/^I tick the box "([^"]+?)"$/) do |box_id|
  check box_id
end

When(/^I choose the radio button "([^"]+?)"$/) do |button_id|
  choose button_id
end


#click on button or link within a selector
When(/^I click on link "([^"]+?)" number (\d+) within "([^"]+?)"$/) do |text, number, css_selector|
	links = all(css_selector,:text=>text).to_a
	int = 1;

	# puts "number argument: #{ number }"
	# puts "int variable: #{ int }"
	#Check to see if there are any links
	if links.any?
		links.each do |node|
			if int == number.to_i
				# puts "They are equal: #{ int } - #{ number }"
				node.click

				break
			else
				# puts "They are not equal: #{ int } - #{ number }"
				int = int.next
			end

			if int > links.length
				raise ArgumentError, "The selected index is not present in this list"
			end
		end
	else
		raise ArgumentError, "No elements in this list"
	end
end

#click on button or link within a selector
When(/^I click (?:on )?"([^"]*?)" within "([^"]+?)"$/) do |text, selector|
  #find(css_selector).click_on(link_to_click)
  #within(:css, css_selector)
  #find_first_link_in(css_selector, link_to_click).click
  #def find_first(text,selector)
  #node = first(selector)
  node = all("#{selector} a",text:text).first #unless node.present?
  node = all("#{selector} input",text:text).first unless node.present?
  node = all(selector,text:text).first unless node.present?
  node.click
end

#click on nth button or link within a selector
When(/^I click on first "([^"]+?)"(?: link,) within "([^"]+?)"$/) do |link_to_click, css_selector|
	#find_first_link_in(css_selector, link_to_click).trigger('click')
	find_first_link_in(css_selector, text:link_to_click).click
end

#click on text within a selector
When(/^I click on text "([^"]+?)" within "([^"]+?)"$/) do |text_to_click, css_selector|
	find(css_selector, ":text => 'text_to_click'").trigger('click')
end

When(/^I click on (?:the )?"([^"]*)" button$/) do |button_text|
  #click the first one...
  first(:button,button_text,{visible:true}).click
end


Then(/^I click on random "(.*?)" link$/) do |selector|
	all(selector).to_a.reject{|node| node.text.empty?}.shuffle.first.click
end

Given(/^I (?:visit|am on) the (?:homepage|home page)$/) do
	visit "/"
end

When(/^I visit "([^"]*)"$/) do |path|
  visit path
end

#Blank to provide headers to the tests
Then(/^: (.*?)$/) do | no_need_to_process |
end

Then(/^I should see "([^"]+?)"$/) do |text_to_see|
	page.should have_content(text_to_see)
end

Then(/^I should see content within "([^"]+?)"$/) do | selector |
	page.should have_css(selector)
	node = all(selector).to_a.first
	node.text.should_not == ""
end

Then(/^I should see (\d+) "([^"]+?)" elements, within "([^"]+?)"$/) do |number_of_elements, css_element, css_container|
	all(css_container + " " + css_element, "").to_a.size.should == number_of_elements.to_i
end

Then(/^I should see more than (\d+) "([^"]+?)" elements, within "([^"]+?)"$/) do |number_of_elements, css_element, css_container|
	all(css_container + " " + css_element, "").to_a.size.should > number_of_elements.to_i
end

Then(/^I should see (\d+) or more "([^"]+?)" elements, within "([^"]+?)"$/) do |number_of_elements, css_element, css_container|
	all(css_container + " " + css_element, "").to_a.size.should >= number_of_elements.to_i
end

Then(/^I should see the selector "(.+?)"$/) do |css_selector|
	#page.save_screenshot("#{text_to_see}.png")
	page.should have_css(css_selector)
end

Then(/^I should see the css selector "(.+?)" for "([^"]+?)"$/) do |css_selector, dummy_text|
	#page.save_screenshot("#{text_to_see}.png")
	page.should have_css(css_selector)
end

Then(/^I should see "([^"]+?)" within "([^"]+?)"$/) do |text_to_see, css_selector|
	page.should have_selector(css_selector, :text=>text_to_see)
end

Then(/^I should see "([^"]+?)" within "([^"]+?)" tag$/) do |text_to_see, html_tag|
  pending # express the regexp above with the code you wish you had
end

Then(/^I should see "([^"]+?)" within "([^"]+?)" only "([^"]+?)" time/) do |text_to_see, css_selector, number_of_times|
	page.all(css_selector, :text=>text_to_see).to_a.size.should equal(number_of_times.to_i)
end

Then(/^I should NOT see "([^"]+?)" within "(.+?)"$/) do |text_to_see, css_selector|
	should_not have_selector(css_selector,:text=>text_to_see)
end

#generic NOT see with no selector context...maybe not very useful
Then(/^I should NOT see "([^"]+?)"$/) do |text|
	should_not have_content(text)
end

Then(/^I should see in order "([^"]+?)" within "([^"]+?)"$/) do |text_to_see, css_selector|
	found_text = page.all(css_selector + " a").to_a.map{|node| node.text}.join(',')
	found_text.should match(text_to_see)
end

Then(/^I should see results in "([^"]+?)", displayed in alphabetical order$/) do |css_selector|
  if all(css_selector).to_a.size <= 0
  	raise ArgumentError, "No elements in this list", caller
  end

  previous = ""
  all(css_selector).to_a.each do |node|
    puts node.text.downcase
    if(previous != "")
      then
        diff = node.text.downcase <=> previous.text.downcase
        diff == 1
      end
      previous = node
  end
end

#throw a 'debug' command in your step defs to open an PRY session and poke around interactively
def debug
	binding.pry #unless ENV['DEBUG'].to_s.empty?
end


Then(/^I should see a date in the correct format within "([^"]+?)"$/) do |css_selector|
	#find all matches for css, look at the text of each found node, and test against our date format regex
	all(css_selector).each {|node| node.text.should match(/^\d{1,2} January|February|March|April|May|June|July|August|September|October|November|December \d{4}$/) }
end

Then(/^I should see "(.*?)" on the right hand side$/) do |text_to_see|
	page.should have_selector(".righthand-nav", :text=>text_to_see)
end

Given(/^the current timeout is (\d+) seconds$/) do |number_of_seconds|
  Capybara.default_wait_time = number_of_seconds.to_i
end

When(/^I hover mouse over "([^"]+?)"$/) do | css_selector|
	find(css_selector).hover
end
