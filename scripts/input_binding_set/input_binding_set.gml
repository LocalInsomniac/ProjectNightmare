/// @param verb
/// @param binding
/// @param [playerIndex]
/// @param [alternate]

function input_binding_set()
{
    var _verb         = argument[0];
    var _binding      = argument[1];
    var _player_index = ((argument_count > 2) && (argument[2] != undefined))? argument[2] : 0;
    var _alternate    = ((argument_count > 3) && (argument[3] != undefined))? argument[3] : 0;
    
    if (_player_index < 0)
    {
        __input_error("Invalid player index provided (", _player_index, ")");
        return undefined;
    }
    
    if (_player_index >= INPUT_MAX_PLAYERS)
    {
        __input_error("Player index too large (", _player_index, " vs. ", INPUT_MAX_PLAYERS, ")\nIncrease INPUT_MAX_PLAYERS to support more players");
        return undefined;
    }
    
    if (_alternate < 0)
    {
        __input_error("Invalid \"alternate\" argument (", _alternate, ")");
        return undefined;
    }
    
    if (_alternate >= INPUT_MAX_ALTERNATE_BINDINGS)
    {
        __input_error("\"alternate\" argument too large (", _alternate, " vs. ", INPUT_MAX_ALTERNATE_BINDINGS, ")\nIncrease INPUT_MAX_ALTERNATE_BINDINGS for more alternate binding slots");
        return undefined;
    }
    
    if (!input_value_is_binding(_binding))
    {
        __input_error("Value provided is not a binding");
        return undefined;
    }
    
    with(global.__input_players[_player_index])
    {
        var _source = __input_binding_get_source(_binding)
        __input_trace("Setting player ", _player_index, " binding for source=", input_source_get_name(_source), ", verb=", _verb, ", alt=", _alternate, " to \"", input_binding_get_name(_binding), "\"");
        set_binding(_source, _verb, _alternate, _binding);
    }
}