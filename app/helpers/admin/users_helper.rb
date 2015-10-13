module Admin::UsersHelper
  def admin_catalogs(user)
    if user.system_admin?
      content_tag(:span, "System", :class => "label label-primary")
    else
      user.admin_catalogs.map(&:name).sort_by(&:downcase).to_sentence
    end
  end

  def last_signed_in(user)
    at = [user.last_sign_in_at, user.current_sign_in_at].compact.max
    sentence_case("#{distance_of_time_in_words_to_now(at)} ago") unless at.nil?
  end

  def render_users_nested_permissions(form)
    render(
      :partial => "admin/users/nested_permissions",
      :locals => {
        :f => form,
        :permissions => sorted_permissions_for_edit(form.object)
      })
  end

  def render_users_role_button_bar(form)
    # TODO: hide admin role from non-system admins based on UserPolicy
    roles = CatalogPermission::ROLE_OPTIONS.each_with_object([]) do |r, roles|
      next if r == "reviewer" && !form.object.catalog.requires_review?
      roles << [r, form.object.role == r ? "active" : ""]
    end
    render(
      :partial => "admin/users/role_button_bar",
      :locals => {
        :f => form,
        :roles => roles
      })
  end

  def sorted_permissions_for_edit(user)
    Catalog.active.sorted.map do |catalog|
      exist = user.catalog_permissions.find { |p| p.catalog_id == catalog.id }
      exist || CatalogPermission.new(
        :user => user,
        :catalog => catalog,
        :role => "user"
      )
    end
  end
end