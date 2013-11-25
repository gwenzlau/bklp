App.factory('Discussion', ['$resource', function($resource) {

    return $resource('/api/book/:book_id/discussions/:id', { book_id: '@book_id', id: '@id' });

}]);
