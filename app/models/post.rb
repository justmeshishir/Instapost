class Post < ActiveRecord::Base
    belongs_to :user
    has_many :comments
    scope :of_followed_users, -> (following_users) { where user_id: following_users } 
    mount_uploader :photo, PhotoUploader
    validates :photo, :user_id, presence: true
    validate :photo_size_validation
    acts_as_votable
    def extension_white_list
        %w(jpg jpeg gif png)
    end
    
    private
    def photo_size_validation
        errors[:photo] << "should be less than 5MB" if photo.size > 5.megabytes
    end
    
end
