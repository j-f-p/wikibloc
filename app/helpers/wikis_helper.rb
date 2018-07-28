module WikisHelper
  def authorized_for_private_wikis?(wiki)
    # wiki.private==nil prior to render of wiki new form
    # Excluding wiki.private==false prevents all public wikis from becoming
    # private.
    (wiki.private==nil || wiki.private?) &&
      (current_user.admin? || current_user.premium?)
  end
  
  def authorized_to_manage_collaborators?(wiki)
    authorized_for_private_wikis?(wiki) &&
      wiki.user==current_user
  end
  
  def markdown(text)
    options = {
      filter_html: true,
      hard_wrap: true,
      link_attributes: { rel: 'nofollow', target: "_blank" },
      prettify: true,
      safe_links_only: true
    }

    extensions = {
      autolink: true,
      disable_indented_code_blocks: true,
      fenced_code_blocks: true,
      footnotes: true,
      highlight: true,
      no_intra_emphasis: true,
      quote: true,
      space_after_headers: true,
      superscript: true,
      underline: true
    }

    renderer = Redcarpet::Render::HTML.new(options)
    markdown = Redcarpet::Markdown.new(renderer, extensions)

    markdown.render(text).html_safe
  end
end
