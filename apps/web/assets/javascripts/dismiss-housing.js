(function() {

  'use strict';

  // click event
  var dismissLinks = document.querySelectorAll('.js-housing-dismiss-link');

  dismissLinks.forEach(function(dismissLink) {
    dismissLink.addEventListener('click', function(event) {
      event.preventDefault();

      // Get dismiss form and submit it
      var dismissForm = document.getElementById(this.dataset.target);
      dismissForm.submit();
    });
  });
})();
