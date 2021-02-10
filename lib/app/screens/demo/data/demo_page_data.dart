import 'package:fullstackdiv_material/app/screens/demo/model/page_card.dart';
import 'package:fullstackdiv_material/system/routes/map_routes.gr.dart';

export 'package:fullstackdiv_material/app/screens/demo/model/page_card.dart';

/// and here we got the list of all the Demo PageCard Pages
/// that shown in the main menu in [demo.dart]

List<PageCard> mainDemoCardList = <PageCard>[
  PageCard(
    title: 'Global Styles',
    subtitle: 'List of Global Styles',
    route: Routes.globalStyleMenu,
  ),
  PageCard(
    title: 'Pages',
    subtitle: '',
    route: Routes.pageExampleMenu,
  ),
  PageCard(
    title: 'Map',
    subtitle: 'All Map examples',
    route: Routes.mapMenuPage,
  ),
  PageCard(
    title: 'Buttons',
    subtitle: 'Basic & Floating Buttons',
    route: Routes.buttonMenu,
  ),
  PageCard(
    title: 'Checkbox',
    subtitle: 'Example of Checkbox',
    route: Routes.demoCheckboxPage,
  ),
  PageCard(
    title: 'Chips',
    subtitle: 'Examples of Chips',
    route: Routes.chipMenu,
  ),
  PageCard(
    title: 'Option',
    subtitle: 'Example of Options',
    route: Routes.optionMenu,
  ),
  PageCard(
    title: 'Cards',
    subtitle: 'Examples of Cards',
    route: Routes.cardMenuPage,
  ),
  PageCard(
    title: 'Vertical Drawer',
    subtitle: 'Example of Vertical Drawer',
    route: Routes.verticalDrawerMenu,
  ),
  PageCard(
    title: 'Bottom Sheet',
    subtitle: 'Example of Bottom Sheet',
    route: Routes.demoBottomSheetPage,
  ),
  PageCard(
    title: 'Action Sheet',
    subtitle: 'Example of Action Sheet',
    route: Routes.demoActionSheetPage,
  ),
  PageCard(
    title: 'Expansion Panel',
    subtitle: 'Examples of Expansion Panel',
    route: Routes.expansionPanelMenu,
  ),
  PageCard(
    title: 'List Item',
    subtitle: 'Example of List Item',
    route: Routes.listItemMenu,
  ),
  PageCard(
    title: 'Input Field',
    subtitle: 'All Input Fields',
    route: Routes.inputFieldMenu,
  ),
  PageCard(
    title: 'Snack Bar',
    subtitle: 'Example of Snack Bar',
    route: Routes.demoSnackbarPage,
  ),
  PageCard(
    title: 'Page Carousel',
    subtitle: 'Page Carousel with Delimiter',
    route: Routes.demoPageCarousel,
  ),
  PageCard(
    title: 'Bottom Navigation Bar',
    subtitle: 'Bottom Navigation Bar',
    route: Routes.bottomNavigationMenu,
  ),
  PageCard(
    title: 'Rating',
    subtitle: 'Example of Rating',
    route: Routes.demoRating,
  ),
  PageCard(
    title: 'Countdown Timer',
    subtitle: 'Example of Countdown Timer',
    route: Routes.demoCountdownTimerPage,
  ),
  PageCard(
    title: 'Slider',
    subtitle: 'Example of Slider',
    route: Routes.sliderMenuPage,
  ),
  PageCard(
    title: 'Local JSON Parser',
    subtitle: 'Generate User local JSON',
    route: Routes.demoUserJsonDecoder,
  ),
  PageCard(
    title: 'Shimmer Effect',
    subtitle: 'List of Shimmer Effect',
    route: Routes.shimmerMenu,
  ),
  PageCard(
    title: 'Custom Switch',
    subtitle: 'Exp of Custom Switch',
    route: Routes.demoCustomSwitch,
  ),
  PageCard(
    title: 'Custom Tab Bar',
    subtitle: 'Example of Tab Bar',
    route: Routes.demoCustomTabBarPage,
  ),
];

///
///
/// Global Styles
List<PageCard> globalStyleDemoCardList = <PageCard>[
  PageCard(
    title: 'Text Styles',
    subtitle: 'List of Text Styles',
    route: Routes.demoTextStylePage,
  ),
  PageCard(
    title: 'Fonts',
    subtitle: 'List of Fonts',
    route: Routes.demoFontPage,
  ),
  PageCard(
    title: 'Colors',
    subtitle: 'List of Colors',
    route: Routes.demoColorPage,
  ),
];

///
///
/// Bottom Navigation
List<PageCard> bottomNavDemoCardList = <PageCard>[
  // PageCard(
  //   title: 'With Auto Route',
  //   subtitle: 'Bottom Nav with Auto Route',
  //   route: Routes.bottomNavigationAutoRoute,
  // ),
  // PageCard(
  //   title: 'With Page PageCard',
  //   subtitle: 'Bottom Nav with Page PageCard',
  //   route: Routes.bottomNavigationPagePageCard,
  // ),
];

///
///
/// Buttons
List<PageCard> buttonPageCardsDemoCardList = <PageCard>[
  PageCard(
    title: 'Basic Button',
    subtitle: 'Bunch of Basic Buttons',
    route: Routes.demoButtonsPage,
  ),
  PageCard(
    title: 'Floating Button',
    subtitle: 'Bunch of Floating Buttons',
    route: Routes.demoFloatingButtonPage,
  ),
];

///
///
/// Chips
List<PageCard> chipDemoCardList = <PageCard>[
  PageCard(
    title: 'Chips',
    subtitle: 'Multiple Selection Chip',
    route: Routes.demoChipsPage,
  ),
  PageCard(
    title: 'Icon Star Chip',
    subtitle: 'Single Selection Chip',
    route: Routes.demoIconStarChipsPage,
  ),
];

///
///
/// Input Field
List<PageCard> inputFieldDemoCardList = <PageCard>[
  PageCard(
    title: 'Text Field',
    subtitle: 'Example of Text Field',
    route: Routes.demoTextFieldPage,
  ),
  PageCard(
    title: 'Large Text Field',
    subtitle: 'Example of Large Text Field',
    route: Routes.demoLargeTextFieldPage,
  ),
  PageCard(
    title: 'PIN',
    subtitle: 'Example of PIN',
    route: Routes.demoPinPage,
  ),
  PageCard(
    title: 'Search Text Field',
    subtitle: 'Example of Search Text Field',
    route: Routes.demoGeneralSearchField,
  ),
];

///
///
/// List Item
List<PageCard> listItemDemoCardList = <PageCard>[
  PageCard(
    title: 'Basic List Item',
    subtitle: 'Basic List Item',
    route: Routes.demoBasicListItem,
  ),
  PageCard(
    title: 'Notification List Item',
    subtitle: 'Notification List Item',
    route: Routes.demoNotificationListItem,
  ),
  PageCard(
    title: 'Journey List Item',
    subtitle: 'Journey List Item',
    route: Routes.demoJourneyListItem,
  ),
  PageCard(
    title: 'Search List Item',
    subtitle: 'Search List Item',
    route: Routes.demoSearchListItem,
  ),
  PageCard(
    title: 'Interactive List Item',
    subtitle: 'Interactive List Item',
    route: Routes.demoInteractiveListItem,
  ),
];

///
///
/// Cards
List<PageCard> cardsDemoCardList = <PageCard>[
  PageCard(
    title: 'Normal Card',
    subtitle: 'Example of Normal Card',
    route: Routes.demoCardPage,
  ),
];

///
///
/// Expansion Panel
List<PageCard> expansionPanelDemoCardList = <PageCard>[
  // PageCard(
  //   title: 'Route Expansion Panel (1)',
  //   subtitle: 'First Variation Expansion Panel',
  //   route: Routes.demoFirstExpansionPanel,
  // ),
  // PageCard(
  //   title: 'Route Expansion Panel (2)',
  //   subtitle: 'Second Variation Expansion Panel',
  //   route: Routes.demoSecondExpansionPanel,
  // ),
  // PageCard(
  //   title: 'Custom Expansion Panel',
  //   subtitle: 'Custom Expansion Panel exp',
  //   route: Routes.demoCustomExpansionPanel,
  // ),
];

///
///
/// Vertical Drawer
List<PageCard> verticalDrawerDemoCardList = <PageCard>[
  // PageCard(
  //   title: 'Vertical Drawer & Nav Bar',
  //   subtitle: 'Vertical Drawer with Nav Bar',
  //   route: Routes.demoVerticalDrawerPage,
  // ),
  // PageCard(
  //   title: 'Public Transport Direction List',
  //   subtitle: 'General List',
  //   route: Routes.demoPublicTransportDirectionList,
  // ),
  // PageCard(
  //   title: 'Public Transport Direction Step by Step',
  //   subtitle: 'Step by Step',
  //   route: Routes.demoPublicTransportDirectionStepByStep,
  // ),
];

///
///
/// Page Examples
List<PageCard> pageExampleDemoCardList = <PageCard>[
  PageCard(
    title: 'Share Page',
    subtitle: 'Share Page',
    route: Routes.demoSharePage,
  ),
];

///
///
/// Map
List<PageCard> mapDemoCardList = <PageCard>[
  PageCard(
    title: 'Map Example',
    subtitle: 'Example of Basic Map',
    route: Routes.demoMapPage,
  ),
  PageCard(
    title: 'Map Transportation Example',
    subtitle: 'Example of transportation data on map',
    route: Routes.demoTransportationMapPage,
  ),
  // PageCard(
  //   title: 'Pin Movement',
  //   subtitle: 'Example of map pin movement',
  //   route: Routes.demoMarkerMovement,
  // ),
  PageCard(
    title: 'Pin Clustering',
    subtitle: 'Example of map pin clustering',
    route: Routes.demoMapClusteringPage,
  ),
  PageCard(
    title: 'Geofencing',
    subtitle: 'Example of geofencing',
    route: Routes.demoGeofencingPage,
  ),
];

///
///
/// Shimmer Effect
List<PageCard> shimmerDemoCardList = <PageCard>[
  PageCard(
    title: 'Basic List View',
    subtitle: 'Basic List View Shimmer',
    route: Routes.basicListViewShimmerPage,
  ),
  PageCard(
    title: 'Container',
    subtitle: 'Container Shimmer',
    route: Routes.containerShimmerPage,
  ),
  PageCard(
    title: 'Dark Container',
    subtitle: 'Dark Container Shimmer',
    route: Routes.darkContainerShimmerPage,
  ),
];

///
///
/// [Option]
List<PageCard> optionDemoCardList = <PageCard>[
  PageCard(
    title: 'Single Selection',
    subtitle: '',
    route: Routes.demoOptionSingleSelection,
  ),
  PageCard(
    title: 'Multi Selection',
    subtitle: '',
    route: Routes.demoOptionMultiSelection,
  ),
];

///
///
/// Slider
List<PageCard> sliderDemoCardList = <PageCard>[
  PageCard(
    title: 'Basic Slider',
    subtitle: 'Example of Basic Slider',
    route: Routes.demoBasicSliderPage,
  ),
];
