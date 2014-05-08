class OldWikipage < ActiveRecord::Base
  attr_accessible :title, :body, :wikipage_id, :revision, :comment, :modifier,
                  :created_at, :updated_at

  belongs_to :wikipage

  def user_preference
    Preference.find_by_email(self.modifier)
  end

end
