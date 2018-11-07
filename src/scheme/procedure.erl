-module(procedure).

-export([p/3]).

-ifdef(EUNIT).
-include_lib("eunit/include/eunit.hrl").
-compile(export_all).
-endif.

p(Params, Body, Env) ->
    fun(Args) ->
	    evaluator:evaluate(Body, merge(Env, zip(Params, Args)))
    end.

zip(Params, Args) ->
    maps:from_list(lists:zip(Params, Args)).

merge(Env0, Env) ->
    maps:merge(Env0, Env).


-ifdef(EUNIT).

zip_test() ->
    Params = [a, b, c],
    Args = [q, r, s],
    Zipped = zip(Params, Args),
    ?assert(Zipped =:= #{a => q, b => r, c => s}).

merge_test() ->
    Env0 = #{a => 10, b => 20, c => 30},
    EnvN = #{b => 21, d => 40},
    Merged = merge(Env0, EnvN),
    ?assert(Merged =:= #{a => 10, b => 21, c => 30, d => 40}).

%% p_1_test() ->
%%     Params = [{symbol, x}],
%%     Body = "(+ x 1)",
%%     Env = environment:global_env(),
%%     P = p(Params, Body, Env),
%%     Res = P([41]),
%%     ?assert(Res =:= 42).

-endif.
