class CreatePricingRules < ActiveRecord::Migration
  def change
    create_table :pricing_rules do |t|

      t.timestamps null: false
    end
  end
end
