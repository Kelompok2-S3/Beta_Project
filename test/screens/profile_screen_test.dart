import 'package:beta_project/cubits/auth_cubit.dart';
import 'package:beta_project/data/auth_repository.dart';
import 'package:beta_project/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';

// Mock AuthCubit
class MockAuthCubit extends Mock implements AuthCubit {}

// Mock AuthRepository
class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late MockAuthCubit mockAuthCubit;

  setUp(() {
    mockAuthCubit = MockAuthCubit();
    when(() => mockAuthCubit.stream).thenAnswer((_) => Stream.value(const AuthAuthenticated('test@example.com')));
    when(() => mockAuthCubit.close()).thenAnswer((_) async {});
    
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
