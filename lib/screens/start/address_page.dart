import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:radish_app/utils/logger.dart';

class AddressPage extends StatelessWidget {
  const AddressPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      minimum: EdgeInsets.all(16.0),

      child: Column(
        children: [

          TextFormField(
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.search,
                color: Colors.grey,
              ),
              prefixIconConstraints: BoxConstraints(
                  minWidth: 24,
                  minHeight: 24
              ),
              border: UnderlineInputBorder(
                borderSide: BorderSide(
                    color: Colors.grey),
              ),
              hintText: '도로명으로 검색하세요.',
              hintStyle: TextStyle(color: Theme.of(context).hintColor),
            ),
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextButton.icon(
                onPressed: () {},
                icon: Icon(
                    CupertinoIcons.compass,
                    color: Colors.white
                ),
                label: Text('현재 위치로 찾기',
                  style: Theme.of(context).textTheme.button,
                ),
                style: TextButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor),
              ),
            ],),

          Expanded(
            child: ListView.builder(
                padding: EdgeInsets.symmetric(vertical: 16),
                itemCount: 30,
                itemBuilder: (context, index){
                  return ListTile(
                    title: Text('address $index'),
                    subtitle: Text('details $index'),
                  );
                }
            ),
          ),

        ],),
    );

  }
}