import 'dart:ffi';

import 'package:chat2p/appbar_page.dart';
import 'package:flutter/material.dart';

class CreateRoom extends StatefulWidget {
  const CreateRoom({super.key, required this.typeRoom});
  final String typeRoom;

  @override
  State<CreateRoom> createState() => _CreateRoomState();
}

class _CreateRoomState extends State<CreateRoom> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _desController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var _typeRoom = typeRoom(); //'room';
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
        title: _typeRoom == 'room'
            ? const Text('Criar sala')
            : const Text('Criar Canal'),
      ),
      body: SingleChildScrollView(
        reverse: true,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Icon(Icons.accessibility_new_rounded),
                  Container(
                      width: 200,
                      height: 200,
                      child: CircleAvatar(
                        foregroundImage: NetworkImage(
                            'https://ramenparados.com/wp-content/uploads/2019/03/no-avatar-png-8.png'),
                      )),
                  IconButton(
                      onPressed: () {}, icon: Icon(Icons.camera_alt_rounded))
                ],
              ),
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Nome',
                  suffixIcon: Icon(Icons.abc),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              TextField(
                controller: _desController,
                decoration: const InputDecoration(
                  labelText: 'Descrição',
                  suffixIcon: Icon(Icons.edit_document),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              ElevatedButton(onPressed: () {}, child: Text('Criar'))
            ],
          ),
        ),
      ),
    );
  }
}
