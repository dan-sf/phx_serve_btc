# PhxServeBtc

This is an example repo to demonstrate how to setup a simple api server using the Phoenix web framework. For more information/background you can check out the [companion blog post](https://www.dsfcode.com/posts/simple-api-server-in-phoenix/) I wrote.

## Running with `mix`

Use `mix` to run the server in development mode.

```
# Get dependencies
mix deps.get

# Create the db
mix ecto.create

# Migrate the db
mix ecto.migrate

# Seed the db
mix run priv/repo/seeds.exs

# Start the server
mix phx.server
```

The deps, db create/migrate, and seed steps should only need to be run once. After that you can start/stop the server normally.

## Running with `docker compose`

Use `docker compose` to simulate something closer to an actual deployment.

```
# Build and run the compose
docker compose up --build

# Seed the db

# Exec into the container
docker exec -it phx_serve_btc bash

# Run the seed script
bin/seed_btc
```

Again, the db seed process should only be needed once. The container data is written to the local file system so it should persist between container start and stop.

## Query the endpoint

To validate things are working as expected, navigate to `http://localhost:4000/api/btc_month/2022-01` to see some output data (make sure the db has been seeded).

