//global array of variables to make them available to both jQuery and Processing
var uivars = {
	numShapes: 20,
	minW: 2,
	maxW: 300,
	minH: 2,
	maxH: 300,
	minA: 200,
	maxA: 255,
	drawBlackLines: false
};

function downloadCanvas() {

//save image
	var image = document.getElementsByTagName("canvas")[0].toDataURL();
	window.open(image);
	console.log (image);	

};

//initiate jQueryUI elements
$(document).ready(function() {

	//Generate button
    $('#generate').button().click(function( event ) {

		var p = Processing.getInstanceById('mycanvas');

		p.clearShapes();
		p.populateShapes();
		p.drawShapes();
		
		$('#mycanvas').hide();
		$('#mycanvas').fadeIn(200);

	});

	$('#downloadCanvas').button();
	  
    //Controls
	$('#numShapes .slider').slider({
		value: 20,
		min: 2,
		step: 1,
		max: 300,
		slide: function( event, ui ) {
			$('#numShapes span').html(ui.value);
			uivars.numShapes = ui.value;
			
		}
	});
	
	$('#widthShapes .slider').slider({
		range: true,
		values: [2, 300],
		min: 2,
		step: 1,
		max: 300,
		slide: function( event, ui ) {
			$('#widthShapes span.min').html(ui.values[0]);
			$('#widthShapes span.max').html(ui.values[1]);
			uivars.minW = ui.values[0];
			uivars.maxW = ui.values[1];
		}
	});

	$('#heightShapes .slider').slider({
		range: true,
		values: [2, 300],
		min: 2,
		step: 1,
		max: 300,
		slide: function( event, ui ) {
			$('#heightShapes span.min').html(ui.values[0]);
			$('#heightShapes span.max').html(ui.values[1]);
			uivars.minH = ui.values[0];
			uivars.maxH = ui.values[1];
		}
	});
	
	$('#opacityShapes .slider').slider({
		range: true,
		values: [200, 255],
		min: 1,
		max: 255,
		step: 1,
		slide: function( event, ui ) {
			$('#opacityShapes span.min').html(ui.values[0]);
			$('#opacityShapes span.max').html(ui.values[1]);
			uivars.minA = ui.values[0];
			uivars.maxA = ui.values[1];
		}
	});

	//scale controls on document load
	scaleControls();

});

//scale controls on window resize
$(window).resize(function(){
	scaleControls();
});

function scaleControls() {
	
	$('#controls').width( $(window).width() - $('#frame').width() - 40 - 40 - 2 + "px" );

}