import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../application/application_index.dart';

class SentNotificationListScreen extends StatelessWidget {
  SentNotificationListScreen({Key? key}) : super(key: key);
  AuthenticatedUser? loggedInUser = UserDataProvider.authenticatedUser;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Sent Announcements List"),
        ),
        body: BlocBuilder<MessageBloc, MessageState>(builder: (_, state) {
          if (state is MessageFailure) {
            return const Text('Could get empoyee attendance');
          }
          if (state is SentMessagesLoaded) {
            final List<MessageModel> messages = state.messages;
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
                      final message = messages[index];
                      return GestureDetector(
                        onTap: () {
                          GoRouter.of(context).push('/update-notification');
                          BlocProvider.of<MessageBloc>(context)
                              .add(GetMessageDetail(
                            token: loggedInUser!.token.toString(),
                            messageId: message.id!,
                          ));
                        },
                        child: SizedBox(
                          height: 50,
                          child: Card(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const CircleAvatar(
                                  maxRadius: 20,
                                  child: Text(
                                    "o",
                                    style: TextStyle(fontSize: 10),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Text('Message: ${message.message}',
                                      style: TextStyle(fontSize: 12)),
                                ),
                                const SizedBox(width: 16),
                                SizedBox(
                                    width: 100,
                                    child: ElevatedButton(
                                      child: Text("Delete"),
                                      onPressed: () {
                                        BlocProvider.of<MessageBloc>(context)
                                            .add(
                                          DeleteNotificationDetail(
                                              token: loggedInUser!.token
                                                  .toString(),
                                              senderId: loggedInUser!.id!,
                                              messageId: message.id!),
                                        );
                                        GoRouter.of(context).pop();
                                      },
                                    ))
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(height: 16);
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  )
                ],
              ),
            );
          }
          return Container();
        }),
      ),
    );
  }
}
