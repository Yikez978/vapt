require 'test_helper'

class StaticPagesControllerTest < ActionController::TestCase
	def setup
		@vapt_project = settings(:setting_vapt_project)
	end

  test "should get home" do
    get :home
    assert_response :success
		assert_select "title", @vapt_project.value
  end

  test "should get contact" do
    get :contact
    assert_response :success
		assert_select "title", "Contact | #{@vapt_project.value}"
  end

  test "should get help" do
    get :help
    assert_response :success
		assert_select "title", "Help | #{@vapt_project.value}"
  end

	test "should get about" do
    get :about
    assert_response :success
		assert_select "title", "About | #{@vapt_project.value}"
  end

end
