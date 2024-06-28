import 'package:acumap/model/gallery.dart';
import 'package:acumap/ui/common/app_colors.dart';
import 'package:acumap/ui/common/ui_helpers.dart';
import 'package:flutter/material.dart';

class SubView extends StatelessWidget {
  final GalleryMain data;
  const SubView({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kblue,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(
            Icons.arrow_back_ios_new,
            color: kgold,
            size: 30,
          ),
        ),
        centerTitle: true,
        title: Text(
          data.name.toString().toUpperCase(),
          style: const TextStyle(
            fontSize: 25,
            fontFamily: "Poppins",
            fontWeight: FontWeight.w900,
            color: kgold,
          ),
        ),
      ),
      body: ListView.builder(
          itemCount: data.subs!.length,
          itemBuilder: (BuildContext ctxt, int index) {
            return Padding(
              padding: const EdgeInsets.only(
                  top: 10.0, bottom: 3, left: 15, right: 15),
              child: Column(
                children: [
                  Container(
                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: kblue,
                        borderRadius: BorderRadius.circular(25),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          alignment: Alignment.center,
                          matchTextDirection: true,
                          repeat: ImageRepeat.noRepeat,
                          image: AssetImage(data.subs![index].image!),
                        )),

                    // child: Image.asset(
                    //   data.subs!.first.image!,
                    //   fit: BoxFit.cover,
                    // )
                    // Text(
                    //   data.subs!.first.name!,
                    //   style: const TextStyle(
                    //     fontSize: 25,
                    //     fontFamily: "Poppins",
                    //     fontWeight: FontWeight.w900,
                    //     color: kgold,
                    //   ),
                    // ),
                  ),
                  verticalSpaceSmall,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        data.subs![index].name!,
                        style: const TextStyle(
                          fontSize: 18,
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w900,
                          color: kblue,
                        ),
                      ),
                    ],
                  ),
                  verticalSpaceSmall,
                ],
              ),
            );
          }),
    );
  }
}
