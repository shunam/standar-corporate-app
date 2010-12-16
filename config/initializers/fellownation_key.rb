if RAILS_ENV == 'development' || RAILS_ENV == 'test' || RAILS_ENV == 'cucumber'
  SITE = 'http://dev.localhost.local:3000'
  FKEY = "6Ar0hI7NPMXC8cjR4KwJ"
  FSECRET = "1pbEh805pCTAs0fYDOIWzH4PG0bRK3JAXNv3w4"
else
  SITE = 'http://fellownation.com'
  FKEY = "zduBQMNOz9pjXgbOWRio"
  FSECRET = "stSDN6YIRsryEE4wumWPdUkqxhVJUP2qZmtHbBXW"
end