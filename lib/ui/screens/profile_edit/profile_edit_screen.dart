import 'dart:io';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:beauty_textfield/beauty_textfield.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:users/users_repository.dart';

import 'package:ani_list/logic/bloc/bloc.dart';
import 'package:ani_list/logic/cubit/cubit.dart';
import 'package:ani_list/constants/constants.dart';
import 'package:ani_list/ui/screens/profile/widgets/avatar.dart';
import 'package:ani_list/ui/widgets/custom_progress_indicator.dart';

class ProfileEditScreen extends StatefulWidget {
  ProfileEditScreen({Key key}) : super(key: key);

  @override
  _ProfileEditScreenState createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  String _name;
  String _bio;
  File _image;
  String _url;

  Widget _buildAppBar() => AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        leading: IconButton(
            icon: Icon(FontAwesomeIcons.arrowLeft, color: Colors.white),
            onPressed: () => Navigator.of(context).pop()),
        centerTitle: true,
        title: Text('Edit',
            style: Theme.of(context)
                .textTheme
                .headline5
                .copyWith(color: Colors.white)),
      );

  Widget _buildBottomBar(User user) => BottomAppBar(
        color: Colors.transparent,
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Material(
            elevation: 5.0,
            borderRadius: BorderRadius.circular(30.0),
            color: Colors.green,
            child: MaterialButton(
              minWidth: MediaQuery.of(context).size.width,
              onPressed: () {
                if (_image != null) {
                  context.read<StorageBloc>().add(UploadImage(_image, user.id));
                }
                User newUser = User(
                    user.id,
                    user.email,
                    _name ?? user.name,
                    _url == null ? user.photo : _url,
                    _bio ?? user.bio,
                    user.favs,
                    user.animesList,
                    user.admin);
                context.read<UserBloc>().add(UpdateUser(newUser));
              },
              child: Text(
                'SAVE',
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .headline6
                    .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      );

  Widget _buildTextField(
          String placeholder, IconData data, Function onChanged) =>
      BeautyTextfield(
        width: double.maxFinite,
        height: 60,
        textColor: Colors.black87,
        backgroundColor: Theme.of(context).primaryColor,
        inputType: TextInputType.text,
        wordSpacing: 1,
        prefixIcon: Icon(data),
        cornerRadius: BorderRadius.all(Radius.circular(30)),
        minLines: 1,
        placeholder: placeholder,
        onChanged: onChanged,
        onSubmitted: (text) => {},
      );

  // BlocProvider.of<UserBloc>(blocContext).state.user.id;

  Future<void> _showDialog() async {
    TextTheme textTheme = Theme.of(context).textTheme;
    await showDialog(
        context: context,
        builder: (BuildContext buildContext) {
          return SimpleDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              title: Text("Change profile picture", style: textTheme.headline5),
              children: <Widget>[
                SimpleDialogOption(
                  onPressed: () {
                    BlocProvider.of<ImageCubit>(context).pickImage(false);
                    Navigator.pop(buildContext);
                  },
                  child: Text('Pick From Gallery', style: textTheme.subtitle1),
                ),
                SimpleDialogOption(
                  onPressed: () {
                    BlocProvider.of<ImageCubit>(context).pickImage(true);
                    Navigator.pop(buildContext);
                  },
                  child: Text('Take New Picture', style: textTheme.subtitle1),
                ),
              ]);
        });
  }

  @override
  Widget build(BuildContext context) {
    final User user = context.select((UserBloc bloc) => bloc.state.user);
    return MultiBlocListener(
      listeners: [
        BlocListener<StorageBloc, StorageState>(
          listener: (context, state) {
            switch (state.status) {
              case StorageStatus.Loading:
                CustomProgressIndicator();
                break;
              case StorageStatus.UploadSuccess:
                _url = state.path;
                break;
              case StorageStatus.Error:
                Text('Upload image error');
                break;
              default:
                break;
            }
          },
        ),
        BlocListener<UserBloc, UserState>(
          listener: (context, state) {
            switch (state.status) {
              case UserStatus.Loading:
                CustomProgressIndicator();
                break;
              case UserStatus.Success:
                return Navigator.of(context).pop();
              case UserStatus.Error:
                break;
              default:
                break;
            }
          },
        ),
      ],
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: _buildAppBar(),
        body: Container(
          height: MediaQuery.of(context).size.height,
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 40.0),
                  child: GestureDetector(
                    onTap: () => _showDialog(),
                    child: BlocBuilder<ImageCubit, ImageState>(
                      builder: (context, state) {
                        if (state is ImageLoading) {
                          return CustomProgressIndicator();
                        } else if (state is ImageLoaded) {
                          _image = state.image;
                        }
                        return Avatar(
                            url: _image == null ? user?.photo : null,
                            imageFile: _image);
                      },
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                _buildTextField(user?.name, FontAwesomeIcons.userAlt,
                    (text) => _name = text),
                _buildTextField(user?.bio, FontAwesomeIcons.penFancy,
                    (text) => _bio = text),
              ],
            ),
          ),
        ),
        bottomNavigationBar: _buildBottomBar(user),
      ),
    );
  }
}
