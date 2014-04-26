class Movie < ActiveRecord::Base
  acts_as_taggable_on :locations, :types
  acts_as_commentable
  acts_as_votable

  scope :recent, -> { order("created_at DESC ")}
  scope :top, -> { select("*, count(comments.id) AS comments_count").
    joins(:comments).
    group("movies.id").
    order("comments_count DESC")
  }

  has_and_belongs_to_many :directors
  has_and_belongs_to_many :actors

  scope :recent, -> { order("created_at DESC") }
end
