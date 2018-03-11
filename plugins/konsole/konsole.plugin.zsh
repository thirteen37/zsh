if which konsole > /dev/null; then
    function tab () {
        local command="cd \"$PWD\""
        (( $# > 0 )) && command="${command}; $*"
        session=$(qdbus org.kde.konsole /Konsole newSession)
        qdbus org.kde.konsole /Sessions/$session runCommand "${command}" > /dev/null
    }
fi
