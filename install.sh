#!/bin/bash

# Массив с вариантами
options=("bash" "zsh")

# Индекс выбранного варианта
selected=0

# Функция для отображения вариантов и текущего выбранного
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

# Отобразить варианты
show_options

# Бесконечный цикл для обработки ввода пользователя
while true; do
    read -rsn1 input

    case $input in
        A) # Стрелка вверх
            ((selected--))
            if [ $selected -lt 0 ]; then
                selected=$((${#options[@]} - 1))
            fi
            show_options
            ;;
        B) # Стрелка вниз
            ((selected++))
            if [ $selected -ge ${#options[@]} ]; then
                selected=0
            fi
            show_options
            ;;
        "") # Нажата клавиша Enter. Выбор сделан.
            clear
            echo "Выбрано: ${options[$selected]}"
            break
            ;;
    esac
done

echo "Installing python package"
python3 -m pip install g4f >/dev/null 2>&1

echo "Move python script to home directory"
mv ./chat_gpt.py ~/.chat_gpt.py

echo "Add alias to shell"
if [[ "${options[$selected]}" = "bash" ]]; then
    echo "alias gpt='python3 ~/.chat_gpt.py <<<'" >> ~/.bashrc
else
    echo "alias gpt='python3 ~/.chat_gpt.py <<<'" >> ~/.zshrc
fi

echo "Removing repository"
cd ../
rm -r gpt-in-terminal

echo "Success!\nRerun terminal"
