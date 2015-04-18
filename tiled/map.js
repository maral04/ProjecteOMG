(function(name,data){
 if(typeof onTileMapLoaded === 'undefined') {
  if(typeof TileMaps === 'undefined') TileMaps = {};
  TileMaps[name] = data;
 } else {
  onTileMapLoaded(name,data);
 }})("map",
{ "height":10,
 "layers":[
        {
         "data":[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 37, 0, 37, 0, 37, 0, 37, 0, 37, 0, 37, 0, 37, 0, 37, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
         "height":10,
         "name":"Background",
         "opacity":1,
         "type":"tilelayer",
         "visible":true,
         "width":15,
         "x":0,
         "y":0
        }, 
        {
         "draworder":"topdown",
         "height":0,
         "name":"objects",
         "objects":[
                {
                 "gid":39,
                 "height":0,
                 "id":6,
                 "name":"",
                 "properties":
                    {

                    },
                 "rotation":0,
                 "type":"",
                 "visible":true,
                 "width":0,
                 "x":350,
                 "y":490
                }, 
                {
                 "gid":39,
                 "height":0,
                 "id":7,
                 "name":"",
                 "properties":
                    {

                    },
                 "rotation":0,
                 "type":"",
                 "visible":true,
                 "width":0,
                 "x":70,
                 "y":490
                }, 
                {
                 "gid":39,
                 "height":0,
                 "id":14,
                 "name":"",
                 "properties":
                    {

                    },
                 "rotation":0,
                 "type":"",
                 "visible":true,
                 "width":0,
                 "x":490,
                 "y":490
                }, 
                {
                 "gid":5,
                 "height":0,
                 "id":17,
                 "name":"",
                 "properties":
                    {

                    },
                 "rotation":0,
                 "type":"",
                 "visible":true,
                 "width":0,
                 "x":910,
                 "y":350
                }],
         "opacity":1,
         "type":"objectgroup",
         "visible":true,
         "width":0,
         "x":0,
         "y":0
        }, 
        {
         "data":[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 11, 23, 0, 0, 0, 11, 23, 0, 0, 11, 23, 0, 0, 0, 0, 0, 0, 11, 23, 0, 0, 0, 0, 0, 0, 0, 11, 23, 0, 0, 0, 0, 0, 0, 11, 23, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 32, 57, 57, 22, 0, 44, 0, 0, 0, 0, 0, 0, 0, 44, 0, 0, 0, 0, 0, 0, 0, 0, 10, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 33, 81, 81, 81, 81, 81, 81, 81, 81, 81, 81, 81, 81, 81, 81, 81, 47, 47, 47, 47, 47, 47, 47, 47, 47, 47, 47, 47, 47, 47, 47],
         "height":10,
         "name":"Front",
         "opacity":1,
         "type":"tilelayer",
         "visible":true,
         "width":15,
         "x":0,
         "y":0
        }],
 "nextobjectid":20,
 "orientation":"orthogonal",
 "properties":
    {

    },
 "renderorder":"right-down",
 "tileheight":70,
 "tilesets":[
        {
         "firstgid":1,
         "image":"images\/tiles_spritesheet.png",
         "imageheight":856,
         "imagewidth":852,
         "margin":0,
         "name":"tileset",
         "properties":
            {

            },
         "spacing":1,
         "tileheight":70,
         "tilewidth":70
        }],
 "tilewidth":70,
 "version":1,
 "width":15
});