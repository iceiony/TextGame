// just defined the game "namespace"
"use strict";
var Game = Game || {};

/**
 * Function was retrieved from JavaScript patterns book
 * @param ns_string
 */
Game.namespace = function (ns_string) {
    var parts = ns_string.split('.'),
        parent = Game,
        parts_length,
        i;
    // strip redundant leading global
    if (parts[0] === "Game") {
        parts = parts.slice(1);
    }
    for (i = 0, parts_length = parts.length; i < parts_length; i += 1) {
    // create a property if it doesn't exist
        if (typeof parent[parts[i]] === "undefined") {
            parent[parts[i]] = {};
        }
        parent = parent[parts[i]];
    }
    return parent;
};
