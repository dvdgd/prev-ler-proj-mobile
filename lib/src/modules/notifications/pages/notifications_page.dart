import 'package:flutter/material.dart';
import 'package:prev_ler/src/config/routes.dart';
import 'package:prev_ler/src/modules/exercises/pages/exercise_details_page.dart';
import 'package:prev_ler/src/modules/notifications/shared/notification_controller.dart';
import 'package:prev_ler/src/shared/entities/notification.dart';
import 'package:prev_ler/src/shared/ui/components/page_title.dart';
import 'package:prev_ler/src/shared/ui/components/sliver_center_text.dart';
import 'package:prev_ler/src/shared/ui/widgets/my_card.dart';
import 'package:prev_ler/src/shared/utils/enums.dart';
import 'package:provider/provider.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  late final NotificationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = context.read<NotificationController>();
    _controller.addListener(_handleStateChange);

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _controller.getNotifications();
    });
  }

  @override
  void dispose() {
    _controller.removeListener(_handleStateChange);
    super.dispose();
  }

  _handleStateChange() {
    if (_controller.state == StateEnum.error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(_controller.errorMessage)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<NotificationController>();
    final notifications = controller.notifications;

    final emptyNotifications = notifications.isEmpty;
    final loading = controller.state == StateEnum.loading;

    return Scaffold(
      appBar: AppBar(
        title: const PageTitle(
          title: 'Notificações',
        ),
      ),
      bottomNavigationBar: loading ? const LinearProgressIndicator() : null,
      body: RefreshIndicator(
        onRefresh: () async {
          controller.getNotifications();
        },
        child: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            if (emptyNotifications && !loading)
              const SliverCenterText(
                message: 'Não existem notificações para exibir.',
              ),
            if (!emptyNotifications)
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  childCount: notifications.length,
                  (context, index) => Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    child: _NotificationCard(notifications[index]),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _NotificationCard extends StatelessWidget {
  const _NotificationCard(this.notification);

  final NotificationData notification;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final now = DateTime.now();
    final isBeforeToday = now.isBefore(notification.time);

    return MyCard(
      padding: const EdgeInsets.all(20),
      onTap: () {
        if (!notification.sent && isBeforeToday) {
          context.read<NotificationController>().markAsRead(notification);
        }

        final exercise = notification.exercise;
        if (exercise != null) {
          Navigator.of(Routes.navigatorKey.currentContext!).push(
            MaterialPageRoute(
              builder: (context) => ExerciseDetailsPage(
                exercise: exercise,
              ),
            ),
          );
        }
      },
      child: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                if (!notification.sent && isBeforeToday)
                  Container(
                    width: 6,
                    height: 6,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                const SizedBox(width: 6),
                Text(
                  notification.title,
                  style: textTheme.titleMedium,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ],
            ),
            const SizedBox(height: 7),
            Text(
              notification.message,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.justify,
              style: textTheme.bodySmall,
            ),
            const SizedBox(height: 7),
            Text(
              'Horario: ${notification.time.toLocal()}',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.justify,
              style: textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}
