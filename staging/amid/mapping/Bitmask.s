( function _Bitmask_s_( ) {

'use strict';

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
  var self = this;

  //debugger;

  _.protoComplementInstance( self );

  Object.preventExtensions( self );

  if( o )
  self.copy( o );

  if( !self.defaultFields )
  throw _.err( 'Bitmask','needs defaultFields' )

}

//

var _defaultFieldsSet = function( src )
{
  var self = this;

  //debugger;
  _.assert( _.arrayIs( src ) || src === null );

  var names = [];
  var defaultValue = {};

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
      defaultValue[ keys[ 0 ] ] = field[ keys[ 0 ] ];
    }

  }

  self[ Symbol.for( 'defaultFields' ) ] = Object.freeze( src );
  self[ Symbol.for( 'names' ) ] = Object.freeze( names );
  self[ Symbol.for( 'defaultValue' ) ] = Object.freeze( defaultValue );

  //debugger;

}

//

var mapToWord = function( map )
{
  var self = this;
  var result = 0;
  var names = self.names;
  var defaultValue = self.defaultValue;

  _.assert( arguments.length === 1 );
  _.assert( _.objectIs( map ) );
  _.mapSupplement( map,defaultValue )
  _.assertMapHasOnly( map,defaultValue );

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

// --
// relationships
// --

var Composes =
{
  defaultFields : null,
}

var Associates =
{
}

var Restricts =
{
  // names : null,
  // defaultValue : null,
}

// --
// proto
// --

var Proto =
{

  init : init,

  _defaultFieldsSet : _defaultFieldsSet,
  mapToWord : mapToWord,
  wordToMap : wordToMap,

  // relationships

  constructor : Self,
  Composes : Composes,
  Associates : Associates,
  Restricts : Restricts,

};

// define

_.protoMake
({
  constructor : Self,
  parent : Parent,
  extend : Proto,
});

wCopyable.mixin( Self );

// accessor

_.accessor( Self.prototype,
{

  defaultFields : 'defaultFields',

});

// readonly

_.accessorReadOnly( Self.prototype,
{

  names : 'names',
  defaultValue : 'defaultValue',

});

wTools.Bitmask = _global_.wBitmask = Self;

})();
