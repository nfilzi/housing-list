var urlHousingInput = document.querySelector('.js-housing-url-input')
urlHousingInput.addEventListener('paste', displayBookingInfoBox, false);

function displayBookingInfoBox() {
  var element = this;

  setTimeout(function () {
    var newHousingUrl = element.value;
    var link = document.createElement('a');
    link.setAttribute('href', newHousingUrl);
    var urlHostname = link.hostname;

    if (urlHostname == 'www.booking.com') {
      var bookingNotice = document.querySelector(".booking-notice");
      bookingNotice.style.display = 'block';
    }
  }, 100);
}
