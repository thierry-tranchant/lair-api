class AddEpisodCookieOnUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :episod_cookie, :text
  end
end
