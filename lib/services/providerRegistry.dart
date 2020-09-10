import 'package:Nuvle/models/providers/homePageProvider.dart';
import 'package:Nuvle/models/providers/mainPageProvider.dart';
import 'package:Nuvle/models/providers/menus/menusProvider.dart';
import 'package:Nuvle/models/providers/socket/socket_provider.dart';
import 'package:Nuvle/models/providers/user/order/orderProvider.dart';
import 'package:Nuvle/models/providers/onBoardProvider.dart';
import 'package:Nuvle/models/providers/user/supportTicketProvider.dart';
import 'package:Nuvle/models/providers/user/tabProvider.dart';
import 'package:Nuvle/models/providers/user/userAccountProvider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

final registerProviders = <SingleChildWidget>[
  //USER
  ChangeNotifierProvider(create: (_) => UserAccountProvider()),
  ChangeNotifierProvider(create: (_) => SupportTicketProvider()),
  ChangeNotifierProvider(create: (_) => TabProvider()),

  ChangeNotifierProvider(create: (_) => OnBoardProvider()),
  ChangeNotifierProvider(create: (_) => MainPageProvider()),
  ChangeNotifierProvider(create: (_) => HomePageProvider()),

  //MENUS
  ChangeNotifierProvider(create: (_) => MenusProvider()),
  ChangeNotifierProvider(create: (_) => OrderProvider()),

  ChangeNotifierProvider(create: (_) => SocketProvider()),
];
