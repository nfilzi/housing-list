var urlHousingInput = document.querySelector('.js-housing-url-input')
urlHousingInput.addEventListener('paste', displayBookingInfoBox, false);

function displayBookingInfoBox() {
  var element = this;

  setTimeout(function () {
    submitButton = document.querySelector(".housing-creation .btn")
    if (submitButton.disabled == true) {
      submitButton.disabled = false
    }
    var newHousingUrl = element.value;
    var link = document.createElement('a');
    link.setAttribute('href', newHousingUrl);
    var urlHostname = link.hostname;

    var bookingNotice = document.querySelector(".booking-notice");

    if (urlHostname == 'www.booking.com') {
      bookingNotice.style.display = 'block';
    } else if (urlHostname == 'secure.booking.com'){
      bookingNotice.style.display = 'none';
    }
  }, 100);
}
