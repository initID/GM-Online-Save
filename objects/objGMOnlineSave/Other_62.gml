var result = "error";

if( ds_map_find_value(async_load, "id") == rid){
	if(ds_map_find_value(async_load, "status") == 0){
		result = ds_map_find_value(async_load, "result");
		try{
			result = json_parse(result);
		}catch(ignore){}
	}
	
	if(is_method(func_onsuccess) && result != "error")
		func_onsuccess(result)
	else if(is_method(func_onfailed))
		func_onfailed(result)

	instance_destroy(id);
}
