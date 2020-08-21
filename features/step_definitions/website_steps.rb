# Hanlie Combrinck
# 20 August 2020

=begin

Automated test to navigate to the https://ting.com website,
print the testimonials and verify the sign up/activate button.

=end

require "selenium-webdriver"

# variable for our URL
url="https://ting.com/"

# Parameter from cucumber.yml for browser
browser = ENV['BROWSER_TYPE']
if (browser == "firefox")
  driver = Selenium::WebDriver.for :firefox
elsif (browser == "chrome")
  driver = Selenium::WebDriver.for :chrome
end

# Navigate to the home page
Given(/^We navigate to the ting.com website/) do
  driver.navigate.to url
end

#search for the word People
When(/^We find the "People love ting" section/) do
  wait = Selenium::WebDriver::Wait.new(:timeout => 5)  #seconds
  begin
    element = wait.until {driver.find_element(:class, 'iconHeader')}
  end
end

#We will display the testimonials
Then(/^We print the content of the testimonials/) do
  waitslide = Selenium::WebDriver::Wait.new(:timeout => 5)  #seconds
  begin
    elementslide = waitslide.until {driver.find_element(:class, 'slideTrack')}
    if !(elementslide == nil)
      elements = waitslide.until {driver.find_elements(:class, 'regularQuote')}
      elements.length.times do |i|
        print "Testimonial #{i + 1} #{elements[i].text} \n"
        i = i + 1
      end
    else
      print "No testimonials found"
    end
  end
end

# search for the sign up/activate button
Given(/^We find the sign up-activate button/) do
  waitbutton = Selenium::WebDriver::Wait.new(:timeout => 5)  #seconds
  begin
    elemendbutton = waitbutton.until {driver.find_element(:class, 'navLinkActivate')}
  end
end

# click the sign up/activate button and find the page title
When(/^We click the sign up-activate button/) do
  begin
    button = driver.find_element(:class, 'navLinkActivate').click
  end
end

# print the title of the sign up page
Then(/^We print the page title of the new page/) do
  waitsection = Selenium::WebDriver::Wait.new(:timeout => 5)  #seconds
  begin
    section = waitsection.until {driver.find_element(:css, 'h1')}
    if !(section == nil)
      print "Page Title: #{section.text}"
    else
      print "Page Title not found"
    end
  ensure
    driver.quit
  end
end
