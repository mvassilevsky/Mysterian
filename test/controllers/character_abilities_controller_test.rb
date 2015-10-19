require 'test_helper'

class CharacterAbilitiesControllerTest < ActionController::TestCase
  test "should get add_character_ability" do
    get :add_character_ability
    assert_response :success
  end

  test "should get delete_character_ability" do
    get :delete_character_ability
    assert_response :success
  end

end
