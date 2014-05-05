class OldWikipage < ActiveRecord::Base
  attr_accessible :title, :body, :wikipage_id, :revision, :published_at, :published_to,
                  :created_at, :updated_at

  belongs_to :wikipage


end
