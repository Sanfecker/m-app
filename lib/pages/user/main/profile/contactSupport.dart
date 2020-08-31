import 'package:flutter/material.dart';
import 'package:nuvlemobile/components/inputs/inputBox.dart';
import 'package:nuvlemobile/misc/functions.dart';
import 'package:nuvlemobile/models/providers/user/supportTicketProvider.dart';
import 'package:nuvlemobile/models/skeltons/api/apiRequestModel.dart';
import 'package:nuvlemobile/models/skeltons/menus/supportTicket.dart';
import 'package:nuvlemobile/models/skeltons/user/userAccount.dart';
import 'package:provider/provider.dart';

class ContactSupport extends StatefulWidget {
  final UserAccount userAccount;

  const ContactSupport({Key key, @required this.userAccount}) : super(key: key);
  @override
  _ContactSupportState createState() => _ContactSupportState();
}

class _ContactSupportState extends State<ContactSupport> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  SupportTicket _supportTicket = SupportTicket();
  FocusNode _messageTitleFN = FocusNode(), _messageFN = FocusNode();

  bool _autoValidate = false;

  @override
  void dispose() {
    _messageTitleFN.dispose();
    _messageFN.dispose();
    super.dispose();
  }

  _handleSubmitted(BuildContext ctx) async {
    Functions().showLoadingDialog(ctx);
    FormState form = _formKey.currentState;
    if (!form.validate()) {
      _autoValidate = true;
      Navigator.pop(ctx);
      showInSnackBar('Please fix the errors in red before submitting.');
    } else {
      form.save();
      try {
        ApiRequestModel apiRequestModel =
            await Provider.of<SupportTicketProvider>(context, listen: false)
                .sendMessage(_supportTicket, widget.userAccount);
        if (apiRequestModel.isSuccessful) {
          Navigator.pop(ctx);
          _formKey.currentState.reset();
          showInSnackBar("Message successfully sent");
        } else {
          Navigator.pop(ctx);
          showInSnackBar(apiRequestModel.errorMessage);
        }
      } catch (e) {
        Navigator.pop(ctx);
        showInSnackBar("Internal Error");
      }
    }
  }

  void showInSnackBar(String value) {
    _scaffoldKey.currentState
        .showSnackBar(new SnackBar(content: new Text(value)));
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(elevation: 0),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                width: screenSize.width * 0.60,
                margin: EdgeInsets.only(bottom: 60, top: 20),
                child: Text(
                  "Contact Support",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                ),
              ),
              Form(
                key: _formKey,
                autovalidate: _autoValidate,
                child: Column(
                  children: <Widget>[
                    InputBox(
                      bottomMargin: 30,
                      labelText: "Message Title",
                      hintText: "Enter your message title",
                      textInputType: TextInputType.text,
                      enableSuggestions: true,
                      focusNode: _messageTitleFN,
                      nextFocusNode: _messageFN,
                      textInputAction: TextInputAction.next,
                      onSaved: (String val) {
                        _supportTicket.title = val;
                      },
                    ),
                    InputBox(
                      bottomMargin: 30,
                      labelText: "Message\n",
                      hintText: "Type your message here",
                      enableSuggestions: true,
                      textInputType: TextInputType.text,
                      // textInputAction: TextInputAction.newline,
                      maxLines: 5,
                      submitAction: () => _handleSubmitted(context),
                      focusNode: _messageFN,
                      onSaved: (String val) {
                        _supportTicket.message = val;
                      },
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 50, horizontal: 20),
                      child: Functions().customButton(
                        context,
                        onTap: () => _handleSubmitted(context),
                        width: screenSize.width,
                        text: "Send Message",
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
