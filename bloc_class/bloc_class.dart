// this is to refine my knowledge in working with streams
// the idea is to implement a getter on the bloc class so that (assuming this is
// what would have happened) I do not have to access every individual element in
// the bloc to either add to the sink or retrieve from the stream

import 'dart:async';

void main() {
  final bloc = Bloc();

  bloc.emailController.stream.listen(
    print(value);
  );

  bloc.email.listen((value) {
    print(value);
  });

  // bloc.emailController.sink.add('My New Email'); // this is what I am trying to avoid
  bloc.changeEmail('My New EMail'); // this is the end goal
}

class Bloc {
  final emailController = StreamController<String>();

  // add data to stream
  Function(String) get changeEmail => emailController.sink.add; 
  Function(String) get changePassword => passwordController.sink.add;
  // this getter makes it simpler to add anything to the sink in robust code base

  Stream<String> get email => emailController.stream; // retrieve data from stream
  Stream<String> get password => passwordController.stream; 
}