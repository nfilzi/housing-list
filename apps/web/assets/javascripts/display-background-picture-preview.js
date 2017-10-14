var backgroundPictureInput = document.getElementById("trip-background-picture");
backgroundPictureInput.addEventListener("change", displayBackgroundPicturePreview, true);

function displayBackgroundPicturePreview() {
  var fileList  = this.files;
  var file      = fileList[0];
  var banner    = document.querySelector(".banner");

  var reader = new FileReader();
  reader.onloadend = function(){
    banner.style.backgroundImage = "url(" + reader.result + ")";
  }
  if (file) {
    reader.readAsDataURL(file);
  }
}
