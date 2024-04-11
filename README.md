# Papa

## Running

### Depencies

- sqlite, on a mac I installed it with `brew install sqlite`

### Running tests

- `mix test`

### Runnin REPL

TODO

## Todo:

- References should probably have an explicit on_delete behavior
- When a user fulfills a visit, make a transaction -15% of the overhead fee.
- If a members account has a balance of 0 minutes then they cant request any more minutes until they fulfill visits themselves
- Various CI steps (you know em! maybe coveralls and the documentation one...doctor??) mix compile --warnings-as-errors, mix format, run: mix credo --strict, mix test --cover

## Notes

- Typespecs are arguably an improvement. The only issue is that it can lead to hard to diagnose issues and be a timesink. Hopefully the Elixir type system addresses types in the future.
- I would likely design things such that there is a visit_request table and visit_fulfillment table. Two separate tables, I imagine both would be create only. That way things are auditable and each record corresponds to one user generated event. A member says I want someone over for 1 hour! But then a pal can only be there for 30 minutes, we may still want the pal to go and record both pieces of data (minutes requested, minutes fulfilled)
- Tasks on a Visit can be interpreted two ways: The tasks requested and / or the tasks fulfilled, or both. I interpreted it as the tasks requested.
- Users are both pals and members, if I wanted to I could have create a role system. Where one user can have multiple roles, or perhaps none if they aren't initiated to the platform yet, if that behavior was desired.

## Design choices

### Application Level

- Use utc_datetime_usec instead of naive_datetime because then it is converted to utc. https://elixirforum.com/t/why-use-utc-datetime-over-naive-datetime-for-ecto/32532/2

### Database Level

- In postgres you would use citext but here I use `COLLATE NOCASE` which is the sqlite way to make case insensitive email comparisons so we don't get the same email with different casing in the database.
- Used UUID over autoincrementing integers although there are arguably preferable formats like ordered UUIDs. I prefer binary id's because you won't get actual results if you pass in an arbitrary UUID like you could a number. It's much easier to get an actual result with an integer. Making it less likely you accidentally mess up a join in a query and it returns results that make some amount of sense. Or if you really screw up and there's some access control bug, which ideally there won't be with some good tests...but access control can be very hard to get right especially in weaker codebases, such as untested codebases! UUID's offer some small amount of insurance in the event there is some kind of human error. One con is that UUIDs (16 bytes) require more space to store than integers (0-8 bytes).
- I am storing tasks in a blob on visit (json--an array of strings). This is quick and dirty imho. Although Ecto is really smart about this using a join table would be ideal. The benefits would be saving space, easier updates, easier analytics, more flexibility in general, for example it would be easy to create a dynamic drop down with presupplied tasks, auto complete for tasks, and stuff like that.
- Made first_name not nullable. Different cultures have different naming conventions but arguably a good way to deal with this is to make first_name required but last_name not.
- Sqlite is not good about the names of foreign key constraints during violations (https://hexdocs.pm/ecto_sqlite3/Ecto.Adapters.SQLite3.html#module-handling-foreign-key-constraints-in-changesets). Becuase of this I have to try / rescue and it is not done in the most surgical way. But I could be a little more surgical if I wanted to. Just not perfect. Also ideally I would use the same exact error message ecto uses.

### Testing

- `validate_schema_fields_and_types` is a nice way of making assertions that your types are what you want. I learned this from Jeffrey Matthias (https://twitter.com/idlehands) one of the authors of Testing Elixir (https://pragprog.com/titles/lmelixir/testing-elixir/)
- I added faker and factories (ex_machina) because I love the testing ergonomics they afford me. It's nice to use some realistic dummy data.
- The factories don't create associations. I find that to be "magical" and would rather manually create associations in tests as it leads to less unexpected behavior im my experience as well as slimmer and easier to read factories.
