class AppStrings {
  // ******* Success Strings *******//
  static const welcomeTitle = 'Welcome, ';
  static String welcomeDescription(String value) =>
      "You've got $value tasks to do.";

  // ******* Empty Strings *******//
  static const emptyTitle = 'You have no task listed';
  static const emptyDescription = 'Create tasks to achieve more.';
  static const createTask = 'Create task';

  // ******* Errors Strings *******//
  static const errorTitle = 'Oops! Something went wrong';
  static const errorDescription =
      'We were unable to load the tasks, please try again later';
  static const tryAgain = 'Try again';
}
