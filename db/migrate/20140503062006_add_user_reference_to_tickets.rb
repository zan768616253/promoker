class AddUserReferenceToTickets < ActiveRecord::Migration
  def change
  	add_reference :tickets, :user
  end
end
