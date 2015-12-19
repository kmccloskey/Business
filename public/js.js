$(document).ready(function() {
	$(".lightbox-image").click(function(){
		var url = $(this).data("img-link");
		$(".lightbox-inner").html("<img src='" + url + "' class='image'>");
		$(".lightbox-outer").removeClass("invis")
		// removes the class to show picture lightbox
	});
	// Adds the class invis which hides the lightbox
	$(".lightbox-outer").click(function(){
		$(".lightbox-outer").addClass("invis")
	});

});