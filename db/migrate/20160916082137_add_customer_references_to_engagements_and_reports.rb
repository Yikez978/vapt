class AddCustomerReferencesToEngagementsAndReports < ActiveRecord::Migration
  def change
    add_reference :engagements, :customer, index: true, foreign_key: true
    add_reference :reports, :customer, index: true, foreign_key: true
  end
end
