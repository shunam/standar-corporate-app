if RAILS_ENV == 'development' || RAILS_ENV == 'test' || RAILS_ENV == 'cucumber'
  SITE = 'http://dev.localhost.local:3000'
  FKEY = "5x7BPZIasz7rwR0WnEMN"
  FSECRET = "4BUxEmOEqMSiswNB37GwhXBmz77v5fczaxkswSYu"
else
  SITE = 'http://fellownation.com'
  FKEY = "zduBQMNOz9pjXgbOWRio"
  FSECRET = "stSDN6YIRsryEE4wumWPdUkqxhVJUP2qZmtHbBXW"
end