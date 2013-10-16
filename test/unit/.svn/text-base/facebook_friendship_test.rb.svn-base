require 'test_helper'

class FacebookFriendshipTest < ActiveSupport::TestCase

  test "friendship creation" do
    f1 = FacebookUser.create
    f2 = FacebookUser.create

    assert !FacebookFriendship.already_exists?(f1, f2)
    assert FacebookFriendship.find_or_create_between(f1, f2)
    assert FacebookFriendship.already_exists?(f1, f2)
  end

  test "sort order preserved" do
    ff = FacebookFriendship.new
    ff.lower_facebook_user_id = 100
    ff.higher_facebook_user_id = 1
    assert ff.save
    ff.reload
    assert ff.lower_facebook_user_id < ff.higher_facebook_user_id
  end

  test "does not create duplicate friendship" do
    f1 = FacebookUser.create
    f2 = FacebookUser.create

    assert !FacebookFriendship.already_exists?(f1, f2)
    ff = FacebookFriendship.find_or_create_between(f1, f2)
    assert ff
    assert_equal FacebookFriendship, ff.class

    ff_dup = FacebookFriendship.find_or_create_between(f1, f2)
    assert_equal FacebookFriendship, ff_dup.class

    assert_equal ff, ff_dup
  end

end
