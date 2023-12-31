#!/bin/bash

options=("bash" "zsh")

selected=0

function show_options() {
    clear
    for i in "${!options[@]}"; do
        if [ $i -eq $selected ]; then
            echo "-> ${options[$i]}"
        else
            echo "   ${options[$i]}"
        fi
    done
}

show_options

while true; do
    read -rsn1 input

    case $input in
        A)
            ((selected--))
            if [ $selected -lt 0 ]; then
                selected=$((${#options[@]} - 1))
            fi
            show_options
            ;;
        B)
            ((selected++))
            if [ $selected -ge ${#options[@]} ]; then
                selected=0
            fi
            show_options
            ;;
        "")
            clear
            break
            ;;
    esac
done

function main() {
    echo "Installing python package..."
    echo
    python3 -m pip install g4f >/dev/null 2>&1

    echo "Move python script to home directory"
    echo
    mv ./chat_gpt.py ~/.chat_gpt.py

    echo "Add alias to shell"
    echo

    if [[ "${options[$selected]}" = "bash" ]]; then
        echo "alias gpt='python3 ~/.chat_gpt.py <<<'" >> ~/.bashrc
    else
       echo "alias gpt='python3 ~/.chat_gpt.py <<<'" >> ~/.zshrc
    fi

    echo "Removing repository"
    echo
    echo "Success!"

    cd ../
    rm -rf gpt-in-terminal
    exec $SHELL
}
main
