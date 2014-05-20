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

  def generate_toc_html(page)
    prev_depth = 1
    html = '<div class="toc"><ol>'
    tocs = page.tocs
    unless tocs.blank?
      html += '<h1>Table of Contents</h1>'
      tocs.each do |toc|
        cur_depth = toc.depth
        if cur_depth > prev_depth
          html += '<ol>'
        end
        if cur_depth < prev_depth
          html += '</ol>'
        end
        html += "<li><div><a class=\"hash-anchor\" href=##{toc.key}>#{toc.title}</a></div>"
        if cur_depth <= prev_depth
          html += '</li>'
        end
        prev_depth = cur_depth
      end
    end
    html += '</ol></div>'
    # puts '--' + html + '--'
    html.html_safe
  end

  def page_type(page)
    'other'
  end
end


