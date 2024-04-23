# PhxServeBtc

This is an example repo to demonstrate how to setup a simple api server using the Phoenix web framework. For more information you can check out the [companion blog post](https://www.dsfcode.com/posts/simple-api-server-in-phoenix/) I wrote.

## Running the server

Start with `mix` in local development mode.

```
mix phx.server
```

Start with `compose` based deployment.

```
docker compose up --build
```

To validate things are working as expected, navigate to `http://localhost:4000/api/btc_month/2022-01` to see some output data (actual data will only be there if the db is seeded, see the blog post how how to do that).

