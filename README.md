# WaitList

This wait list app is an experimented implement that imitates [KnowThen's WaitList App](https://github.com/knowthen/elixir_authorization_tutorial).
The implement here is without live-view and with following features:

  * RBAC using DB table (role, access)
  * Use phx.gen.auth for authentication
  * Keep minimal css as an origin phx.new (aka miligram css)

## Initial Steps to generate the app

  * `mix phx.new wait_list --no-dashboard --binary-id`
  * `cd wait_list`
  * optional: `mix help phx.gen.auth` to see available options of phx.gen.auth
  * `mix phx.gen.auth Accounts User users --hashing-lib argon2`
  * `mix do deps.get, deps.compile`
  * `mix ecto.create`
  * `mix ecto.migrate`
  * `mix phx.server`
  * Clean `app.html.eex`, clean `page/index.html.eex`

## Initial git commands

  * `git init`
  * `git add .`
  * `git commit -m "Initial commit"`
  * Create a remote repo in github.com then following the guide in the new created github page
  * `git branch -M main`
  * `git remote add origin https://github.com/tuan-karma/wait-list-RBAC.git`
  * `git push -u origin main`