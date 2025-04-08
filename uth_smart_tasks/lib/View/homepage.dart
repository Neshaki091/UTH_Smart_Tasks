import 'package:flutter/material.dart';
import '../Models/task_model.dart';
import '../Provider/task_service.dart';
import 'taskDetailScreen.dart';

class TaskScreen extends StatefulWidget {
  @override
  _TaskScreenState createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  final TaskService _taskService = TaskService();

  late Future<List<Task>> _tasks;
  int _selectedIndex = 0;
  List<bool> isCheckedList = [];

  @override
  void initState() {
    super.initState();
    _tasks = _taskService.fetchTasks(); // Lấy danh sách task từ API
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/background.png"),
            alignment: Alignment.topRight, // Điều chỉnh kích thước ảnh
          ),
        ),
        child: Column(
          children: [
            _buildAppBar(),
            Expanded(
              child: FutureBuilder<List<Task>>(
                future: _tasks,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text("Error loading tasks"));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return _buildEmptyView();
                  } else {
                    if (isCheckedList.isEmpty) {
                      isCheckedList = List.generate(
                        snapshot.data!.length,
                        (index) => false,
                      );
                    }
                    final tasksToShow = snapshot.data!.take(3).toList();
                    return ListView.builder(
                      padding: EdgeInsets.all(15),
                      itemCount: tasksToShow.length,
                      itemBuilder: (context, index) {
                        return _buildTaskCard(tasksToShow[index], index);
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavBar(),
      floatingActionButton: FloatingActionButton(
        shape: CircleBorder(),
        onPressed: () {},
        backgroundColor: Colors.blue,
        child: Icon(Icons.add, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Color.fromARGB(0, 255, 255, 255),
      title: Row(
        children: [
          Image.network(
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTvpJnSeqHxgbHr4-wN_LGEyZier1L22_g_8R824-DEs2Tzxp16St-5LdEC7Twyn1uVv0s&usqp=CAU",
            height: 60,
            width: 60,

            errorBuilder: (context, error, stackTrace) => Icon(Icons.error),
          ),
          SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "SmartTasks",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.lightBlue,
                ),
              ),
              Text(
                "A simple and efficient to-do app",
                style: TextStyle(fontSize: 8, color: Colors.lightBlue),
              ),
            ],
          ),
          SizedBox(width: 70),
          Icon(Icons.notifications, size: 35, color: Colors.amber),
        ],
      ),
    );
  }

  Widget _buildBottomNavBar() {
    return SizedBox(
      height: 60, // Điều chỉnh chiều cao ở đây
      child: BottomAppBar(
        shape: CircularNotchedRectangle(),
        color: const Color.fromARGB(255, 255, 255, 255),
        notchMargin: 8,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildNavItem(Icons.home, 0),
            _buildNavItem(Icons.calendar_today, 1),
            SizedBox(width: 40),
            _buildNavItem(Icons.edit_document, 2),
            _buildNavItem(Icons.settings, 3),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, int index) {
    return IconButton(
      icon: Icon(
        icon,
        color: _selectedIndex == index ? Colors.blue : Colors.grey,
      ),
      onPressed: () {
        setState(() {
          _selectedIndex = index;
        });
      },
    );
  }
  
  Widget _buildEmptyView() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("assets/no_tasks.png", height: 150),
          SizedBox(height: 10),
          Text(
            "No Tasks Yet!",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Text("Stay productive—add something to do"),
        ],
      ),
    );
  }

  Widget _buildTaskCard(Task task, int index) {
    List<Color> colors = [
      Color(0xFFFFD3D0),
      Color(0xFFD0FFD6),
      Color(0xFFD0E3FF),
      Color(0xFFFFE4A8),
    ];

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => TaskDetailScreen(task: task)),
        );
      },
      child: Card(
        color: colors[index % colors.length],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        margin: EdgeInsets.symmetric(vertical: 8),
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Checkbox(
                    value: isCheckedList[index],
                    onChanged: (value) {
                      setState(() {
                        isCheckedList[index] = value!;
                      });
                    },
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          task.title,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          task.description,
                          style: TextStyle(fontSize: 14, color: Colors.black87),
                          textAlign: TextAlign.start,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Status: ${task.status}",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                  Text(
                    task.time.length >= 10
                        ? task.time.substring(0, 10)
                        : task.time,
                    style: TextStyle(fontSize: 14, color: Colors.black54),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
