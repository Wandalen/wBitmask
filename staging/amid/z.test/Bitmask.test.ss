( function _Bitmask_test_s_( ) {

'use strict';

/*

to run this test
from the project directory run

npm install
node ./staging/z.test/Sample.test.s

*/

if( typeof module !== 'undefined' )
{

  require( 'wTools' );
  require( '../mapping/Bitmask.s' );

  if( require( 'fs' ).existsSync( __dirname + '/../../amid/diagnostic/Testing.debug.s' ) )
  require( '../../amid/diagnostic/Testing.debug.s' );
  else
  require( 'wTesting' );

}

var _ = wTools;
var Self = {};

//

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

//

var mapToWord = function( test )
{
  //default 10100

  test.description = 'simple1';
  var got = bitmask.mapToWord( { hidden : 1, terminal : 0, directory : 1 } );
  var expected = parseInt('11001', 2);
  test.identical( got,expected );

  test.description = 'simple2';
  var got = bitmask.mapToWord( { link : 0, system : 1 } );
  var expected = parseInt('00110', 2)
  test.identical( got,expected );

  test.description = 'value is -1';
  var got = bitmask.mapToWord( { hidden : -1, system : 1 } );
  var expected = parseInt('10111', 2)
  test.identical( got,expected );

  test.description = 'map value is bigger then 1 or 0';
  var got = bitmask.mapToWord( { hidden : -1, system : 100 } );
  var expected = parseInt('10111', 2)
  test.identical( got,expected );

  test.description = 'map value is str';
  var got = bitmask.mapToWord( { hidden : 'a', system : 0 } );
  var expected = parseInt('10101', 2)
  test.identical( got,expected );

  if( Config.debug )
  {
    test.description = 'no argument';
    test.shouldThrowError( function()
    {
       bitmask.mapToWord(  );
    });

    test.description = 'map is not a object';
    test.shouldThrowError( function()
    {
       bitmask.mapToWord( [ 1, 2, 3 ] );
    });

    test.description = 'map with unknown property';
    test.shouldThrowError( function()
    {
       bitmask.mapToWord( { hidden : -1, system : 1, original : 1 } );
    });
  }

}

//

var wordToMap = function( test )
{

}


var toStr = function( test  )
{

}

var _defaultFieldsArraySet = function( test )
{

}

var Proto =
{

  name : 'Bitmask test',

  tests:
  {
    mapToWord: mapToWord,



  }

}

_.mapExtend( Self,Proto );

if( typeof module !== 'undefined' && !module.parent )
_.testing.test( Self );

} )( );
