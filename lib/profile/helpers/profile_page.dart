class ProfilePage{
  static String profile(int rol){
    Map<int, String> profiles = {
      3: 'teacher',
      5: 'student',
    };

    return profiles[rol] ?? 'login';
  }
}