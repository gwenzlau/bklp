App.controller('DiscussionsCtrl', ['$scope', 'Discussion', function($scope, Discussion) {
    console.log("Discussion", arguments);
    var book_id = App.opts.book_id;
    $scope.discussions = Discussion.query({ book_id: book_id });
}]);
