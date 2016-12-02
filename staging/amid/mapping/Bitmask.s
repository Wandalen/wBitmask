( function _Bitmask_s_( ) {

'use strict';

// dependencies

if( typeof module !== 'undefined' )
{

  if( typeof wBase === 'undefined' )
  try
  {
    require( '../wTools.s' );
  }
  catch( err )
  {
    require( 'wTools' );
  }

  if( typeof wCopyable === 'undefined' )
  try
  {
    require( '../../mixin/Copyable.s' );
  }
  catch( err )
  {
    require( 'wCopyable' );
  }

}

// constructor

var _ = wTools;
var Parent = null;
var Self = function wBitmask( o )
{
  if( !( this instanceof Self ) )
  if( o instanceof Self )
  return o;
  else
  return new( _.routineJoin( Self, Self, arguments ) );
  return Self.prototype.init.apply( this,arguments );
}

// --
// inter
// --

var init = function( o )
{
  var self = this; /*changes context to current object*/

  _.instanceInit( self );/*extends object by fields from relationships*/

  Object.preventExtensions( self );/*disables object extending*/

  if( o )/*clones fields from options object*/
  self.copy( o );

  if( !self.defaultFieldsArray ) /*checks if defaultFieldsArray is provided by( o )*/
  throw _.err( 'Bitmask','needs defaultFieldsArray' )

}

//

/**
 * Converts boolean map( map ) into  32-bit number bitmask.
 * Each true/false key value in map corresponds to 1/0 bit value in number.
 * Before converions function supplements source( map ) by unique fields from( defaultFieldsMap ).
 *
 * @param { object } map - source map.
 * @return { number } Returns boolean map values represented as number.
 *
 * @example
 * var defaultFieldsArray =
 * [
 *   { hidden : false },
 *   { system : true }
 * ];
 *
 * var bitmask = wBitmask
 * ({
 *   defaultFieldsArray : defaultFieldsArray
 * });
 * var word = bitmask.mapToWord( { hidden : true } );
 * console.log( word ); // returns 3( 0011 in Dec )
 *
 * @method mapToWord
 * @throws {exception} If no argument provided.
 * @throws {exception} If( map ) is not a Object.
 * @throws {exception} If( map ) is extended by unknown property.
 * @memberof wTools
 */

var mapToWord = function( map )
{
  var self = this;
  var result = 0;
  var names = self.names;
  var defaultFieldsMap = self.defaultFieldsMap;

  _.assert( arguments.length === 1 );
  _.assert( _.objectIs( map ) );
  _.mapSupplement( map,defaultFieldsMap )
  _.assertMapHasOnly( map,defaultFieldsMap );

  for( var f = 0 ; f < names.length ; f++ )
  {
    var name = names[ f ];
    result |= map[ name ] ? 1 << f : 0;
  }

  return result;
}

//

/**
 * Applies 32-bit number bitmask( word ) on boolean map( defaultFieldsMap ).
 * Each bit value in number corresponds to true/false key value in map.
 *
 * @param { number } word - source bitmask.
 * @return { object } Returns new boolean map with values from( word ).
 *
 * @example
 * var defaultFieldsArray =
 * [
 *   { hidden : false },
 *   { system : true }
 * ];
 *
 * var bitmask = wBitmask
 * ({
 *   defaultFieldsArray : defaultFieldsArray
 * });
 * var map = bitmask.wordToMap( parseInt( '0011', 2 ) );
 * console.log( map ); // returns { hidden: true, system: true }
 *
 * @method wordToMap
 * @throws {exception} If no argument provided.
 * @throws {exception} If( word ) is not a Number.
 * @memberof wTools
 */

var wordToMap = function( word )
{
  var self = this;
  var result = {};
  var names = self.names;

  _.assert( arguments.length === 1 );
  _.assert( _.numberIs( word ) );

  for( var f = 0 ; f < names.length ; f++ )
  {
    var name = names[ f ];
    result[ name ] = word & ( 1 << f ) ? true : false;
  }

  return result;
}

//

/**
 * Converts map( defaultFieldsMap ) to string representation using
 * options( o ).
 *
 * @param { object } o - options {@link wTools~toStrOptions}.
 * @return { string } Returns string that represents map's data.
 *
 * @example
 * var defaultFieldsArray =
 * [
 *   { hidden : false },
 *   { system : true }
 * ];
 *
 * var bitmask = wBitmask
 * ({
 *   defaultFieldsArray : defaultFieldsArray
 * });
 * var str = bitmask.toStr( { multiline : true } );
 * console.log( str );
 * // returns
 * // {
 * //   hidden: true,
 * //   system: true
 * // }
 *
 * @method toStr
 * @memberof wTools
 */

var toStr = function( o )
{
  var self = this;
  var result = '';
  var o = o || {};

  var result = _.toStr( self.defaultFieldsMap, o );
  return result;
}

//

/**
 *
 * @param { array } src - source array.
 *
 * @example
 * var defaultFieldsArray =
 * [
 *   { hidden : false },
 *   { system : true }
 * ];
 * var bitmask = wBitmask
 * ({
 *   defaultFieldsArray : defaultFieldsArray
 * });
 * console.log( bitmask.defaultFieldsArray );
 * // returns [ { hidden: false }, { system: true } ]
 *
 * @private
 * @method _defaultFieldsArraySet
 * @memberof wTools
 */

var _defaultFieldsArraySet = function( src )
{
  var self = this;

  _.assert( _.arrayIs( src ) || src === null );

  var names = [];
  var defaultFieldsMap = {};

  if( src )
  {

    if( src.length > 32 )
    throw _.err( 'Bitmask cant store more then 32 fields' );

    for( var s = 0 ; s < src.length ; s++ )
    {
      var field = src[ s ];
      var keys = Object.keys( field );
      _.assert( _.objectIs( field ) );
      _.assert( keys.length === 1 );
      names.push( keys[ 0 ] );
      defaultFieldsMap[ keys[ 0 ] ] = field[ keys[ 0 ] ];
    }

  }

  self[ Symbol.for( 'defaultFieldsArray' ) ] = Object.freeze( src );
  self[ Symbol.for( 'names' ) ] = Object.freeze( names );
  self[ Symbol.for( 'defaultFieldsMap' ) ] = Object.freeze( defaultFieldsMap );

}

// --
// relationships
// --

var Composes =
{
  defaultFieldsArray : null,
}

var Associates =
{
}

var Restricts =
{
}

// --
// proto
// --

var Proto =
{

  init : init,

  mapToWord : mapToWord,
  wordToMap : wordToMap,

  toStr : toStr,

  _defaultFieldsArraySet : _defaultFieldsArraySet,


  // relationships

  constructor : Self,
  Composes : Composes,
  Associates : Associates,
  Restricts : Restricts,

};

// define

/*Makes prototype for constructor Self. Extends prototype with field from Proto
and repairs relationships : Composes, Aggregates, Associates, Restricts.*/

_.protoMake
({
  constructor : Self,
  parent : Parent,
  extend : Proto,
});

/*Mixins wCopyable into prototype Self*/

wCopyable.mixin( Self );

// accessor

/*Defines set/get functions for provided object fields names*/

_.accessor( Self.prototype,
{

  defaultFieldsArray : 'defaultFieldsArray',

});

// readonly

/*Makes fields readonly by defining only getter function*/

_.accessorReadOnly( Self.prototype,
{

  names : 'names',
  defaultFieldsMap : 'defaultFieldsMap',

});

/*Defines class on wTools and global namespaces*/
wTools.Bitmask = _global_.wBitmask = Self;

})();
