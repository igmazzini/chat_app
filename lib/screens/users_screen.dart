import 'package:chat_app/models/user.dart';
import 'package:chat_app/services/auth_service.dart';
import 'package:chat_app/services/chat_service.dart';
import 'package:chat_app/services/users_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../services/socket_service.dart';

class UsersScreen extends StatefulWidget {
   
  const UsersScreen({Key? key}) : super(key: key);

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {


 /*  final users = [
    User(online: false, uid: '1', name: 'Carlos', email: 'algo@algo.com'),
    User(online: true, uid: '1', name: 'Maria', email: 'algo@algo.com'),
    User(online: false, uid: '1', name: 'Mirta', email: 'algo@algo.com'),
    User(online: true, uid: '1', name: 'Pedro', email: 'algo@algo.com'),
    User(online: false, uid: '1', name: 'Manuel', email: 'algo@algo.com'),
  ]; */

  final usersService = UsersService();

  final RefreshController _refreshController =  RefreshController(initialRefresh: false);

  List<User> users = [];


  @override
  void initState() {


    _loadUsers(); 
    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    final authService = Provider.of<AuthService>(context);
    final socketService = Provider.of<SocketService>(context);

    return  Scaffold(
      appBar: AppBar(
        title:  Text(authService.user.name, style: const TextStyle(color: Colors.black54 ),),
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.exit_to_app_outlined, color: Colors.red[500],),
          onPressed: () async {

            await authService.logout();

            socketService.disconnect();

            Navigator.pushReplacementNamed(context, 'login');

          },),
          actions: [
            Container(
              margin: const EdgeInsets.only(right: 10),
              child: (socketService.serverStatus == ServerStatus.online)  ? const Icon(Icons.check_circle_outline, color: Colors.green,) : const Icon(Icons.offline_bolt_outlined, color: Colors.red,),
            )
          ],
      ),
      body:SmartRefresher(
        controller: _refreshController,
        enablePullDown: true,
        header: WaterDropHeader(
          complete: Icon(Icons.check, color:Colors.blue[400]),
          waterDropColor: Colors.blue[400]!,
        ),
        onRefresh: _loadUsers,
        child: _usersListView(),
      ),
    );
  }

  ListView _usersListView() {
    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      itemBuilder: ( _ , i ) => _userListTile(users[i]),
      separatorBuilder: ( _ , i ) => const Divider(),
      itemCount: users.length
      );
  }

  ListTile _userListTile(User user) {
    return ListTile(
        onTap: () {
          _onUserTap(user);
        },
        leading: CircleAvatar(
          backgroundColor: Colors.blue[100],
          child: Text(user.name.substring(0,2)), 
        ),
        trailing: Container(
          width: 15,
          height: 15,            
          decoration: BoxDecoration(
            color: (user.online) ? Colors.green : Colors.red,
            borderRadius: BorderRadius.circular(10)
          ),
        ),
        title: Text(user.name),
        subtitle: Text(user.email),
        );
  }

 
  void _loadUsers() async{  
    

    users = await usersService.getUsers();

    setState(() {});


    _refreshController.refreshCompleted();

  }

  void _onUserTap(User user) {

    final chatService = Provider.of<ChatService>(context, listen: false);

    chatService.chatUser = user;

    Navigator.pushNamed(context, 'chat');
    
  }
}