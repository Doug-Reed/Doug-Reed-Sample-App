require 'test_helper'

class SearchTest < ActiveSupport::TestCase
#There's only one field. Testing a save with a valid value, and testing with no value.  
  
  test "save without text" do
    search = Search.new
    assert !search.save, "Attempted to save with no searchtext."
    puts "Attempted to save with no searchtext."
  end
  
  test "save with proper text" do
    search = searches(:kittens)
    assert search.save, "Saving rails fixture with valid searchtext."
    puts "Saving rails fixture with valid searchtext."
  end

end
