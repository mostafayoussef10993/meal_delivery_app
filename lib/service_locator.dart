import 'package:get_it/get_it.dart';
import 'package:musicapp/common/cubits/cart_cubit.dart';
import 'package:musicapp/data/repository/auth/auth_repository_impl.dart';
import 'package:musicapp/data/repository/meal/meal_repository.dart';
import 'package:musicapp/data/sources/auth/auth_firebase_service.dart';

import 'package:musicapp/domain/repository/auth/auth.dart';
import 'package:musicapp/domain/usecases/auth/get_user.dart';
import 'package:musicapp/domain/usecases/auth/signin.dart';
import 'package:musicapp/domain/usecases/auth/signup.dart';
import 'package:musicapp/domain/usecases/cart/add_to_cart.dart';
import 'package:musicapp/domain/usecases/cart/remove_from_cart.dart';
import 'package:musicapp/domain/usecases/delivery/process_delivery_usecase.dart';
import 'package:musicapp/domain/usecases/search/search_meal_usecase.dart';
import 'package:musicapp/presentation/delivery/bloc/delivery_cubit.dart';

import 'package:musicapp/presentation/meal/bloc/meal_bloc.dart';
import 'package:musicapp/presentation/meal_detail/bloc/meal_detail_bloc.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  sl.registerSingleton<AuthFirebaseService>(AuthFirebaseServiceImpl());
  sl.registerSingleton<AuthRepository>(AuthRepositoryImpl());

  sl.registerSingleton<SignupUseCase>(SignupUseCase());
  sl.registerSingleton<SigninUseCase>(SigninUseCase());
  sl.registerSingleton<GetUserUseCase>(GetUserUseCase());

  // Cubits
  sl.registerLazySingleton<CartCubit>(() => CartCubit());

  // UseCases
  sl.registerLazySingleton<AddToCartUseCase>(
    () => AddToCartUseCase(sl<CartCubit>()),
  );
  sl.registerLazySingleton<RemoveFromCartUseCase>(
    () => RemoveFromCartUseCase(sl<CartCubit>()),
  );

  // Repositories
  sl.registerLazySingleton<MealRepository>(() => MealRepository());

  // Search
  sl.registerLazySingleton<SearchMealsUseCase>(
    () => SearchMealsUseCase(sl<MealRepository>()),
  );

  // Blocs
  sl.registerFactory<MealBloc>(
    () => MealBloc(
      repository: sl<MealRepository>(),
      searchMealsUseCase: sl<SearchMealsUseCase>(),
    ),
  );
  sl.registerFactory<MealDetailBloc>(
    () => MealDetailBloc(repo: sl<MealRepository>()),
  );

  // Delivery
  sl.registerLazySingleton<ProcessDeliveryUseCase>(
    () => ProcessDeliveryUseCase(),
  );
  sl.registerFactory<DeliveryCubit>(
    () => DeliveryCubit(processDelivery: sl<ProcessDeliveryUseCase>()),
  );
}
