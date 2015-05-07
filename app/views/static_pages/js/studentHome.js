
function showTutorList()
{
  for( var tutorID in tutorLookup )
  {
    var tutor = tutorLookup[ tutorID ];
    var divID = "tutor" + tutorID;
    var listDivID = "languageList" + tutorID;

    $( tutorListDiv ).append( "<div class='tutor' id='" + divID + "'>" + tutor.email + "<div id='" + listDivID + "' class='languageList'></div></div>" );

    for( var i = 0; i < tutor.languages.length; i++ )
    {
      var language = tutor.languages[i];

      var langDivID = divID + "_language" + language.id;

      $( "#" + listDivID ).append( "<div class='language' id='" + langDivID + "'>" + language.name + "</div>" );

      // Start event listener as well for each language/tutor combination
      ( function( _tutorID, _languageID ) 
      {
        $( "#tutor" + _tutorID + "_language" + _languageID ).on( "click", function()
        {
          startConversation( _tutorID, _languageID, languageLookup[ _languageID ] );
          console.log( "Starting conversation with tutor " + _tutorID, "Language: " + languageLookup[ _languageID ] );
        });
      })( tutorID, language.id );
    }
  }
}

function showStudentHome()
{
  if( currentPageDiv )
  {
    $( currentPageDiv ).hide();
  }

  getConversations();

  getLanguageList( function()
  {
    $( studentPageDiv ).show();
    currentPageDiv = studentPageDiv;

    console.log( currentPageDiv );
    console.log( languageList );
    getAllTutors( languageList, showTutorList );
  });

}

