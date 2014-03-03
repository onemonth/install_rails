Given(/^I am on the homepage$/) do
  visit root_path
end

When(/^I click "(.*?)"$/) do |button_text|
  click_on button_text
end

Then(/^I am asked about my OS$/) do
  within 'h2' do
    expect(page).to have_content('Which operating system are you using?')
  end
end
