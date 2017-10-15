var pictureInput = document.querySelector(".js-picture-upload-input-with-preview");
pictureInput.addEventListener("change", displayBackgroundPicturePreview, true);

function displayBackgroundPicturePreview() {
  var fileList                    = this.files;
  var file                        = fileList[0];

  var displayPreviewTargetClass   = "." + this.dataset.target;
  var displayPreviewTargetElement = document.querySelector(displayPreviewTargetClass);

  var reader = new FileReader();
  reader.onloadend = function(){
    displayPreviewTargetElement.style.backgroundImage = "url(" + reader.result + ")";
  }
  if (file) {
    reader.readAsDataURL(file);
  }
}
