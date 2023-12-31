import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../../features/connect/application/connect_bloc.dart';
import '../../../features/registration/application/registration_bloc.dart';
import 'bloc.dart';

class GlobalBlocProvider extends StatelessWidget {
  const GlobalBlocProvider({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  /// Provider for GlobalBlocs
  @override
  Widget build(BuildContext context) {
    final blocFactory = Provider.of<BlocFactory>(context);
    return MultiBlocProvider(
      providers: [
        BlocProvider<RegistrationBloc>(
          create: (_) => blocFactory.createRegistrationBloc(),
          lazy: true,
        ),
      ],
      child: child,
    );
    return child;
  }
}
