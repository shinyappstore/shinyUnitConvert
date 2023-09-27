var trackclickedbutton = null;
$(document).on('shiny:connected', function(event) {
  $(".panel-content .btn").click(function(e){
    console.log(trackclickedbutton)
    if(trackclickedbutton!=null)
    trackclickedbutton.target.style = ""
    trackclickedbutton = e
    trackclickedbutton.target.style = "background-color:blue;color:white"
  })
});

