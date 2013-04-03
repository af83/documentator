# documentator

`documentator` has one primary goal: having better docs on our projects.

documentator provides two main features to achieve that goal:


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

`bootstrap` provides a minimal set of documentation files.
Those are empty, and they *must* be written for each project. The content is
specific to each project:

  * What's the architecture? (providing a [ditaa](http://ditaa.sourceforge.net/)
schema will  earn you some extra karma points)
  * Dependencies?
  * Environnements?

As a treat, `bootstrap` generates a Gemfile in `project/doc` which includes
[Guide'em up](https://github.com/nono/guide-em-up). Guide'em up can be used to
preview markdown file in a browser.


``` bash
bundle exec documentator bootstrap
```

### Importing templates

`import` provides templates for common documentation that should be the same
from one project to another. Installing ElasticSearch is basically always the
same. If there are projet specific particularities, you can always add them
here.

``` bash
bundle exec documentator list
```

A language can be specified to the `list` command.

``` bash
bundle exec documentator list fr
```

A language must be specified to the `import` command.

``` bash
bundle exec documentator import fr beasntalkd mongodb
```

## Contribution

YES. We want contributions.

* Adding a bootstrap's file is done by adding a file to
`lib/documentator/bootstrap`.
* Adding a templates's file is done by adding a file to
`lib/documentator/templates`.


## Copyright

MIT. See LICENSE for further details.
