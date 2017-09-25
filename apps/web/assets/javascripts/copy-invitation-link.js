(function() {

  'use strict';

  // click event
  var element = document.querySelector('.copy-invitation-link')
  element.addEventListener('click', copyInvitationLink, true);

  // event handler
  function copyInvitationLink(event) {
    event.preventDefault();

    // find target element
    var
      target     = event.target,
      copyTarget = target.dataset.copytarget,
      input      = (copyTarget ? document.querySelector(copyTarget) : null);

    // is element selectable?
    if (input && input.select) {
      // select text
      input.select();

      try {
        // copy text
        document.execCommand('copy');
        input.blur();

        // notice
        var notice = document.querySelector('.trip-invitation-notice');

        notice.innerText     = 'URL copied!';
        notice.style.display = 'block';

        setTimeout(function () {
          notice.style.display = 'none';
        }, 2000)
      }
      catch (err) {
        alert('Please press Ctrl/Cmd+C to copy');
      }
    }
  }
})();
