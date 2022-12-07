Given('I cleared database') do
  Baggage.delete_all
end

Given('I have baggage:') do |table|
  attributes = table.rows_hash
  baggage = Baggage.new(attributes)
  baggage.save
end

When('I execute {string}') do |string|
  visit baggages_path + "/" + string
end

Then('I should see {string}') do |string|
  page.should have_content(string)
end

When('I create baggage:') do |table|
  attributes = table.rows_hash
  visit new_baggage_path

  fill_in 'Number', with: attributes['num']
  fill_in 'Weight', with: attributes['weight']
  click_on 'Create Baggage'
end

Then('in database should be baggage:') do |table|
  attributes = table.rows_hash
  baggage = Baggage.find_by(num: attributes['num'].to_i, weight: attributes['weight'].to_f)
  expect(baggage).to be_truthy
end

When('I update baggage:') do |table|
  visit baggages_path + "/all_baggage"
  attributes = table.rows_hash
  click_link "Number = #{attributes["num"]}, Weight = #{attributes["weight"]}"
  click_link "Edit"
end

When('I update baggage to:') do |table|
  attributes = table.rows_hash
  fill_in 'Number', with: attributes['num']
  fill_in 'Weight', with: attributes['weight']
  click_on 'Update Baggage'
end

When('I delete baggage:') do |table|
  visit baggages_path + "/all_baggage"
  attributes = table.rows_hash
  click_link "Number = #{attributes["num"]}, Weight = #{attributes["weight"]}"
  click_on "Delete"
end

Then('in database should not be baggage:') do |table|
  attributes = table.rows_hash
  baggage = Baggage.find_by(num: attributes['num'].to_i, weight: attributes['weight'].to_f)
  expect(baggage).to be_nil
end