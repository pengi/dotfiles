#!/bin/sh

echo "======================================================================="
echo "=== Updateing dotilfes"
echo "==="
echo "=== $0"
echo "=== PWD        = $PWD"
echo "=== HOME       = $HOME"
echo "======================================================================="

syncrepo() {
    CHECKOUT=$1
    REMOTE=$2
    BRANCH=$3

    mkdir -p $CHECKOUT
    if [ ! -d $CHECKOUT/.git ]; then
    git -C $CHECKOUT init --quiet
    fi
    git -C $CHECKOUT config core.eol lf
    git -C $CHECKOUT config core.autocrlf false
    git -C $CHECKOUT config fsck.zeroPaddedFilemode ignore
    git -C $CHECKOUT config fetch.fsck.zeroPaddedFilemode ignore
    git -C $CHECKOUT config receive.fsck.zeroPaddedFilemode ignore
    git -C $CHECKOUT remote add origin "$REMOTE" \
        || git -C $CHECKOUT remote set-url origin "$REMOTE"
    git -C $CHECKOUT fetch origin $BRANCH
    git -C $CHECKOUT checkout $BRANCH
    git -C $CHECKOUT branch -u origin/$BRANCH $BRANCH
    git -C $CHECKOUT rebase origin/$BRANCH
}

symlink_dot() {
    FILE=$1

    # Backup if not a symlink
    if [ -f $HOME/.$FILE -a ! -h $HOME/.$FILE ]; then
        mv $HOME/.$FILE $HOME/.$FILE.bak
    fi
    # Refresh symlink
    if [ -e $HOME/.$FILE ]; then
        rm $HOME/.$FILE
    fi
    ln -s $PWD/$FILE $HOME/.$FILE
}


syncrepo $HOME/.oh-my-zsh https://github.com/ohmyzsh/ohmyzsh.git master
git -C $HOME/.oh-my-zsh config oh-my-zsh.remote origin
git -C $HOME/.oh-my-zsh config oh-my-zsh.branch master

symlink_dot zshrc