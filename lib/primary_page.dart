import 'package:families_app/cubits/children/children_cubit.dart';
import 'package:families_app/cubits/parents/parents_cubit.dart';
import 'package:families_app/utils/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PrimaryPage extends StatefulWidget {
  const PrimaryPage({Key? key, required this.cubits}) : super(key: key);

  final Set<Cubit> cubits;
  @override
  _PrimaryPageState createState() => _PrimaryPageState();
}

class _PrimaryPageState extends State<PrimaryPage> {
  final _routes = Routes();
  final _textInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
    borderSide: const BorderSide(color: Colors.grey),
  );
  @override
  void initState() {
    super.initState();
    _routes.defineRoutes();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ParentsCubit>(create: (_) => widget.cubits.whereType<ParentsCubit>().first, lazy: false),
        BlocProvider<ChildrenCubit>(create: (_) => widget.cubits.whereType<ChildrenCubit>().first, lazy: false),
      ],
      child: MaterialApp(
        title: 'Family App',
        theme: ThemeData(
          primarySwatch: Colors.grey,
          inputDecorationTheme: InputDecorationTheme(
            labelStyle: const TextStyle(color: Colors.grey),
            border: _textInputBorder,
            focusedBorder: _textInputBorder,
          ),
          textTheme: const TextTheme(
            headline1: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            headline2: TextStyle(fontSize: 24.0, color: Colors.grey, fontWeight: FontWeight.bold),
            headline6: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            bodyText2: TextStyle(fontSize: 16.0, color: Colors.black87),
            bodyText1: TextStyle(fontSize: 14.0, color: Colors.white),
          ),
        ),
        initialRoute: Routes.to.home(),
        onGenerateRoute: Routes.router.generator,
      ),
    );
  }
}
