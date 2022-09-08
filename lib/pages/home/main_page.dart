import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_thoughts/bloc/tasks_bloc.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  TextEditingController controller = TextEditingController();
  int id = 0;

  @override
  Widget build(BuildContext context) {
    context.read<TasksBloc>().add(LoadEvent());
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 26,
              vertical: 27,
            ),
            child: BlocConsumer<TasksBloc, TasksState>(
              listener: (context, state) {
                if (state is LoadNotifyState) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Task added'),
                  ));
                }
              },
              builder: (context, state) {
                if (state is LaodedState) {
                  return Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: TextFormField(
                              cursorColor: Colors.white,
                              controller: controller,
                              decoration: const InputDecoration(
                                labelText: 'Type text...',
                                labelStyle: TextStyle(
                                  color: Colors.white,
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xFFE0E0E0),
                                  ),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xFFE0E0E0),
                                  ),
                                ),
                              ),
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                              onSaved: (String? value) {},
                              keyboardType: TextInputType.text,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              context.read<TasksBloc>().add(
                                    AddTaskEvent(
                                      id: id,
                                      title: controller.text,
                                      isDone: false,
                                    ),
                                  );
                              increment();
                            },
                            icon: const Icon(
                              Icons.add,
                              size: 36,
                              color: Color(0xFFE0E0E0),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 25),
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        itemCount: state.tasks.length,
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 13),
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () => context.read<TasksBloc>().add(
                                  SetTaskStatusEvent(
                                    state.tasks[index].id,
                                    !state.tasks[index].isDone,
                                    index,
                                  ),
                                ),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 12,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFF333333),
                                boxShadow: [
                                  BoxShadow(
                                    color:
                                        const Color(0xFF000000).withOpacity(0.16),
                                    spreadRadius: 1,
                                    blurRadius: 4,
                                  ),
                                ],
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      state.tasks[index].title,
                                      style:  TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 24,
                                        color: Colors.white,
                                        decoration: state.tasks[index].isDone? TextDecoration.lineThrough : null,
                                      ),
                                    ),
                                  ),
                                  Icon(
                                    state.tasks[index].isDone? Icons.check_box
                                        : Icons.check_box_outline_blank,
                                    color: const Color(0xFFE0E0E0),
                                    size: 36,
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  );
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  increment() {
    id++;
  }
}
