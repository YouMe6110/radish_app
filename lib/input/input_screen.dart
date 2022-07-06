import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:beamer/beamer.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:radish_app/constants/common_size.dart';

import 'multi_image_select.dart';

class InputScreen extends StatefulWidget {
  const InputScreen({Key? key}) : super(key: key);

  @override
  _InputScreenState createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {
  var _divider = Divider(
    height: 1,
    color: Colors.grey[300],
    thickness: 1,
    indent: common_bg_padding,
    endIndent: common_bg_padding,
  );

  var _border =
      UnderlineInputBorder(borderSide: BorderSide(color: Colors.transparent));

  bool _suggestPriceSelected = false;

  TextEditingController _priceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: TextButton(
          onPressed: () {
            context.beamBack(); //뒤로가기 속성 가져오기
          },
          style: TextButton.styleFrom(
              backgroundColor: Theme.of(context).appBarTheme.backgroundColor),
          child: Text('뒤로', style: Theme.of(context).textTheme.bodyText2),
        ),
        actions: [
          TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(
                backgroundColor: Theme.of(context).appBarTheme.backgroundColor),
            child: Text('완료', style: Theme.of(context).textTheme.bodyText2),
          ),
        ],
        title: Text(
          '중고상품 업로드',
          style: Theme.of(context).textTheme.headline6,
        ),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          MultiImageSelect(),
          SizedBox(
            height: 15,
          ),
          _divider,
          TextFormField(
            decoration: InputDecoration(
              contentPadding:
                  EdgeInsets.symmetric(horizontal: common_bg_padding),
              hintText: '상품 제목',
              border: _border,
              enabledBorder: _border,
              focusedBorder: _border,
            ),
          ),
          _divider,
          ListTile(
            dense: true,
            title: Text('카테고리 선택'),
            trailing: Icon(Icons.navigate_next),
          ),
          _divider,
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  inputFormatters: [
                    MoneyInputFormatter(trailingSymbol: '원', mantissaLength: 0),
                  ],
                  controller: _priceController,
                  onChanged: (value) {
                    setState(() {
                      if (value == '0원') {
                        _priceController.clear();
                      }
                    });
                  },
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: common_bg_padding),
                    hintText: '상품가격을 입력하세요',
                    border: _border,
                    enabledBorder: _border,
                    focusedBorder: _border,
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: common_bg_padding),
                child: TextButton.icon(
                  onPressed: () {
                    setState(() {
                      _suggestPriceSelected = !_suggestPriceSelected;
                    });
                  },
                  label: Text(
                    '가격 제안 받기',
                    style: TextStyle(
                        color: _suggestPriceSelected
                            ? Theme.of(context).primaryColor
                            : Colors.black54),
                  ),
                  icon: Icon(
                      _suggestPriceSelected
                          ? Icons.check_circle
                          : Icons.check_circle_outline,
                      color: _suggestPriceSelected
                          ? Theme.of(context).primaryColor
                          : Colors.black54),
                  style: TextButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      primary: Colors.black38),
                ),
              ),
            ],
          ),
          _divider,
          TextFormField(
            maxLines: null,
            keyboardType: TextInputType.multiline,
            decoration: InputDecoration(
              contentPadding:
                  EdgeInsets.symmetric(horizontal: common_bg_padding),
              hintText: '상품 및 필요한 세부설명을 입력해주세요.',
              border: _border,
              enabledBorder: _border,
              focusedBorder: _border,
            ),
          ),
        ],
      ),
    );
  }
}
