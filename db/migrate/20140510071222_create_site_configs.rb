class CreateSiteConfigs < ActiveRecord::Migration
  def change
    create_table :site_configs do |t|
      t.string :property
      t.string :value
      t.timestamps
    end
  end
end
