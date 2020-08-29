import 'package:nuvlemobile/models/providers/mainPageProvider.dart';
import 'package:nuvlemobile/models/providers/menus/menusProvider.dart';
import 'package:nuvlemobile/models/providers/user/order/orderProvider.dart';
import 'package:nuvlemobile/models/providers/onBoardProvider.dart';
import 'package:nuvlemobile/models/providers/user/supportTicketProvider.dart';
import 'package:nuvlemobile/models/providers/user/tabProvider.dart';
import 'package:nuvlemobile/models/providers/user/userAccountProvider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

final registerProviders = <SingleChildWidget>[
  //USER
  ChangeNotifierProvider(create: (_) => UserAccountProvider()),
  ChangeNotifierProvider(create: (_) => SupportTicketProvider()),
  ChangeNotifierProvider(create: (_) => TabProvider()),

  ChangeNotifierProvider(create: (_) => OnBoardProvider()),
  ChangeNotifierProvider(create: (_) => MainPageProvider()),

  //MENUS
  ChangeNotifierProvider(create: (_) => MenusProvider()),
  ChangeNotifierProvider(create: (_) => OrderProvider()),
];
