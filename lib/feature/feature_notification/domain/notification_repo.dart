abstract class NotificationRepo {
  Future<void> init();
  Future<void> showNotification({required String title, required String body});
}
