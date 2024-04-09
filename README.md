# Papa

## Running

### Depencies

- sqlite, on a mac I installed it with `brew install sqlite`

### Running tests

- `mix test`

### Runnin REPL

TODO

## Todo:

- Create an account
- Request a visit
- Validate email uniqueness
- Do we want to validate / save whether a user is a member or a papa pal?
- When a user fulfills a visit, make a transaction -15% of the overhead fee.
- If a members account has a balance of 0 minutes then they cant request any more minutes until they fulfill visits themselves

- Note: Document assumptions and design choices

## Notes

- As of right now, tasks I may store in a blob. But, a join table may work here as well.

## Design choices

### Application Level

- Use utc_datetime_usec instead of naive_datetime because then it is converted to utc. https://elixirforum.com/t/why-use-utc-datetime-over-naive-datetime-for-ecto/32532/2

### Database Level

- Would have been nice to use citext but that's a Postgres thing. Otherwise we have to enforce email uniqueness due to casing at the application level.
- Used UUID over autoincrementing integers although there are arguably preferable formats like ordered UUIDs. I prefer binary id's because you won't get actual results if you pass in an arbitrary UUID like you could a number. It's much easier to get an actual result with an integer. Making it less likely you accidentally mess up a join in a query and it returns results that make some amount of sense. Or if you really screw up and there's some access control bug, which ideally there won't be with some good tests...but access control can be very hard to get right especially in weaker codebases, especially untested codebases (I really like tests...)! UUID's offer some small amount of insurance in the event there is some kind of human error.

### Testing

- `validate_schema_fields_and_types` is a nice way of making assertions that your types are what you want. I learend this from Jeffrey Matthias (https://twitter.com/idlehands) one of the authors of Testing Elixir (https://pragprog.com/titles/lmelixir/testing-elixir/)
- I added faker and factories (ex_machina) because I love the testing ergonomics they afford me. And it's nice to use some realistic dummy data.
