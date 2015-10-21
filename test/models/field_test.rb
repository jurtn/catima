require "test_helper"

class FieldTest < ActiveSupport::TestCase
  should validate_presence_of(:item_type)
  should validate_presence_of(:name)
  should validate_presence_of(:name_plural)
  should validate_presence_of(:slug)

  should validate_uniqueness_of(:slug).scoped_to(:item_type_id)
  should allow_value("hey").for(:slug)
  should_not allow_value("under_score").for(:slug)

  test "only one field can be primary per type" do
    title = fields(:one_title)
    summary = fields(:one_summary)

    assert(title.primary?)
    refute(summary.primary?)

    summary.update!(:primary => true)

    refute(title.reload.primary?)
    assert(summary.reload.primary?)

    # Field in another item type is not affected
    assert(fields(:one_author_name).primary?)
  end

  test "generates and assigns uuid" do
    SecureRandom.stubs(:uuid => "1234-abcd")

    field = Field::Text.create!(
      :item_type => item_types(:two_author),
      :name => "Text",
      :name_plural => "Texts",
      :slug => "text"
    )
    assert_equal("_1234_abcd", field.uuid)
  end
end
