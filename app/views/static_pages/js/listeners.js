
function initializeListeners()
{
  $( loginButton  ).on( "click", function()
  {
    login();
    console.log("Login");
  });

  $( registerButton ).on( "click", function()
  {
    register();
    console.log("Register");
  });
}

