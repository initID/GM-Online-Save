playerdata = {
	name: "Hawk Eye",
	job: "Archer",
	level: 55,
	gold: 2000
}


// Sample writing a save
gmos_init("00000000-0000-0000-0000-000000000000","testUser1");
gmos_write("player.json", playerdata)
///


									   return; 
// Sample loading that save (comment the ^return above)
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
///