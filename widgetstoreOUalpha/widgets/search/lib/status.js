//#########################################
//footer status method
//#########################################

function setStatus(status) {
        //display status
        $("#ltfll_footer").html("<span>" + status + "</span>");
        //wait 1.5 sec and fade status to invisibility (in 3 sec)
        $("#ltfll_footer span").delay(1500).fadeTo(3000, 0);
}

function delStatus() {
	$("#ltfll_footer span").remove();
}
