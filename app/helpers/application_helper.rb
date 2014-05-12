require 'redcarpet'
require 'trie'

module ApplicationHelper

  def absolute_path(page)
    if page.class.to_s == 'String'
      '/' + page
    elsif page.class.to_s == 'Wikipage' || page.class.to_s == 'OldWikipage'
      '/' + page.title + '?rev=' + page.wikipage.revision.to_s
    else
      page
    end
  end

  def admin?(user)
    return false if user.nil?
    CONFIG['admin'].split(',').map!{|x| x.strip!}.include?(user.email)
  end

  def page_modifier(page)
    user_preference = page.user_preference
    user_preference.nil? ? page.modifier : user_preference.title
  end

  def page_type(page)
    'other'
  end
end


