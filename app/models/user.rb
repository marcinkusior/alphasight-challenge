








class User < ActiveRecord::Base
	before_save :create_short_url
  before_save :scrap_headings

  has_many :friendships, dependent: :destroy, foreign_key: :friender_id
  has_many :friended_users, through: :friendships, source: :friended
  has_many :reverse_friendships, class_name: "Friendship", dependent: :destroy, foreign_key: :friended_id
  has_many :frienders, through: :reverse_friendships, source: :friender

	validates :name, presence: true
	validates :website_url, presence: true

	has_many :headings, dependent: :destroy

  def friends
    friender_friends_ids = "SELECT friender_id FROM friendships 
                            WHERE friended_id = :user_id"
    friended_friends_ids = "SELECT friended_id FROM friendships 
                            WHERE friender_id = :user_id"

    User.where("id IN (#{friender_friends_ids}) OR 
                id IN (#{friended_friends_ids})", user_id: self.id)
  end

  def friends_with?(user)
    self.friends.include?(user)
  end

  def self.options_for_select_without(user)
    User.where.not(id: user.id).map{|user| [user.name, user.id] }
  end

  protected

  def create_short_url
  	request = Googl.shorten(
  		self.website_url,
  		ENV['IP'],
  		ENV['GOOGLE_API_KEY']
		)
  	self.short_url = request.short_url
  end

  def scrap_headings
   doc= Nokogiri::HTML(open(self.website_url)) 
   types = ['h1', 'h2', 'h3'] 
   types.each do |type| 
     doc.css(type).each do |heading|  
      self.headings.build(group: type, content: heading.text)
     end 
   end
  end
end
      