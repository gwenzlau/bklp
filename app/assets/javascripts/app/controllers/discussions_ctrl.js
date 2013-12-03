App.controller('DiscussionsCtrl', ['$scope', 'Discussion', function($scope, Discussion) {
    var book_id = App.opts.book_id;

    $scope.discussions = Discussion.query({ book_id: book_id });
    $scope.discussion = new Discussion({ book_id: book_id });
    $scope.visibleDiscussion = null;
    $scope.newDiscussionForm = null;

    $scope.newDiscussion = function(discussion) {

        discussion.$save();

        // Reload the discussions view
        $scope.discussions = Discussion.query({ book_id: book_id });
    };

    $scope.showDiscussion = function(discussion, $event) {
        $event.stopPropagation();
        $scope.newDiscussionForm = null;
        $scope.visibleDiscussion = discussion;
    };

    $scope.showDiscussionForm = function($event) {
        $event.stopPropagation();
        $scope.visibleDiscussion = null;
        $scope.newDiscussionForm = true;
    };

}]);
