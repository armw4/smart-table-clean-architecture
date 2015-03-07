angular
.module 'app',
[
  'ui.bootstrap',
  'templates',
  'ngRoute',
  'organization',
  'person',
  'pagination.demo',
  'smart-table',
  'angular.filter']
.config ($routeProvider) ->
  $routeProvider
  .when '/',
    templateUrl: 'templates/core/template.html'
    controller: 'PaginationCtrl'
    resolve:
      organizations: (organization) -> organization.get()
