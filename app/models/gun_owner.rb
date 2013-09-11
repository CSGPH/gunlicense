class GunOwner < ActiveRecord::Base
  has_one :user
  has_many :guns

  geocoded_by :address
  after_validation :geocode

  class << self
    def import(file)
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
  end

  def generate_username(q)
    if ["BUSINESS", "SECURITY AGENCY"].include? q
      name.downcase.gsub(" ", "")
    else
      spread   = name.split(",")
      initials = name.last.split(" ").map { |i| i[0,1] }.join(" ").gsub(" ","")
      "#{initials}#{spread.first}"
    end
  end

  private

  def self.open_spreadsheet(file)
    case File.extname(file.original_filename)
    when '.csv' then Roo::Csv.new(file.path, nil, :ignore)
    when '.xls' then Roo::Excel.new(file.path, nil, :ignore)
    when '.xlsx' then Roo::Excelx.new(file.path, nil, :ignore)
    else raise "Unknown file type: #{file.original_filename}"
    end
  end
end
