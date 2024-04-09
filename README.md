# Papa

**TODO: Add description**

# Running

## Depencies

- sqlite, on a mac I installed with `brew install sqlite`

## Running tests

- `mix test`

## Note:

- I like Postgres becuase it has the case insensitive citext type for emails, will have to enforce email non duplication because of cases at the application level.
- Using utc_datetime_usec instead of naive_datetime because then it is convereted to utc. https://elixirforum.com/t/why-use-utc-datetime-over-naive-datetime-for-ecto/32532/2
- Using UUID over autoincrementing although there are arguably preferable formats like ordered UUIDs. I prefer binary id's because numbers won't fetch actual results. Making it less likely you accidentally mess up a join in a query and it returns results that make some amount of sense. Or if you really screw up and there's some access control bug, which ideally there won't be with some good tests! It won't lead to accidentally pulling up results. Honestly this is just some amount of insurance in the event there is some kind of human error.
