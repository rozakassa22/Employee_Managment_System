import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:employee_management_system/presentation/presentation_index.dart';

class NotificationListScreen extends StatelessWidget {
  NotificationListScreen({Key? key}) : super(key: key);

  AuthenticatedUser? loggedInUser = UserDataProvider.authenticatedUser;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Notifications List"),
        ),
        body: BlocBuilder<MessageBloc, MessageState>(builder: (_, state) {
          if (state is MessageFailure) {
            return const Text('Could get empoyee attendance');
          }
          if (state is RecivedMessagesLoaded) {
            final List<ReceivedMessageModel> messages = state.messages;
            if (messages.isNotEmpty) {
              return Padding(
                padding: const EdgeInsets.only(
                  left: 16,
                  right: 16,
                  top: 0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Notification List',
                      style: Theme.of(context).textTheme.headline1,
                    ),
                    const SizedBox(height: 16),
                    ListView.separated(
                      primary: false,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: messages.length,
                      itemBuilder: (context, index) {
                        ReceivedMessageModel message = messages[index];
                        return GestureDetector(
                          onTap: () {
                            GoRouter.of(context)
                                .push('/notification-details', extra: message);
                          },
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CircleAvatar(
                                maxRadius: 20,
                                child: Text(
                                  message.message_sender!.substring(0, 1),
                                  style: const TextStyle(fontSize: 10),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Text('From: ${message.message_sender}',
                                    style:
                                        TextStyle(fontSize: 12)),
                              ),
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(height: 16);
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              );
            }
          }
          return Container();
        }),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              BlocProvider.of<MessageBloc>(context).add(GetRecivedMessages(
                  token: loggedInUser!.token.toString(),
                  userId: loggedInUser!.id!));
              GoRouter.of(context).pop();
            },
            child: Icon(Icons.refresh_rounded)),
      ),
    );
  }
}
