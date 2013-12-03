/*
 *  Discussions Controller
 *
 *  Handles creating, viewing and posting comments on discussions.
 */
App.controller('DiscussionsCtrl', ['$scope', '$http', 'Discussion', function($scope, $http, Discussion) {
    var book_id = App.opts.book_id;

    // Lookup all discussions from the API
    $scope.discussions = Discussion.query({ book_id: book_id });

    // Create a new discussion for the discussion form
    $scope.discussion = new Discussion({ book_id: book_id });

    // Keep these empty for now so that neither the
    // show discussion view or form show up
    $scope.visibleDiscussion = null;
    $scope.newDiscussionForm = null;


    $scope.newDiscussion = function($event, discussion) {
        if ($event) $event.preventDefault();

        discussion.$save();

        // Reload the discussions view
        $scope.discussions = Discussion.query({ book_id: book_id });

        // Show the discussion
        $scope.showDiscussion(discussion);

        $scope.discussion_form.$setPristine(true);
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

        if ($event) $event.preventDefault();

        $http.post(comment_url, JSON.stringify({ commentary: { message: $scope.newCommentText } })).
          success(function(data, status, headers, config) {
            $scope.discussions = Discussion.query({ book_id: book_id });
            $scope.visibleDiscussion = Discussion.get({ book_id: book_id, id: discussion.id });
            $scope.newCommentText = "";

            $scope.comment_form.$setPristine(true);
          }).
          error(function(data, status, headers, config) {
            alert("We had an error posting your comment, please try again");
          });
    };

}]);
