%% -*- mode: erlang -*-
%% link:
%% https://stackoverflow.com/questions/28084192/what-am-i-doing-wrong-with-erl-parseparse-form

-module(evaly).
-export([eval/1]).

eval(File) ->
    {ok, B} = file:read_file(File),
    Forms = scan(erl_scan:tokens([],binary_to_list(B),1),[]),
    [parse_form(X) || X <- Forms].

scan({done,{ok,T,N},S},Res) ->
    scan(erl_scan:tokens([],S,N),[T|Res]);
scan(_,Res) ->
    lists:reverse(Res).

%%================================================================
%% Internal
%%================================================================

parse_form(X) ->
    io:fwrite("PARSE: ~p ~n", [X]),
    case erl_parse:parse_form(X) of
	{ok, Y} ->
	    Y;
	Other ->
	    io:fwrite("~p ~n", [Other]),
	    Other
    end.
