USER_1  = firstName : 'Marian',     lastName : 'Lumba',      organization : 'Netflix',    socialSecurityNumber : '2222222222'
USER_2  = firstName : 'Sansom',     lastName : 'Shawn',      organization : 'Google',     socialSecurityNumber : '2022222222'
USER_3  = firstName : 'Luis',       lastName : 'Mayorga',    organization : "McDonald's", socialSecurityNumber : '5122221222'
USER_4  = firstName : 'Cashias',    lastName : 'Otoya',      organization : 'Twitter',    socialSecurityNumber : '6232220222'
USER_5  = firstName : 'Joey',       lastName : 'Poindexter', organization : 'Github',     socialSecurityNumber : '7242222222'
USER_6  = firstName : 'Sylvester',  lastName : 'Livermore',  organization : 'Github',     socialSecurityNumber : '9282222222'
USER_7  = firstName : 'Julius',     lastName : 'Wiliams',    organization : 'Github',     socialSecurityNumber : '2202222222'
USER_8  = firstName : 'Lanister',   lastName : 'Mobaser',    organization : 'Netflix',    socialSecurityNumber : '4226222222'
USER_9  = firstName : 'Shay Shawy', lastName : 'Stokinov',   organization : 'Google',     socialSecurityNumber : '1228222222'
USER_10 = firstName : 'Brielle',    lastName : 'Hallester',  organization : 'Twitter',    socialSecurityNumber : '1922222222'

PEOPLE = [
  USER_1,
  USER_2,
  USER_3,
  USER_4,
  USER_5,
  USER_6,
  USER_7,
  USER_8,
  USER_9,
  USER_10
]

angular
.module 'person', []
.service 'person', ($q) ->
  find = (query, options) ->
    # simulate IQueryable<T> in .NET. by default you're working
    # against a query that represents ALL objects (select * from <table>).
    searchResults        = _(PEOPLE)
    socialSecurityFilter = new RegExp query.socialSecurityNumber

    deferred = $q.defer()

    result = ->
      if query.socialSecurityNumber
        # partial match (starts with/contains)
        searchResults =
          searchResults
          .filter (person) -> socialSecurityFilter.test(person.socialSecurityNumber)

      if query.organization
        # exact match
        searchResults = searchResults.where organization: query.organization

      deferred.resolve searchResults.value()

    simulateDelay = options and options.async

    delay = if simulateDelay then 1500 else 0

    setTimeout result, delay

    deferred.promise

  findRemote: (query) -> find query, async: true

  findLocal: (query) -> find query

  page: (people, number, count) ->
    skipCount = count * (number - 1)

    _(people).slice(skipCount).take(count).value()
