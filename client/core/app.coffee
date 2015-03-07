angular
.module 'app',
[
  'ui.bootstrap',
  'templates',
  'ngRoute',
  'organization',
  'person',
  'index',
  'smart-table',
  'angular.filter']
.config ($routeProvider) ->
  $routeProvider
  .when '/',
    templateUrl: 'templates/core/template.html'
    controller: 'IndexCtrl'
    resolve:
      index: (organization, person) ->
        organization
        .get()
        .then (organizations) ->
          firstOrganization = organizations[0]

          person
          .findRemote organization : firstOrganization.name
          .then (people) -> organizations: organizations, people: people
