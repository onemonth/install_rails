class User
  include Mongoid::Document
  field :guest
  field :os
  field :os_version
  field :rails_version

  def self.new_guest
    new { |u| u.guest = true }
  end

end
