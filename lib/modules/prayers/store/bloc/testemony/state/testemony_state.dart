

import '../../../../data/models/testemonie_model.dart';

abstract class TestemonyState{}

class LoadingTestemonyState extends TestemonyState{}

class LoadedTestemonyState extends TestemonyState{
  final List<TestemonieModel> testemonies;

  LoadedTestemonyState(this.testemonies);
}

class ErrorTestemonyState extends TestemonyState{}

class EmptyTestemonyState extends TestemonyState{}
