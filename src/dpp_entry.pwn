/*
*
* D++ Scripting Language
*     Made for a SA:MP server
*
* Entry point
*
* 
* - by: DEntisT, (c) 2022
*
*/


#if !defined SAMP_MODE
 	#define SAMP_MODE 1
#endif

#pragma dynamic 215750000
#pragma warning disable 204
#pragma warning disable 211
#pragma option -;+
#define DPP_DEBUG 1
#define dpp_maxfuncs 1000
#define dpp_maxconst 100
#define dpp_argcharsize 100

#define dpp_const_type_int 1
#define dpp_const_type_bool 2
#define dpp_const_type_str 3

#define dpp_rtn_type_int 1
#define dpp_rtn_type_bool 2
#define dpp_rtn_type_str 3

// REQUIRED.
#include <open.mp>

enum dpp_enumset
{
	console_pkg,
	system_pkg,
	samp_pkg
};

new dpp_config[dpp_enumset];
new dpp_currentfuncid = 0;
new dpp_validfunc[dpp_maxfuncs];
new dpp_funcname[dpp_maxfuncs][64];
new dpp_funccodeblock[dpp_maxfuncs][1024];

new dpp_funcreturn_int[dpp_maxfuncs];
new dpp_funcreturn_bool[dpp_maxfuncs];
new dpp_funcreturn_str[dpp_maxfuncs][1024];

new dpp_returned[dpp_maxfuncs];
new dpp_returntype[dpp_maxfuncs];

new dpp_processfunc = 0;

new dpp_interpreter = 1;

//OPTIONS

new dpp_option_debug = 0;

//includes
#include "dpp_modules/dpp_header.inc"
#include "dpp_modules/dpp_utils.inc"
#include "dpp_modules/dpp_const.inc"
#include "dpp_modules/dpp_interpreter.inc"
#if SAMP_MODE == 1
#include "dpp_modules/dpp_samp.inc"
#endif

main()
{
	dpp_nullcomment();
	dpp_nullcomment();
	dpp_execute("script.dpp");
	dpp_nullcomment();
	dpp_nullcomment();
	dpp_comment();
	dpp_print("The SAMP script will continue running in the background.");
	dpp_comment();
	dpp_nullcomment();
	dpp_nullcomment();
	CallLocalFunction("DPP_GAMEMODEINIT", "");
	return 1;
}