class ForumThread < ApplicationRecord
    # Extend Friendly ID disini
    extend FriendlyId

    friendly_id :title, use: :slugged
    belongs_to :user
    # dependent: :destroy digunakan ketika suatu data dihapus, data yang berkaitan akan ikut terhapus
    has_many :forum_posts, dependent: :destroy

    validates :title, presence: true, length: {maximum: 30}
    validates :content, presence: true

    def sticky?
        sticky_order != 100 and sticky_order != nil
    end

    def pin_it!
        self.sticky_order = 1
        self.save # ForumThread.pin_it!
    end
end
