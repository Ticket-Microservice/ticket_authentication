# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Authentication.Repo.insert!(%Authentication.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

Application.put_env(:authentication, :start_servers, false)

alias Authentication.Repo
alias Authentication.Schemas.Gender
alias Authentication.Schemas.Roles

# Define the master data
genders = [
  %{name: "Male", is_enabled: true},
  %{name: "Female", is_enabled: true},
  %{name: "Non-Binary", is_enabled: true}
]

roles = [
  %{name: "Admin", is_enabled: true},
  %{name: "Buyer", is_enabled: true},
]

# Insert each record only if `name` does not already exist
Enum.each(genders, fn gender ->
  case Repo.get_by(Gender, name: gender.name) do
    nil ->
      # Insert the gender if it doesn't exist
      Repo.insert!(Gender.changeset(%Gender{}, gender))
    _ ->
      # Log or skip if it already exists
      IO.puts("Gender '#{gender.name}' already exists, skipping...")
  end
end)

Enum.each(roles, fn role ->
  case Repo.get_by(Roles, name: role.name) do
    nil ->
      # Insert the gender if it doesn't exist
      Repo.insert!(Roles.changeset(%Roles{}, role))
    _ ->
      # Log or skip if it already exists
      IO.puts("role '#{role.name}' already exists, skipping...")
  end
end)
