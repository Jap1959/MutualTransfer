


import 'package:connect2prof/CustomWidgets/Colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PostDesign extends StatefulWidget {
  const PostDesign({Key? key}) : super(key: key);

  @override
  State<PostDesign> createState() => _PostDesignState();
}

class _PostDesignState extends State<PostDesign> {
  bool readMore = false;
  @override
  Widget build(BuildContext context) {
    final Width=MediaQuery.of(context).size.width;
    return Container(
      width: 1000,
      height: 160,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),border: Border.all(color: Colors.grey,width: 2)
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage('https://images.wallpapersden.com/image/download/purple-sunrise-4k-vaporwave_bGplZmiUmZqaraWkpJRmbmdlrWZlbWU.jpg'),
                  ),
                Text('Name',style: TextStyle(fontFamily: 'MonoRoboto',fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white)),

              ],
            ),
            Card(
              child: Column(
                children: [
                  Text(
                    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
                    textAlign: TextAlign.center,
                    maxLines: readMore ? 100 : 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        readMore = !readMore;
                      });
                    },
                    child: Text(readMore ? "Read less" : "Read more"),
                  ),
                ],
              ),


            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.phone_outlined,color: kPrimary,),
                Icon(Icons.message_outlined,color: kPrimary,),
              ],
            ),

          ],
        ),
      ),
    );
  }
}
