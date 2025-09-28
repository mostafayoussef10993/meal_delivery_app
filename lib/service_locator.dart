import 'package:get_it/get_it.dart';
import 'package:musicapp/common/cubits/cart_cubit.dart';
import 'package:musicapp/common/cubits/wishlist_cubit.dart';
import 'package:musicapp/data/repository/auth/auth_repository_impl.dart';
import 'package:musicapp/data/repository/product/product_repository.dart';
import 'package:musicapp/data/sources/auth/auth_firebase_service.dart';

import 'package:musicapp/domain/repository/auth/auth.dart';
import 'package:musicapp/domain/usecases/auth/get_user.dart';
import 'package:musicapp/domain/usecases/auth/signin.dart';
import 'package:musicapp/domain/usecases/auth/signup.dart';
import 'package:musicapp/domain/usecases/cart/add_to_cart.dart';
import 'package:musicapp/domain/usecases/cart/remove_from_cart.dart';
import 'package:musicapp/domain/usecases/search/search_product_usecase.dart';

import 'package:musicapp/domain/usecases/whishlist/add_to_wishlist.dart';
import 'package:musicapp/domain/usecases/whishlist/remove_from_wishlist.dart';
import 'package:musicapp/presentation/products/bloc/product_bloc.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  sl.registerSingleton<AuthFirebaseService>(AuthFirebaseServiceImpl());

  sl.registerSingleton<AuthRepository>(AuthRepositoryImpl());

  sl.registerSingleton<SignupUseCase>(SignupUseCase());

  sl.registerSingleton<SigninUseCase>(SigninUseCase());

  sl.registerSingleton<GetUserUseCase>(GetUserUseCase());

  // Cubits
  sl.registerLazySingleton<WishlistCubit>(() => WishlistCubit());

  sl.registerLazySingleton<CartCubit>(() => CartCubit());

  // UseCases
  sl.registerLazySingleton<AddToCartUseCase>(
    () => AddToCartUseCase(sl<CartCubit>()),
  );
  sl.registerLazySingleton<AddToWishlistUseCase>(
    () => AddToWishlistUseCase(sl<WishlistCubit>()),
  );
  // Remove from cart
  sl.registerLazySingleton<RemoveFromCartUseCase>(
    () => RemoveFromCartUseCase(sl<CartCubit>()),
  );
  sl.registerLazySingleton<RemoveFromWishlistUseCase>(
    () => RemoveFromWishlistUseCase(sl<WishlistCubit>()), // 🔹 هنا
  );
  sl.registerLazySingleton<ProductRepository>(() => ProductRepository());

  sl.registerLazySingleton<SearchProductsUseCase>(
    () => SearchProductsUseCase(sl<ProductRepository>()),
  );

  sl.registerFactory<ProductBloc>(
    () => ProductBloc(
      repository: sl<ProductRepository>(),
      searchProductsUseCase: sl<SearchProductsUseCase>(),
    ),
  );
}
