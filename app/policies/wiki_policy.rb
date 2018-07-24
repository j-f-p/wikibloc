class WikiPolicy < ApplicationPolicy
  def update?
    user.present?
  end
  
  def destroy?
    user.admin? || record.user == user
  end
  
  class Scope
    attr_reader :user, :scope
    
    def initialize(user, scope)
      @user = user
      @scope = scope
    end
    
    def resolve
      wikis = []
      all_wikis = scope.all
      if user.role == 'admin'
        wikis = all_wikis # reveal all wikis for admin
      elsif user.role == 'premium'
        all_wikis.each do |wiki|
          if wiki.private==false ||
            wiki.user==user || wiki.collaborators.include?(user)
            # reveal public wikis or any private wiki that the user provided a
            # primary or secondary contribution of content
            wikis << wiki
          end
        end
      else # user is 'standard'
        all_wikis.each do |wiki|
          if wiki.private==false || wiki.collaborators.include?(user)
            # reveal public wikis or any private wiki that the user provided a
            # secondary contribution of content
            wikis << wiki
          end
        end
      end
      wikis
    end
    
  end
end
