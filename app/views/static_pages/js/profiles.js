
function getProfile()
{
  $.ajax( url + "me", 
  {
    type: "GET",
    statusCode: 
    {
      200: function( response )
      {
        conversationView();
      },
      401: function( response )
      {
        registerOrLogin();
      },
    }
  });
}

function registerOrLogin()
{
  loginPage.show(); 
}

