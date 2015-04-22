(function(name,data){
 if(typeof onTileMapLoaded === 'undefined') {
  if(typeof TileMaps === 'undefined') TileMaps = {};
  TileMaps[name] = data;
 } else {
  onTileMapLoaded(name,data);
 }})("map",
{ "height":12,
 "layers":[
        {
         "data":[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 37, 0, 37, 0, 37, 0, 37, 0, 37, 0, 37, 0, 37, 0, 37, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
         "height":12,
         "name":"Background",
         "opacity":1,
         "type":"tilelayer",
         "visible":true,
         "width":16,
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
                 "y":560
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
                 "y":560
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
                 "y":560
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
                 "y":420
                }, 
                {
                 "gid":5,
                 "height":0,
                 "id":25,
                 "name":"",
                 "properties":
                    {

                    },
                 "rotation":0,
                 "type":"",
                 "visible":true,
                 "width":0,
                 "x":70,
                 "y":140
                }, 
                {
                 "gid":5,
                 "height":0,
                 "id":26,
                 "name":"",
                 "properties":
                    {

                    },
                 "rotation":0,
                 "type":"",
                 "visible":true,
                 "width":0,
                 "x":591,
                 "y":149
                }, 
                {
                 "gid":5,
                 "height":0,
                 "id":30,
                 "name":"",
                 "properties":
                    {

                    },
                 "rotation":0,
                 "type":"",
                 "visible":true,
                 "width":0,
                 "x":700,
                 "y":350
                }, 
                {
                 "gid":5,
                 "height":0,
                 "id":31,
                 "name":"",
                 "properties":
                    {

                    },
                 "rotation":0,
                 "type":"",
                 "visible":true,
                 "width":0,
                 "x":630,
                 "y":350
                }, 
                {
                 "gid":19,
                 "height":0,
                 "id":39,
                 "name":"",
                 "properties":
                    {

                    },
                 "rotation":0,
                 "type":"",
                 "visible":true,
                 "width":0,
                 "x":980,
                 "y":210
                }],
         "opacity":1,
         "type":"objectgroup",
         "visible":true,
         "width":0,
         "x":0,
         "y":0
        }, 
        {
         "data":[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 11, 23, 0, 0, 0, 11, 23, 0, 0, 11, 23, 0, 0, 0, 0, 0, 0, 0, 11, 23, 0, 0, 0, 0, 0, 0, 0, 11, 12, 23, 0, 0, 0, 0, 0, 0, 11, 23, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 32, 57, 57, 22, 0, 44, 0, 0, 0, 0, 0, 0, 0, 0, 44, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 57, 33, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 81, 81, 81, 81, 81, 81, 81, 81, 81, 81, 81, 81, 81, 81, 81, 81, 47, 47, 47, 47, 47, 47, 47, 47, 47, 47, 47, 47, 47, 47, 47, 47],
         "height":12,
         "name":"Front",
         "opacity":1,
         "type":"tilelayer",
         "visible":true,
         "width":16,
         "x":0,
         "y":0
        }],
 "nextobjectid":40,
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
 "width":16
});