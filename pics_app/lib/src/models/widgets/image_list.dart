import 'package:flutter/material.dart';
import 'package:pics_app/src/models/image_model.dart';

class ImageList extends StatelessWidget {
  final List<ImageModel> images;

  ImageList(this.images);

  @override
  Widget build(context) {
    return ListView.builder(
      itemCount: images.length,
      itemBuilder: (context, int index) {
        return buildImage(images[index]);
      } 
    );
  }

  Widget buildImage(ImageModel image) {
    return Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey)
          ),
          padding: const EdgeInsets.all(20.0),
          margin: const EdgeInsets.all(20.0),
          child: Column(
            children: <Widget>[
              Padding(
                child: Image.network(image.url),
                padding: EdgeInsets.only(
                  bottom: 8.0,
                ),
              ),
              Text(image.title),
            ],
          ),
        );
  }

}