﻿angular.module('article-detail',['resource.articles'])

.config(["$routeProvider", ($routeProvider) ->
  $routeProvider
    .when "/post/:url",
      templateUrl: "/app/article/detail/article-detail.tpl.html"
      controller: 'ArticleDetailCtrl'
      resolve:
        article: ['$route','$q','Articles',($route,$q,Articles)->
          deferred = $q.defer()
          Articles.query
            url: $route.current.params.url
          , (data) ->
            deferred.resolve(data[0])
          deferred.promise
        ]
])

.controller('ArticleDetailCtrl',
["$scope","$window", "$translate", "$route", "article", "Articles", "context", "progressbar"
($scope, $window, $translate, $route, article, Articles, context, progressbar) ->
  $window.scroll(0,0)

  $scope.item = article

  codeformat()#格式化代码

  #初始化新评论
  $scope.entity=
    author :
      name : context.account.name
      email : context.account.email
  $scope.editmode = !context.account.name
  $scope.isAdmin = context.auth.admin

  #提交评论
  $scope.save = ->
    $scope.submitted=true
    if $scope.form.$invalid
      return

    progressbar.start()
    $scope.loading = $translate("global.post")
    $scope.entity.id = $scope.item._id
    Articles.addComment $scope.entity
    , (data)->
      $scope.item.comments.push(data)
      $scope.entity.content = ""
      progressbar.complete()
      $scope.submitted=false
      $scope.loading = ""
      context.account =
        name: $scope.entity.author.name
        email: $scope.entity.author.email
        url: $scope.entity.url
    ,(error)->
      progressbar.complete()
      $scope.submitted=false
      $scope.loading = ""

  #浏览量+1
  #Article.browsed id:"(guid'#{$scope.item.PostId}')"

  $scope.edit = (item) ->
    $window.location.href="/admin/article/#{item._id}"
])