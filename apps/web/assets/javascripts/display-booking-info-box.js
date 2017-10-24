function displayInfoBox() {
  var element = this;

  setTimeout(function () {
    var newHousingUrl = element.value;

    // Create a link out of the value
    var link = document.createElement('a');
    link.setAttribute('href', newHousingUrl);
    var urlHostname = link.hostname;

    var supportedProvidersRegexp   = /^(www|secure)\.(airbnb|booking)\.[a-z]+/;

    // Get all the notices
    var notSupportedProviderNotice = document.querySelector(".not-supported-provider-notice");
    var bookingNotice              = document.querySelector(".booking-notice");

    // Hide them
    notSupportedProviderNotice.style.display = 'none';
    bookingNotice.style.display = 'none';

    if (newHousingUrl != '' && urlHostname.match(supportedProvidersRegexp) == null) {
      notSupportedProviderNotice.style.display = 'block';
    }
    else if (urlHostname == 'www.booking.com') {
      bookingNotice.style.display = 'block';
    }
  }, 100);
}

var urlHousingInput = document.querySelector('.js-housing-url-input');

urlHousingInput.addEventListener('keyup', displayInfoBox, false);
urlHousingInput.addEventListener('paste', displayInfoBox, false);
