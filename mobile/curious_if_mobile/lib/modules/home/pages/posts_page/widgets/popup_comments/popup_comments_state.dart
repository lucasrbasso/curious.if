import '../../../../../../domain/comment/model/comment_model.dart';

abstract class PopupCommentsState {}

class PopupCommentsStateEmpty extends PopupCommentsState {}

class PopupCommentsStateLoading extends PopupCommentsState {}

class PopupCommentsStateFailure extends PopupCommentsState {
  final String message;
  PopupCommentsStateFailure({
    required this.message,
  });
}

class PopupCommentsStateSuccess extends PopupCommentsState {
  final List<CommentModel> comments;

  final String message;
  PopupCommentsStateSuccess({
    required this.message,
    required this.comments,
  });
}
