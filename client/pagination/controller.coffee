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

ITEMS_PER_PAGE = 2

angular
.module 'pagination.demo', []
.controller 'PaginationCtrl', ($scope, person) ->
  allPeople           = null
  defaultOrganization = ORGANIZATIONS[0]

  $scope.organization  = defaultOrganization
  $scope.organizations = ORGANIZATIONS

  person
  .findRemote organization: defaultOrganization.name
  .then (people) ->
    allPeople = people

    $scope.totalItems = allPeople.length
    $scope.people     = _(allPeople).take(ITEMS_PER_PAGE).value()

  $scope.itemsPerPage = ITEMS_PER_PAGE
  $scope.maxSize      = 5

  # client side filter
  $scope.pageChange = ->
    # pagination always works against original/cached result set (ALl individuals from previous query)
    $scope.people = person.page(allPeople, $scope.currentPage, ITEMS_PER_PAGE)

  # client side or remote filter depending on if user is searching against SSN in addition to organization
  $scope.organizationChange = ->
    # typically we'd render masked SSN to client and hit server to perform search against full SSN
    remoteQueryDueToSensitiveInfo = $scope.socialSecurityNumber

    query = organization: $scope.organization.name, socialSecurityNumber: $scope.socialSecurityNumber

    request = if remoteQueryDueToSensitiveInfo then person.findRemote else person.findLocal

    request(query)
    .then (people) ->
      allPeople = people

      $scope.currentPage = 1
      $scope.totalItems  = allPeople.length
      $scope.people      = _(people).take(ITEMS_PER_PAGE).value()
