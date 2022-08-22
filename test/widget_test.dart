import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:todo_app/feature_todo/domain_layer/repository/api_repository.dart';
import 'package:todo_app/feature_todo/presentation_layer/bloc/Connectivity/connectivity_cubit.dart';
import 'package:todo_app/feature_todo/presentation_layer/bloc/cubit/task_cubit.dart';
import 'package:todo_app/feature_todo/presentation_layer/views/home.dart';
import 'package:todo_app/feature_todo/presentation_layer/widgets/add_task_bottom_sheet.dart';

void main() {
  testWidgets('Add a todo', (WidgetTester tester) async {
    /// Find the widgets using keys
    final addTitle = find.byKey(const ValueKey('addTitle'));
    final addButton = find.byKey(const ValueKey('addButton'));

    await tester.pumpWidget(MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => TaskCubit(ApiRepository())),
        BlocProvider(
            create: (_) => ConnectivityCubit(connectivity: Connectivity()))
      ],child: const MaterialApp(home: Scaffold(body: AddTaskBottomSheet()),)));
    await tester.enterText(addTitle, 'Testing the title widget');
    await tester.tap(addButton);
    await tester.pump(const Duration(seconds: 5));

    expect(find.text('Testing the title widget'), findsOneWidget);
  });
}