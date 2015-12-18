# == Schema Information
#
# Table name: choices
#
#  catalog_id              :integer
#  category_id             :integer
#  choice_set_id           :integer
#  created_at              :datetime         not null
#  id                      :integer          not null, primary key
#  long_name_old           :text
#  long_name_translations  :json
#  short_name_old          :string
#  short_name_translations :json
#  updated_at              :datetime         not null
#

class Choice < ActiveRecord::Base
  include HasTranslations

  belongs_to :catalog
  belongs_to :category
  belongs_to :choice_set

  store_translations :short_name, :required => true
  store_translations :long_name, :required => false

  validates_presence_of :catalog

  %w(de en fr it).each do |locale|
    define_method("long_display_name_#{locale}") do
      long_name = public_send("long_name_#{locale}")
      short_name = public_send("short_name_#{locale}")
      long_name.present? ? long_name : short_name
    end
  end

  def long_display_name(locale=I18n.locale)
    public_send("long_display_name_#{locale}")
  end

  def self.sorted(locale=I18n.locale)
    order("LOWER(choices.short_name_translations->>'short_name_#{locale}') ASC")
  end

  def self.short_named(name, locale=I18n.locale)
    where("choices.short_name_translations->>'short_name_#{locale}' = ?", name)
  end
end
