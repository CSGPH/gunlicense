class GunOwner < ActiveRecord::Base
  has_one :user
  has_many :guns

  geocoded_by :full_address
  after_validation :geocode

  acts_as_gmappable :process_geocoding => false

  def self.import(file)
    spreadsheet = open_spreadsheet(file)
    header = spreadsheet.row(1)
    (2..spreadsheet.last_row).each do |i|
      row           = Hash[[header, spreadsheet.row(i)].transpose]
      user          = find_by_name(row["FIREARMS HOLDER"].strip) || new
      user.name     = row["FIREARMS HOLDER"].strip
      user.address  = row["ADDRESS"].strip
      user.city     = row["CITY/MUNICIPALITY"].strip
      user.province = row["PROVINCE"].strip
      user.region   = row["REGION"]
      user.save

      snum              = row["SERIAL NUMBER"].to_s.gsub(".0","").strip
      gun               = Gun.find_by_serial_number(snum) || Gun.new
      gun.gun_owner     = user
      gun.serial_number = snum
      gun.kind          = row["KIND"].to_s.strip
      gun.make          = row["MAKE"].to_s.strip
      gun.caliber       = row["CALIBER"].to_s.strip
      gun.model         = row["MODEL"].to_s.strip
      gun.issued_date   = row["ISSUED DATE"]
      gun.expiry_date   = row["EXPIRY DATE"]
      gun.save

      sleep 0.25
    end
  end

  def self.unmapped_addresses
    where(:latitude => nil, :longitude => nil)
  end

  def full_address
    "#{self.address} #{self.city}"
  end

  def gmaps4rails_infowindow
    "<p>Name: #{name}</p>" +
    "<p>Address: #{full_address}</p>" +
    "<p>Guns Listed: #{gun_count}</p>" +
    "<a href=\"/gun_owners/#{id}\"> More Info</a>"
  end

  def gun_count
    guns.count
  end

  def notify_expired!
    SMS.send_message!({:to => mobile_number, :from => "CSG", :text => "Your firearm license is expired!"})
  end

  def authenticate(serial_number)
    gun = Gun.find_by_serial_number(serial_number)
    unless gun.nil?
      gun.gun_owner
    else
      nil
    end
  end

  private

  def self.open_spreadsheet(file)
    case File.extname(file)
    when '.csv' then Roo::Csv.new(file, nil, :ignore)
    when '.xls' then Roo::Excel.new(file, nil, :ignore)
    when '.xlsx' then Roo::Excelx.new(file, nil, :ignore)
    else raise "Unknown file type: #{file}"
    end
  end
end
