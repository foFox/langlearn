
function showTutorHome()
{
  if( currentPageDiv )
  {
    $( currentPageDiv ).hide();
  }

  $( tutorPageDiv ).show();
  currentPageDiv = tutorPageDiv;

  console.log( currentPageDiv );
}

