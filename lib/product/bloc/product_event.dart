import 'package:equatable/equatable.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object?> get props => [];
}

class ProductLoad extends ProductEvent {
  final int page;
  final int perPage;
  final bool isRefresh;

  const ProductLoad({
    required this.page,
    required this.perPage,
    this.isRefresh = false,
  });

  @override
  List<Object?> get props => [page, perPage, isRefresh];
}
