import 'package:beta_project/features/authentication/cubit/auth_cubit.dart'; // Updated import
import 'package:beta_project/features/authentication/cubit/auth_state.dart'; // Updated import
import 'package:beta_project/data/auth_repository.dart';
import 'package:beta_project/features/profile/pages/profile_screen.dart'; // Updated import
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';

// Mock AuthCubit
class MockAuthCubit extends Mock implements AuthCubit {
  // Mock the 'state' getter
  @override
  AuthState get state => super.noSuchMethod(
        Invocation.getter(#state),
        returnValue: AuthInitial(), // Provide a default return value
      );

  // Mock the 'stream' getter
  @override
  Stream<AuthState> get stream => super.noSuchMethod(
        Invocation.getter(#stream),
        returnValue: Stream.empty(), // Provide a default return value
      );

  // Mock the 'close' method
  @override
  Future<void> close() => super.noSuchMethod(
        Invocation.method(#close, []),
        returnValue: Future.value(),
      );

  // Mock the 'logout' method as it's used in ProfileScreen
  @override
  Future<void> logout() => super.noSuchMethod(
        Invocation.method(#logout, []),
        returnValue: Future.value(),
      );
}

void main() {
  late MockAuthCubit mockAuthCubit;

  setUp(() {
    mockAuthCubit = MockAuthCubit();
    
    // Mock SharedPreferences with a fake image URL to avoid AssetImage
    SharedPreferences.setMockInitialValues({
      'test@example.com_image': 'http://example.com/avatar.png',
    });
  });

  Widget createWidgetUnderTest() {
    return MaterialApp(
      home: BlocProvider<AuthCubit>.value(
        value: mockAuthCubit,
        child: const ProfileScreen(),
      ),
    );
  }

  group('ProfileScreen Widget Test', () {
    testWidgets('renders ProfileScreen with Edit Profile text', (tester) async {
      await mockNetworkImages(() async {
        // Arrange
        when(() => mockAuthCubit.state).thenReturn(const AuthAuthenticated('test@example.com'));
        
        // Act
        await tester.pumpWidget(createWidgetUnderTest());
        await tester.pumpAndSettle(); // Wait for animations

        // Assert
        expect(find.text('Edit Profile'), findsOneWidget);
        expect(find.text('Username'), findsOneWidget);
        expect(find.text('Email'), findsOneWidget);
        expect(find.text('Date of Birth'), findsOneWidget);
      });
    });

    testWidgets('shows basic structure', (tester) async {
      await mockNetworkImages(() async {
        // Arrange
        when(() => mockAuthCubit.state).thenReturn(const AuthAuthenticated('test@example.com'));

        await tester.pumpWidget(createWidgetUnderTest());
        
        // Verify basic structure exists
        expect(find.byType(Scaffold), findsOneWidget);
      });
    });
  });
}
