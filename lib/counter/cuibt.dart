import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/counter/states.dart';

// LOGIC
class CounterCubit extends Cubit<CounterStates> {

  // هو محتاج الانشيل استيت عشان يبدأ
  CounterCubit() : super(CounterInitialState());
  int counter = 1;

  // بعمل الطريقه دي عشان تسهل عليا استخدمها ف اي مكان ف الابليكشن ... عشان اقدر استدعيها ف اي مكان
  //  عملتها استاتيك وخدت اوبجيكت من الكونتركويبت ودي طريقه استخدام البلوك

  static CounterCubit get(context) => BlocProvider.of(context);

  void miuns() {
    counter--;
    emit(CounterMiunsState(counter));
  }

  void puls() {
    counter++;
    emit(CounterPlusState(counter));
    // يعني ايه ايمت ؟ يعني غيرر
  }
}
