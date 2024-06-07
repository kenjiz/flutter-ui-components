import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_ui_components/flutter_ui_components.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bloc_test/bloc_test.dart';

import 'test_widget/model/user.dart';

import 'test_widget/view/pagination_test.dart';

class MockFetchListBloc extends MockBloc<FetchListEvent, FetchListState<User>> implements FetchListBloc<User> {}

class MockFetchListEvent extends FetchListEvent {}

extension on WidgetTester {
  Future<void> pumpPaginationWidget(FetchListBloc<User> fetchBloc) async {
    return pumpWidget(
      MaterialApp(
        home: BlocProvider<FetchListBloc<User>>.value(
          value: fetchBloc,
          child: const Scaffold(
            body: PaginationTest(),
          ),
        ),
      ),
    );
  }
}

void main() {
  late FetchListBloc<User> fetchListBloc;

  setUp(() {
    fetchListBloc = MockFetchListBloc();
  });

  setUpAll(() {
    registerFallbackValue(MockFetchListEvent());
  });

  testWidgets('should show loading indicator when state is StateStatus.loading', (WidgetTester tester) async {
    when(() => fetchListBloc.fetchListItems(1, null)).thenAnswer((_) async => FetchedList.empty());

    when(() => fetchListBloc.state).thenReturn(
      FetchListState(
        list: FetchedList.empty(),
        status: StateStatus.loading,
      ),
    );

    await tester.pumpPaginationWidget(fetchListBloc);

    // expect loading indicator
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    final listView = find.byWidgetPredicate((widget) => widget is CustomListView<User>);
    expect(listView, findsOneWidget);
  });

  testWidgets('should show empty list text when state is StateStatus.empty', (WidgetTester tester) async {
    when(() => fetchListBloc.fetchListItems(1, null)).thenAnswer((_) async => FetchedList.empty());

    when(() => fetchListBloc.state).thenReturn(
      FetchListState(
        list: FetchedList.empty(),
        status: StateStatus.empty,
      ),
    );

    await tester.pumpPaginationWidget(fetchListBloc);

    expect(find.text('List is empty'), findsOneWidget); // using DefaultEmptyWidget
  });

  testWidgets('should show error text when state is StateStatus.failure', (WidgetTester tester) async {
    when(() => fetchListBloc.fetchListItems(1, null)).thenAnswer((_) async => FetchedList.empty());

    when(() => fetchListBloc.state).thenReturn(
      FetchListState(
        list: FetchedList.empty(),
        status: StateStatus.failure,
      ),
    );

    await tester.pumpPaginationWidget(fetchListBloc);

    expect(find.textContaining('Something went wrong'), findsOneWidget); // using DefaultErrorWidget
  });

  testWidgets('should show list of items when state is StateStatus.success', (WidgetTester tester) async {
    const testList = [
      User('Test 1'),
      User('Test 2'),
      User('Test 3'),
    ];

    const fetchedList = FetchedList(
      hasNext: false,
      items: testList,
      nextPage: 1,
    );

    when(() => fetchListBloc.fetchListItems(1, null)).thenAnswer((_) async => fetchedList);

    when(() => fetchListBloc.state).thenReturn(
      const FetchListState(
        list: fetchedList,
        status: StateStatus.success,
      ),
    );

    await tester.pumpPaginationWidget(fetchListBloc);

    final text1 = find.byWidgetPredicate((widget) => widget is ListTile && widget.title is Text);

    expect(text1, findsNWidgets(testList.length));

    for (var i = 0; i < testList.length; i++) {
      expect(find.text(testList[i].name), findsOneWidget);
    }
  });

  testWidgets('should not render bottom loader when there is no more data', (tester) async {
    const fetchedList = FetchedList(hasNext: false, items: <User>[], nextPage: 2);

    when(() => fetchListBloc.state).thenReturn(
      const FetchListState(
        list: fetchedList,
        status: StateStatus.success,
        hasNext: false,
        paginationStatus: StateStatus.success,
        nextPage: 2,
      ),
    );
    await tester.pumpPaginationWidget(fetchListBloc);
    expect(find.byType(DefaultLoadingWidget), findsNothing);
  });

  testWidgets('should fetch next data', (WidgetTester tester) async {
    final fetchedList = FetchedList(
      hasNext: true,
      items: List.generate(10, (idx) => User('User $idx')),
      nextPage: 2,
    );

    when(() => fetchListBloc.state).thenReturn(
      FetchListState(
        list: fetchedList,
        status: StateStatus.success,
        hasNext: true,
        paginationStatus: StateStatus.success,
        nextPage: 2,
      ),
    );

    await tester.pumpPaginationWidget(fetchListBloc);

    expect(find.byType(ListTile), findsNWidgets(10));

    final listView = tester.widget<ListView>(find.byType(ListView));
    final ctrl = listView.controller;
    ctrl?.jumpTo(ctrl.offset + 300);
    await tester.pumpAndSettle();

    verify(() => fetchListBloc.add(any())).called(1);
  });
}
