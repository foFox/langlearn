
// Call API to retrieve list of available languages
function getLanguageList( callback )
{
  $.ajax( url + "languages",
  {
    type: "GET",
    dataType: "json",
    accepts: { text: "application/json" },
    statusCode:
    {
      200: function( response )
      { 
        languageList = response.languages;
        for( var i = 0; i < languageList.length; i++ )
        {
          var language = response.languages[i];
          languageLookup[ language.id ] = language.name;
        }
        callback();
      },
      401: function( response )
      {
        registerOrLogin();
      },
    }
  });
}

// Callback chainer to retrieve tutors for all languages
function getAllTutors( languageList, finalCallback )
{
  if( languageList.length ){
    getLanguageTutors( languageList.shift(), function()
    {
      getAllTutors( languageList, finalCallback );
    });
  }
  else
  {
    console.log( tutorLookup );
    finalCallback();
  }
}

// Call API to retrieve tutors of a specific language
function getLanguageTutors( language, callback )
{
  $.ajax( url + "languages/" + language.id + "/users",
  {
    type: "GET",
    dataType: "json",
    accepts: { text: "application/json" },
    statusCode:
    {
      200: function( response )
      {
        var users = response.users;

        // Add tutor to our master list
        for( var i = 0; i < users.length; i++ )
        {
          if( users[i].id in tutorLookup )
          {
            tutorLookup[ users[i].id ].languages.push( language );
          }
          else
          {
            tutorLookup[ users[i].id ] = {};
            tutorLookup[ users[i].id ].email = users[i].email_address;
            tutorLookup[ users[i].id ].languages = [];
            tutorLookup[ users[i].id ].languages.push( language );
          }
        }
        callback();
      },
      401: function( response )
      {
        registerOrLogin();
      },
    }
  });
}

