# middleman-angular-templates

A basic middleman extension that precompiles your Angular.js templates. Stop making server requests to fetch your HTML!

## Installation

Add to your `Gemfile`:

    gem 'middleman-angular-templates', git: 'git@github.com:damrbaby/middleman-angular-templates.git'

And to `config.rb`:

    activate :angular_templates

## Usage

This gives you access to the helper method `angular_include_templates` which will pre-compile all of your `html` templates inside `<script type="text/ng-template">` tags ([docs](http://docs.angularjs.org/api/ng.directive:script)).

Conditions for pre-compilation:

  1. Restricted to partials only
  2. Partial must have one of the following extensions: `html` `erb` `slim` or `haml`

## Example
The following `source/index.html.erb`:

    <body>
      <%= angular_include_templates %>
    </body>

With the following directory structure:

    source/index.html.erb
    source/_login.erb
    source/dashboard/_home.erb

Will compile to the following:

    <body>
      <script type="text/ng-template" id="login.html">
	<h1>My login page</h1>
      </script>

      <script type="text/ng-template" id="dashboard/home.html">
	<h1>My home page</h1>
      </script>
    </body>

Then you can have routes such as:

    $routeProvider.when('/login', { templateUrl: 'login.html' })
    $routeProvider.when('/dashboard', { templateUrl: 'dashboard/home.html' })

Also works with `ng-include`:

    <div ng-include="'login.html'"></div>
    <div ng-include="'dashboard/home.html'"></div>

## Advanced
You can also specify a custom base path for your template partials:

    <% if mobile %>
      <%= angular_include_templates "mobile" %>
    <% else %>
      <%= angular_include_templates "desktop" %>
    <% end %>

