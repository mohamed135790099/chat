import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


//to return image to imageprovider put Image.image
class UserImagePicker extends StatefulWidget {
  UserImagePicker(this.imagePickFn );
  final void Function(XFile? imagePicker)imagePickFn;



  @override
  _UserImagePickerState createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  XFile? _imagePicker ;
  //image picker for web
  /*
    Image? pickedImage;
    void _pickerImageWeb()async{
    Object? fromPicker = await ImagePickerWeb.getImage(outputType: ImageType.widget) ;

    if (fromPicker != null) {
      setState(() {
        pickedImage = fromPicker as Image? ;
      });
    }
  }

  */
  List<XFile>? _imageFileList;


  set _imageFile(XFile? value) {
    _imageFileList = value == null ? null : [value];
  }



  void _pickerImage(ImageSource src) async {
    XFile? _file;
    _file = await ImagePicker().pickImage(source: src);

    if (_file != null) {
      setState(() {
        _imageFile = _file;
        _imagePicker=_file;
       // _imagePicker = File(_file!.path);
      });
      widget.imagePickFn(_imagePicker);
    } else {
      debugPrint('No Image Selector');
    }
  }

  @override
  Widget build(BuildContext context) {
    var index=0;
    return Column(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundColor: Colors.grey,
          backgroundImage: _imageFileList != null ?Image.file(File(_imageFileList![index].path)).image : null,
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            FlatButton.icon(
              textColor:Theme.of(context).primaryColor,
              onPressed: () => _pickerImage(ImageSource.camera),
              icon: const Icon(Icons.photo_camera_outlined),
              label: const Text('Add Image\nfrom Camera',textAlign:TextAlign.center,),
            ),
            FlatButton.icon(
              textColor:Theme.of(context).primaryColor,
              onPressed: () => _pickerImage(ImageSource.gallery),
              icon: const Icon(Icons.image_outlined),
              label: const Text('Add Image\nfrom Gallery',textAlign:TextAlign.center,),
            ),
          ],
        )
      ],
    );
  }
}
