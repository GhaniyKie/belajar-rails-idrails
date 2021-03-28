class ForumPost < ApplicationRecord
    belongs_to :user
    # Counter chache digunakan untuk menghitung jumlah ForumPost
    # counter_cache diimplementasikan agar tidak terjadi beban berlebih pada Database, karena perhitungan Query
    belongs_to :forum_thread, counter_cache: true
    
    validates :content, presence: true
end
