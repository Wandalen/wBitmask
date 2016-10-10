( function _Bitmask_s_( ) {

'use strict';

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

//

var _ = wTools;
var Parent = null;
var Self = function wBitmask( o )
{
  if( !( this instanceof Self ) )
  return new( _.routineJoin( Self, Self, arguments ) );
  return Self.prototype.init.apply( this,arguments );
}

// --
// inter
// --

var init = function( o )
{
  var self = this; /*changes context to current object*/

  _.protoComplementInstance( self );/*extends object by fields from relationships*/

  Object.preventExtensions( self );/*disables object extending*/

  if( o )/*clones fields from options object*/
  self.copy( o );

  if( !self.defaultFieldsArray ) /*checks if defaultFieldsArray is provided by( o )*/
  throw _.err( 'Bitmask','needs defaultFieldsArray' )

}

//

/**
 * Converts boolean map( map ) into  32-bit number represetation.
 * Before converions function supplements source( map ) by default fields
 * from( defaultFieldsMap ) that map doesn`t contain.
 *
 * @param { object } map - source map.
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

var toStr = function( o )
{
  var self = this;
  var result = '';
  var o = o || {};

  var result = _.toStr( self.defaultFieldsMap );
  return result;
}

//

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
  // names : null,
  // defaultFieldsMap : null,
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
