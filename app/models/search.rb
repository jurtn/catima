# Base class for simple and advanced searches.
class Search
  attr_reader :catalog, :page, :per

  def initialize(catalog, page, per)
    @catalog = catalog
    self.page = page
    self.per = per || 20
  end

  def page=(value)
    @page = [1, value.to_i].max
  end

  def per=(value)
    @per = [1, value.to_i].max
  end

  def offset
    per * (page - 1)
  end

  def page_for_offset(an_offset)
    1 + (an_offset / per)
  end

  def items
    unpaginaged_items.page(page).per(per)
  end
end