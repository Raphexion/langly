-module(evaluator).

-export([evaluate/1,
	 evaluate/2]).

-ifdef(EUNIT).
-include_lib("eunit/include/eunit.hrl").
-compile(export_all).
-endif.

evaluate(Expr) ->
    evaluate(Expr, environment:global_env()).

evaluate(Expr, Env) ->
    evaluate_inner(parser:parse(Expr), Env).

%%%
%%
%%%

evaluate_inner({symbol, S}, Env) ->
    maps:get(S, Env, {error, symbol_missing, S, Env});

evaluate_inner([{symbol, Rator}|Rands], Env) ->
    evaluate_symbol(Rator, Rands, maps:find(Rator, Env));

evaluate_inner(Expr, Env) ->
    {e, Expr, Env}.

%%

evaluate_symbol(_, Rands, {ok, F}) ->
    F(Rands);

evaluate_symbol(Rator, Rands, error) ->
    {error, unknown, Rator, Rands}.

-ifdef(EUNIT).

evaluate_mini_test() ->
    Expr = "x",
    Env = #{"x" => 12},
    Res = evaluate(Expr, Env),
    io:fwrite("~p ~n", [Res]),
    ?assert(Res =:= 12).

-endif.
