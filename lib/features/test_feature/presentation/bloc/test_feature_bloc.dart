import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
part 'test_feature_event.dart';
part 'test_feature_state.dart';
class TestFeatureBloc extends Bloc<TestFeatureEvent, TestFeatureState> {
  TestFeatureBloc() : super(TestFeatureInitial());
  @override
  Stream<TestFeatureState> mapEventToState(
    TestFeatureEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
