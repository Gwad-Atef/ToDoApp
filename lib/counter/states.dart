abstract class CounterStates {}
// كريت كونتر استيت عشان الكيوبت بيحتاج استيت واحد

//  screen switch هتبدل الشاشه                  INITIALSTATE

class CounterInitialState extends CounterStates {}

class CounterMiunsState extends CounterStates {
  // ببعت قيمه مع الاستيت
  final int counter;
  CounterMiunsState(this.counter);
}

class CounterPlusState extends CounterStates {
  final int counter;
  CounterPlusState(this.counter);
}
