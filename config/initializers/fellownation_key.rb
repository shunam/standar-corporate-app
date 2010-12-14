if RAILS_ENV == 'development' || RAILS_ENV == 'test' || RAILS_ENV == 'cucumber'
  SITE = 'http://dev.localhost.local:3000'
  FKEY = "5x7BPZIasz7rwR0WnEMN"
  FSECRET = "4BUxEmOEqMSiswNB37GwhXBmz77v5fczaxkswSYu"
else
  SITE = 'http://fellownation.com'
  FKEY = "nODvh8Yv1JbRECh419wk"
  FSECRET = "bpndsoPa6e7eGHeIDkSfjUo08HrXumvS0lezSfRu"
end