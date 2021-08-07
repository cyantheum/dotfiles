#!/bin/bash

has_git() {
    if [[ "$(git --version)" != *"version"* ]]; then
        return 0 
    else
        return 1 
    fi
}

backup_vim_dot_files() {
    cp $HOME/.config/nvim/init.vim .
}

need_to_push_changes() {
    if [[ "$(git status | grep -i "modified")" == *"modified"* ]]; then
        return 1
    else
        return 0
    fi
}

push_changes() {
    git add -u;
    git commit -m "Auto | `date +'%Y-%m-%d %H:%M:%S'`"; 
    git push origin master
}

backup() {
    if [[ has_git -ne 0 ]]; then
        exit
    fi

    backup_vim_dot_files
    if [[ need_commit_changes -ne 1 ]]; then
        push_changes
    fi
}

backup
