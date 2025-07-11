# Firebase Authentication with Bloc/Cubit

This project now implements the BLoC (Business Logic Component) pattern for state management and business logic, specifically for Firebase authentication.

## Architecture Overview

The new authentication system follows these patterns:

### 1. Repository Pattern
- **`AuthRepository`**: Abstract interface for authentication operations
- **`FirebaseAuthRepository`**: Concrete implementation using `FirebaseAuthService`

### 2. BLoC Pattern
- **`AuthBloc`**: Manages global authentication state
- **`AuthEvent`**: Authentication actions (sign in, sign up, sign out, etc.)
- **`AuthState`**: Authentication status (loading, authenticated, unauthenticated, error)

### 3. Cubit Pattern (for UI Forms)
- **`LoginFormCubit`**: Manages login form state and validation
- **`SignupFormCubit`**: Manages signup form state and validation

## File Structure

```
lib/
├── bloc/
│   ├── auth/
│   │   ├── auth_bloc.dart       # Main authentication BLoC
│   │   ├── auth_event.dart      # Authentication events
│   │   └── auth_state.dart      # Authentication states
│   ├── login_form/
│   │   ├── login_form_cubit.dart    # Login form logic
│   │   └── login_form_state.dart    # Login form state
│   ├── signup_form/
│   │   ├── signup_form_cubit.dart   # Signup form logic
│   │   └── signup_form_state.dart   # Signup form state
│   └── bloc.dart                # Barrel file for exports
├── repositories/
│   └── auth_repository.dart     # Repository pattern implementation
├── screens/
│   └── bloc_login_screen.dart   # Example Bloc-based login screen
└── services/
    └── firebase_auth_service.dart   # Original Firebase service (unchanged)
```

## Usage Examples

### 1. Triggering Authentication Events

```dart
// Sign in with email/password
context.read<AuthBloc>().add(
  AuthSignInRequested(
    email: 'user@example.com',
    password: 'password123',
  ),
);

// Sign up with email/password
context.read<AuthBloc>().add(
  AuthSignUpRequested(
    email: 'user@example.com',
    password: 'password123',
    displayName: 'John Doe',
  ),
);

// Google Sign In
context.read<AuthBloc>().add(AuthGoogleSignInRequested());

// Apple Sign In
context.read<AuthBloc>().add(AuthAppleSignInRequested());

// Sign Out
context.read<AuthBloc>().add(AuthSignOutRequested());

// Password Reset
context.read<AuthBloc>().add(
  AuthPasswordResetRequested(email: 'user@example.com'),
);
```

### 2. Listening to Authentication State

```dart
BlocBuilder<AuthBloc, AuthState>(
  builder: (context, state) {
    if (state is AuthLoading || state is AuthSigningIn) {
      return CircularProgressIndicator();
    } else if (state is AuthAuthenticated) {
      return Text('Welcome, ${state.user.email}!');
    } else if (state is AuthUnauthenticated) {
      return LoginScreen();
    } else if (state is AuthError) {
      return Text('Error: ${state.message}');
    }
    return Container();
  },
)
```

### 3. Form State Management

```dart
// Update form fields
context.read<LoginFormCubit>().emailChanged('user@example.com');
context.read<LoginFormCubit>().passwordChanged('password123');

// Toggle password visibility
context.read<LoginFormCubit>().togglePasswordVisibility();

// Toggle remember me
context.read<LoginFormCubit>().toggleRememberMe();

// Listen to form state
BlocBuilder<LoginFormCubit, LoginFormState>(
  builder: (context, state) {
    return Column(
      children: [
        TextField(
          onChanged: (value) => context.read<LoginFormCubit>().emailChanged(value),
          decoration: InputDecoration(
            errorText: state.emailError,
          ),
        ),
        ElevatedButton(
          onPressed: state.isFormValid ? () => _login() : null,
          child: Text('Login'),
        ),
      ],
    );
  },
)
```

### 4. Error Handling

```dart
BlocListener<AuthBloc, AuthState>(
  listener: (context, state) {
    if (state is AuthError) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(state.message),
          backgroundColor: Colors.red,
        ),
      );
    } else if (state is AuthPasswordResetSent) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Password reset email sent to ${state.email}'),
          backgroundColor: Colors.green,
        ),
      );
    }
  },
  child: YourWidget(),
)
```

## Benefits of This Architecture

### 1. **Separation of Concerns**
- UI logic separated from business logic
- Form validation separated from authentication logic
- Clear boundaries between layers

### 2. **Testability**
- Easy to unit test BLoCs and Cubits
- Repository pattern allows for mock implementations
- Clear state transitions make testing predictable

### 3. **Maintainability**
- Single source of truth for authentication state
- Predictable state management
- Easy to add new authentication methods

### 4. **Reusability**
- AuthBloc can be used across multiple screens
- Form Cubits can be reused for different forms
- Repository pattern allows for easy provider switching

## Migration from Controller-based Approach

To migrate from the existing `LoginController` approach:

1. **Replace controller calls** with BLoC events:
   ```dart
   // Old
   await LoginController().login(email, password);
   
   // New
   context.read<AuthBloc>().add(
     AuthSignInRequested(email: email, password: password),
   );
   ```

2. **Replace state checks** with BLoC state listening:
   ```dart
   // Old
   if (FirebaseAuth.instance.currentUser != null) { ... }
   
   // New
   BlocBuilder<AuthBloc, AuthState>(
     builder: (context, state) {
       if (state is AuthAuthenticated) { ... }
     },
   )
   ```

3. **Replace form validation** with Cubit:
   ```dart
   // Old
   if (AppValidators.isValidEmail(email)) { ... }
   
   // New
   BlocBuilder<LoginFormCubit, LoginFormState>(
     builder: (context, state) {
       return TextField(
         decoration: InputDecoration(
           errorText: state.emailError,
         ),
       );
     },
   )
   ```

## Testing

The new architecture makes testing much easier:

```dart
// Test AuthBloc
void main() {
  group('AuthBloc', () {
    late AuthBloc authBloc;
    late MockAuthRepository mockAuthRepository;

    setUp(() {
      mockAuthRepository = MockAuthRepository();
      authBloc = AuthBloc(authRepository: mockAuthRepository);
    });

    test('emits AuthAuthenticated when sign in succeeds', () async {
      // Arrange
      when(() => mockAuthRepository.signInWithEmailAndPassword(any(), any()))
          .thenAnswer((_) async => mockUserCredential);

      // Act
      authBloc.add(AuthSignInRequested(
        email: 'test@example.com',
        password: 'password',
      ));

      // Assert
      await expectLater(
        authBloc.stream,
        emitsInOrder([
          AuthSigningIn(),
          AuthAuthenticated(user: mockUser),
        ]),
      );
    });
  });
}
```

This new architecture provides a solid foundation for scalable, maintainable, and testable authentication in your Flutter app.
