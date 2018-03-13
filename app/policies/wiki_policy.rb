class WikiPolicy < ApplicationPolicy
  def update?
    user.present?
  end
  
  def destroy?
    user.admin? || record.user == user
  end
end
