require "test_helper"

class FieldTest < ActiveSupport::TestCase
  should validate_presence_of(:item_type)
  should validate_presence_of(:name)
  should validate_presence_of(:name_plural)
  should validate_presence_of(:slug)

  should validate_uniqueness_of(:slug).scoped_to(:item_type_id)
  should allow_value("hey").for(:slug)
  should_not allow_value("under_score").for(:slug)
end