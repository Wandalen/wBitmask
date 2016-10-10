

if( typeof module !== 'undefined' )
require( 'wBitmask' );

var _ = wTools;

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

var map = bitmask.wordToMap( word );

console.log( 'map :\n' + _.toStr( map ) );
