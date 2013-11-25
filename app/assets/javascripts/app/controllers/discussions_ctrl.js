App.controller('DiscussionsCtrl', ['$scope', 'Discussion', function($scope, Discussion) {
    var book_id = App.opts.book_id;

    $scope.discussions = Discussion.query({ book_id: book_id });
    $scope.discussion = new Discussion({ book_id: book_id });

    $scope.newDiscussion = function(discussion) {

        discussion.$save();

        // Reload the discussions view
        $scope.discussions = Discussion.query({ book_id: book_id });
    }

}]);
