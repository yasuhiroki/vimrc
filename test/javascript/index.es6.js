/**
 * Sample
 *
 * @class
 */
class Sample {

  constructor() {
    console.log('sample');

    this.val = 100;
  }

  hello() {
    console.log('hello');
    console.log(this.val);
  }
}

const sample = new Sample();
sample.hello();
