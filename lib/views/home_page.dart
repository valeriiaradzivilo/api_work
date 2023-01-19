import 'dart:math';

import 'package:flutter/material.dart';
import 'package:rest_api_work/models/comments.dart';
import 'package:rest_api_work/services/remote_service.dart';
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Comment>? comments;

  var isLoaded = false;

  @override
  void initState(){
    super.initState();

    // fetch data from api
    getData();
  }

  getData()
  async{
    comments = await RemoteService().getComments();
    if(comments!=null)
      {
        setState(() {
          isLoaded = true;
        });
      }
  }
  Random random = Random();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Visibility(
        visible: isLoaded,
        replacement: const Center(
          child: CircularProgressIndicator(),
        ),
        child: ListView.builder(
          itemCount: comments?.length,
            itemBuilder: (context, index){
          return Container(
            child: Row(
              children: [
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Color.fromARGB(random.nextInt(255), random.nextInt(255), random.nextInt(255), random.nextInt(255)),
                  ),
                ),
                SizedBox(width: 10,),
                Expanded(
                  child: Column(
                    children: [
                      Text(comments![index].name
                        ,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 24,
                        fontWeight: FontWeight.bold),
                      ),
                      Text(
                      comments![index].body ?? "no comment provided",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 24),),
                      SizedBox(height: 10,),
                    ],
                  ),
                ),

              ],
            ),
          );
        }),
      )
    );
  }
}
