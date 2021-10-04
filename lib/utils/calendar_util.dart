import 'package:alarm_calendar/alarm_calendar_plugin.dart';
import 'package:awesome_core/core.dart';
import 'package:flutter/cupertino.dart';
import 'package:tobo/page/home/model/tobo.dart';

class CalendarUtil {
  static CalendarUtil? _instance;

  CalendarUtil._();

  static CalendarUtil get instance => _instance ?? CalendarUtil._();

  void calendarsInit(Tobo tobo) {
    final Calendars calendars = Calendars(
        DateTime.now().add(const Duration(hours: 1)),
        DateTime.now().add(const Duration(days: 1)));
    //更新参数
    calendars.setTitle = 'TODO[${tobo.content}]';
    calendars.setAlert = [15];
    calendars.setAllDay = 0;
    calendars.setNote = tobo.content;
    createEvent(calendars);
  }

  Future<void> createEvent(Calendars calendars) async {
    //查询是否有读权限。
    await AlarmCalendar.CheckReadPermission().then((res) async {
      if (res != null) {
        //查询是否有写权限
        await AlarmCalendar.CheckWritePermission().then((resWrite) async {
          if (resWrite != null) {
            try {
              final id = await AlarmCalendar.createEvent(calendars);
              calendars.setEventId = id!;
              debugPrint('获得ID为：' + id);
              'todo已添加到系统日历中'.toast();
            } catch (e) {
              debugPrint('添加失败=${e.toString()}');
            }
          }
        });
      }
    });
  }

  Future<void> selectEvent(String id) async {
    //查询是否有读权限。
    await AlarmCalendar.CheckReadPermission().then((res) async {
      if (res != null) {
        //查询是否有写权限
        await AlarmCalendar.CheckWritePermission().then((resWrite) async {
          if (resWrite != null) {
            final result = await AlarmCalendar.selectEvent(id);
            print('获取返回数据：$result');
          }
        });
      }
    });
  }
}
