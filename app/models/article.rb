# coding: utf-8
require 'file_size_validator' 
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
  mount_uploader :thumb, PhotoUploader
  validates :thumb, :presence => true,  :file_size => { :maximum => 0.5.megabytes.to_i } 
end
