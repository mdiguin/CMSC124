-module(cats).
-compile(export_all).

% START PONG
init_chat() ->
    % User1 = string:chomp(io:get_line("Enter your name: ")),
    % io:format("Hello, ~s!~n", 
    %               [User1]),
    register (cat, spawn(cats,cat_receive,[])).

% START PING
init_chat2(User1) ->
    % User2 = string:chomp(io:get_line("")),
    spawn(cats, dog, [User1]),
    spawn(cats,cat_send,[User1]),
    {dog, User1} ! {dog, self()}.


cat_send(User2_Pid) ->
    receive
        {dog, User2_Pid} ->
            Message = io:get_line("You: "),
            User2_Pid ! {cat, self(), Message},
            cat_send(User2_Pid)
    end.
    
cat_receive() ->
    % Message = io:get_line("You: "),
    % Rand_string = "[Message]",
    % {dog, User1_Node} ! {cat, self()},
	receive
        {dog, User2_Pid} ->
			% io:format("CAT() PARAM1 ~n"),
            
			% User2_Pid ! {cat, self(), Message},
			cat_receive();
        {dog, User2_Pid, Message} ->
            % io:format("CAT() PARAM2 ~n"),
			io:format("dog: ~s", [Message]),
            % Reply = io:get_line("You: "),
			% User2_Pid ! {cat, self(), Reply},
			cat_receive()
	end.
% PING IS DOG
dog(User1_Node) ->
    % io:format(">>>DOG CHECKPOINT"),
    % Message = io:get_line("You: "),
    % Message = "asdasad",
    % io:format("<<<DOG CHECKPOINT"),
    % {cat, User1_Node} ! {dog, self(), Message},
    % {cat, User1_Node} ! {dog, self()},
    receive
        {cat, User1_Pid} ->
            % io:format("DOG() PARAM1 ~n"),
            Message = io:get_line("You: "),
			% io:format("~s", [Message]),
            User1_Pid ! {dog, self(), Message},
            dog(User1_Node);
        {cat, User1_Pid, Message} ->
            % io:format("DOG() PARAM2 ~n"),
			io:format("cat: ~s", [Message]),
            Reply = io:get_line("You: "),
			User1_Pid ! {dog, self(), Reply},
			dog(User1_Node)
    end.
    % dog(User1_Node).

% c(cats).
% cats:init_chat2(user1@osboxes).