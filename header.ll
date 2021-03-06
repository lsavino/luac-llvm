%lua_State = type opaque
%lua_Number = type double
%lua_Integer = type i64
%lua_Unsigned = type i32

declare %lua_State* @luaL_newstate ()
%luaL_newstate_fp = type %lua_State* ()*

declare void @lua_pushnumber (%lua_State*, %lua_Number)
%lua_pushnumber_fp = type void (%lua_State*, %lua_Number)*

declare void @lua_settop (%lua_State*, i32)
%lua_settop_fp = type void (%lua_State*, i32)*

declare i32 @lua_toboolean (%lua_State*, i32)
%lua_toboolean_fp = type i32 (%lua_State*, i32)*

declare void @lua_pushboolean (%lua_State*, i32)
%lua_pushboolean_fp = type void (%lua_State*, i32)*

@globalState = private unnamed_addr global %lua_State* null

%pop_fp = type void (%lua_State*, i32)*
define fastcc void @pop (%lua_State* %state, i32 %count) {
    %index = sub i32 -1, %count
    call %lua_settop_fp @lua_settop (%lua_State* %state, i32 %index)

    ret void
}

define i32 @main () {
entry:
    %state = call %luaL_newstate_fp @luaL_newstate ()
    store %lua_State* %state, %lua_State** @globalState

    ; generated code starts here
