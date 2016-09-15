require 'test_helper'

class AnonymousQuestionsControllerTest < ActionController::TestCase
  setup do
    @anonymous_question = anonymous_questions(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:anonymous_questions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create anonymous_question" do
    assert_difference('AnonymousQuestion.count') do
      post :create, anonymous_question: { active: @anonymous_question.active, string: @anonymous_question.string }
    end

    assert_redirected_to anonymous_question_path(assigns(:anonymous_question))
  end

  test "should show anonymous_question" do
    get :show, id: @anonymous_question
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @anonymous_question
    assert_response :success
  end

  test "should update anonymous_question" do
    patch :update, id: @anonymous_question, anonymous_question: { active: @anonymous_question.active, string: @anonymous_question.string }
    assert_redirected_to anonymous_question_path(assigns(:anonymous_question))
  end

  test "should destroy anonymous_question" do
    assert_difference('AnonymousQuestion.count', -1) do
      delete :destroy, id: @anonymous_question
    end

    assert_redirected_to anonymous_questions_path
  end
end
