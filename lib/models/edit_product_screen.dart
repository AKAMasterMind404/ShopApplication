import 'package:flutter/material.dart';

class EditProductScreen extends StatefulWidget {
  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  String imgurl1 = 'https://www.windowscentral.com/sites/wpcentral.com/files/styles/large_wm_brw/public/field/image/2021/06/windows-11-install-1.jpg';
  final _priceFocusNode = FocusNode();
  final _descFocusNode = FocusNode();
  final _imageUrlFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    _imageUrlFocusNode.addListener(_updateImageUrl);
    super.initState();
  }

  void _updateImageUrl(){
    if(!_imageUrlFocusNode.hasFocus){
      setState(() {});
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _imageUrlFocusNode.removeListener(_updateImageUrl);
    _priceFocusNode.dispose();
    _descFocusNode.dispose();
    _imageUrlController.dispose();
    _imageUrlFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Product"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Form(
          child: SingleChildScrollView(
            child: Column(
              children: [
                // TITLE
                TextFormField(
                  autocorrect: true,
                  decoration: InputDecoration(
                    labelText: "Title",
                    hintText: "Enter the title here",
                  ),
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (v) {
                    // Used to Toggle Input Focus
                    FocusScope.of(context).requestFocus(_priceFocusNode);
                  },
                ),
                // PRICE
                TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: "Price",
                    ),
                    textInputAction: TextInputAction.next,
                    focusNode: _priceFocusNode,
                    onFieldSubmitted: (v) {
                      // Used to Toggle Input Focus
                      FocusScope.of(context).requestFocus(_descFocusNode);
                    }),
                // DESCRIPTION
                TextFormField(
                  autocorrect: true,
                  decoration: InputDecoration(
                    labelText: "Description",
                    hintText: "Describe your product",
                  ),
                  focusNode: _descFocusNode,
                  maxLines: 3,
                  textInputAction: TextInputAction.next,
                ),
                Row(
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      margin: EdgeInsets.only(top: 8, right: 10),
                      decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.grey)),
                      child: _imageUrlController.text.isEmpty
                          ? Center(child: Text("Enter a URL"))
                          : FittedBox(
                              child: Image.network(
                                  _imageUrlController.text,
                                  fit: BoxFit.cover),
                            ),
                    ),
                    Expanded(
                        child: TextFormField(
                          decoration: InputDecoration(labelText: 'Image URL'),
                          keyboardType: TextInputType.url,
                          textInputAction: TextInputAction.done,
                          controller: _imageUrlController,
                          focusNode: _imageUrlFocusNode,
                          onEditingComplete: () {
                            setState(() {});
                          },
                        )
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
