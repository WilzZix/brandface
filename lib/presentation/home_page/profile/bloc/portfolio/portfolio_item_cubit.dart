import 'package:bloc/bloc.dart';
import 'package:brandface/core/error/failures.dart';
import 'package:brandface/domain/entities/profile/portfolio_entity.dart';
import 'package:brandface/domain/usecase/profile/add_portfolio_image_use_case.dart';
import 'package:brandface/domain/usecase/profile/get_portfolio_detail_use_case.dart';
import 'package:brandface/domain/usecase/profile/remove_portfolio_image_use_case.dart';
import 'package:brandface/domain/usecase/profile/update_portfolio_use_case.dart';
import 'package:brandface/domain/usecase/profile/upload_portfolio_file_use_case.dart';
import 'package:brandface/presentation/home_page/profile/bloc/portfolio/portfolio_item_state.dart';

class PortfolioItemCubit extends Cubit<PortfolioItemState> {
  final GetPortfolioDetailUseCase _getPortfolioDetailUseCase;
  final UpdatePortfolioUseCase _updatePortfolioUseCase;
  final UploadPortfolioFileUseCase _uploadPortfolioFileUseCase;
  final AddPortfolioImageUseCase _addPortfolioImageUseCase;
  final RemovePortfolioImageUseCase _removePortfolioImageUseCase;

  PortfolioItemCubit({
    required GetPortfolioDetailUseCase getPortfolioDetailUseCase,
    required UpdatePortfolioUseCase updatePortfolioUseCase,
    required UploadPortfolioFileUseCase uploadPortfolioFileUseCase,
    required AddPortfolioImageUseCase addPortfolioImageUseCase,
    required RemovePortfolioImageUseCase removePortfolioImageUseCase,
  }) : _getPortfolioDetailUseCase = getPortfolioDetailUseCase,
       _updatePortfolioUseCase = updatePortfolioUseCase,
       _uploadPortfolioFileUseCase = uploadPortfolioFileUseCase,
       _addPortfolioImageUseCase = addPortfolioImageUseCase,
       _removePortfolioImageUseCase = removePortfolioImageUseCase,
       super(const PortfolioItemState());

  Future<void> loadPortfolio(int id, {bool force = false}) async {
    if (!force && state.status == PortfolioItemStatus.loading) {
      return;
    }

    emit(
      state.copyWith(status: PortfolioItemStatus.loading, clearFailure: true),
    );
    final result = await _getPortfolioDetailUseCase.call(params: id);
    result.fold(
      ifLeft: (failure) => emit(
        state.copyWith(status: PortfolioItemStatus.failure, failure: failure),
      ),
      ifRight: (item) => emit(
        state.copyWith(
          status: PortfolioItemStatus.ready,
          item: item,
          clearFailure: true,
        ),
      ),
    );
  }

  Future<UploadedFileEntity?> uploadFile(String path) async {
    emit(
      state.copyWith(status: PortfolioItemStatus.saving, clearFailure: true),
    );
    final result = await _uploadPortfolioFileUseCase.call(params: path);
    UploadedFileEntity? uploadedFile;
    result.fold(
      ifLeft: (failure) => emit(
        state.copyWith(
          status: PortfolioItemStatus.failure,
          failure: failure,
          item: state.item,
        ),
      ),
      ifRight: (file) {
        uploadedFile = file;
        emit(
          state.copyWith(
            status: PortfolioItemStatus.ready,
            item: state.item,
            clearFailure: true,
          ),
        );
      },
    );
    return uploadedFile;
  }

  Future<bool> savePortfolio({
    required int id,
    required Map<String, dynamic> data,
  }) async {
    emit(
      state.copyWith(status: PortfolioItemStatus.saving, clearFailure: true),
    );
    final result = await _updatePortfolioUseCase.call(
      params: UpdatePortfolioParams(id: id, data: data),
    );

    bool isSuccess = false;
    result.fold(
      ifLeft: (failure) => emit(
        state.copyWith(status: PortfolioItemStatus.failure, failure: failure),
      ),
      ifRight: (item) {
        isSuccess = true;
        emit(
          state.copyWith(
            status: PortfolioItemStatus.ready,
            item: item,
            clearFailure: true,
          ),
        );
      },
    );
    return isSuccess;
  }

  Future<bool> addImage({
    required int portfolioId,
    required int imageId,
  }) async {
    emit(
      state.copyWith(status: PortfolioItemStatus.saving, clearFailure: true),
    );
    final result = await _addPortfolioImageUseCase.call(
      params: AddPortfolioImageParams(
        portfolioId: portfolioId,
        imageId: imageId,
      ),
    );

    bool isSuccess = false;
    await result.fold(
      ifLeft: (failure) async => emit(
        state.copyWith(status: PortfolioItemStatus.failure, failure: failure),
      ),
      ifRight: (_) async {
        isSuccess = true;
        await loadPortfolio(portfolioId, force: true);
      },
    );
    return isSuccess;
  }

  Future<bool> removeImage({
    required int portfolioId,
    required int imageId,
  }) async {
    emit(
      state.copyWith(status: PortfolioItemStatus.saving, clearFailure: true),
    );
    final result = await _removePortfolioImageUseCase.call(
      params: RemovePortfolioImageParams(
        portfolioId: portfolioId,
        imageId: imageId,
      ),
    );

    bool isSuccess = false;
    await result.fold(
      ifLeft: (failure) async => emit(
        state.copyWith(status: PortfolioItemStatus.failure, failure: failure),
      ),
      ifRight: (_) async {
        isSuccess = true;
        await loadPortfolio(portfolioId, force: true);
      },
    );
    return isSuccess;
  }

  Failure? consumeFailure() => state.failure;
}
