class AddForumPostCounterToForumThreads < ActiveRecord::Migration[6.1]
  def up
    add_column :forum_threads, :forum_posts_count, :integer, default: 0
    # Karena sudah ada nilai dari forum

    ForumThread.all.each do |t|
      ForumThread.reset_counters(t.id, :forum_posts) # Nama Relasi
    end
  end

  def down
    remove_column :forum_threads, :forum_posts_count
  end

end
