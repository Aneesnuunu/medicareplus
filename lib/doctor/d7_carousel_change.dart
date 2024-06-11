import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Theam/theme.dart';
import '../provider/d7_model.dart';
import '../widget/appbar.dart';

class ImageUploadPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ImageUploadModel(),
      child: _ImageUploadPageContent(),
    );
  }
}

class _ImageUploadPageContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final model = Provider.of<ImageUploadModel>(context);

    return Scaffold(
      appBar: const CustomAppBar(
        title: "Carousel Change",
      ),
      body: Stack(
        children: [
          Column(
            children: [
              const SizedBox(height: 20),
              model.images.isNotEmpty
                  ? SizedBox(
                height: 200,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: model.images.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.file(model.images[index]),
                    );
                  },
                ),
              )
                  : Container(height: 200, color: Colors.grey[200]),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(11))),
                  backgroundColor: AppThemeData.primaryColor,
                ),
                onPressed: model.pickImages,
                child: const Text(
                  'Select Images',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(11))),
                  backgroundColor: AppThemeData.primaryColor,
                ),
                onPressed: model.isUploading ? null : model.uploadImages,
                child: const Text(
                  'Upload Images',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(height: 20,),
              const Text("Available Images",style: TextStyle(color: Colors.white,fontSize: 20),),
              const SizedBox(height: 20,),
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: model.firestore.collection('carousel_images').snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    final documents = snapshot.data!.docs;
                    return GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 4.0,
                        mainAxisSpacing: 4.0,
                      ),
                      itemCount: documents.length,
                      itemBuilder: (context, index) {
                        final imageUrl = documents[index]['url'] as String;
                        return Stack(
                          children: [
                            GestureDetector(
                              onTap: () {
                                // Do nothing when the image is tapped
                              },
                              child: Image.network(
                                imageUrl,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Positioned(
                              top: 5,
                              right: 5,
                              child: GestureDetector(
                                onTap: () {
                                  _showDeleteConfirmation(context, documents[index].id, model);
                                },
                                child: const CircleAvatar(
                                  radius: 10,
                                  backgroundColor: Colors.red,
                                  child: Icon(
                                    Icons.delete,
                                    color: Colors.white,
                                    size: 15,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
          if (model.isUploading)
            Center(
              child: Container(
                child: const CircularProgressIndicator(),
              ),
            ),
        ],
      ),
    );
  }

  Future<void> _showDeleteConfirmation(BuildContext context, String documentId, ImageUploadModel model) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppThemeData.backgroundBlack,
          title: const Text('Delete Image',style: TextStyle(color: Colors.white),),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Are you sure you want to delete this image?',style: TextStyle(color: Colors.white),),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                model.deleteImage(documentId);
                Navigator.of(context).pop();
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }
}
