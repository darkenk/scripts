if [ ! -n $1 ]; then
    echo "Missing folder name"
else
    if [[ "$1" = /* ]]; then
        NEW_HOME=$1
    else
        NEW_HOME="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"/$1
    fi
    echo "Using ${NEW_HOME} as repo config folder"
    mkdir -p ${NEW_HOME}
    if [ ! -e ${NEW_HOME}/repo ]; then
        curl http://commondatastorage.googleapis.com/git-repo-downloads/repo > ${NEW_HOME}/repo
        chmod a+x ${NEW_HOME}/repo
    fi
    if [ ! -e ${NEW_HOME}/.gitconfig ]; then
        cp ${HOME}/.gitconfig ${NEW_HOME}/.gitconfig
    fi
    if [ ! -e ${NEW_HOME}/.ssh ]; then
        ln -s ${HOME}/.ssh ${NEW_HOME}/.ssh
    fi
    alias git="HOME=${NEW_HOME} git"
    alias repo="HOME=${NEW_HOME} ${NEW_HOME}/repo"
fi
