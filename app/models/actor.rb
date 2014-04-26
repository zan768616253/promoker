class Actor < ActiveRecord::Base
  has_many :profiles, :as => :profilable
  has_and_belongs_to_many :movies
end
