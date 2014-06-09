class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string   :title,        default: "untitled"
      t.string   :province
      t.string   :city
      t.string   :district
      t.string   :location
      t.string   :contact
      t.string   :duration
      t.string   :budget
      t.text     :description
      t.text     :script
      t.text     :team
      t.text     :plan
      t.text     :expense
      t.string   :cover
      t.string   :video
      t.references  :user
      t.string   :status,       default: "draft"
      t.datetime :start_at
      t.integer  :project_id
      t.string   :movie_type
      t.datetime :published_at
      t.string   :currency
      t.timestamps
    end
  end
end
