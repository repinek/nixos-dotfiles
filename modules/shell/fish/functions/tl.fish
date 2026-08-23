# Written by AI, but looks good
function tl --description "Translate text using local LibreTranslate"
    # less than 2
    if test (count $argv) -lt 2
        echo "Usage: tl [source] <target> <text>" >&2
        return 2
    end

    set -l source auto
    set -l target $argv[1]
    set -l text (string join " " $argv[2..-1])

    # greater than 3 and argv2 contains en ru uk zh
    if test (count $argv) -ge 3; and contains -- $argv[2] en ru uk zh
        set source $argv[1]
        set target $argv[2]
        set text (string join " " $argv[3..-1])
    end

    set -l payload (jq -cn \
        --arg q "$text" \
        --arg source "$source" \
        --arg target "$target" \
        '{
          q: $q,
          source: $source,
          target: $target,
          format: "text",
          alternatives: 3
        }')

    set -l response (curl --silent --show-error \
        --header "Content-Type: application/json" \
        --data-binary "$payload" \
        http://127.0.0.1:5000/translate/translate)

    if test $status -ne 0
        echo "LibreTranslate is unavailable" >&2
        return 1
    end

    string join \n $response | jq -r '
        if .error then
            "error: \(.error)"
        else
            "translated:\n  \(.translatedText)\n"
            + (if (.alternatives // [] | length) > 0 then
                "\nalternatives:\n"
                + ([.alternatives[]]
                    | to_entries
                    | map("  \(.key + 1). \(.value)")
                    | join("\n"))
              else
                ""
              end)
        end
    '
end
