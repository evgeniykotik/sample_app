require 'test_helper'

class UsersControllerTest < ActionController::TestCase

  def setup
    @user = users(:postoyalko)
    @other_user = users(:archer)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should redirect edit when not logged in" do
    get :edit, params: { id: @user.id }
    assert_not flash.empty?
    assert_redirected_to login_url
  end
  
  test "should redirect update when not logged in" do
    patch :update, params: {id:@user.id, user: { name: @user.name, email: @user.email }}
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect edit when logged in as wrong user" do
    log_in_as(@other_user)
    get :edit, params: { id: @user.id }
    assert flash.empty?
    assert_redirected_to root_url
  end

  test "should redirect update when logged in as wrong user" do
    log_in_as(@other_user)
    patch :update, params: {id:@user.id, user: { name: @user.name, email: @user.email }}
    assert flash.empty?
    assert_redirected_to root_url
  end

  test "should redirect index when not logged in" do
    get :index
    assert_redirected_to login_url
  end
  
  test "should redirect destroy when not logged in" do
    assert_no_difference 'User.count' do
    delete :destroy, params: { id: @user.id }
    end
    assert_redirected_to login_url
  end

  test "should redirect destroy when logged in as a non-admin" do
    log_in_as(@other_user)
    assert_no_difference 'User.count' do
    delete :destroy, params: { id: @user.id }
   end
     assert_redirected_to root_url
  end
  
  test "should redirect following when not logged in" do
    get :following, params: { id: @user.id }
    assert_redirected_to login_url
  end

  test "should redirect followers when not logged in" do
    get :followers, params: { id: @user.id }
    assert_redirected_to login_url
  end
end

