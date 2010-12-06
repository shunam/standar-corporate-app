# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_standar_corporate_app_session',
  :secret      => '28642c2c5b3b6da826f9dd3d462877051fd2e47f73c77c773699296ce196902e48d545f63a66147bf8e75cbe0f2b82072e4cb4d44537a2ed1df165fa743184e9'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
