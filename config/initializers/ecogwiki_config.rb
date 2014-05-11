# Load from config/ecogwiki.yml
CONFIG = YAML.load_file(Rails.root.join('config/ecogwiki.yml'))
puts '-------------- config'
puts CONFIG.inspect