import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../presentation_index.dart';

class UpdateNotificationDetail extends StatelessWidget {
  UpdateNotificationDetail({Key? key}) : super(key: key);
  AuthenticatedUser? loggedInUser = UserDataProvider.authenticatedUser;

  final formKey = GlobalKey<FormState>();

  final messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Update Notification Detail"),
        ),
        body: BlocBuilder<MessageBloc, MessageState>(
          builder: (context, state) {
            if (state is MessageFailure) {
              // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              //   duration: Duration(seconds: 1),
              //   content: Text('could not get message details'),
              // ));
              return Center(
                child: Text('could not get message details'),
              );
              GoRouter.of(context).pop();
            }
            if (state is MessageDetailLoaded) {
              return Container(
                padding: const EdgeInsets.all(40),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.amber, width: 1),
                  ),
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 30),
                        Container(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Message:",
                                  style: GoogleFonts.roboto(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black,
                                  )),
                              const SizedBox(
                                height: 10,
                              ),
                              TextField(
                                controller: messageController,
                                keyboardType: TextInputType.multiline,
                                maxLines: 20,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      width: 1,
                                      color: Colors.orange,
                                    ),
                                  ),
                                  hintText: "Enter your message here",
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        BlocListener<MessageBloc, MessageState>(
                          listener: (_, MessageState state) {
                            if (state is MessageFailure) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                duration: Duration(seconds: 2),
                                content: Text('Couldnot send message'),
                              ));
                            }
                            if (state is NotificationDetailUpdated) {
                              GoRouter.of(context).pop();
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                duration: Duration(seconds: 2),
                                content: Text('message updated'),
                              ));
                            }
                          },
                          child: InkWell(
                            child: SizedBox(
                                width: 200, child: SignUpContainer(st: "Send")),
                            onTap: () {
                              final formValid =
                                  formKey.currentState!.validate();
                              if (!formValid) return;
                              (context).read<MessageBloc>().add(
                                    UpdateMessage(
                                        token: loggedInUser!.token.toString(),
                                        message: messageController.text,
                                        messageId: state.message.id!,
                                        senderId: loggedInUser!.id!),
                                  );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
