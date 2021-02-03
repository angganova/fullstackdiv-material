import 'package:fullstackdiv_material/app/demo/model/demo_controller.dart';
import 'package:fullstackdiv_material/system/routes/map_routes.gr.dart';
export 'package:fullstackdiv_material/app/demo/model/demo_controller.dart';

/// and here we got the list of all the Demo Controller Pages
/// that shown in the main menu in [demo.dart]

List<Controller> mainControllers = <Controller>[
  Controller(
    title: 'Global Styles',
    subtitle: 'List of Global Styles',
    child: Routes.globalStyleMenu,
  ),
  Controller(
    title: 'Pages',
    subtitle: '',
    child: Routes.pageExampleMenu,
  ),
  // Controller(
  //   title: 'Map',
  //   subtitle: 'All Map examples',
  //   child: Routes.mapMenuPage,
  // ),
  Controller(
    title: 'Buttons',
    subtitle: 'Basic & Floating Buttons',
    child: Routes.buttonMenu,
  ),
  Controller(
    title: 'Checkbox',
    subtitle: 'Example of Checkbox',
    child: Routes.demoCheckboxPage,
  ),
  Controller(
    title: 'Chips',
    subtitle: 'Examples of Chips',
    child: Routes.chipMenu,
  ),
  Controller(
    title: 'Option',
    subtitle: 'Example of Options',
    child: Routes.optionMenu,
  ),
  Controller(
    title: 'Cards',
    subtitle: 'Examples of Cards',
    child: Routes.cardMenuPage,
  ),
  Controller(
    title: 'Vertical Drawer',
    subtitle: 'Example of Vertical Drawer',
    child: Routes.verticalDrawerMenu,
  ),
  Controller(
    title: 'Bottom Sheet',
    subtitle: 'Example of Bottom Sheet',
    child: Routes.demoBottomSheetPage,
  ),
  Controller(
    title: 'Action Sheet',
    subtitle: 'Example of Action Sheet',
    child: Routes.demoActionSheetPage,
  ),
  Controller(
    title: 'Expansion Panel',
    subtitle: 'Examples of Expansion Panel',
    child: Routes.expansionPanelMenu,
  ),
  Controller(
    title: 'List Item',
    subtitle: 'Example of List Item',
    child: Routes.listItemMenu,
  ),
  Controller(
    title: 'Input Field',
    subtitle: 'All Input Fields',
    child: Routes.inputFieldMenu,
  ),
  Controller(
    title: 'Snack Bar',
    subtitle: 'Example of Snack Bar',
    child: Routes.demoSnackbarPage,
  ),
  Controller(
    title: 'Page Carousel',
    subtitle: 'Page Carousel with Delimiter',
    child: Routes.demoPageCarousel,
  ),
  Controller(
    title: 'Bottom Navigation Bar',
    subtitle: 'Bottom Navigation Bar',
    child: Routes.bottomNavigationMenu,
  ),
  Controller(
    title: 'Rating',
    subtitle: 'Example of Rating',
    child: Routes.demoRating,
  ),
  Controller(
    title: 'Countdown Timer',
    subtitle: 'Example of Countdown Timer',
    child: Routes.demoCountdownTimerPage,
  ),
  Controller(
    title: 'Slider',
    subtitle: 'Example of Slider',
    child: Routes.sliderMenuPage,
  ),
  Controller(
    title: 'Local JSON Parser',
    subtitle: 'Generate User local JSON',
    child: Routes.demoUserJsonDecoder,
  ),
  Controller(
    title: 'Shimmer Effect',
    subtitle: 'List of Shimmer Effect',
    child: Routes.shimmerMenu,
  ),
  Controller(
    title: 'Custom Switch',
    subtitle: 'Exp of Custom Switch',
    child: Routes.demoCustomSwitch,
  ),
  Controller(
    title: 'Custom Tab Bar',
    subtitle: 'Example of Tab Bar',
    child: Routes.demoCustomTabBarPage,
  ),
];

///
///
/// Global Styles
List<Controller> globalStyleControllers = <Controller>[
  Controller(
    title: 'Text Styles',
    subtitle: 'List of Text Styles',
    child: Routes.demoTextStylePage,
  ),
  Controller(
    title: 'Fonts',
    subtitle: 'List of Fonts',
    child: Routes.demoFontPage,
  ),
  Controller(
    title: 'Colors',
    subtitle: 'List of Colors',
    child: Routes.demoColorPage,
  ),
];

///
///
/// Bottom Navigation
List<Controller> bottomNavControllers = <Controller>[
  // Controller(
  //   title: 'With Auto Route',
  //   subtitle: 'Bottom Nav with Auto Route',
  //   child: Routes.bottomNavigationAutoRoute,
  // ),
  // Controller(
  //   title: 'With Page Controller',
  //   subtitle: 'Bottom Nav with Page Controller',
  //   child: Routes.bottomNavigationPageController,
  // ),
];

///
///
/// Buttons
List<Controller> buttonControllers = <Controller>[
  Controller(
    title: 'Basic Button',
    subtitle: 'Bunch of Basic Buttons',
    child: Routes.demoButtonsPage,
  ),
  Controller(
    title: 'Floating Button',
    subtitle: 'Bunch of Floating Buttons',
    child: Routes.demoFloatingButtonPage,
  ),
];

///
///
/// Chips
List<Controller> chipControllers = <Controller>[
  Controller(
    title: 'Chips',
    subtitle: 'Multiple Selection Chip',
    child: Routes.demoChipsPage,
  ),
  Controller(
    title: 'Icon Star Chip',
    subtitle: 'Single Selection Chip',
    child: Routes.demoIconStarChipsPage,
  ),
];

///
///
/// Input Field
List<Controller> inputFieldControllers = <Controller>[
  Controller(
    title: 'Text Field',
    subtitle: 'Example of Text Field',
    child: Routes.demoTextFieldPage,
  ),
  Controller(
    title: 'Large Text Field',
    subtitle: 'Example of Large Text Field',
    child: Routes.demoLargeTextFieldPage,
  ),
  Controller(
    title: 'PIN',
    subtitle: 'Example of PIN',
    child: Routes.demoPinPage,
  ),
  Controller(
    title: 'Search Text Field',
    subtitle: 'Example of Search Text Field',
    child: Routes.demoGeneralSearchField,
  ),
];

///
///
/// List Item
List<Controller> listItemControllers = <Controller>[
  Controller(
    title: 'Basic List Item',
    subtitle: 'Basic List Item',
    child: Routes.demoBasicListItem,
  ),
  Controller(
    title: 'Notification List Item',
    subtitle: 'Notification List Item',
    child: Routes.demoNotificationListItem,
  ),
  Controller(
    title: 'Journey List Item',
    subtitle: 'Journey List Item',
    child: Routes.demoJourneyListItem,
  ),
  Controller(
    title: 'Search List Item',
    subtitle: 'Search List Item',
    child: Routes.demoSearchListItem,
  ),
  Controller(
    title: 'Interactive List Item',
    subtitle: 'Interactive List Item',
    child: Routes.demoInteractiveListItem,
  ),
];

///
///
/// Cards
List<Controller> cardsControllers = <Controller>[
  Controller(
    title: 'Normal Card',
    subtitle: 'Example of Normal Card',
    child: Routes.demoCardPage,
  ),
];

///
///
/// Expansion Panel
List<Controller> expansionPanelController = <Controller>[
  // Controller(
  //   title: 'Route Expansion Panel (1)',
  //   subtitle: 'First Variation Expansion Panel',
  //   child: Routes.demoFirstExpansionPanel,
  // ),
  // Controller(
  //   title: 'Route Expansion Panel (2)',
  //   subtitle: 'Second Variation Expansion Panel',
  //   child: Routes.demoSecondExpansionPanel,
  // ),
  // Controller(
  //   title: 'Custom Expansion Panel',
  //   subtitle: 'Custom Expansion Panel exp',
  //   child: Routes.demoCustomExpansionPanel,
  // ),
];

///
///
/// Vertical Drawer
List<Controller> verticalDrawerController = <Controller>[
  // Controller(
  //   title: 'Vertical Drawer & Nav Bar',
  //   subtitle: 'Vertical Drawer with Nav Bar',
  //   child: Routes.demoVerticalDrawerPage,
  // ),
  // Controller(
  //   title: 'Public Transport Direction List',
  //   subtitle: 'General List',
  //   child: Routes.demoPublicTransportDirectionList,
  // ),
  // Controller(
  //   title: 'Public Transport Direction Step by Step',
  //   subtitle: 'Step by Step',
  //   child: Routes.demoPublicTransportDirectionStepByStep,
  // ),
];

///
///
/// Page Examples
List<Controller> pageExampleControllers = <Controller>[
  Controller(
    title: 'Share Page',
    subtitle: 'Share Page',
    child: Routes.demoSharePage,
  ),
];

///
///
/// Map
List<Controller> mapControllers = <Controller>[
  // Controller(
  //   title: 'Map Example',
  //   subtitle: 'Example of Basic Map',
  //   child: Routes.demoMapPage,
  // ),
  // Controller(
  //   title: 'Map Transportation Example',
  //   subtitle: 'Example of transportation data on map',
  //   child: Routes.demoTransportationMapPage,
  // ),
  // Controller(
  //   title: 'Pin Movement',
  //   subtitle: 'Example of map pin movement',
  //   child: Routes.demoMarkerMovement,
  // ),
  // Controller(
  //   title: 'Pin Clustering',
  //   subtitle: 'Example of map pin clustering',
  //   child: Routes.demoMapClusteringPage,
  // ),
  // Controller(
  //   title: 'Geofencing',
  //   subtitle: 'Example of geofencing',
  //   child: Routes.demoGeofencingPage,
  // ),
];

///
///
/// Shimmer Effect
List<Controller> shimmerControllers = <Controller>[
  Controller(
    title: 'Basic List View',
    subtitle: 'Basic List View Shimmer',
    child: Routes.basicListViewShimmerPage,
  ),
  Controller(
    title: 'Container',
    subtitle: 'Container Shimmer',
    child: Routes.containerShimmerPage,
  ),
  Controller(
    title: 'Dark Container',
    subtitle: 'Dark Container Shimmer',
    child: Routes.darkContainerShimmerPage,
  ),
];

///
///
/// [Option]
List<Controller> optionControllers = <Controller>[
  Controller(
    title: 'Single Selection',
    subtitle: '',
    child: Routes.demoOptionSingleSelection,
  ),
  Controller(
    title: 'Multi Selection',
    subtitle: '',
    child: Routes.demoOptionMultiSelection,
  ),
];

///
///
/// Slider
List<Controller> sliderControllers = <Controller>[
  Controller(
    title: 'Basic Slider',
    subtitle: 'Example of Basic Slider',
    child: Routes.demoBasicSliderPage,
  ),
];
