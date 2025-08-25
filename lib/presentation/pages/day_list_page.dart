import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_todo/domain/entities/day_list.dart';
import 'package:flutter_todo/presentation/widgets/custom_card.dart';
import 'package:flutter_todo/presentation/widgets/page_wrapper.dart';
import 'package:flutter_todo/presentation/widgets/tasks_list.dart';
import 'package:flutter_todo/providers/day_lists_provider_provider.dart';
import 'package:go_router/go_router.dart';

class DayListPage extends ConsumerStatefulWidget {
  const DayListPage({super.key, required this.dayListId});

  final String dayListId;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _DayListPage();
  }
}

class _DayListPage extends ConsumerState<DayListPage> {
  @override
  Widget build(BuildContext context) {
    final dayLists = ref.watch(dayListsProvider);
    DayList selectedDayList = dayLists.firstWhere(
      (d) => d.id == widget.dayListId,
    );
    final totalCount = selectedDayList.tasks.length;
    final doneCount = selectedDayList.tasks
        .where((t) => t.done == true)
        .length;
    final donePercentage = totalCount == 0
        ? 0.0
        : (doneCount / totalCount) * 100;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.go('/');
          },
        ),
      ),
      body: PageContentWrapper(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _Header(),
              SizedBox(height: 20),
              _ProgressCard(donePercentage: donePercentage,doneCount: doneCount, totalCount: totalCount,),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Tasks",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(height: 20),
              TasksList(
                taskListId: selectedDayList.id,
                title: selectedDayList.title,
                tasks: selectedDayList.tasks,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.go('/day-list/${selectedDayList.id}/new-task'),
        backgroundColor: Colors.amber[800],
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "Welcome!",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            ),
            SizedBox(width: 10),
            const Icon(Icons.waving_hand_rounded, color: Colors.brown),
          ],
        ),
        SizedBox(width: 10),
        Text(
          "Saturday, August 23, 2025",
          style: TextStyle(color: Colors.black, fontSize: 15),
        ),
      ],
    );
  }
}

class _ProgressCard extends StatelessWidget {
  const _ProgressCard({super.key, required this.donePercentage, required this.doneCount, required this.totalCount});
  final double donePercentage;
  final int doneCount;
  final int totalCount;
  @override
  Widget build(BuildContext context) {
    return CustomCard(
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Today's Progress",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text("$doneCount of $totalCount tass completed"),
                  ],
                ),
              ),
              Text(
                '${donePercentage.toStringAsFixed(0)} %',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  color: Colors.amber[800],
                ),
              ),
            ],
          ),
          SizedBox(height: 20),

          _ProgressBar(donePercentage: donePercentage),
        ],
      ),
    );
  }
}

class _ProgressBar extends StatefulWidget {
  const _ProgressBar({required this.donePercentage});
  final double donePercentage;

  @override
  State<StatefulWidget> createState() {
    return _ProgressBarState();
  }
}

class _ProgressBarState extends State<_ProgressBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    _animation = Tween<double>(begin: 0, end: widget.donePercentage).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _animationController.forward();
  }

  @override
  void didUpdateWidget(covariant oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.donePercentage != widget.donePercentage) {
      _animation = Tween<double>(begin: 0, end: widget.donePercentage).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
      );
      _animationController
        ..reset()
        ..forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return LayoutBuilder(
          builder: (context, constraints) => Row(
            children: [
              Container(
                width: (_animation.value * constraints.maxWidth) / 100,
                height: 10,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(5),
                    bottomLeft: Radius.circular(5),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  width: 0,
                  height: 10,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(5),
                      bottomRight: Radius.circular(5),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }
}
