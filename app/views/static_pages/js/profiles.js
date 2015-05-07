
function getProfile()
{
  $.ajax( url + "me", 
  {
    type: "GET",
    dataType: "json",
    accepts: { text: "application/json" },
    statusCode: 
    {
      200: function( response )
      {
        if( response.user.user_type == "student" )
        {
          showStudentHome();
        }
        else
        {
          showTutorHome();
        }
      },
      401: function( response )
      {
        registerOrLogin();
      },
    }
  });
}

function logout()
{
  $.ajax( url + "sessions",
  {
    type: "DELETE",
    dataType: "json",
    accepts: { text: "application/json" },
    statusCode:
    {
      200: function( response )
      {
        console.log( response );
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
  if( currentPageDiv )
  {
    $( currentPageDiv ).hide();
  }

  $( loginPageDiv ).show(); 
  currentPageDiv = loginPageDiv;

  console.log( currentPageDiv );
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
    accepts: { text: "application/json" },
    contentType: "application/json",
    data: JSON.stringify( data ),
    dataType: "json", 
    accepts: { text: "application/json" },
    statusCode: {
      200: function( response ) 
      {
        getProfile();
      },
      401: function( response ) 
      {
        $( "input[name='logPassword']" ).addClass( "error" );
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
    return;
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
    type: "POST",
    contentType: "application/json",
    data: JSON.stringify( data ),
    dataType: "json", 
    accepts: { text: "application/json" },
    statusCode: {
      200: function( response ) 
      {
        if( data.user_type == "student" )
        {
          showStudentHome();
        }
        else
        {
          showTutorHome();
        }
      },
      422: function( response )
      {
        $( "input[name='regEmail']" ).addClass( "error" );
      }
    }
  });
}

