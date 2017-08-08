class User < ActiveRecord::Base
  has_many :spots
  has_secure_password

  def slug
    self.username.downcase.strip.gsub(' ', '-')
  end

  def self.find_by_slug(slug)
    self.all.find do |x|
      x.slug == slug
    end
  end
end
