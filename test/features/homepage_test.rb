require "test_helper"

class CanAccessHomeTest < Capybara::Rails::TestCase
  def test_homepage_has_content
    visit root_path
    assert page.has_content?("Responsive Shots")
    assert_content page, "Responsive Shots"
    refute_content page, "Goobye All!"
  end
end