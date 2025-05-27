import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:my_task_products/features/products/data/models/product_model.dart';
import 'package:my_task_products/features/products/domain/usecases/add_products_use_case.dart';

part 'add_product_state.dart';

class AddProductCubit extends Cubit<AddProductState> {
  AddProductCubit({required this.addProductsUseCase})
    : super(AddProductInitial());

  final AddProductsUseCase addProductsUseCase;

  final TextEditingController title = TextEditingController();
  final TextEditingController description = TextEditingController();
  final TextEditingController discountPercentage = TextEditingController();
  num discount = 0;
  num priceProduct = 0;
  final TextEditingController shippingInformation = TextEditingController();
  final TextEditingController price = TextEditingController();
  final formKey = GlobalKey<FormState>();

  Future<void> addProduct() async {
    if (formKey.currentState!.validate()) {
      emit(AddProductLoading());
      final response = await addProductsUseCase.call(
        title: title.text.trim(),
        description: description.text.trim(),
        discountPercentage:
            discount, //num.parse(discountPercentage.text.trim()),
        shippingInformation: shippingInformation.text.trim(),
        price: priceProduct, //num.parse(price.text.trim()),
      );
      response.fold((error) => emit(AddProductError(message: error.message!)), (
        product,
      ) {
        emit(AddProductSuccess(productModel: product));
        title.clear();
        description.clear();
        price.clear();
        discountPercentage.clear();
        shippingInformation.clear();
      });
    } else {}
  }
}
