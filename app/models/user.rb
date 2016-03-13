








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

  def options_for_friends
    reject_ids = self.friends.map{|user| user.id } << self.id
    User.where.not(id: reject_ids).map{|user| [user.name, user.id] }
  end

  def all_paths_between(headings)
    headings.map do |heading| 
      if heading.user == self then
        [ "(#{heading.content})", [self.name]]
      else
        result = self.path_of_introduction(heading.user) << heading.user.name
        [ "(#{heading.content})", result ] 
        #ex.=> ['Some Topic of Interest', ['Mike', 'Sally', 'David'] ]
      end
    end
  end

  def path_of_introduction(rootuser)
    return ['friends already with'] if self.friends_with?(rootuser)
    queue = [[self]]
    rootfriends = rootuser.friends
    marked = [self]
    until queue.empty? do
      subject = queue.shift
      return subject.map{|user| user.name } if rootfriends.include?(subject[-1])
      marked << subject[-1]
      subject[-1].friends.each do |friend|
        to_queue = subject + [friend]
        queue << to_queue unless marked.include?(friend)
      end
    end
    ['no connection with']
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
   doc = Nokogiri::HTML(open(self.website_url)) 
   types = ['h1', 'h2', 'h3'] 
   types.each do |type| 
     doc.css(type).each do |heading|  
      self.headings.build(group: type, content: heading.text)
     end 
   end
  end
end
      