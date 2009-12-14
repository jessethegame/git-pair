When /^I add the author "([^\"]*)"$/ do |name|
  git_pair %(--add "#{name}")
end

Then /^`git pair` should display "([^\"]*)" in its author list$/ do |name|
  output = git_pair
  authors = authors_list_from_output(output)
  assert authors.include?(name)
end

Then /^`git pair` should display "([^\"]*)" in its author list only once$/ do |name|
  output = git_pair
  authors = authors_list_from_output(output)
  assert_equal 1, authors.select { |author| author == name}.size
end

Then /^the gitconfig should include "([^\"]*)" in its author list only once$/ do |name|
  output = git_config
  authors = output.split("\n").map { |line| line =~ /^git-pair\.authors=(.*)$/; $1 }.compact
  assert_equal 1, authors.select { |author| author == name}.size
end


def authors_list_from_output(output)
  output =~ /Author list: (.+)\n\s?\n/im
  $1.strip.split("\n").map { |name| name.strip }
end
