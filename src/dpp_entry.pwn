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
//-----------------------------------------------------------
#pragma dynamic 21575000000000
#pragma warning disable 204
#pragma warning disable 211
#pragma option -;+
//-----------------------------------------------------------
#define dpp_invalidclass 100
//-----------------------------------------------------------
#define DPP_VERSION_MAJOR 1
#define DPP_VERSION_MINOR 0
#define DPP_VERSION_PATCH 0
#define DPP_VERSION_RELEASE 4

#define DPP_VERSION_BETA 0

#define DPP_LOG_FILE "dpp.log"
//-----------------------------------------------------------
#define DPP_INVALID_INLINE_ID 0
#define DPP_INVALID_FORM_ID -1
#define DPP_INVALID_TASK_ID -1
#define DPP_INVALID_ENUM_ID -1
//-----------------------------------------------------------
#define DPP_DEBUG 1
#define DPP_BRACES 0
//-----------------------------------------------------------
#define dpp_maxcodelines 2048
#define dpp_maxformatlen 2048
//-----------------------------------------------------------
#define dpp_maxformargs 10
//-----------------------------------------------------------
#define dpp_maxconst 100
#define dpp_maxfuncs 200
#define dpp_maxinline 100
#define dpp_maxvar 100
#define dpp_maxclass 100
#define dpp_maxtasks 50
#define dpp_maxiter 50
#define dpp_maxobj 100
#define dpp_maxtypedef 50
#define dpp_maxenum 20
//-----------------------------------------------------------
#define dpp_maxenumvals 100
//-----------------------------------------------------------
#define dpp_maxitersize 1000
#define dpp_invaliditerval -1
//-----------------------------------------------------------
#define dpp_formstruct_local 0
#define dpp_formstruct_sampcmd 1
//-----------------------------------------------------------
#define dpp_argcharsize 100
//-----------------------------------------------------------
#define dpp_const_type_int 1
#define dpp_const_type_bool 2
#define dpp_const_type_str 3
#define dpp_const_type_double 4
#define dpp_const_type_char 5
//-----------------------------------------------------------
#define dpp_var_type_int 1
#define dpp_var_type_bool 2
#define dpp_var_type_str 3
#define dpp_var_type_double 4
#define dpp_var_type_char 5
//-----------------------------------------------------------
#define dpp_rtn_type_void 0
#define dpp_rtn_type_int 1
#define dpp_rtn_type_bool 2
#define dpp_rtn_type_str 3
#define dpp_rtn_type_double 4
#define dpp_rtn_type_char 5
//-----------------------------------------------------------
new content[18000];
new subcontent[16000];
//-----------------------------------------------------------
new dpp_skipelse = 0;
//-----------------------------------------------------------
new dpp_skipcase = 0;
new dpp_switchedvar;
//-----------------------------------------------------------
// PREDEFINES
//-----------------------------------------------------------
#define DPP_LOGPROCESSES 0
//-----------------------------------------------------------
#define dpp_maxsymbolchar 64
#define dpp_maxstrsize 256
#define dpp_maxargsc 20
//-----------------------------------------------------------
#define dpp_null "null"
//-----------------------------------------------------------
// REQUIRED.
#include <open.mp>
//-----------------------------------------------------------
new dpp_lastvalueprcfunc;
//-----------------------------------------------------------
new dpp_enuminterpreter = 1;
new dpp_currentenumid = -1;
new dpp_nextenumval = 0;

new dpp_validenum[dpp_maxenum];
new dpp_enumname[dpp_maxenum][dpp_maxsymbolchar];
enum __dpp_valcache
{
    e_valid,
    e_valname[dpp_maxsymbolchar],
    e_value
}
new dpp_enumvalues[dpp_maxenum][dpp_maxenumvals][__dpp_valcache];
//-----------------------------------------------------------
new dpp_validtypedef[dpp_maxtypedef];
new dpp_typedefname[dpp_maxtypedef][dpp_maxstrsize];
new dpp_typedefrepl[dpp_maxtypedef][dpp_maxstrsize];
//-----------------------------------------------------------
enum dpp_enumset
{
    console_comp,
    system_comp,
    samp_comp,
    math_comp,
    files_comp,
    misc_comp,
    data_comp
};

new dpp_config[dpp_enumset];
//-----------------------------------------------------------
//const
enum __dpp_const_val
{
    const_valid,
    const_name[dpp_maxsymbolchar],
    const_type,
    integervalue,
    /*bool:*/boolvalue,
    Float:floatvalue,
    stringvalue[dpp_maxstrsize],
    charvalue
}
new dpp_constdata[dpp_maxconst][__dpp_const_val];
//-----------------------------------------------------------
//vars
enum __dpp_var_val
{
    var_valid,
    var_name[dpp_maxsymbolchar],
    var_type,
    var_object,
    var_unsigned,
    integervalue,
    /*bool:*/boolvalue,
    Float:floatvalue,
    stringvalue[dpp_maxstrsize],
    charvalue,
    //func
    var_static,
    var_baseformid
}

new dpp_vardata[dpp_maxvar][__dpp_var_val];
//-----------------------------------------------------------
//inline
//new dpp_inlineinterpreter = 1;
new dpp_currentinlineid = DPP_INVALID_INLINE_ID;
new dpp_validinline[dpp_maxinline];
new dpp_inlinebaseform[dpp_maxinline];
new dpp_inlinename[dpp_maxinline][dpp_maxsymbolchar];
new dpp_inlinecodeblock[dpp_maxinline][1024];
//-----------------------------------------------------------
//tasks
new dpp_internaltasks[dpp_maxtasks];

new dpp_taskinterpreter = 1;
new dpp_currenttaskid = DPP_INVALID_TASK_ID;
new dpp_validtask[dpp_maxtasks];
new dpp_taskname[dpp_maxtasks][dpp_maxsymbolchar];
new dpp_taskcodeblock[dpp_maxtasks][1024];
new dpp_interval[dpp_maxtasks];
//-----------------------------------------------------------
//iterators
new dpp_validiter[dpp_maxiter];
new dpp_itername[dpp_maxiter][dpp_maxsymbolchar];
new dpp_itersize[dpp_maxiter];
new dpp_itervalues[dpp_maxiter][dpp_maxitersize];
//-----------------------------------------------------------
//bunch of crap
new dpp_currentfuncid = DPP_INVALID_FORM_ID;
new dpp_validfunc[dpp_maxfuncs];
new dpp_funcname[dpp_maxfuncs][dpp_maxsymbolchar];
new dpp_funccodeblock[dpp_maxfuncs][1024];
new dpp_autoform[dpp_maxfuncs];
new dpp_hookform[dpp_maxfuncs];
new dpp_structtype[dpp_maxfuncs];
new dpp_methodform[dpp_maxfuncs];
enum __dpp_argcache
{
    dpp_argname[32],
    dpp_argvalue[1024]
}
new dpp_args[dpp_maxfuncs][dpp_maxformargs][__dpp_argcache];
//-----------------------------------------------------------
new dpp_validclass[dpp_maxclass];
new dpp_classname[dpp_maxclass][dpp_maxsymbolchar];
new dpp_workingclassid = dpp_invalidclass;
//-----------------------------------------------------------
new dpp_funcreturn_int[dpp_maxfuncs];
new dpp_funcreturn_bool[dpp_maxfuncs];
new dpp_funcreturn_str[dpp_maxfuncs][1024];
new Float:dpp_funcreturn_double[dpp_maxfuncs];
new dpp_funcreturn_char[dpp_maxfuncs];
//-----------------------------------------------------------
new dpp_objectid = -1;
new dpp_isobjinit = 0;
new dpp_validobj[dpp_maxobj];
new dpp_objname[dpp_maxobj][dpp_maxsymbolchar];
//-----------------------------------------------------------
new dpp_returned[dpp_maxfuncs];
new dpp_returntype[dpp_maxfuncs];
//-----------------------------------------------------------
new dpp_processfunc = DPP_INVALID_FORM_ID;
new dpp_isconditional = 0;
//-----------------------------------------------------------
new dpp_interpreter = 1;
//-----------------------------------------------------------
new File:dpp_filehandle;
new dpp_fhandleused = 0;
//-----------------------------------------------------------
// project config

new dpp_projname[128];
new dpp_stackoutput = 0;
//-----------------------------------------------------------
// process cache

new dpp_terminated = 0;
new dpp_sysreturned = 0;

new dpp_warningcount = 0;
new dpp_errorcount = 0;
//-----------------------------------------------------------
//OPTIONS

new dpp_option_debug = 0;
new dpp_option_warnings = 1;
new dpp_option_hooking = 1;
new dpp_option_escapechar = '\\';
new dpp_option_allspc = 0;
//-----------------------------------------------------------
// data
new dpp_compiling_pass = 1;
new dpp_compiled = 0;
new dpp_lastclass;
// do and end
new dpp_event = 0;
#define dpp_event_form 0
#define dpp_event_task 1
#define dpp_event_class 2
#define dpp_event_inline 3
#define dpp_event_enum 4
//-----------------------------------------------------------
//includes
#include "dpp_modules/dpp_header.inc"
#include "dpp_modules/dpp_proj.inc"
#include "dpp_modules/dpp_utils.inc"
#include "dpp_modules/dpp_const.inc"
#include "dpp_modules/dpp_vars.inc"
#include "dpp_modules/dpp_mathimpl.inc"
#include "dpp_modules/dpp_namespace.inc"
#include "dpp_modules/dpp_inline.inc"
#include "dpp_modules/dpp_tasks.inc"
#include "dpp_modules/dpp_iter.inc"
#include "dpp_modules/dpp_objects.inc"
#include "dpp_modules/dpp_typedef.inc"
#include "dpp_modules/dpp_enum.inc"
#include "dpp_modules/dpp_persistent.inc"

#include "dpp_modules/dpp_interpreter.inc"
//-----------------------------------------------------------
//compiler sys
#include "dpp_compiler/dpp_index.inc"
//-----------------------------------------------------------
// component impl
#include "dpp_components/dpp_system.inc"
#include "dpp_components/dpp_console.inc"
#include "dpp_components/dpp_samp.inc"
#include "dpp_components/dpp_math.inc"
#include "dpp_components/dpp_files.inc"
#include "dpp_components/dpp_misc.inc"
#include "dpp_components/dpp_data.inc"
//-----------------------------------------------------------

dpp_main(); public dpp_main()
{
    strmid(dpp_projname,"Unnamed project",0,128,128);
    dpp_nullcomment();
    dpp_nullcomment();
    dpp_compile("index.dpp");
    SetTimer("main_again", 3000, false);
    return 1;   
}

main_again();
public main_again()
{
    if(dpp_compiled == 1)
    {
        dpp_execute("index.dppc");
    }

    CallLocalFunction("DPP_GAMEMODEINIT", "");
    CallRemoteFunction("dppcord_init", "");
    CallLocalFunction("dpp_taskinit", "");
    return 1;
}

dpp_dostackoutput();
public dpp_dostackoutput()
{
    new stackfile[512],argfile[256];
    if(fexist("stackoutput.dpplog")) fremove("stackoutput.dpplog");
    dpp_nullcomment();
    dpp_comment();
    dpp_print("Loading the stack...");
    dpp_print("Loading the forms stack...");
    dpp_comment();
    dpp_savelog("stackoutput.dpplog","===============================================================");
    dpp_savelog("stackoutput.dpplog","FORMS");
    dpp_savelog("stackoutput.dpplog","===============================================================");
    for(new i; i < dpp_maxfuncs; i++)
    {
        format(stackfile,sizeof stackfile,"ID : %i | VALID : %i | NAME: \"%s\"\n\n",
            i,
            dpp_validfunc[i],
            dpp_funcname[i]);
        for(new argid; argid < dpp_maxformargs; argid++)
        {
            format(argfile, sizeof argfile, "\n\nARG[%i] NAME : \"%s\" | ARG[%i] VALUE : \"%s\"",
                argid,dpp_args[i][argid][dpp_argname],
                argid,dpp_args[i][argid][dpp_argvalue]);
            strcat(stackfile, argfile);
        }
        dpp_savelog("stackoutput.dpplog",stackfile);
    }
    dpp_comment();
    dpp_print("Loading the const stack...");
    dpp_comment();
    dpp_savelog("stackoutput.dpplog","===============================================================");
    dpp_savelog("stackoutput.dpplog","CONSTANTS");
    dpp_savelog("stackoutput.dpplog","===============================================================");
    for(new i; i < dpp_maxconst; i++)
    {
        format(stackfile,sizeof stackfile,"ID : %i | VALID : %i | NAME: \"%s\"",
            i,
            dpp_constdata[i][const_valid],
            dpp_constdata[i][const_name]);
        dpp_savelog("stackoutput.dpplog",stackfile);
    }
    dpp_comment();
    dpp_print("Loading the vars stack...");
    dpp_comment();
    dpp_savelog("stackoutput.dpplog","===============================================================");
    dpp_savelog("stackoutput.dpplog","VARS");
    dpp_savelog("stackoutput.dpplog","===============================================================");
    for(new i; i < dpp_maxvar; i++)
    {
        format(stackfile,sizeof stackfile,"ID : %i | VALID : %i | NAME: \"%s\"",
            i,
            dpp_vardata[i][var_valid],
            dpp_vardata[i][var_name]);
        dpp_savelog("stackoutput.dpplog",stackfile);
    }
    dpp_comment();
    dpp_print("Loading the class stack...");
    dpp_comment();
    dpp_savelog("stackoutput.dpplog","===============================================================");
    dpp_savelog("stackoutput.dpplog","CLASSES");
    dpp_savelog("stackoutput.dpplog","===============================================================");
    for(new i; i < dpp_maxclass; i++)
    {
        format(stackfile,sizeof stackfile,"ID : %i | VALID : %i | NAME: \"%s\"",
            i,
            dpp_validclass[i],
            dpp_classname[i]);
        dpp_savelog("stackoutput.dpplog",stackfile);
    }

    dpp_comment();
    dpp_print("Loading the iterator stack...");
    dpp_comment();
    dpp_savelog("stackoutput.dpplog","===============================================================");
    dpp_savelog("stackoutput.dpplog","ITERATORS");
    dpp_savelog("stackoutput.dpplog","===============================================================");
    for(new i; i < dpp_maxiter; i++)
    {
        format(stackfile,sizeof stackfile,"ID : %i | VALID : %i | NAME: \"%s\" | SIZE: %i",
            i,
            dpp_validiter[i],
            dpp_itername[i],
            dpp_itersize[i]);
        dpp_savelog("stackoutput.dpplog",stackfile);
    }

    return 1;
}

DPP_ProcessCode(line[]); public DPP_ProcessCode(line[])
{
    dpp_process(line);
    return 1;
}

public OnGameModeExit()
{
    CallLocalFunction("dpp_sampexitcall", "");
    dpp_nullcomment();
    dpp_comment();
    dpp_nullcomment();
    dpp_print("The interpreter reached the EOS point.");
    dpp_print("Process finished with %i errors and %i warnings.", dpp_errorcount,dpp_warningcount);
    dpp_nullcomment();
    dpp_nullcomment();
    dpp_comment();
    //dpp_print("The SA:MP/open.mp script will continue running in the background.");
    if(dpp_stackoutput == 1)
    {
        CallLocalFunction("dpp_dostackoutput", "");
    }
    else
    {
        dpp_print("System stack output is disabled.");
    }
    dpp_comment();
    dpp_nullcomment();
    dpp_nullcomment();
    return 1;
}

//-----------------------------------------------------------

main()
{
    CallLocalFunction("dpp_main", "");
}