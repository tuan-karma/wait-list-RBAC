# WaitList

This wait list app is an experimented implement that imitates [KnowThen's WaitList App](https://github.com/knowthen/elixir_authorization_tutorial).
The implement here is without live-view and with following features:

  * RBAC using DB table (role, access): access_control_rules = Roles & Permissions ~~belongs to user~~
  * Use phx.gen.auth for authentication
  * Keep minimal css as an origin phx.new (aka miligram css)
  * Use Kaffy admin tool to manage/edit/control the access_control_rules, user_id --> user

## Initial Steps to generate the app

  * `mix phx.new wait_list --no-dashboard --binary-id`
  * `cd wait_list`
  * optional: `mix help phx.gen.auth` to see available options of phx.gen.auth
  * `mix phx.gen.auth Accounts User users --hashing-lib argon2`
  * `mix do deps.get, deps.compile`
  * `mix ecto.create`
  * `mix ecto.migrate`
  * `mix phx.server`
  * Clean the header part in `app.html.eex`, clean the body of `page/index.html.eex`
  * Create UserController and UserView and corresponding templates (:index, :edit, :update)
  * `mix phx.gen.html Reservation Party parties name:string size:integer status` then edit/modify/improve ...
  * Modify `templates/party/index.html.eex` to represent "Reserve" "Seat" "Cancel" button in one page, borrow the code from others `...templates/party/*.html.eex`
  * Implement RBAC similar to knowthen but with a table of `rules` stored Database


## Initial git commands

  * `git init`
  * `git add .`
  * `git commit -m "Initial commit"`
  * Create a remote repo in github.com then following the guide in the new created github page
  * `git branch -M main`
  * `git remote add origin https://github.com/tuan-karma/wait-list-RBAC.git`
  * `git push -u origin main`