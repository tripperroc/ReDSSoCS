require 'test_helper'

class FacebookUserTest < ActiveSupport::TestCase

  test "friendship creation" do
    f1 = FacebookUser.create
    f2 = FacebookUser.create
    
    assert !f1.is_friends_with?(f2)
    assert !f2.is_friends_with?(f1)

    f1.find_or_create_friendship_with(f2)

    assert f1.is_friends_with?(f2)
    assert f2.is_friends_with?(f1)
  end

  test "self-referential activerecord relationship" do
    f1 = FacebookUser.create
    f2 = FacebookUser.create
    f3 = FacebookUser.create

    f1.find_or_create_friendship_with(f2)

    assert_equal f1, f2.facebook_friends.first
    assert_equal f2, f1.facebook_friends.first

    assert_equal 1, f1.facebook_friendships.size
    assert_equal 1, f2.facebook_friendships.size

    f1.find_or_create_friendship_with(f3)
    f1.reload
    assert_equal 2, f1.facebook_friendships.size
  end

end
