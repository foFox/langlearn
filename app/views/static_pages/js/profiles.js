
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
  $( loginPageDiv ).show(); 
}

function login()
{
  var email = $( "input[name='logEmail']" ).val();
  var password = $( "input[name='logPassword']" ).val();

  var data = {
    "email_address" : email,
    "password" : password
  };

  $.ajax( url + "sessions",
  {
    type: "POST",
    contentType: "application/json",
    data: JSON.stringify( data ),
    dataType: "json", statusCode: {
      200: function( response ) 
      {
        console.log( response );
      }
    }
  });
}

function register()
{
  var email = $( "input[name='regEmail']" ).val();
  var first = $( "input[name='regName']" ).val();
  var last = $( "input[name='regSurname']" ).val();
  var password = $( "input[name='regPassword1']" ).val();
  var password_match = $( "input[name='regPassword2'" ).val();
  var userStatus = $( "input:radio[name='role']:checked" ).val();

  if( password != password_match )
  {
    $( "input[name='regPassword1']" ).addClass( "error" );
    $( "input[name='regPassword2']" ).addClass( "error" );
  }

  var data = {
    "name" : first,
    "surname" : last,
    "password" : password,
    "user_type" : userStatus,
    "email_address" : email
  }

  $.ajax( url + "users",
  {
    type: "PUT",
    contentType: "application/json",
    data: JSON.stringify( data ),
    dataType: "json", statusCode: {
      200: function( response ) 
      {
        console.log( response );
      },
      422: function( response )
      {
        $( "input[name='regEmail']" ).addClass( "error" );
      }
    }
  });
}

