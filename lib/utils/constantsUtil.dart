/// ------------ KEY ROUTES TO NAVIGATION ------------
final String signOutRoute = 'signOutPage';

/// ------------ CLIENT ------------
final String placesHomeRoute = 'placesHomePage';
final String placeDetailClientRoute = 'placeDetailClientPage';
final String reservationCreationRoute = 'reservationCreationPage';

/// ------------ OWNER ------------
final String signInRoute = 'signInPage';
final String signUpRoute = 'signUpPage';
final String placeCreationRoute = 'placeCreationPage';
final String placeDetailOwnerRoute = 'placeDetailOwnerPage';
final String placesRoute = 'placesPage';
final String profileRoute = 'profilePage';
final String reservationsRoute = 'reservationsPage';

/// ------------ URL FIREBASE STORAGE ------------
const String URL_STORAGE = 'https://firebasestorage.googleapis.com/v0/b/utsreservatfire.appspot.com/o/place%2f';
const String PARAMS_STORAGE = '?alt=media&token=';

/// ------------ URL BACKEND ------------
const String BASE_ADDRESS = 'http://143.198.169.174:8090';
const String ITEM_URL = '/api/v1';

/// ------------ CODE RESPONSE ------------
const int SUCCESSFUL = 200;
const int SUCCESSFUL_CREATION = 201;
const int SUCCESSFUL_UPDATE = 211;
const int WITHOUT_AUTHORIZATION = 401;
const int WRONG_PASSWORD = 430;
const int ERROR_SAVE = 432;
const int ERROR_SEARCH = 435;
const int USER_NOT_EXIST = 436;
const int INTERNAL_ERROR_SERVER = 500;
const int USER_ALREADY_EXIST = 501;

/// ------------ KEY SESSION MANAGER ------------
const String KEY_TOKEN = 'token';
const String KEY_USER_ID = 'user_id';

/// ------------ TOPICS NOTIFICATION PUSH ------------
const String TOPIC_USER = 'user_';
