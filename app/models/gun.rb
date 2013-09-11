class Gun < ActiveRecord::Base
  belongs_to :gun_owner, :dependent => :delete
end
