
function sendMessage()
{
  console.log( "Send message" );
}

// Starts messaging event listener
function startMessaging()
{
  $( document ).keydown(function (event)
  {
    if( event.which == 13 && messagingActive )
    {
      sendMessage();
      event.preventDefault();
      return false;
    }
  });
}

