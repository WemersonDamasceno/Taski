import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taski/src/core/constants/app_colors.dart';
import 'package:taski/src/list_task/presentation/view_model/task_view_model.dart';
import 'package:taski/src/list_task/presentation/widgets/task_item_widget.dart';

class TaskListView extends StatelessWidget {
  const TaskListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundScreen,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundScreen,
        surfaceTintColor: AppColors.backgroundScreen,
        title: const Row(
          children: [
            Icon(Icons.check_box_sharp, color: AppColors.primaryColor),
            Text("Taski"),
          ],
        ),
        centerTitle: false,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Row(
              children: [
                Text("John"),
                SizedBox(width: 10),
                CircleAvatar(
                  backgroundImage: NetworkImage(
                    "https://images.pexels.com/photos/1040880/pexels-photo-1040880.jpeg?auto=compress&cs=tinysrgb&w=800",
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: const TextSpan(
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                children: [
                  TextSpan(
                    text: "Welcome, ",
                    style: TextStyle(
                      color: AppColors.secondaryColor,
                    ),
                  ),
                  TextSpan(
                    text: "John.",
                    style: TextStyle(
                      color: AppColors.primaryColor,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              "You've got 7 tasks to do.",
              style: TextStyle(
                color: AppColors.descriptionColor,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: Consumer<TaskViewModel>(
                builder: (context, taskViewModel, child) {
                  return ListView.builder(
                    itemCount: taskViewModel.tasks.length,
                    itemBuilder: (context, index) {
                      return TaskItemWidget(
                        task: taskViewModel.tasks[index],
                        onToggle: () => taskViewModel.toggleTaskStatus(index),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        enableFeedback: true,
        selectedItemColor: AppColors.primaryColor,
        unselectedItemColor: AppColors.disableItems,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.ballot_outlined),
            label: "Todo",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_box_outlined),
            label: "Create",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: "Search",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.check_box_outlined),
            label: "Done",
          ),
        ],
      ),
    );
  }
}
