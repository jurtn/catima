class UserPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def user_is_admin?
    user.system_admin? || user.admin_of_any_catalog?
  end
  alias_method :create?, :user_is_admin?
  alias_method :edit?, :user_is_admin?
  alias_method :index?, :user_is_admin?
  alias_method :new?, :user_is_admin?
  alias_method :show?, :user_is_admin?
  alias_method :update?, :user_is_admin?

  def destroy?
    user.system_admin?
  end

  def permit(params)
    allowed = [
      :email,
      { :catalog_permissions_attributes => [:id, :catalog_id, :role] }
    ]
    allowed.delete(:email) unless user.system_admin?
    remove_prohibited_role_changes(params.permit(*allowed))
  end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      return scope.all if user.system_admin? || user.admin_of_any_catalog?
      scope.none
    end
  end

  private

  def remove_prohibited_role_changes(params)
    return params if user.system_admin?
    admin_catalog_ids = user.admin_catalog_ids
    params.fetch(:catalog_permissions_attributes, []).reject! do |perm|
      perm[:role] == "admin" || !admin_catalog_ids.include?(perm["id"].to_i)
    end
    params
  end
end