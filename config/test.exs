import Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :discovery, DiscoveryWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "aHzgvVuvWvyFVcqPPt6dKfYPRp4HrBhh3PgZ/UVP9mAM2DsgpaRlvTwukl2Ycb7a",
  server: false

# In test we don't send emails.
config :discovery, Discovery.Mailer,
  adapter: Swoosh.Adapters.Test

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
