class Test {
  static TEST = 100;

  constructor(private arg1: string,
              private arg2?: number) {
  }
}

let test1 = new Test("hoge");

let test2 = new Test();               // Should occur error after buffer write
let test3 = new Test("hoge", "fuga"); // Should occur error after buffer write
