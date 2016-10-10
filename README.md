# wBitmask
Module that provides an easy way to manage boolean maps values with bitmasking technique in JavaScript.

## Bitmask
Bitmask is a sequence of bits that we can use to store different data in a single value.
For example, we can store a set of Boolean flags,RGB color or IP address in one integer.
More about bitmask [Wikipedia](https://en.wikipedia.org/wiki/Mask_(computing)).

By using bitwise operations we can easily get needed bit(s) and set to or compare with value of our variable. For example, by using shift operators and bitwise AND we can get boolean value of our flag masked in a number and set it to our property in a map.
More about bitwise operations [Wikipedia](https://en.wikipedia.org/wiki/Bitwise_operation).

## Instalation
```terminal
npm install wBitmask --save-dev;
```
## Usage
```javascript
var defaultFieldsArray =
[

  { hidden : false },
  { system : false },
  { terminal : true },
  { directory : false },
  { link : true },

];

var bitmask = wBitmask
({
  defaultFieldsArray : defaultFieldsArray
});

console.log( 'bitmask' )
console.log( bitmask.toStr() );

var originalMap =
{
  hidden : 1,
  terminal : 0,
  directory : 1,
}

console.log( 'originalMap :\n' + _.toStr( originalMap ) );

var word = bitmask.mapToWord( originalMap );

console.log( 'word : ' + word );

var restoredMap = bitmask.wordToMap( word );

console.log( 'restoredMap :\n' + _.toStr( restoredMap ) );
```
