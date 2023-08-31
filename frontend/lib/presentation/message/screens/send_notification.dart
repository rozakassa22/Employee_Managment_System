import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:employee_management_system/presentation/presentation_index.dart';

class SendNotification extends StatelessWidget {
  SendNotification({Key? key}) : super(key: key);

  AuthenticatedUser? loggedInUser = UserDataProvider.authenticatedUser;

  final formKey = GlobalKey<FormState>();

  final messageController = TextEditingController();

  final reciverController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Send Notifcations"),
        ),
        body: Container(
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
                        CustomEmailField(
                          controller: reciverController,
                          labelText: "For",
                          hintText: "receiver email",
                          validator: (String? email) {
                            if (email == null || email.isEmpty) {
                              return "Reciver must not be empty!";
                            }
                            final validEmail =
                                RegExp("[A-Za-z]@[A-Za-z].[A-Za-z]");
                            final correct = validEmail.hasMatch(email);

                            return correct ? null : "Enter a valid email";
                          },
                        ),
                        const SizedBox(
                          height: 30,
                        ),
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
                      if (state is MessageSentSuccessfully) {
                        GoRouter.of(context).pop();
                      }
                    },
                    child: InkWell(
                      child: SizedBox(
                          width: 200, child: SignUpContainer(st: "Send")),
                      onTap: () {
                        final formValid = formKey.currentState!.validate();
                        if (!formValid) return;
                        List<String> recivers = [];
                        recivers.add(reciverController.text);
                        (context).read<MessageBloc>().add(
                              MessageSend(
                                token: loggedInUser!.token.toString(),
                                senderId: loggedInUser!.id!,
                                receiverEmail: recivers,
                                message: messageController.text,
                              ),
                            );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
