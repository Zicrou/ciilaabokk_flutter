import 'package:ciilaabokk/app/data/models/product.dart';
import 'package:ciilaabokk/app/data/services/remote_services.dart';
import 'package:get/state_manager.dart';
import 'package:logger/logger.dart';

final logger = Logger();

class ProductController extends GetxController {
  var isLoading = true.obs;
  var productList = <Product>[].obs;

  @override
  void onInit() {
    super.onInit();
    //fetchProducts();
  }

  // void fetchProducts() async {
  //   isLoading(true);
  //   try {
  //     var products = await RemoteServices.fetchProducts();
  //     productList.value = products;
  //     logger.i("Fetched products: ${productList.length}");
  //   } catch (e) {
  //     print("Error fetching products: $e");
  //   } finally {
  //     isLoading(false);
  //   }
  // }
}
