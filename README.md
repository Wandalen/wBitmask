# module::Bitmask [![Status](https://github.com/Wandalen/wBitmask/workflows/Test/badge.svg)](https://github.com/Wandalen/wBitmask/actions?query=workflow%3ATest) [![experimental](https://img.shields.io/badge/stability-experimental-orange.svg)](https://github.com/emersion/stability-badges#experimental)
A small class to convert a map of Booleans to Integer and vice versa with help of defined schema. The constructor of Bitmask expects names which created instance use for conversion. Use the module to solve the bitmask conversion problem robustly.

## Bitmask
Bitmask is a sequence of bits that we can use to store different data in a single value.
For example, we can store boolean options flags from map in a single integer.
[More](https://en.wikipedia.org/wiki/Mask_(computing)) about bitmask.

By using bitwise operations we can easily get needed bit(s) and set to or compare with value of our variable. For example, by using shift operators and bitwise AND we can get boolean value of our flag masked in a number and set it to our property in a map.
[More](https://en.wikipedia.org/wiki/Bitwise_operation) about bitwise operations.

## Installation
```terminal
npm install wBitmask
```

### Try out
```
npm install
node sample/Sample.js
```

## Usage
```javascript

var _ = wTools;

/*define array of possible names and bit values, that can vary*/
var defaultFieldsArray =
[

  { hidden : false },
  { system : false },
  { terminal : true },
  { directory : false },
  { link : true },

];

/*create new instance of wBitmask by passing options object with array( defaultFieldsArray ) to the constructor*/
var bitmask = wBitmask
({
  defaultFieldsArray : defaultFieldsArray
});

console.log( 'bitmask' )
console.log( bitmask.toStr() );
/*
bitmask
{
  hidden : false,
  system : false,
  terminal : true,
  directory : false,
  link : true
}
*/

/*define our boolean map*/
var originalMap =
{
  hidden : 1,
  terminal : 0,
  directory : 1,
}

console.log( 'originalMap :\n' + _.toStr( originalMap ) );
/*originalMap :
{ hidden : 1, terminal : 0, directory : 1 }*/

/*Convert boolean map into  32-bit number bitmask*/
var word = bitmask.mapToWord( originalMap );

console.log( 'word : ' + word );
/*word : 25*/

/*Convert 32-bit number bitmask into boolean map */
var restoredMap = bitmask.wordToMap( word );

console.log( 'restoredMap :\n' + _.toStr( restoredMap ) );
/*restoredMap :
{
  hidden : true,
  system : false,
  terminal : false,
  directory : true,
  link : true
}*/
```
