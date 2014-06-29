require 'file_size_validator' 
class Movie < ActiveRecord::Base
  paginates_per 12
  acts_as_taggable_on :locations, :types
  acts_as_commentable
  acts_as_votable

  mount_uploader :thumb, PhotoUploader
  validates :thumb, :presence => true,  :file_size => { :maximum => 0.5.megabytes.to_i } 
  scope :recent, -> { order("created_at DESC ")}
  scope :top, -> { select("*, count(comments.id) AS comments_count").
    joins(:comments).
    group("movies.id").
    order("comments_count DESC")
  }
  scope :recommends, -> { where(:home_page => true).limit(4).order(home_page_order: :asc) }

  belongs_to :director
  has_and_belongs_to_many :actors

  def type_enum
    Tag.tags_on(:movie_type)
  end

  def location_enum
    Tag.tags_on(:location)
  end
  
end
