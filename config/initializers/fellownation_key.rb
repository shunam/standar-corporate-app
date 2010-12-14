if RAILS_ENV == 'development' || RAILS_ENV == 'test' || RAILS_ENV == 'cucumber'
  SITE = 'http://dev.localhost.local:3000'
  FKEY = "yHrtKI4tnaS8hdnNN8VP"
  FSECRET = "D4UcudiPAuoZ6XM8ZBeyhosPEV7tzZ9B0hzMWD40"
else
  SITE = 'http://fellownation.com'
  FKEY = "Tv9AXLCC1G94MiZZugBw"
  FSECRET = "UBwbjrka2hIgVhljOxLtb8ORr1pcKV8OxIPckAQu"
end