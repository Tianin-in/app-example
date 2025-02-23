import 'package:festival_app/model/festival_and_task.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'dart:developer' as developer;

part 'festival_and_tasks_provider.g.dart';

enum FestivalFilter {
  all,
  official,
  custom,
}

@Riverpod(keepAlive: true)
class FestivalAndTasksList extends _$FestivalAndTasksList {
  FestivalFilter _currentFilter = FestivalFilter.all;
  DateTime? _selectedDate;

  void setFilter(FestivalFilter filter) {
    _currentFilter = filter;
    ref.notifyListeners();
  }

  void setSelectedDate(DateTime? date) {
    _selectedDate = date;
    ref.notifyListeners();
  }

  List<FestivalAndTasks> applyFilters(List<FestivalAndTasks> festivals) {
    festivals = festivals.where((festival) {
      // 应用类型筛选
      if (_currentFilter == FestivalFilter.all) return true;

      if (_currentFilter == festival.dayType) return true;

      return false;
    }).toList();

    return festivals.where((festival) {
      // 应用日期筛选
      if (_selectedDate != null) {
        return festival.data.month == _selectedDate!.month;
      }

      return true;
    }).toList();
  }

  Future<List<FestivalAndTasks>> _fetchFestivalAndTaskss() async {
    List<FestivalAndTasks> list = [
      // 已经有的节假日
      FestivalAndTasks(
        id: '001',
        festivalName: '立春',
        data: DateTime(2025, 9, 10),
        dayType: FestivalFilter.custom,
        state: '1',
        imageUrl: 'assets/images/xianquan.png',
        festivalDescription:
            "春节是中国最重要的传统节日，通常在农历新年到来时庆祝，标志着新一年的开始。春节的庆祝活动从除夕夜开始，家人团聚，吃年夜饭，放鞭炮，发红包，送祝福。春节期间，街道上张灯结彩，舞龙舞狮等民俗活动热闹非凡，是象征着辞旧迎新和团圆的节日",
        plans: 3,
        taskItem: [
          TaskItem(id: '1', content: '小豆腐生日', isCompleted: true),
          TaskItem(id: '2', content: '准备春联', isCompleted: false),
          TaskItem(id: '3', content: '购买年货', isCompleted: false),
        ],
        countDown: 0,
      ),
      // 新增的中国法定节假日
      FestivalAndTasks(
        id: '004',
        festivalName: '春节',
        data: DateTime(2025, 2, 10),
        dayType: FestivalFilter.official,
        state: '1',
        imageUrl: 'assets/images/spring_festival.jpg',
        festivalDescription: "春节是中国的传统节日，通常是农历新年。家人团聚、祭祖、吃团圆饭、放烟花是春节的传统习俗。",
        plans: 4,
        taskItem: [
          TaskItem(id: '7', content: '购买年货', isCompleted: false),
          TaskItem(id: '8', content: '准备年夜饭', isCompleted: false),
          TaskItem(id: '9', content: '布置春节装饰', isCompleted: false),
        ],
        countDown: 0,
      ),
      FestivalAndTasks(
        id: '005',
        festivalName: '清明节',
        data: DateTime(2025, 4, 4),
        dayType: FestivalFilter.official,
        state: '2',
        imageUrl: 'assets/images/qingming.jpg',
        festivalDescription: "清明节是中国的传统节日，主要以扫墓、祭祖和踏青为主要活动。",
        plans: 2,
        taskItem: [
          TaskItem(id: '10', content: '扫墓', isCompleted: false),
          TaskItem(id: '11', content: '踏青', isCompleted: false),
        ],
        countDown: 0,
      ),
      FestivalAndTasks(
        id: '006',
        festivalName: '劳动节',
        data: DateTime(2025, 5, 1),
        dayType: FestivalFilter.official,
        state: '3',
        imageUrl: 'assets/images/labor_day.jpg',
        festivalDescription: "劳动节是国际劳动者的节日，旨在庆祝劳动和劳动者的贡献。",
        plans: 1,
        taskItem: [
          TaskItem(id: '12', content: '参加劳动节活动', isCompleted: false),
        ],
        countDown: 0,
      ),
      FestivalAndTasks(
        id: '007',
        festivalName: '端午节',
        data: DateTime(2025, 6, 25),
        dayType: FestivalFilter.official,
        state: '1',
        imageUrl: 'assets/images/duanwu.jpg',
        festivalDescription: "端午节是中国传统的节日，通常有赛龙舟和吃粽子等习俗，纪念古代爱国诗人屈原。",
        plans: 2,
        taskItem: [
          TaskItem(id: '13', content: '包粽子', isCompleted: false),
          TaskItem(id: '14', content: '观看龙舟比赛', isCompleted: false),
        ],
        countDown: 0,
      ),
      FestivalAndTasks(
        id: '008',
        festivalName: '中秋节',
        data: DateTime(2025, 9, 29),
        dayType: FestivalFilter.official,
        state: '2',
        imageUrl: 'assets/images/mid_autumn.jpg',
        festivalDescription: "中秋节是中国传统节日之一，象征着团圆和丰收，通常有赏月和吃月饼的习俗。",
        plans: 3,
        taskItem: [
          TaskItem(id: '15', content: '准备月饼', isCompleted: false),
          TaskItem(id: '16', content: '赏月', isCompleted: false),
          TaskItem(id: '17', content: '家人聚会', isCompleted: false),
        ],
        countDown: 0,
      ),
      FestivalAndTasks(
        id: '009',
        festivalName: '国庆节',
        data: DateTime(2025, 10, 1),
        dayType: FestivalFilter.official,
        state: '3',
        imageUrl: 'assets/images/national_day.jpg',
        festivalDescription: "国庆节是中华人民共和国的国庆日，纪念中华人民共和国的成立，通常有盛大的庆祝活动。",
        plans: 4,
        taskItem: [
          TaskItem(id: '18', content: '参加国庆庆祝活动', isCompleted: false),
          TaskItem(id: '19', content: '观看阅兵', isCompleted: false),
          TaskItem(id: '20', content: '家人聚会', isCompleted: false),
          TaskItem(id: '21', content: '休假旅游', isCompleted: false),
        ],
        countDown: 0,
      ),
      FestivalAndTasks(
        id: '010',
        festivalName: '元旦',
        data: DateTime(2025, 1, 1),
        dayType: FestivalFilter.official,
        state: '1',
        imageUrl: 'assets/images/new_year.jpg',
        festivalDescription: "元旦是公历新年的第一天，也是许多国家的法定节日，象征着新的开始。",
        plans: 3,
        taskItem: [
          TaskItem(id: '22', content: '庆祝新年', isCompleted: false),
          TaskItem(id: '23', content: '做新年决心', isCompleted: false),
          TaskItem(id: '24', content: '与亲朋好友聚会', isCompleted: false),
        ],
        countDown: 0,
      ),
      FestivalAndTasks(
        id: '011',
        festivalName: '七夕节',
        data: DateTime(2025, 8, 22),
        dayType: FestivalFilter.custom,
        state: '2',
        imageUrl: 'assets/images/qixi.jpg',
        festivalDescription: "七夕节是中国的传统节日，通常是情侣们庆祝爱情的日子，有着浪漫的文化背景。",
        plans: 2,
        taskItem: [
          TaskItem(id: '25', content: '送礼物', isCompleted: false),
          TaskItem(id: '26', content: '约会', isCompleted: false),
        ],
        countDown: 0,
      ),
      FestivalAndTasks(
        id: '012',
        festivalName: '重阳节',
        data: DateTime(2025, 10, 10),
        dayType: FestivalFilter.official,
        state: '3',
        imageUrl: 'assets/images/chongyang.jpg',
        festivalDescription: "重阳节是中国的传统节日，通常有登高、赏菊花等活动，是为老人祈福的节日。",
        plans: 1,
        taskItem: [
          TaskItem(id: '27', content: '登高', isCompleted: false),
        ],
        countDown: 0,
      ),
    ];

    return list;
  }

  @override
  Future<List<FestivalAndTasks>> build() => _fetchFestivalAndTaskss();

  Future<void> updateFestivalAndTasks(
      int index, FestivalAndTasks updatedFestivalAndTasks) async {
    final previousState = state;
    if (!previousState.hasValue) return;

    final currentList = previousState.value!;
    DateTime now = DateTime.now();
    Duration difference = updatedFestivalAndTasks.data.difference(now);
    updatedFestivalAndTasks = updatedFestivalAndTasks.copyWith(
        countDown: difference.inDays + 1,
        plans: updatedFestivalAndTasks.taskItem.length);
    state = AsyncData([
      ...currentList.sublist(0, index),
      updatedFestivalAndTasks,
      ...currentList.sublist(index + 1),
    ]);

    try {
      await Future.delayed(const Duration(milliseconds: 100));
      // 如果是真实API，这里会发送更新请求
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
      state = previousState; // 恢复之前的状态
    }
  }

  //添加到任务列表
  Future<void> saveFestivalAndTask(FestivalAndTasks newFestivalAndTasks) async {
    final previousState = state;
    if (!previousState.hasValue) return;

    final currentList = previousState.value!;

    newFestivalAndTasks = newFestivalAndTasks.copyWith(
        id: (currentList.length + 1).toString(),
        state: "2",
        plans: newFestivalAndTasks.taskItem.length);

    print("新节日Id" + newFestivalAndTasks.id);

    // 更新状态，添加新的节日和任务
    state = AsyncData([...currentList, newFestivalAndTasks]);

    try {
      // 如果是真实API，这里会发送添加请求
      // await Future.delayed(const Duration(milliseconds: 100));
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
      state = previousState; // 恢复之前的状态
    }
  }

  Future<bool> deleteTask(String id, String taskId) async {
    final previousState = state;
    if (!previousState.hasValue) return false;

    final currentList = previousState.value!;

    final festivalIndex =
        currentList.indexWhere((festival) => festival.id == id);

    final festival = currentList[festivalIndex];

    final updatedTaskList =
        festival.taskItem.where((task) => task.id != taskId).toList();

    final updatedFestival = festival.copyWith(taskItem: updatedTaskList);

    state = AsyncData([
      ...currentList.sublist(0, festivalIndex),
      updatedFestival,
      ...currentList.sublist(festivalIndex + 1),
    ]);

    try {
      // 如果是真实API，这里会发送更新请求
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
      state = previousState; // 恢复之前的状态
    }

    return true;
  }
}
