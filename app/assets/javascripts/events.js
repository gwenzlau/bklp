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

});