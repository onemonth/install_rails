class User
  include ActiveModel::Model

  attr_accessor :config

  def update(params)
    params.each do |key, value|
      config[key] = value
    end
  end

  def save
    true
  end

  def method_missing(name)
    config[name.to_s]
  end
end
