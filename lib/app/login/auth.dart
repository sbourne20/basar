class IsiData {
  IsiData({this.datax});

  final String datax;
}

abstract class AuthBase{
  IsiData processIsiData(String isiaandata);
}

class Auth implements AuthBase {

  @override
  IsiData processIsiData (String isiandata){   
    if (isiandata==null) {
      return null;
    } 
    return IsiData(datax: isiandata);
  }

}