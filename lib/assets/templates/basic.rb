# >---------------------------------[ Initial Setup ]----------------------------------<

run "bundle update"

# >---------------------------------[ Git ]----------------------------------<

git :init
git add: '.'
git commit: "-aqm 'Initial commit'"

# >---------------------------------[ Git ]----------------------------------<

## GEMFILE
run "rm Gemfile"
file "Gemfile"
add_source "https://rubygems.org"

# ## Ruby
# insert_into_file 'Gemfile', "ruby '2.0.0'\n", after: "source 'https://rubygems.org'"

## Rails
gem 'rails'

gem_group :develoment do
  gem 'sqlite3'
end

gem_group :production do
  gem 'rails_12factor'
  gem 'pg'
end
gem 'sass-rails'
gem 'uglifier'
gem 'coffee-rails'
gem 'jquery-rails'
gem 'turbolinks'
gem 'jbuilder'
gem 'bootstrap-sass', '~> 2.3.2.0'
gem 'devise', '3.0.0.rc'
gem 'simple_form', '3.0.0.rc'
run "bundle install --without production"

# Add bootstrap CSS and JS

inject_into_file "app/assets/javascripts/application.js", "//= require bootstrap\n", before: "//= require_tree ."

file 'app/assets/stylesheets/bootstrap_and_overrides.css.scss', <<-CODE
@import "bootstrap";
body {
  padding-top: 60px;
}
@import "bootstrap/responsive";
.center {
  text-align: center;
}
CODE

# Generate home and about page
generate(:controller, "Pages home about")
route "root to: 'pages#home'"
route "get 'about', to: 'pages#about'"
run "rm app/views/pages/home.html.erb"
file 'app/views/pages/home.html.erb', <<-CODE
<% unless user_signed_in? %>
  <div class="hero-unit">
    <h1>Welcome to One Month Rails!</h1>
    <p>
      You've found the home page for the
      <%= link_to "One Month Rails", "http://onemonthrails.com" %>
      application.
    </p>
    <p>
      <%= link_to "Sign Up Now!", new_user_registration_path, class: "btn btn-primary btn-large" %>
    </p>
  </div>
<% end %>
CODE

run "rm app/views/pages/about.html.erb"
file 'app/views/pages/about.html.erb', <<-CODE
<h1>About Us</h1>
<p>This is what we're about.</p>
CODE

# Create the application layout
run "rm app/views/layouts/application.html.erb"
file 'app/views/layouts/application.html.erb', <<-CODE
  <!DOCTYPE html>
  <html>
    <head>
      <title>#{@app_name.humanize}</title>
      <%= stylesheet_link_tag    "application", :media => "all", "data-turbolinks-track" => true %>
      <%= javascript_include_tag "application" %>
      <%= csrf_meta_tags %>
    </head>
    <body>
      <%= render 'layouts/header' %>

      <div class="container">
        <% flash.each do |name, msg| %>
          <%= content_tag(:div, msg, class: "alert alert-\#{name}") %>
        <% end %>
        <%= yield %>
        <%= render 'layouts/footer' %>
      </div>

    </body>
  </html>
CODE

# Create the header
file 'app/views/layouts/_header.html.erb', <<-CODE
<div class="navbar navbar-fixed-top navbar-inverse">
  <div class="navbar-inner">
    <div class="container">

      <!-- .btn-navbar is used as the toggle for collapsed navbar content -->
      <a class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
      </a>

      <%= link_to "#{@app_name.humanize}", root_path, class: "brand" %>

      <!-- Everything you want hidden at 940px or less, place within here -->
      <ul class="nav navbar-nav pull-right">
        <li><%= link_to "About Us", about_path %></li>
        <% if user_signed_in? %>
          <li><%= link_to "Edit Profile", edit_user_registration_path %></li>
          <li><%= link_to "Logout", destroy_user_session_path, method: :delete %></li>
        <% else %>
          <li><%= link_to "Login", new_user_session_path %></li>
        <% end %>
      </ul>
    </div>
  </div>
</div>
CODE

# Create the footer
file 'app/views/layouts/_footer.html.erb', <<-CODE
  <div class="footer">
    <small>
      Build your own site with <%= link_to "One Month Rails", "http://onemonthrails.com" %>
    </small>
  </div>
CODE

# Set up Simple Form
generate("simple_form:install", "--bootstrap")

# Set up Devise

application "\# Required for Devise on Heroku"
application "config.assets.initialize_on_precompile = false"

run "bundle exec rails generate devise:install"
run "bundle exec rails generate devise User"
run "rake db:migrate"

file "app/views/devise/registrations/new.html.erb", <<-CODE
<h2>Sign up</h2>

<%= simple_form_for(resource, :as => resource_name, :url => registration_path(resource_name), html: { class: 'form-horizontal'}) do |f| %>
  <%= f.error_notification %>

  <%= f.input :name %>
  <%= f.input :email %>
  <%= f.input :password %>

  <div class="form-actions">
    <%= f.submit "Sign up", class: "btn btn-primary" %>
  </div>
<% end %>

<%= render "devise/shared/links" %>

CODE

file "app/views/devise/registrations/edit.html.erb", <<-CODE
<h2>Sign up</h2>

<%= simple_form_for(resource, :as => resource_name, :url => registration_path(resource_name), html: { class: 'form-horizontal'}) do |f| %>
  <%= f.error_notification %>

  <%= f.input :name %>
  <%= f.input :email %>
  <%= f.input :password %>

  <div class="form-actions">
    <%= f.submit "Sign up", class: "btn btn-primary" %>
  </div>
<% end %>

<%= render "devise/shared/links" %>

CODE

# Customize Devise

generate(:migration, "AddNameToUsers", "name:string")
rake "db:migrate"

inject_into_file "app/models/user.rb", ":name, ", after: "attr_accessible "

# Create a seed user

append_file "db/seeds.rb" do <<-CODE
User.create(name: "Example User", email: "user@example.com", password: "foobar", password_confirmation: "foobar")
CODE
end

rake "db:seed"
