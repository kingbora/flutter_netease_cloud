main(List<String> args) {
  List _list = [{
    "name": "kingbora",
    "artist": "aj"
  },{
    "name": "joy",
    "artist": "mkm"
  }];
  var temp = _list.map((item) {
    return item['name'];
  });
  print(temp);
  print(temp.toList().join("/"));
}