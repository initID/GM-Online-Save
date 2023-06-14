# GM-Online-Save
Simple Online Save plugin for GameMaker. A functional online save feature to your GameMaker project, as simple as possible so you can focus more on working on your game rather than to wrestle with the backend and all the intricacies involves with it.

## Usage
- Download the plugins from [Marketplace](https://marketplace.yoyogames.com/assets/11289/gm-online-save).
- Install it to your local project. 
- You begin by calling this function to initialize it once. ``gmos_init(gameid, userid)``.
- Parameter 'gameid' is a unique identifier for your project and it should be in a proper UUID string, you can generate one at random [here](https://www.uuidgenerator.net)

### Writing a save
```
gmos_write(filename, data, on_success, on_failed)
```
Parameter 'filename' can be any string you wish, while 'data' is the data that you want to write, and it should be in the form of GML Struct. 'on_success' & 'on_failed' are optional parameters that takes on any function with 1 parameter, these functions will be called if save is success or failed.

### Reading a save
```
gmos_read(filename, on_success, on_failed)

```
The 'filename' should be the exact same string that you used earlier. This function returns nothing! so if you want to grab the data, you make use of 'on_success' & 'on_failed' optional parameters that takes on any function with 1 parameter, these functions will be called if read is success or failed.

### Example

```
// Data that you want to write
playerdata = {
    name: "Hawk Eye",
    job: "Archer",
    level: 55,
    gold: 2000
}

gmos_init("00000000-0000-0000-0000-000000000000","testUser1");

// Sample writing a save
gmos_write("player.json", playerdata)

// Sample loading that save
gmos_read("player.json",
    function(result){
        show_message("load success!");
        show_message(result.name);
        show_message(result.job);
        show_message(result.level);
    },
    function(result){
        show_message("load failed!");
        show_message(result);
    }
);
```
