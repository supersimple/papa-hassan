# Papa

## Running

### Depencies

- sqlite, on a mac I installed it with `brew install sqlite`

### Running tests

- `mix test`

### Runnin REPL

TODO

## Todo:

- Can first name last name or email be nil?
- Request a visit
- Do we want to validate / save whether a user is a member or a papa pal?
- When a user fulfills a visit, make a transaction -15% of the overhead fee.
- If a members account has a balance of 0 minutes then they cant request any more minutes until they fulfill visits themselves
- Various CI steps (you know em! maybe coveralls and the documentation one...doctor??) mix compile --warnings-as-errors, mix format, run: mix credo --strict, mix test --cover

- Note: Document assumptions and design choices

## Notes

- Typespecs are arguably an improvement. The only issue is that it can lead to hard to diagnose issues and be a timesink. Hopefully the Elixir type system addresses types.

## Design choices

### Application Level

- Use utc_datetime_usec instead of naive_datetime because then it is converted to utc. https://elixirforum.com/t/why-use-utc-datetime-over-naive-datetime-for-ecto/32532/2

### Database Level

- In postgres you would use citext but here I use`COLLATE NOCASE` which is the sqlite way.
- Used UUID over autoincrementing integers although there are arguably preferable formats like ordered UUIDs. I prefer binary id's because you won't get actual results if you pass in an arbitrary UUID like you could a number. It's much easier to get an actual result with an integer. Making it less likely you accidentally mess up a join in a query and it returns results that make some amount of sense. Or if you really screw up and there's some access control bug, which ideally there won't be with some good tests...but access control can be very hard to get right especially in weaker codebases, especially untested codebases (I really like tests...)! UUID's offer some small amount of insurance in the event there is some kind of human error.
- I am storing tasks in a blob on visit (json--an array of strings). This is quick and dirty imho. Although Ecto is really smart about this using a join table would be ideal. The benefits would be saving space, easier updates, easier analytics, more flexibility in general, for example it would be easy to create a dynamic drop down, auto complete, and stuff like that.
- Made first_name not nullable. Different cultures have different naming conventions but I am just going to assume a first_name is required and last_name is not.

### Testing

- `validate_schema_fields_and_types` is a nice way of making assertions that your types are what you want. I learned this from Jeffrey Matthias (https://twitter.com/idlehands) one of the authors of Testing Elixir (https://pragprog.com/titles/lmelixir/testing-elixir/)
- I added faker and factories (ex_machina) because I love the testing ergonomics they afford me. It's nice to use some realistic dummy data.
