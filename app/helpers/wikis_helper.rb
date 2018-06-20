module WikisHelper
  def authorized_for_private_wikis?(wiki)
    wiki.private? && (current_user.admin? || current_user.premium?)
  end
  
  def wiki_viewable(wiki)
    wiki.private!=true ||
      current_user.admin? ||
      ( current_user.premium? && current_user.id==wiki.user_id )
  end
end
