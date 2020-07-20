
    // Add active class to the current button (highlight it)
    var header = document.getElementById("myDIV");
    var btns = header.getElementsByClassName("btn");
    for (var i = 0; i < btns.length; i++) {
        btns[i].addEventListener("click", function() {
        var current = document.getElementsByClassName("active");
        current[0].className = current[0].className.replace(" active", "");
        this.className += " active";
        });
    }
      
       
    //Password Change

    // Get the modal
    var modal = document.getElementById("pass");
    // Get the button that opens the modal
    var btn = document.getElementById("passbtn");
    // Get the <span> element that closes the modal
    var span = document.getElementsByClassName("close")[0];
    // When the user clicks the button, open the modal 
    btn.onclick = function() {
        modal.style.display = "block";
    }
    // When the user clicks on <span> (x), close the modal
    span.onclick = function() {
        modal.style.display = "none";
    }
    // When the user clicks anywhere outside of the modal, close it
    window.onclick = function(event) {
        if (event.target == modal) {
        modal.style.display = "none";
        }
    }
   
    
    //Profile img
    var modal1 = document.getElementById("profi");
    var btn1 = document.getElementById("probtn");
    var span1 = document.getElementsByClassName("close1")[0];
    
    btn1.onclick = function(){
        modal1.style.display = "block";
    }
    span1.onclick = function(){
        modal1.style.display = "none";
    }
    window.onclick = function(event1) {
        if (event1.target == modal1) {
        modal1.style.display = "none";
        }
    }

    
    //Cover img
    var modal2 = document.getElementById("cover_img");
    var btn2 = document.getElementById("coverbtn");
    var span2 = document.getElementsByClassName("close2")[0];

    btn2.onclick = function(){
        modal2.style.display = "block";
    }
    span2.onclick = function(){
        modal2.style.display = "none";
    }
    window.onclick = function(event2){
        if (event2.target == modal2){
            modal2.style.display = "none";
        }
    }


    