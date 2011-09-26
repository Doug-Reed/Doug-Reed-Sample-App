require 'test_helper'

class SearchesControllerTest < ActionController::TestCase
  setup do
    @search = searches(:kittens)
  end

#  test "should post result" do
#    post :result, id: @search.to_param
#    assert_response :success

#  end

#  test "should get_flickr_api" do
    
#    assert_not_nil @controller.send(:call_flickr_api => :search =>@search)
      
 # end
  
 # test "should get index" do
    #In this application - Index reidrects to resuls
 #   get :index
 #   assert_redirected_to result_path(assigns(:search))   
 #   assert_response :success
 #   assert_not_nil assigns(:searches)
 # end

#  test "should get new" do
#    get :new
#    assert_response :success
#  end

  test "should create search" do
    assert_difference('Search.count') do
      post :create, search: @search.attributes
    end
  end


#  test "should show results" do
#    post :result, @search
#    assert_response :success
#  end
#  test "should show search" do
#    get :show, id: @search.to_param
#    assert_response :success
#  end

#  test "should get edit" do
#    get :edit, id: @search.to_param
#    assert_response :success
#  end

#  test "should update search" do
#    put :update, id: @search.to_param, search: @search.attributes
#    assert_redirected_to search_path(assigns(:search))
#  end

#  test "should destroy search" do
#    assert_difference('Search.count', -1) do
#      delete :destroy, id: @search.to_param
#    end

#   assert_redirected_to searches_path
#  end
end
