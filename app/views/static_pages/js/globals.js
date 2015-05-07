
var url = "https://langstudy.us/api/v1/";

var containerDiv = "#container";

var currentPageDiv = null;

// Login or register

var loginPageDiv = "#loginPage";
var registerDiv = "#register";
var loginDiv = "#login";

var loginButton = "#submitLogin";
var registerButton = "#submitRegister";

var userID = null;

// Student home page

var studentPageDiv = "#studentHomePage";
var tutorListDiv = "#tutorList";

var languageLookup = {};
var languageList = [];
var tutorLookup = {};

// Tutor home page

var tutorPageDiv = "#tutorHomePage";

// Shared between tutors and students
var conversationLookup = {};
var currentConversation = null;
var messagingActive = false;

