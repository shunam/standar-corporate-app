if RAILS_ENV == 'development' || RAILS_ENV == 'test' || RAILS_ENV == 'cucumber'
  SITE = 'http://dev.localhost.local:3000'
  FKEY = "yHrtKI4tnaS8hdnNN8VP"
  FSECRET = "D4UcudiPAuoZ6XM8ZBeyhosPEV7tzZ9B0hzMWD40"
else
  SITE = 'http://fellownation.com'
  FKEY = "lO2RiG4jBsAOXVgvJAaQ"
  FSECRET = "KFQj6QhddGbdpsJ0hkuTRqhSnYgMVhk4LRKxKeU8"
end