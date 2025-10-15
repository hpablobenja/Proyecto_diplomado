// lib/domain/usecases/usecase.dart

abstract class Usecase<T, P> {
  Future<T> call(P params);
}

class NoParams {}
