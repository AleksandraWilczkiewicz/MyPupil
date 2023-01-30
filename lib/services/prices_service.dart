import 'package:alewilapp/services/animal_service.dart';
import 'package:http/http.dart' as http;

import '../models/shop_price.dart';

class PricesService {
  Future<List<ShopPrice>?> getPrices() async {
    var client = http.Client();
    
    var uri = Uri.parse('https://fakeshopapi.lm.r.appspot.com/prices?isPies=${AnimalService().GetAnimal() == SelectedAnimal.Cat ? 'false' : 'true'}');
    var response = await client.get(uri);

    if(response.statusCode == 200) {
      var json = response.body;
      return shopPriceFromJson(json);
    }
  }
}