App.controller('DiscussionsCtrl', ['$scope', '$http', 'Discussion', function($scope, $http, Discussion) {
    var book_id = App.opts.book_id;

    function updateDiscussions() {

    }

    $scope.discussions = Discussion.query({ book_id: book_id });
    $scope.discussion = new Discussion({ book_id: book_id });
    $scope.visibleDiscussion = null;
    $scope.newDiscussionForm = null;

    $scope.newDiscussion = function(discussion) {

        discussion.$save();

        // Reload the discussions view
        $scope.discussions = Discussion.query({ book_id: book_id });

        // Show the discussion
        $scope.showDiscussion(discussion);
    };

    $scope.showDiscussion = function(discussion, $event) {
        if ($event) $event.stopPropagation();

        $scope.newDiscussionForm = null;
        $scope.visibleDiscussion = discussion;
    };

    $scope.showDiscussionForm = function($event) {
        if ($event) $event.stopPropagation();

        $scope.visibleDiscussion = null;
        $scope.newDiscussionForm = true;
    };

    $scope.postComment = function($event, discussion) {
        var comment_url = "/api/book/"+ book_id +"/discussions/"+ discussion.id +"/commentaries";

        $http.post(comment_url, JSON.stringify({ commentary: { message: $scope.newCommentText } })).
          success(function(data, status, headers, config) {
            $scope.discussions = Discussion.query({ book_id: book_id });
            $scope.visibleDiscussion = Discussion.get({ book_id: book_id, id: discussion.id });
            $scope.newCommentText = "";
          }).
          error(function(data, status, headers, config) {
            alert("We had an error posting your comment, please try again");
          });
    };

}]);
