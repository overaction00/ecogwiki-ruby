class SimilarPage < ActiveRecord::Base
  attr_accessible :wikipage_id, :title, :score

  belongs_to :wikipage
end
