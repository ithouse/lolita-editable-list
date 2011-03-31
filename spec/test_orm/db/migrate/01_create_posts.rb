class CreatePosts < ActiveRecord::Migration

  class << self
    def up
    	create_table :posts, :force=>true do |t|
			t.string :title
			t.text	 :body
      t.timestamps
		end
    end

    def down
      drop_table :posts
    end
  end
end