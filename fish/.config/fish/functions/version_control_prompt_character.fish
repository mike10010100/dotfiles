function version_control_prompt_character
    git branch >/dev/null 2>/dev/null; and echo -n '±'; and return
    # hg root >/dev/null 2>/dev/null; and echo -n '☿'; and return
    svn info >/dev/null 2>/dev/null; and echo -n '§'; and return
    echo '○'
end
