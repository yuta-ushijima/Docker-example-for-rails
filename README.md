# TaskLeaf How to setup

### Ruby version
`ruby 2.6.0`

### System dependencies
```bash
$ bundle install --jobs=4 --path vendor/bundle
```

### Database creation
```bash
$ bin/rails db:setup
```

### How to run the test suite
```bash
bundle exec rspec
```
