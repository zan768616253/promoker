# coding: utf-8
class Article < ActiveRecord::Base
  default_scope { order("created_at DESC") }

  acts_as_taggable
  acts_as_commentable
  acts_as_votable

end
