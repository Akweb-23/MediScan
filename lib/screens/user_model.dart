// Placeholder for a global user profile object

class UserModel {
  String firstName;
  String lastName;
  String email;
  String mobileNumber;
  String passwordPlaceholder;
  String dob;
  String gender;
  String avatarUrl;

  UserModel({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.mobileNumber,
    required this.passwordPlaceholder,
    required this.dob,
    required this.gender,
    required this.avatarUrl,
  });
}

// Global service class to manage the single user instance
class UserProfileService {
  static final UserProfileService _instance = UserProfileService._internal();

  factory UserProfileService() {
    return _instance;
  }

  UserProfileService._internal();

  // Initialize with dummy data (simulating post-login state)
  UserModel _currentUser = UserModel(
    firstName: 'Chandrima',
    lastName: 'Saha',
    email: 'Chandrima.Saha@gmail.com',
    mobileNumber: '9767994567',
    passwordPlaceholder: '**********',
    dob: '02-05-2000',
    gender: 'Female',
    avatarUrl: 'https://placehold.co/100x100/EFEFEF/3B3B3B?text=CS',
  );

  UserModel get currentUser => _currentUser;

  // Method to update user data (simulating successful registration/login)
  void updateUserInfo({
    required String firstName,
    required String lastName,
    required String email,
    required String mobileNumber,
    required String dob,
    required String gender,
  }) {
    // In a real app, this would typically be triggered after a login/registration API call
    _currentUser.firstName = firstName;
    _currentUser.lastName = lastName;
    _currentUser.email = email;
    _currentUser.mobileNumber = mobileNumber;
    _currentUser.dob = dob;
    _currentUser.gender = gender;
    // Note: Password/Avatar logic is skipped for simplicity.
    print('User profile updated successfully.');
  }
}