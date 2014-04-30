"use strict";
Game.namespace("Game.Render.Text");
/*
  "this" will point to Game.Engine instance;
  Element returned will be a JQuery object;
 */
Game.Render.Text.directDisplay = function (scene) {
    var jQuery = $;

    jQuery(this.getOutputElement()).html(scene.content);
};