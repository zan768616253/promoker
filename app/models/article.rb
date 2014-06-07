# coding: utf-8
class Article < ActiveRecord::Base

  paginates_per 5
  acts_as_taggable
  acts_as_commentable
  acts_as_votable

  scope :recent, -> { order("created_at DESC") }
  scope :top, -> { select("*, count(comments.id) AS comments_count").
      joins(:comments).
      group("articles.id").
      order("comments_count DESC")
  }

  validates_presence_of :title
end
