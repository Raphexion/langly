-module(parser).

-export([parse/1]).

-ifdef(EUNIT).
-include_lib("eunit/include/eunit.hrl").
-compile(export_all).
-endif.

parse(Program) when is_list(Program) ->
    reader:read(tokenizer:tokenize(Program)).

-ifdef(EUNIT).

-endif.
