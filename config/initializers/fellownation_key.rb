if RAILS_ENV == 'development' || RAILS_ENV == 'test' || RAILS_ENV == 'cucumber'
  SITE = 'http://localhost:3000'
  FKEY = "afJkSxi9N30qDhwcm7g"
  FSECRET = "ewqmnpXpJ4QD7GaDxn4n7Ki6aubWplCs2LV8tY5Q"
else
  SITE = 'http://fellownation.com'
  FKEY = "lO2RiG4jBsAOXVgvJAaQ"
  FSECRET = "KFQj6QhddGbdpsJ0hkuTRqhSnYgMVhk4LRKxKeU8"
end