!function( ng ) {
    "use strict";

    var $ = ng.element;
    var module = ng.module( "frontkit.tooltip", [] );

    module.directive( "tooltip", [
        "$document",
        "$interpolate",
        function( $document, $interpolate ) {
            var definition = {};
            var tooltip = $( "<span>" ).addClass( "tooltip" );
            $document.find( "body" ).append( tooltip );

            definition.priority = 1000;
            definition.compile = function( tElem, tAttrs ) {
                var title = $interpolate( tAttrs.title );

                // We shouldn't remove the attribute because if tooltip is applied in a <abbr>,
                // for example, the styles (which are required to demonstrate something) would
                // be lost.
                tAttrs.$set( "title", "" );

                return function( scope, element ) {
                    var timeout;

                    element.on( "mouseenter", function() {
                        // Schedule showing the tooltip after 300 ms
                        timeout = setTimeout( function() {
                            var text = title( scope ).trim();
                            var rect = element[ 0 ].getBoundingClientRect();
                            timeout = null;

                            // If one of these is the case, no tooltip will be shown:
                            // 1. no text
                            // 2. no parent element (meaning the element is no longer in the DOM)
                            if ( !text || !element.parent().length ) {
                                return;
                            }

                            // Update the tooltip content, show it and position it
                            tooltip.text( text ).addClass( "visible" );
                            tooltip.css({
                                top: rect.bottom + "px",
                                left: rect.left + ( rect.width / 2 ) + "px"
                            });

                            // When the element is destroyed, also trigger mouseleave event,
                            // so the tooltip is surely hidden
                            element.on( "$destroy", function destroyCb() {
                                element.triggerHandler( "mouseleave" );
                                element.off( "$destroy", destroyCb );
                            });
                        }, 300 );
                    });

                    element.on( "mouseleave", function() {
                        // If the timeout for showing the tooltip has not been triggered yet,
                        // let's ensure that this doesn't happen by clearing it
                        if ( timeout ) {
                            clearTimeout( timeout );
                            timeout = null;
                            return;
                        }

                        // ...otherwise, just remove .visible from the element
                        tooltip.removeClass( "visible" );
                    });
                };
            };

            return definition;
        }
    ]);
}( angular );