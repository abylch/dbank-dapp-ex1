import Debug "mo:base/Debug";
import Time "mo:base/Time";
import Float "mo:base/Float";

actor DBank{
  // var currentValue = 300;
  // currentValue := 100;

  // persistence variable if the code is update it doesn't reset the value
  stable var currentValue: Float = 500;

  // time method now
  stable var startTime = Time.now();
  Debug.print("start Time after last deploy");
  Debug.print(debug_show(startTime));


  // ***** reset the value of currentValue and startTime, if u want to restart the app ****

  // resets the value for testing purposes, every deploy
  currentValue := 500;
  // use when starting compound, for tesing only, it compounds every second or minute
  startTime := Time.now();


  // prints only text
  Debug.print("hello from new Debug");

  // constant variable
  let id = 4786947386983;

  // prints values
  Debug.print("your id");
  Debug.print(debug_show(id));
  Debug.print("your current value");
  Debug.print(debug_show(currentValue));
  

// private update function
  func topUp() {
    currentValue += 11;
    Debug.print("new current value:");
    Debug.print(debug_show(currentValue));
  };
 // topUp();

// public update function
  public func deposit_pub(amount: Float) {
    currentValue += amount;
    Debug.print("new current value:");
    Debug.print(debug_show(currentValue));
  };

  // public function
  public func withdrawl_pub(amount: Float) {
    let tempValue: Float = currentValue - amount;
    if (tempValue >=0) {
      currentValue -= amount;
      Debug.print("new current value after withdrawl:");
      Debug.print(debug_show(currentValue));
    } else {
      Debug.print("not enought funds to withdrawl");
    }
  };

  public query func checkBalance():async Float {
    Debug.print("new current value after checkBalance func");
    return currentValue;
  };

  public func compound() {
    let currentTime = Time.now();
    let timeElapsedNSecs = currentTime - startTime;
    // for testing purposes instead of years, we convert to seconds / 1000000000
    // for minutes 10e x 6, 1000000
    let timeElapsedSecs = timeElapsedNSecs / 1000000000;
    let timeElapsedMins = timeElapsedNSecs / 1000000;
    // compound formula, Amount = deposit(1+ interestRate/numberoftimes)**(not*t)
    currentValue := currentValue * (1.01 ** Float.fromInt(timeElapsedMins));
    // updates the time
    startTime := currentTime;
  };

};
