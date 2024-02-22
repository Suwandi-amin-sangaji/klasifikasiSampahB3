import 'dart:io';
import 'package:hele/core/constants/color_constant.dart';
import 'package:hele/features/detection/models/plant_model.dart';
import 'package:hele/features/detection/screens/detail_screen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite_v2/tflite_v2.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class ScanScreen extends StatefulWidget {
  const ScanScreen({super.key, required this.title});

  final String title;

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  bool _loading = true;
  File _image = File("");
  List _output = [];
  final picker = ImagePicker();
  Future<List<PlantModel>?> readJsonData() async {
    try {
      String jsonString =
          await rootBundle.loadString('assets/json/model/model_tanaman.json');
      final jsonData = json.decode(jsonString);

      List<dynamic> tanamanData = jsonData;
      List<PlantModel> tempList = [];
      for (var item in tanamanData) {
        tempList.add(PlantModel.fromJson(item));
      }
      print(tempList);
      return tempList;
    } catch (e) {
      print(e);
    }
    return null;
  }

  late Future<List<PlantModel>?> futurePlantModel;

  @override
  void initState() {
    super.initState();
    futurePlantModel = readJsonData();
    setState(() {
      _loading = true;
    });
    loadModel().then((value) {
      setState(() {});
    });
  }

  detectImage(File image) async {
    var output = await Tflite.runModelOnImage(
        path: image.path,
        numResults: 24,
        threshold: 0.8,
        imageMean: 224,
        imageStd: 224);
    setState(() {
      _output = output!;
      _loading = false;
    });
  }

  loadModel() async {
    await Tflite.loadModel(
        model: 'assets/tf/model/sampah.tflite',
        labels: 'assets/tf/model/labels.txt');
  }

  @override
  void dispose() {
    super.dispose();
  }

  pickImage() async {
    var image = await picker.getImage(source: ImageSource.camera);
    // if(image == null) return null;

    setState(() {
      if (image != null) {
        _image = File(image.path);
      } else {
        return null;
      }
    });

    detectImage(_image);
  }

  pickGalleryImage() async {
    var image = await picker.getImage(source: ImageSource.gallery);
    if (image == null) return null;

    setState(() {
      _image = File(image.path);
    });

    detectImage(_image);
  }

  @override
  Widget build(BuildContext context) {
    print(_output.toString() + "TEST");
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leadingWidth: 30,
          title: const Text(
            "Scan",
            style: TextStyle(color: Colors.black),
          ),
          elevation: 1.5,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_sharp,
              color: Colors.black,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
          backgroundColor: Colors.white,
        ),
        backgroundColor: Colors.white,
        body: FutureBuilder(
            future: futurePlantModel,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: _loading
                            ? Container(
                                width: 350,
                                height: 350,
                                child: Column(
                                  children: [
                                    Image.asset(
                                      'assets/images/holder_image.png',
                                      fit: BoxFit.cover,
                                    ),
                                    SizedBox(
                                      height: 50,
                                    )
                                  ],
                                ),
                              )
                            : Container(
                                child: Column(
                                  children: [
                                    Container(
                                      width: 350,
                                      height: 300,
                                      padding: EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          boxShadow: [
                                            BoxShadow(
                                              color: ColorConstant.primaryColor
                                                  .withOpacity(0.2),
                                              blurRadius: 10,
                                              offset: Offset(0, 3),
                                            ),
                                          ]),
                                      child: Image.file(
                                        _image,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      _output.length == 0
                                          ? "Unclassified image. Please try again"
                                          : '${_output[0]['label']}', //_output[0]
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    )
                                  ],
                                ),
                              ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 40),
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          children: [
                            Visibility(
                              visible: !_loading && _output.length == 0
                                  ? false
                                  : true,
                              child: GestureDetector(
                                onTap: () {
                                  _loading
                                      ? pickImage()
                                      : Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) => DetailScreen(
                                              mapDetail: () {
                                                return snapshot.data!.elementAt(
                                                    _output[0]['index']);
                                              }(),
                                            ),
                                          ),
                                        );
                                },
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.7,
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 14),
                                  decoration: BoxDecoration(
                                    color: ColorConstant.primaryColor,
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Text(
                                    _loading ? 'Capture a Photo' : 'See Detail',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            !_loading && _output.length == 0
                                ? Container()
                                : Text("Or"),
                            SizedBox(
                              height: 12,
                            ),
                            GestureDetector(
                              onTap: () {
                                if (_loading) {
                                  pickGalleryImage();
                                } else {
                                  _image.delete();
                                  setState(() {
                                    _loading = true;
                                  });
                                }
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.7,
                                alignment: Alignment.center,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 14),
                                decoration: BoxDecoration(
                                  color: ColorConstant.primaryColor,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  _loading ? 'Select a Photo' : "Retry",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                );
              } else {
                return CircularProgressIndicator();
              }
            }),
      ),
    );
  }
}
