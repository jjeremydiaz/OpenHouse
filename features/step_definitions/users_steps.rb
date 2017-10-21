Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
  expect(page.body.index(e1) < page.body.index(e2))
end

Then /account "(.*)" should( not)? exist/ do |u, should_not_exist|
  user = User.find_by(username: u)
  if should_not_exist
    expect(user == nil)
  else
    expect(user != nil)
  end
end

Then /account "(.*)" exists/ do |u|
  User.create!(username: u)
end