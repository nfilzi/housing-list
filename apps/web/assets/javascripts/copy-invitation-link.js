(function() {
  'use strict';

  var tripInvitation = document.querySelector('.trip-invitation');

  if (tripInvitation) {
    var invitationIncentive = document.querySelector('.trip-invitation-incentive');
    invitationIncentive.addEventListener('click', openInvitationDetails);

    var invitationLink = document.querySelector('.copy-invitation-link');
    invitationLink.addEventListener('click', copyInvitationLink, true);
  }

  function openInvitationDetails(event) {
    event.preventDefault();

    var tripInvitationDetails = document.querySelector('.trip-invitation-details');

    event.currentTarget.style.display   = 'none';
    tripInvitationDetails.style.display = 'block';
  }

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
