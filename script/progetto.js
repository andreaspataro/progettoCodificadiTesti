function gestoreEvidenzia(riga){
    console.log(riga);
    var a = document.getElementsByClassName("selected");
    if (a.length > 0) {
        a[0].classList.remove("selected");
    }
    document.getElementById("#" + riga).classList.add("selected");
}