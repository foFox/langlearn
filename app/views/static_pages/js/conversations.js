
function getConversations()
{
  $.ajax( url + "me/conversations",
  {
    type: "GET",
    dataType: "json",
    accepts: { text: "application/json" },
    statusCode:
    {
      200: function( response )
      { 
        var conversations = response.conversations;
        console.log( conversations );
      
        // Add conversations to our lookup dictionary
        for( var i = 0; i < conversations.length; i++ )
        {
          var conversation = conversations[i];
          conversationLookup[ conversation.id ] = conversation;
         
          if( i == 0 )
          {
            currentConversation = conversation;
            displayConversation( conversation.id ); 
          }
        }
      },
      401: function( response )
      {
        registerOrLogin();
      },
    }
  });
}

function startConversation( tutorID, languageID, languageName )
{
  console.log( "Starting conversation with tutor " + tutorID + ", language " + languageID + ", name " + languageName );

  var data = {
    tutor_id : tutorID.toString(),
    language_id : languageID.toString(),
    language_name: languageName.toString()
  };

  $.ajax( url + "me/conversations",
  {
    type: "POST",
    contentType: "application/json",
    data: JSON.stringify( data ),
    dataType: "json", 
    accepts: { text: "application/json" },
    statusCode: {
      200: function( response )
      {
        console.log( response );
        currentConversation = response.conversation; 
        conversationLookup[ currentConversation.id ] = currentConversation;

        displayConversation( currentConversation.id );
      },
      401: function( response )
      {
        registerOrLogin();
      },
      422: function( response )
      {
        console.log( response );
      }
    }
  });
}

function displayConversation( conversationID )
{
  var conversation = conversationLookup[ conversationID ];

  $.ajax( url + "conversations/" + conversation.id + "/messages",
  {  
    type: "GET",
    dataType: "json",
    accepts: { text: "application/json" },
    statusCode:
    {
      200: function( response )
      {
        messagingActive = true;
        startMessaging();
      },
      401: function( response )
      {
        registerOrLogin();
      },
    }
  });  

  console.log( "Display conversation: " );
  console.log( conversation );
}

