require 'open-uri'

class UpgradeRubygems
  UPGRADES = {
    "1.8" => "http://installrails.com/rubygems-update-1.8.30.gem",
    "2.0" => "http://installrails.com/rubygems-update-2.0.15.gem",
    "2.2" => "http://installrails.com/rubygems-update-2.2.3.gem"
  }

  def call
    puts "You're up to date" and return if !upgrade_available?

    puts "You currently have #{rubygems_version}"
    download
    install
    update
    puts "You now have #{rubygems_version}"
  end

  private

    def download
      puts "Downloading #{upgrade_url}..."

      open(filename, "wb") do |file|
        open(upgrade_url) do |uri|
          file.write(uri.read)
        end
      end
    end

    def install
      puts "Installing #{filename}..."
      `gem install --local #{filename}`
    end

    def update
      puts "Updating rubygems..."
      `update_rubygems --no-ri --no-rdoc`
    end

    def rubygems_version
      `gem --version`
    end

    def upgrade_available?
      !!upgrade_url
    end

    def upgrade_url
      @upgrade_file ||= UPGRADES[rubygems_version[0..2]]
    end

    def filename
      @filename ||= upgrade_url.split("/").last
    end
end

upgrade = UpgradeRubygems.new
upgrade.call
