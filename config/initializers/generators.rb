Rails.application.config.generators do |g|
  g.fixture_replacement :factory_girl, :dir => 'spec/factories'
end
