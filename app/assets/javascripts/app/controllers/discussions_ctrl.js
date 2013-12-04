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


    /*
     *  newDiscussion
     *
     *  Creates a discussion from form data
     */
    $scope.newDiscussion = function($event, discussion) {
        if ($event) $event.preventDefault();

        discussion.$save(function(discussion_obj) {
            $scope.discussions.push(discussion_obj);

            // Show the discussion
            $scope.showDiscussion(discussion_obj);

            // Reset the form
            $scope.discussion_form.$setPristine(true);
            $scope.discussion_form.quote = "";
            $scope.discussion_form.page = "";
            $scope.discussion_form.pages_total = "";
            $scope.discussion_form.message = "";
        });
    };


    /*
     *  showDiscussion
     *
     *  Shows a full discussion and comments
     */
    $scope.showDiscussion = function(discussion, $event) {
        if ($event) $event.stopPropagation();

        $scope.newDiscussionForm = null;
        $scope.visibleDiscussion = discussion;
    };


    /*
     *  showDiscussionForm
     *
     *  Shows a form to create a new discussion
     */
    $scope.showDiscussionForm = function($event) {
        if ($event) $event.stopPropagation();

        $scope.visibleDiscussion = null;
        $scope.newDiscussionForm = true;
    };


    /*
     *  postComment
     *
     *  Creates a comment from form data
     */
    $scope.postComment = function($event, discussion) {
        var new_comment_url = "/api/book/"+ book_id +"/discussions/"+ discussion.id +"/commentaries";

        if ($event) $event.preventDefault();

        $http.post(new_comment_url, JSON.stringify({ commentary: { message: $scope.newCommentText } })).
            success(function(data, status, headers, config) {
                // Add comment into the discussion
                discussion.comments.push(data.commentary);

                // Reset the form
                $scope.newCommentText = "";
                $scope.comment_form.$setPristine(true);
            }).
            error(function(data, status, headers, config) {
                alert("We had an error posting your comment, please try again");
            });
    };

}]);
