module.exports = function( grunt ) {
    return {
        options: {
            module: "frontkit",
            url: function( url ) {
                return url.replace( "src/", "" );
            }
        },
        core: {
            expand: true,
            src: "src/templates/**/*.html",
            ext: ".html.js"
        }
    };
};