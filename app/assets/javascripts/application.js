//= require jquery
//= require jquery_ujs
//= require backbone-rails
//= require handlebars.runtime
//= require websocket_rails/main
//= require draword.coffee
//= require_tree ./draword/models
//= require_tree ./draword/collections
//= require_tree ./templates
//= require_tree .

$(function () {
  new Draword.App();
});
