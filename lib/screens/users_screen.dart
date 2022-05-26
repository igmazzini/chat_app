import 'package:chat_app/models/user.dart';
import 'package:chat_app/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class UsersScreen extends StatefulWidget {
   
  const UsersScreen({Key? key}) : super(key: key);

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {


  final users = [
    User(online: false, uid: '1', name: 'Carlos', email: 'algo@algo.com'),
    User(online: true, uid: '1', name: 'Maria', email: 'algo@algo.com'),
    User(online: false, uid: '1', name: 'Mirta', email: 'algo@algo.com'),
    User(online: true, uid: '1', name: 'Pedro', email: 'algo@algo.com'),
    User(online: false, uid: '1', name: 'Manuel', email: 'algo@algo.com'),
  ];

  final RefreshController _refreshController =  RefreshController(initialRefresh: false);


  @override
  Widget build(BuildContext context) {

    final authService = Provider.of<AuthService>(context);

    return  Scaffold(
      appBar: AppBar(
        title:  Text(authService.user.name, style: const TextStyle(color: Colors.black54 ),),
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon:  Icon(Icons.exit_to_app_outlined, color: Colors.red[500],),
          onPressed: () async {
            await authService.logout();
            Navigator.pushReplacementNamed(context, 'login');
          },),
          actions: [
            Container(
              margin: const EdgeInsets.only(right: 10),
              child: const Icon(Icons.check_circle_outline, color: Colors.green,),
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
    // monitor network fetch
    await Future.delayed(const Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }
}