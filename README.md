# Decidim::Iframe

This module is a separated feature from the Decidim Awesome -module
(https://github.com/decidim-ice/decidim-module-decidim_awesome), made into its
own module.

#### Fullscreen Iframe component

Another simple component that can be used to embed an Iframe with any external content in it that fills all the viewport.

![Fullscreen iframe](examples/fullscreen-iframe.png)

## Installation

Add this line to your application's Gemfile:

```ruby
gem "decidim-iframe", git: "git@github.com:mainio/decidim-module-iframe.git"
```

And then execute:

```bash
$ bundle install
```

## Usage

This module enables creation of a new component which allows embedding a fullscreen Iframe -element to the page.
You also have a possibility to make the size of the Iframe -element responsive to the page size or make it static with
manually set height and width attributes.
