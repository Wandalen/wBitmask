

if( typeof module !== 'undefined' )
require( 'wBitmask' );

var _ = wTools;

var defaultFields =
[

  { hidden : false },
  { system : false },
  { terminal : true },
  { directory : false },
  { link : false },

];

var bitmask = wBitmask
({

  defaultFields : defaultFields

});

console.log( 'bitmask' )

console.log( bitmask.toStr() );
