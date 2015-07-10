require 'test_helper'

class JirasControllerTest < ActionController::TestCase
  setup do
    @jira = jiras(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:jiras)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create jira" do
    assert_difference('Jira.count') do
      post :create, jira: { issuekey: @jira.issuekey, projectname: @jira.projectname, status: @jira.status }
    end

    assert_redirected_to jira_path(assigns(:jira))
  end

  test "should show jira" do
    get :show, id: @jira
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @jira
    assert_response :success
  end

  test "should update jira" do
    patch :update, id: @jira, jira: { issuekey: @jira.issuekey, projectname: @jira.projectname, status: @jira.status }
    assert_redirected_to jira_path(assigns(:jira))
  end

  test "should destroy jira" do
    assert_difference('Jira.count', -1) do
      delete :destroy, id: @jira
    end

    assert_redirected_to jiras_path
  end
end
