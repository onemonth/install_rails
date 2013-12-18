// $('#license').mouseover(function() {
//   $(this)
// })
("#license").mouseover(function() {
    $("#hidden_div").css("visibility: show;");
})(this).mouseout(function() {
    $("#hidden_div").css("visibility: hidden;");
});