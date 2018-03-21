var pictureInput = document.querySelector(".js-picture-upload-input-with-preview");
pictureInput.addEventListener("change", pictureUploadPreview, true);

function pictureUploadPreview() {
  var fileList                    = this.files;
  var file                        = fileList[0];

  var displayPreviewTargetClass   = "." + this.dataset.target;
  var displayPreviewTargetElement = document.querySelector(displayPreviewTargetClass);

  var reader = new FileReader();
  reader.onloadend = function(){
    displayPreviewTargetElement.classList.add('picture-upload-preview');
    displayPreviewTargetElement.style.backgroundImage = "url(" + reader.result + ")";
  }

  if (file) {
    reader.readAsDataURL(file);
  }
}
