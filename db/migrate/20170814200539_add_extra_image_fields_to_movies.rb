class AddExtraImageFieldsToMovies < ActiveRecord::Migration[5.1]
  def change
    add_column :events, :image_content_type, :string
    add_column :events, :image_file_size, :integer
    add_column :events, :image_updated_at, :datetime
  end
end
