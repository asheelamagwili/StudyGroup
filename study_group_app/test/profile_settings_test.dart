import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:study_group_app/models/user.dart';
import 'package:study_group_app/services/auth.dart';
import 'package:study_group_app/screens/profile/settings_page.dart';
import 'package:study_group_app/services/user_service.dart';

class MockUserProvider extends Mock implements UserService {}
class MockAuth extends Mock implements Auth {}

void main () {
  final _auth = MockAuth();
  var test_uid = 'anbBHZQ6IWbl7rj7zZH1L5mzxxd2';
  var testWidget = ProfileSettings(uid: test_uid, auth: _auth,);

  Widget makeTestableWidget({Widget child}) {
    return StreamProvider.value(
      value: MockAuth().getUser,
      child: MaterialApp(
        home: child,
      ),
    );
  }

  group('Profile Settings', () {

    testWidgets('Initial build of settings page.', (WidgetTester tester) async {
      await tester.pumpWidget(makeTestableWidget(child: testWidget));

      // Test intial build of Widget tree in FindGroup()
      expect(find.byWidget(testWidget), findsOneWidget);
    });

    testWidgets('Change name', (WidgetTester tester) async {
      var result = UserService(uid: test_uid).updateFirstName('newfirstName newLastName');
      dynamic actual = 1;
      expect(result, actual);
    });
  });
}