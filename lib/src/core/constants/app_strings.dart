class AppStrings {
  // ******* Success Strings *******//
  static const welcomeTitle = 'Welcome, ';
  static String welcomeDescription(String value) =>
      "You've got $value tasks to do.";

  // ******* Empty Strings *******//
  static const emptyTitle = 'You have no task listed';

  static const notFoundTaks = 'No result found.';
  static const emptyDescription = 'Create tasks to achieve more.';
  static const createTask = 'Create task';
  static const create = 'Create';

  // ******* Errors Strings *******//
  static const errorTitle = 'Oops! Something went wrong';
  static const errorDescription =
      'We were unable to load the tasks, please try again later';
  static const tryAgain = 'Try again';

  // ******* Snackbar Strings *******//
  static const successCreateTask = 'Task successfully created!';
  static const buttonClose = 'Close';

  // ******* Bottom Sheet Strings *******//
  static const hintTask = 'What\'s in your mind?';
  static const hintAddNote = 'Add a note...';

  // ******* Search Strings *******//
  static const searchTask = 'Search by task...';

  // ******* Done Tasks Strings *******//
  static const titleDoneTasks = 'Completed Tasks';
  static const deleteAllTasks = 'Delete all';
  static const cancel = 'Cancel';
  static const deleteTask = 'Delete';

  static const deleteAllTasksDescription =
      'Are you sure you want to delete all completed tasks?';
  static const deleteTaskDescription =
      'Are you sure you want to delete this task?';
  static const deleteTasks = 'Delete task';
  static const deleteAllTasksTitle = 'Delete all task';

  static const successDeleteTask = 'Task successfully deleted!';
  static String taskCompleted(String value) =>
      'Task $value completed successfully';

  // ******* Bottom Navigator Strings *******//
  static const todoBottomNavigator = 'Todo';
  static const createBottomNavigator = 'Create';
  static const searchBottomNavigator = 'Search';
  static const doneBottomNavigator = 'Done';
}
