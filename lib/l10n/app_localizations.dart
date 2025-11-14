import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en')
  ];

  /// No description provided for @createAccount.
  ///
  /// In en, this message translates to:
  /// **'Create New User'**
  String get createAccount;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @signup.
  ///
  /// In en, this message translates to:
  /// **'Sign up'**
  String get signup;

  /// No description provided for @menu.
  ///
  /// In en, this message translates to:
  /// **'Menu'**
  String get menu;

  /// No description provided for @user_created.
  ///
  /// In en, this message translates to:
  /// **'Your user has been created'**
  String get user_created;

  /// No description provided for @alreadyHaveAnAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get alreadyHaveAnAccount;

  /// No description provided for @doesntHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Doesn\'t have an account yet?'**
  String get doesntHaveAccount;

  /// No description provided for @register.
  ///
  /// In en, this message translates to:
  /// **'Register now'**
  String get register;

  /// No description provided for @username.
  ///
  /// In en, this message translates to:
  /// **'Username'**
  String get username;

  /// No description provided for @playerName.
  ///
  /// In en, this message translates to:
  /// **'Player Name'**
  String get playerName;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @birthDate.
  ///
  /// In en, this message translates to:
  /// **'Birth Date'**
  String get birthDate;

  /// No description provided for @selectDate.
  ///
  /// In en, this message translates to:
  /// **'Select Date'**
  String get selectDate;

  /// No description provided for @number.
  ///
  /// In en, this message translates to:
  /// **'Phone number'**
  String get number;

  /// No description provided for @username_not_correct.
  ///
  /// In en, this message translates to:
  /// **'Username is not correct'**
  String get username_not_correct;

  /// No description provided for @password_not_correct.
  ///
  /// In en, this message translates to:
  /// **'Password is not correct'**
  String get password_not_correct;

  /// No description provided for @username_unique.
  ///
  /// In en, this message translates to:
  /// **'The username you\'ve entered already exists'**
  String get username_unique;

  /// No description provided for @username_min_length.
  ///
  /// In en, this message translates to:
  /// **'Username must be more than 4 characters'**
  String get username_min_length;

  /// No description provided for @password_min_length.
  ///
  /// In en, this message translates to:
  /// **'Password must be more than 6 characters'**
  String get password_min_length;

  /// No description provided for @number_min_length.
  ///
  /// In en, this message translates to:
  /// **'Phone number must be excatly 11 numbers'**
  String get number_min_length;

  /// No description provided for @field_required.
  ///
  /// In en, this message translates to:
  /// **'Field Required'**
  String get field_required;

  /// No description provided for @limited_quantity.
  ///
  /// In en, this message translates to:
  /// **'Limited Quantity'**
  String get limited_quantity;

  /// No description provided for @left.
  ///
  /// In en, this message translates to:
  /// **'Left'**
  String get left;

  /// No description provided for @contactUs.
  ///
  /// In en, this message translates to:
  /// **'Contact Us'**
  String get contactUs;

  /// No description provided for @about.
  ///
  /// In en, this message translates to:
  /// **'About Us'**
  String get about;

  /// No description provided for @prizes.
  ///
  /// In en, this message translates to:
  /// **'Prizes'**
  String get prizes;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @finalRankings.
  ///
  /// In en, this message translates to:
  /// **'Final Rankings'**
  String get finalRankings;

  /// No description provided for @rankings.
  ///
  /// In en, this message translates to:
  /// **'World Rankings'**
  String get rankings;

  /// No description provided for @playNow.
  ///
  /// In en, this message translates to:
  /// **'Play Now'**
  String get playNow;

  /// No description provided for @welcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome'**
  String get welcome;

  /// No description provided for @accountProfile.
  ///
  /// In en, this message translates to:
  /// **'Account Profile'**
  String get accountProfile;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @start.
  ///
  /// In en, this message translates to:
  /// **'Start'**
  String get start;

  /// No description provided for @rules.
  ///
  /// In en, this message translates to:
  /// **'Rules'**
  String get rules;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @contact.
  ///
  /// In en, this message translates to:
  /// **'Contact Us'**
  String get contact;

  /// No description provided for @practice.
  ///
  /// In en, this message translates to:
  /// **'Practice'**
  String get practice;

  /// No description provided for @terms.
  ///
  /// In en, this message translates to:
  /// **'Terms of Service'**
  String get terms;

  /// No description provided for @privacy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacy;

  /// No description provided for @copyrights.
  ///
  /// In en, this message translates to:
  /// **'© 2023 InZone, Inc. InZone, and any associated logos are trademarks, service marks, and/or registered trademarks of InZone, Inc.'**
  String get copyrights;

  /// No description provided for @aboutDesc.
  ///
  /// In en, this message translates to:
  /// **'Welcome to InZone, founded in 2023 as the ultimate hub for exhilarating question and answer competitions. We\'re dedicated to creating games that blend knowledge and excitement, providing players with the opportunity to win real money. Our diverse range of categories ensures there\'s something for everyone, making every competition a thrilling challenge. Join our global community, where the pursuit of knowledge leads to real-world triumphs. Welcome to the future of gaming.'**
  String get aboutDesc;

  /// No description provided for @facebookGroup.
  ///
  /// In en, this message translates to:
  /// **'Join our facebook group'**
  String get facebookGroup;

  /// No description provided for @prizesDesc.
  ///
  /// In en, this message translates to:
  /// **'Play Freely for Unlimited Time! Now, there are no limits as you immerse yourself in the gaming realm, allowing you to collect awards and achievements at your own pace.'**
  String get prizesDesc;

  /// No description provided for @challenges.
  ///
  /// In en, this message translates to:
  /// **'Upcoming Challenges'**
  String get challenges;

  /// No description provided for @challengesDesc.
  ///
  /// In en, this message translates to:
  /// **'Football fanatics, get ready! Exciting challenges are coming your way, spanning the Premier League, La Liga, Serie A, Bundesliga, and Ligue 1. Brace for intense moments and unexpected twists. Sharpen your knowledge, stay tuned, and don\'t miss the countdown to football greatness! ⚽🔥'**
  String get challengesDesc;

  /// No description provided for @notifyMe.
  ///
  /// In en, this message translates to:
  /// **'Notify Me'**
  String get notifyMe;

  /// No description provided for @willBeNotified.
  ///
  /// In en, this message translates to:
  /// **'Will be notified'**
  String get willBeNotified;

  /// No description provided for @comingSoon.
  ///
  /// In en, this message translates to:
  /// **'Challenge Coming Soon'**
  String get comingSoon;

  /// No description provided for @saveAndClose.
  ///
  /// In en, this message translates to:
  /// **'Save and Close'**
  String get saveAndClose;

  /// No description provided for @exitGame.
  ///
  /// In en, this message translates to:
  /// **'Exit Game'**
  String get exitGame;

  /// No description provided for @trueOrFalse.
  ///
  /// In en, this message translates to:
  /// **'True or False'**
  String get trueOrFalse;

  /// No description provided for @multipleChoices.
  ///
  /// In en, this message translates to:
  /// **'Multiple Choices'**
  String get multipleChoices;

  /// No description provided for @searchPlayer.
  ///
  /// In en, this message translates to:
  /// **'Search Player'**
  String get searchPlayer;

  /// No description provided for @areYouSure.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to save and close the game?!'**
  String get areYouSure;

  /// No description provided for @you.
  ///
  /// In en, this message translates to:
  /// **'You'**
  String get you;

  /// No description provided for @sureExit.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to close the game?!'**
  String get sureExit;

  /// No description provided for @yes.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get yes;

  /// No description provided for @no.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get no;

  /// No description provided for @saveAndExit.
  ///
  /// In en, this message translates to:
  /// **'Save and Exit'**
  String get saveAndExit;

  /// No description provided for @saveAndPlay.
  ///
  /// In en, this message translates to:
  /// **'Save and Play Again'**
  String get saveAndPlay;

  /// No description provided for @point.
  ///
  /// In en, this message translates to:
  /// **'Point'**
  String get point;

  /// No description provided for @points.
  ///
  /// In en, this message translates to:
  /// **'Points'**
  String get points;

  /// No description provided for @skipQuestion.
  ///
  /// In en, this message translates to:
  /// **'Lose a Point and Skip Question'**
  String get skipQuestion;

  /// No description provided for @playAgain.
  ///
  /// In en, this message translates to:
  /// **'Play Again'**
  String get playAgain;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @finishTut.
  ///
  /// In en, this message translates to:
  /// **'Finish Tutorial'**
  String get finishTut;

  /// No description provided for @unlimitedText.
  ///
  /// In en, this message translates to:
  /// **'Unlimited'**
  String get unlimitedText;

  /// No description provided for @requestFailed.
  ///
  /// In en, this message translates to:
  /// **'Please check your internet'**
  String get requestFailed;

  /// No description provided for @coins.
  ///
  /// In en, this message translates to:
  /// **'Coins'**
  String get coins;

  /// No description provided for @gamesPlayed.
  ///
  /// In en, this message translates to:
  /// **'Games Played'**
  String get gamesPlayed;

  /// No description provided for @tableRankings.
  ///
  /// In en, this message translates to:
  /// **'World Rankings'**
  String get tableRankings;

  /// No description provided for @note.
  ///
  /// In en, this message translates to:
  /// **'Note: collecting points weekly prizes will be distributed every Saturday. Please ensure your mobile number is correct and available to collect your prize.'**
  String get note;

  /// No description provided for @additionalNote.
  ///
  /// In en, this message translates to:
  /// **'Please note that the deadline for collecting points for each week will be on Saturday 1:59 AM. Points accumulated after this deadline will be counted towards the following week.'**
  String get additionalNote;

  /// No description provided for @noRankedUsers.
  ///
  /// In en, this message translates to:
  /// **'No Users Played Yet'**
  String get noRankedUsers;

  /// No description provided for @buyNow.
  ///
  /// In en, this message translates to:
  /// **'Buy Now'**
  String get buyNow;

  /// No description provided for @yourAvatars.
  ///
  /// In en, this message translates to:
  /// **'Your Avatars'**
  String get yourAvatars;

  /// No description provided for @buyMoreAvatars.
  ///
  /// In en, this message translates to:
  /// **'Buy More Avatars'**
  String get buyMoreAvatars;

  /// No description provided for @yourThemes.
  ///
  /// In en, this message translates to:
  /// **'Your Themes'**
  String get yourThemes;

  /// No description provided for @select.
  ///
  /// In en, this message translates to:
  /// **'Select'**
  String get select;

  /// No description provided for @selectMode.
  ///
  /// In en, this message translates to:
  /// **'Select Mode'**
  String get selectMode;

  /// No description provided for @selected.
  ///
  /// In en, this message translates to:
  /// **'Selected'**
  String get selected;

  /// No description provided for @selectTheme.
  ///
  /// In en, this message translates to:
  /// **'Select'**
  String get selectTheme;

  /// No description provided for @selectedTheme.
  ///
  /// In en, this message translates to:
  /// **'Selected'**
  String get selectedTheme;

  /// No description provided for @helpingPerks.
  ///
  /// In en, this message translates to:
  /// **'Helping Perks'**
  String get helpingPerks;

  /// No description provided for @skipAdIn.
  ///
  /// In en, this message translates to:
  /// **'Skip Ad in'**
  String get skipAdIn;

  /// No description provided for @skipAd.
  ///
  /// In en, this message translates to:
  /// **'Skip Ad'**
  String get skipAd;

  /// No description provided for @seconds.
  ///
  /// In en, this message translates to:
  /// **'Seconds'**
  String get seconds;

  /// No description provided for @challengesWord.
  ///
  /// In en, this message translates to:
  /// **'Challenges'**
  String get challengesWord;

  /// No description provided for @questionsAbout.
  ///
  /// In en, this message translates to:
  /// **'Questions about'**
  String get questionsAbout;

  /// No description provided for @playersChallenge.
  ///
  /// In en, this message translates to:
  /// **'Players Challenge'**
  String get playersChallenge;

  /// No description provided for @teamsChallenge.
  ///
  /// In en, this message translates to:
  /// **'Teams Challenge'**
  String get teamsChallenge;

  /// No description provided for @nationalTeamsChallenge.
  ///
  /// In en, this message translates to:
  /// **'National Teams Challenge'**
  String get nationalTeamsChallenge;

  /// No description provided for @tournamentsChallenge.
  ///
  /// In en, this message translates to:
  /// **'Tournaments Challenge'**
  String get tournamentsChallenge;

  /// No description provided for @bestOffers.
  ///
  /// In en, this message translates to:
  /// **'Best Offers'**
  String get bestOffers;

  /// No description provided for @checkOffer.
  ///
  /// In en, this message translates to:
  /// **'Check Offer'**
  String get checkOffer;

  /// No description provided for @alreadyPlayedOnce.
  ///
  /// In en, this message translates to:
  /// **'Playable once a day'**
  String get alreadyPlayedOnce;

  /// No description provided for @yourPerks.
  ///
  /// In en, this message translates to:
  /// **'Your Perks'**
  String get yourPerks;

  /// No description provided for @youHave.
  ///
  /// In en, this message translates to:
  /// **'You Have'**
  String get youHave;

  /// No description provided for @selectPerk.
  ///
  /// In en, this message translates to:
  /// **'Select'**
  String get selectPerk;

  /// No description provided for @perksTitle.
  ///
  /// In en, this message translates to:
  /// **'Buy More Perks'**
  String get perksTitle;

  /// No description provided for @coinsTitle.
  ///
  /// In en, this message translates to:
  /// **'Buy More Coins'**
  String get coinsTitle;

  /// No description provided for @congratsText.
  ///
  /// In en, this message translates to:
  /// **'Congratulations you have made your purchase successfully you can check your items in your account profile'**
  String get congratsText;

  /// No description provided for @congratsAvatar.
  ///
  /// In en, this message translates to:
  /// **'Congratulations you have made your purchase successfully, you will find it in your account profile'**
  String get congratsAvatar;

  /// No description provided for @checkYourAccount.
  ///
  /// In en, this message translates to:
  /// **'Check your account'**
  String get checkYourAccount;

  /// No description provided for @playOnSite.
  ///
  /// In en, this message translates to:
  /// **'Play on Website'**
  String get playOnSite;

  /// No description provided for @close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// No description provided for @remove.
  ///
  /// In en, this message translates to:
  /// **'Remove'**
  String get remove;

  /// No description provided for @shop.
  ///
  /// In en, this message translates to:
  /// **'Shop'**
  String get shop;

  /// No description provided for @perksError.
  ///
  /// In en, this message translates to:
  /// **'You already have 4 perks selected you have to remove at least 1 to select from the others'**
  String get perksError;

  /// No description provided for @currency.
  ///
  /// In en, this message translates to:
  /// **'EGP'**
  String get currency;

  /// No description provided for @navigationHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get navigationHome;

  /// No description provided for @navigationRankings.
  ///
  /// In en, this message translates to:
  /// **'Rankings'**
  String get navigationRankings;

  /// No description provided for @navigationBestOffers.
  ///
  /// In en, this message translates to:
  /// **'Offers'**
  String get navigationBestOffers;

  /// No description provided for @edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// No description provided for @ad.
  ///
  /// In en, this message translates to:
  /// **'Ad 5 Seconds'**
  String get ad;

  /// No description provided for @coinAd.
  ///
  /// In en, this message translates to:
  /// **'Ad: Free Coins!'**
  String get coinAd;

  /// No description provided for @wordsLimit.
  ///
  /// In en, this message translates to:
  /// **'At least type 3 words'**
  String get wordsLimit;

  /// No description provided for @addHint.
  ///
  /// In en, this message translates to:
  /// **'Add Hint'**
  String get addHint;

  /// No description provided for @deleteWord.
  ///
  /// In en, this message translates to:
  /// **'Delete Word'**
  String get deleteWord;

  /// No description provided for @modes.
  ///
  /// In en, this message translates to:
  /// **'Modes'**
  String get modes;

  /// No description provided for @chooseYourTeam.
  ///
  /// In en, this message translates to:
  /// **'Choose Your Team'**
  String get chooseYourTeam;

  /// No description provided for @choose.
  ///
  /// In en, this message translates to:
  /// **'Choose'**
  String get choose;

  /// No description provided for @chooseYourTeamFirst.
  ///
  /// In en, this message translates to:
  /// **'Choose the team you want to represent first'**
  String get chooseYourTeamFirst;

  /// No description provided for @enter_event.
  ///
  /// In en, this message translates to:
  /// **'ُEnter Event'**
  String get enter_event;

  /// No description provided for @numberOfPlayers.
  ///
  /// In en, this message translates to:
  /// **'Number of Players'**
  String get numberOfPlayers;

  /// No description provided for @gameDuration.
  ///
  /// In en, this message translates to:
  /// **'Game Duration (Seconds)'**
  String get gameDuration;

  /// No description provided for @team.
  ///
  /// In en, this message translates to:
  /// **'Team'**
  String get team;

  /// No description provided for @endsAt.
  ///
  /// In en, this message translates to:
  /// **'Ends At'**
  String get endsAt;

  /// No description provided for @yourTeam.
  ///
  /// In en, this message translates to:
  /// **'Your Team'**
  String get yourTeam;

  /// No description provided for @playEventNow.
  ///
  /// In en, this message translates to:
  /// **'Play Event Now'**
  String get playEventNow;

  /// No description provided for @best_score.
  ///
  /// In en, this message translates to:
  /// **'Your Best Score Is'**
  String get best_score;

  /// No description provided for @bank.
  ///
  /// In en, this message translates to:
  /// **'Bank'**
  String get bank;

  /// No description provided for @bank_score.
  ///
  /// In en, this message translates to:
  /// **'Bank Score'**
  String get bank_score;

  /// No description provided for @current_score.
  ///
  /// In en, this message translates to:
  /// **'Current Score'**
  String get current_score;

  /// No description provided for @inzoneCoins.
  ///
  /// In en, this message translates to:
  /// **'InZone Coins'**
  String get inzoneCoins;

  /// No description provided for @winningTeam.
  ///
  /// In en, this message translates to:
  /// **'Given to the winning team only'**
  String get winningTeam;

  /// No description provided for @winningPlayers.
  ///
  /// In en, this message translates to:
  /// **'Given to the top 5 players in the event'**
  String get winningPlayers;

  /// No description provided for @exclusiveAvatar.
  ///
  /// In en, this message translates to:
  /// **'Exclusive Avatar for the winners'**
  String get exclusiveAvatar;

  /// No description provided for @exclusiveTheme.
  ///
  /// In en, this message translates to:
  /// **'Exclusive Theme the winners'**
  String get exclusiveTheme;

  /// No description provided for @congratulations.
  ///
  /// In en, this message translates to:
  /// **'Congratulations you have earned these prizes'**
  String get congratulations;

  /// No description provided for @update_app.
  ///
  /// In en, this message translates to:
  /// **'App Needs Update To Get The Newest Events and Games'**
  String get update_app;

  /// No description provided for @update_app_text.
  ///
  /// In en, this message translates to:
  /// **'Update App'**
  String get update_app_text;

  /// No description provided for @not_enough_coins.
  ///
  /// In en, this message translates to:
  /// **'You don\'t have enough coins to participate in this event'**
  String get not_enough_coins;

  /// No description provided for @buy_coins.
  ///
  /// In en, this message translates to:
  /// **'Buy More Coins'**
  String get buy_coins;

  /// No description provided for @login_word.
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get login_word;

  /// No description provided for @continue_with_google.
  ///
  /// In en, this message translates to:
  /// **'Continue with google'**
  String get continue_with_google;

  /// No description provided for @waiting_for_other_players.
  ///
  /// In en, this message translates to:
  /// **'Wating for other players'**
  String get waiting_for_other_players;

  /// No description provided for @waiting_for_player_to_finish.
  ///
  /// In en, this message translates to:
  /// **'Waiting for the other player'**
  String get waiting_for_player_to_finish;

  /// No description provided for @waiting_for_players.
  ///
  /// In en, this message translates to:
  /// **'ًWaiting for other players'**
  String get waiting_for_players;

  /// No description provided for @choose_option_to_play.
  ///
  /// In en, this message translates to:
  /// **'Choose an Option to Play'**
  String get choose_option_to_play;

  /// No description provided for @choose_option_description.
  ///
  /// In en, this message translates to:
  /// **'This mode is playable for free once per day'**
  String get choose_option_description;

  /// No description provided for @wins.
  ///
  /// In en, this message translates to:
  /// **'Wins'**
  String get wins;

  /// No description provided for @loses.
  ///
  /// In en, this message translates to:
  /// **'Loses'**
  String get loses;

  /// No description provided for @draws.
  ///
  /// In en, this message translates to:
  /// **'Draws'**
  String get draws;

  /// No description provided for @win_percentage.
  ///
  /// In en, this message translates to:
  /// **'Win Percentage'**
  String get win_percentage;

  /// No description provided for @season_results.
  ///
  /// In en, this message translates to:
  /// **'Season Results'**
  String get season_results;

  /// No description provided for @last_20_results.
  ///
  /// In en, this message translates to:
  /// **'Last 20 Matches you played during this season'**
  String get last_20_results;

  /// No description provided for @no_results.
  ///
  /// In en, this message translates to:
  /// **'No Results Available Yet'**
  String get no_results;

  /// No description provided for @you_have_been_promoted.
  ///
  /// In en, this message translates to:
  /// **'You have been promoted'**
  String get you_have_been_promoted;

  /// No description provided for @you_have_been_demoted.
  ///
  /// In en, this message translates to:
  /// **'You have been demoted'**
  String get you_have_been_demoted;

  /// No description provided for @daily_challenge.
  ///
  /// In en, this message translates to:
  /// **'Daily Challenge'**
  String get daily_challenge;

  /// No description provided for @weekly_challenge.
  ///
  /// In en, this message translates to:
  /// **'Weekly Challenge'**
  String get weekly_challenge;

  /// No description provided for @monthly_challenge.
  ///
  /// In en, this message translates to:
  /// **'Monthly Challenge'**
  String get monthly_challenge;

  /// No description provided for @yearly_challenge.
  ///
  /// In en, this message translates to:
  /// **'Yearly Challenge'**
  String get yearly_challenge;

  /// No description provided for @play_online.
  ///
  /// In en, this message translates to:
  /// **'Play Online'**
  String get play_online;

  /// No description provided for @play_alone.
  ///
  /// In en, this message translates to:
  /// **'Play Alone'**
  String get play_alone;

  /// No description provided for @all_ranks.
  ///
  /// In en, this message translates to:
  /// **'All Ranks'**
  String get all_ranks;

  /// No description provided for @previous_ranks.
  ///
  /// In en, this message translates to:
  /// **'Your Previous Ranks'**
  String get previous_ranks;

  /// No description provided for @no_previous_rank.
  ///
  /// In en, this message translates to:
  /// **'No Previous Ranks'**
  String get no_previous_rank;

  /// No description provided for @maximum_free_coins.
  ///
  /// In en, this message translates to:
  /// **'You have reached the maximum daily times of free coins'**
  String get maximum_free_coins;

  /// No description provided for @account_edited.
  ///
  /// In en, this message translates to:
  /// **'Your account has been edited'**
  String get account_edited;

  /// No description provided for @win_promotion_flag.
  ///
  /// In en, this message translates to:
  /// **'Win to rank up'**
  String get win_promotion_flag;

  /// No description provided for @lose_demotion_flag.
  ///
  /// In en, this message translates to:
  /// **'If you lose you will be demoted'**
  String get lose_demotion_flag;

  /// No description provided for @events.
  ///
  /// In en, this message translates to:
  /// **'Events'**
  String get events;

  /// No description provided for @events_and_challenges.
  ///
  /// In en, this message translates to:
  /// **'Events & Challenges'**
  String get events_and_challenges;

  /// No description provided for @rate_our_app.
  ///
  /// In en, this message translates to:
  /// **'Rate our app please'**
  String get rate_our_app;

  /// No description provided for @rate_our_app_desc.
  ///
  /// In en, this message translates to:
  /// **'Please rate our app to expand and attract more users'**
  String get rate_our_app_desc;

  /// No description provided for @rate_app.
  ///
  /// In en, this message translates to:
  /// **'Rate Our App'**
  String get rate_app;

  /// No description provided for @play_with_your_friends.
  ///
  /// In en, this message translates to:
  /// **'Play with Friends'**
  String get play_with_your_friends;

  /// No description provided for @friends_desc.
  ///
  /// In en, this message translates to:
  /// **'Create private matches and challenge your friends! Full control over settings—pick your teams, set your rules, and settle the score. Share your room code and let the rivalry begin! ��'**
  String get friends_desc;

  /// No description provided for @ranked_matches.
  ///
  /// In en, this message translates to:
  /// **'Ranked Matches'**
  String get ranked_matches;

  /// No description provided for @ranked_desc.
  ///
  /// In en, this message translates to:
  /// **'Climb the ranks and prove your skill! Win to advance through divisions, earn season rewards, and compete for glory. Your rank resets each season—can you reach the top? 🏆⚽'**
  String get ranked_desc;

  /// No description provided for @casual_matches.
  ///
  /// In en, this message translates to:
  /// **'Casual Matches'**
  String get casual_matches;

  /// No description provided for @casual_desc.
  ///
  /// In en, this message translates to:
  /// **'Quick matches, instant action! Jump in and play without rankings or pressure. Perfect for practicing, testing strategies, or just having fun. Match starts in 30 seconds! ⚡�'**
  String get casual_desc;

  /// No description provided for @room_code.
  ///
  /// In en, this message translates to:
  /// **'Your Room Code is'**
  String get room_code;

  /// No description provided for @match_code.
  ///
  /// In en, this message translates to:
  /// **'Match Code'**
  String get match_code;

  /// No description provided for @enter_code.
  ///
  /// In en, this message translates to:
  /// **'Enter the pass code of your friend\'s match'**
  String get enter_code;

  /// No description provided for @join_match.
  ///
  /// In en, this message translates to:
  /// **'Join Match'**
  String get join_match;

  /// No description provided for @join_room_error.
  ///
  /// In en, this message translates to:
  /// **'Error in joining the match'**
  String get join_room_error;

  /// No description provided for @code_empty.
  ///
  /// In en, this message translates to:
  /// **'Empty Code, Enter the code of your friend\'s match'**
  String get code_empty;

  /// No description provided for @ends_on.
  ///
  /// In en, this message translates to:
  /// **'Ends On'**
  String get ends_on;

  /// No description provided for @session_complete.
  ///
  /// In en, this message translates to:
  /// **'Session Complete!'**
  String get session_complete;

  /// No description provided for @accuracy.
  ///
  /// In en, this message translates to:
  /// **'Accuracy'**
  String get accuracy;

  /// No description provided for @best_streak.
  ///
  /// In en, this message translates to:
  /// **'Best Streak'**
  String get best_streak;

  /// No description provided for @avg_speed.
  ///
  /// In en, this message translates to:
  /// **'Avg Speed'**
  String get avg_speed;

  /// No description provided for @total_questions.
  ///
  /// In en, this message translates to:
  /// **'Total Questions'**
  String get total_questions;

  /// No description provided for @correct_answers.
  ///
  /// In en, this message translates to:
  /// **'Correct Answers'**
  String get correct_answers;

  /// No description provided for @wrong_answers.
  ///
  /// In en, this message translates to:
  /// **'Wrong Answers'**
  String get wrong_answers;

  /// No description provided for @speed_bonuses.
  ///
  /// In en, this message translates to:
  /// **'Speed Bonuses'**
  String get speed_bonuses;

  /// No description provided for @total_points.
  ///
  /// In en, this message translates to:
  /// **'Total Points'**
  String get total_points;

  /// No description provided for @continueButton.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueButton;

  /// No description provided for @practice_mode.
  ///
  /// In en, this message translates to:
  /// **'Practice Mode'**
  String get practice_mode;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
