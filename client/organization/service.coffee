ORGANIZATION_1 = name : "McDonald's"
ORGANIZATION_2 = name : 'Twitter'
ORGANIZATION_3 = name : 'Google'
ORGANIZATION_4 = name : 'Github'
ORGANIZATION_5 = name : 'Netflix'

ORGANIZATIONS = [
  ORGANIZATION_1,
  ORGANIZATION_2,
  ORGANIZATION_3,
  ORGANIZATION_4,
  ORGANIZATION_5
]

angular
.module 'organization', []
.service 'organization', ($q) ->
  get: ->
    deferred = $q.defer()

    deferred.resolve ORGANIZATIONS

    deferred.promise
