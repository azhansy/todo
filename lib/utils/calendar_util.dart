import 'package:alarm_calendar/alarm_calendar_plugin.dart';
import 'package:awesome_core/core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nova_alarm_plugin/nova_alarm_plugin.dart';
import 'package:tobo/page/home/model/tobo.dart';

class CalendarUtil {
  static CalendarUtil? _instance;

  CalendarUtil._();

  static CalendarUtil get instance => _instance ?? CalendarUtil._();

  void calendarsInit(Tobo tobo) {
    final Calendars calendars =
        Calendars(DateTime.now(), DateTime.now().add(const Duration(days: 1)));
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

  //由于平台差异性，Android调用原生闹钟只能设置当前时间戳和备注信息
  /// time 设置闹钟的时间戳   闹钟备注   一般闹钟生效后会自我销毁
  Future<void> setClock(Tobo tobo, TimeOfDay timeOfDay) async {
    debugPrint('setclock');

    //一小时后响铃
    final String time =
        DateTime.now().applied(timeOfDay).millisecondsSinceEpoch.toString();
    debugPrint(time);

    final bool? result = await NovaAlarmPlugin.setClock(
      time,
      tobo.hashCode,
      title: tobo.content,
      content: tobo.content,
    );
  }

  Future<void> cancelClock() async {
    final bool? result = await NovaAlarmPlugin.closeClock();
    debugPrint('cancelClock$result');
  }

//Android平台初始化定时器和前台Service
//   static Future initClockService({String? title, String? content}) async {
//     WidgetsFlutterBinding.ensureInitialized();
//     if (Platform.isAndroid) {
//       var params = {
//         "title": title,
//         "content": content
//       };
//       await _channel.invokeMethod('initClockService', params);
//     }
//   }

//IOS使用的本地推送实现闹钟提醒
// setClock
// requestClockPermission
// isClockAvailable
// closeClock
// closeNotification
}
