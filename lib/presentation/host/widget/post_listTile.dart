import 'package:airbnb_clone/data/models/posting_model.dart';
import 'package:flutter/material.dart';

class PostListtile extends StatefulWidget {
  PostListtile({super.key, this.posting});
  PostingModel? posting;

  @override
  State<PostListtile> createState() => _PostListtileState();
}

class _PostListtileState extends State<PostListtile> {
  PostingModel? posting;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    posting = widget.posting;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(),
          color: const Color.fromARGB(255, 189, 189, 189),
        ),
        child: ListTile(
          leading: Text(
            posting!.name!,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          trailing: AspectRatio(
              aspectRatio: 3 / 2,
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Image(
                  image: posting!.displayImages!.first,
                  fit: BoxFit.fitWidth,
                ),
              )),
        ),
      ),
    );
  }
}
