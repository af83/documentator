# documentator

documentator has one primary goal: having better docs on our projects.

documentator provides two main features to achieve that goal:


### Bootstrap

`bootstrap` provides a minimal set of documentation's file.
Those are empty, and they *must* be written for each project. This is specific
to each project:

  * What's the architecture (providing a [ditaa](http://ditaa.sourceforge.net/)
  schema will make you earns some karma points)?
  * Dependencies?
  * Environnements?


As a treat, `bootstrap` generates a Gemfile in `project/doc` which include
[Guide'em up](https://github.com/nono/guide-em-up). Guide'em up can be used to
preview markdown file in a browser.

### Import

`import` provides some templates of common documentation that should be the same
from one project to another. And yet, we write them on each project. I mean,
installing ElasticSearch is always the same.

## Installation

With bundler, add it to your `Gemfile`:

``` ruby
group :development do
  gem "documentator", git: "git@github.com:AF83/documentator.git"
end
```

## Usage

Commands should be used from the root directory of the current project.

### Bootstrap

``` bash
bundle exec documentator bootstrap
```

### Importing templates

``` bash
bundle exec documentator list
```

``` bash
bundle exec documentator import nginx
```

## Contribution

YES. We want contributions.

* Adding a bootstrap's file is done by adding a file to
`lib/documentator/bootstrap`.
* Adding a templates's file is done by adding a file to
`lib/documentator/templates`.


## Copyright

MIT. See LICENSE for further details.
