# Tabstat

This goal of `Tabstat` is to serve as a cli utility that helps in manipulating tabular data (CSV, TSV, etc) and extract
meaningful insight out of it.

# Vision

## Answer questions like,

- What are the columns that we have?
- Total number of rows.
- Basic stats (reduce)
  . avg
  . max
  . min
  . Frequency

- Map
  . cut (get specific columns)
  . alias (change column names)
- filter
  . filter rows based on specific conditions

## Sample usage
`tabstat -f “file_name” -e “filter ‘col1=something or col2=somethingelse’ | map ‘score’ | avg”`

The above command take a file with given file name and filter all values with given `col1/col2` value and takes the `score`
value for it and averages it.


## Usage

## Development

After checking out the repo, 
- Run `bin/setup` to install dependencies. 
- Then, run `rake test` to run the tests. 
- You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## To run the utility

```
 ruby lib/tabstat.rb -f "<file-name>" -d <delimiter> -e "<expression>"
```

## Parameters

| Parameter    | Purpose                                                     | Example                                                                    |
|--------------|-------------------------------------------------------------|----------------------------------------------------------------------------|
| -f or --file | File on which the utility will have to be executed.         | /Users/kannanr/Desktop/projects/7-languages-in-7-weeks/ruby/day3/biostats.csv |
| -e or --exp  | Expression containing operations to be executed on the file | `max col1`                                                                 |


## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/tabstat. This project is intended to be a
safe,
welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the tabstat project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the
[code of conduct](https://github.com/techconative/tabstat/blob/master/CODE_OF_CONDUCT.md).
