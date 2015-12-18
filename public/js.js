$(document).ready(function() {
	$(".lightbox-image").click(function(){
		var url = $(this).data("img-link");
		$(".lightbox-inner").html("<img src='" + url + "' class='image'>");
		$(".lightbox-outer").removeClass("invis")
	});
	$(".lightbox-outer").click(function(){
		$(".lightbox-outer").addClass("invis")
	});

});