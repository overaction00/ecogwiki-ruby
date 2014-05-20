class Toc < ActiveRecord::Base
  attr_accessible :wikipage_id, :key, :title, :depth, :order

  belongs_to :wikipage
end
