class Gun < ActiveRecord::Base
  belongs_to :gun_owner, :dependent => :delete

  def self.search(search)
    if search
      where 'serial_number LIKE ?', "%#{search}%"
    else
      false
    end
  end
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
