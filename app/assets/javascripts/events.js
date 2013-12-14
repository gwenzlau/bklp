$(document).ready( function() {

	// Switch between book menues
	function switchBookTabs(selector) {
		switch(selector) {
			case 'book-desc':
				$('#book-reviews, #book-suggestions, #book-discussions').hide();
				$('#'+selector+', #currently-reading').show();
				break;
			case 'book-reviews':
				$('#book-desc, #currently-reading, #book-suggestions, #book-discussions').hide();
				$('#'+selector).show();
				break;
			case 'book-suggestions':
				$('#book-desc, #currently-reading, #book-reviews, #book-discussions').hide();
				$('#'+selector).show();
				break;
			case 'book-discussions':
				$('#book-desc, #currently-reading, #book-suggestions, #book-reviews').hide();
				$('#'+selector).show();
				break;
		}
	}

	$('#book-nav ul li a').click( function() {
		var selector = $(this).attr('for');
		switchBookTabs(selector);
		$('#book-nav ul li a').removeClass('active');
		$(this).addClass('active');
	});

	// post review
	$('#post-review').click( function() {
		var body = $('#review_body').val();
		var book_id = $('#book_id').val(); 
		var user_id = $('#user_id').val();
		var d = {'review[body]': body, 'review[book_id]': book_id, 'review[user_id]': user_id}
		$.post('/reviews', d, function(data) {
			if(data[0].status == 'success') {
				$('#modal-comment-content').hide();
				$('#modal-comment-success').show();
			}
		});
	});

});