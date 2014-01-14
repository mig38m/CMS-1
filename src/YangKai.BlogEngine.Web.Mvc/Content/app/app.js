﻿
angular.module("app", ['ngRoute', 'ngSanitize', 'ngAnimate', 'ngCookies', 'l18n', 'formatFilters', 'index', 'article', 'board', 'about', 'issue', 'gallery', 'main.controllers', 'AccountServices', 'customDirectives', 'pasvaz.bindonce', 'ngProgress', 'ui.utils', 'ui.bootstrap', 'pascalprecht.translate', 'angulartics', 'angulartics.google.analytics']).config([
  "$locationProvider", function($locationProvider) {
    return $locationProvider.html5Mode(true);
  }
]).config([
  "$httpProvider", function($httpProvider) {
    return $httpProvider.responseInterceptors.push(interceptor);
  }
]).config([
  "$routeProvider", function($routeProvider) {
    return $routeProvider.otherwise({
      redirectTo: "/"
    });
  }
]).config([
  "$translateProvider", function($translateProvider) {
    $translateProvider.preferredLanguage('zh');
    return $translateProvider.useLocalStorage();
  }
]).run([
  "$location", "$rootScope", function($location, $rootScope) {
    return $rootScope.$on("$routeChangeSuccess", function(event, current, previous) {
      var _ref;
      return $rootScope.title = (_ref = current.$$route.title) != null ? _ref : '';
    });
  }
]);
