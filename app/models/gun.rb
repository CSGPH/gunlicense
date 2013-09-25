class Gun < ActiveRecord::Base
  belongs_to :gun_owner, :dependent => :delete

  def self.expired
    where("expiry_date < ?", Date.today)
  end

  def expired?
    if expiry_date < Date.today
      true
    else
      false
    end
  end
end
