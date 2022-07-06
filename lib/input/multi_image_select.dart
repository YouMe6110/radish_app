import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:radish_app/constants/common_size.dart';

class MultiImageSelect extends StatelessWidget {
  const MultiImageSelect({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        Size _size = MediaQuery.of(context).size;
        var imgSize = _size.width / 3;
        return SizedBox(
          height: _size.width / 3,
          width: _size.width / 3,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              Padding(
                padding: const EdgeInsets.all(common_sm_padding),
                child: Container(
                  width: imgSize,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.grey, width: 2),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.camera_alt_rounded, color: Colors.grey),
                      Text('0/10',
                          style: Theme.of(context).textTheme.subtitle2),
                    ],
                  ),
                ),
              ),
              ...List.generate(
                100,
                (index) => Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          top: common_sm_padding,
                          bottom: common_sm_padding,
                          right: common_sm_padding),
                      child: ExtendedImage.network(
                        'https://picsum.photos/200',
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    Positioned(
                      right: 0,
                      top: 0,
                      width: 40,
                      height: 40,
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {},
                        icon: Icon(Icons.remove_circle,
                            size: 30, color: Colors.red[300]),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
