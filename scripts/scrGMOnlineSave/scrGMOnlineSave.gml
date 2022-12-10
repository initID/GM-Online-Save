#macro GMOS_DEFAULT_URL "https://load.pythonanywhere.com"
#macro GMOS_DEFAULT_FUNC function(result){ show_message(result) }
#macro GMOS_DEFAULT_TIMEOUT 1200

global.__gmos_gameid = "";
global.__gmos_userid = "";
global.__gmos_url = GMOS_DEFAULT_URL;

/**
 * Initialize GM Online Save
 * @param {string} gameid Unique GUID identifier for your game. Generate one at https://www.uuidgenerator.net
 * @param {string} userid Unique identifier for your user. ie: that player username
 * @param {string} [url]="https://debug.pythonanywhere.com" URL to your backend server
 */
function gmos_init(gameid, userid, url=GMOS_DEFAULT_URL){
	global.__gmos_gameid = gameid;
	global.__gmos_userid = userid;
	global.__gmos_url = url;
}


/**
 * Write the data to the cloud
 * @param {string} filename Filename for the save
 * @param {Struct} data The content/data that you want to be saved
 * @param {function} [on_success] Callback function that will be called when save is successful
 * @param {function} [on_failed] Callback function that will be called when save is failed
 */
function gmos_write(filename, data, on_success=GMOS_DEFAULT_FUNC, on_failed=GMOS_DEFAULT_FUNC){
	request_url = __gmos_get_request_url(filename);
	var header = ds_map_create();
	ds_map_add(header, "Content-Type", "application/json");
	request_id = http_request(request_url, "POST", header, json_stringify(data));

	instance_create_depth(0,0,0, objGMOnlineSave, { 
		rid : request_id, 
		func_onsuccess : on_success,
		func_onfailed : on_failed
		});
	ds_map_destroy(header);
}


/**
 * Read data from the cloud
 * @param {any} filename Filename for the save
 * @param {function} [on_success] Callback function that will be called when save is successful
 * @param {function} [on_failed] Callback function that will be called when save is failed
 */
function gmos_read(filename, on_success=GMOS_DEFAULT_FUNC, on_failed=GMOS_DEFAULT_FUNC){
	request_url = __gmos_get_request_url(filename);
	request_id = http_get(request_url); 
	instance_create_depth(0,0,0, objGMOnlineSave, { 
		rid : request_id, 
		func_onsuccess : on_success,
		func_onfailed : on_failed
		});
}


/**
 * Helper function that compose the request url
 */
function __gmos_get_request_url(filename){
	var result = global.__gmos_url;
	result += "/game/" + global.__gmos_gameid;
	result += "/user/" + global.__gmos_userid;
	result += "/file/" + string(filename);
	return result;
}