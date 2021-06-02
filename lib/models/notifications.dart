import 'package:cloud_functions/cloud_functions.dart';
import 'package:awesome_notifications/awesome_notifications.dart';

import 'package:meta/meta.dart';
import 'package:data/data_repository.dart';

class AniNotification {
  DataRepository _dataRepository;

  AniNotification({@required DataRepository dataRepository}) {
    this._dataRepository = dataRepository;
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });
    this.helloNotification();
  }

  static final _stream = FirebaseFunctions.instance
      .httpsCallable('getUserName')()
      .asStream()
      .asBroadcastStream();

  DateTime createSchedule(int hour, int minute) {
    DateTime scheduleTime;
    final time = DateTime.now();

    scheduleTime = new DateTime(time.year, time.month, time.day, hour, minute,
        time.second, time.millisecond, time.microsecond);
    return scheduleTime;
  }

  void createNotification(String animeUrl, String userName, String animeTitle,
      int hour, int minute) {
    final DateTime schedule = createSchedule(hour, minute);
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (isAllowed) {
        AwesomeNotifications().createNotification(
          content: NotificationContent(
              id: 10,
              summary: animeUrl,
              channelKey: 'basic_channel',
              title: 'Hello ' + userName,
              body: 'The best anime of the day is ' + animeTitle),
          schedule: NotificationCalendar.fromDate(date: schedule),
        );
      }
    });
  }

  void helloNotification() {
    _stream.listen((event) async {
      try {
        final BestTodayResult bestToday =
            await this._dataRepository.fetchBestAnimeToday();
        final AnimeInfos animeInfo = await this
            ._dataRepository
            .fetchAnimeInfos(bestToday.idAnime.toString());
        createNotification(animeInfo.url, event.data, animeInfo.title, 8, 42);
      } catch (_) {
        print("An error occurred trying to fetch the best anime of the day");
      }
    });
  }
}
