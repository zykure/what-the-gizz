#!/bin/bash

# Publishes files to zykure.github.io and uploads to zykure.de

NAME="what-the-gizz"
TARGET="${1:-../zykure.github.io.git/${NAME}/}"

if [ ! -d "${TARGET}" ]; then
    echo "ERROR: Target directory ${TARGET} does not exist."
    exit 1
fi

echo "Copying files to directory: ${TARGET}"
cp -var * ${TARGET} || exit $?

OLD_PWD="${PWD}"

cd ${TARGET}
echo "Committing files ..."
git add .
git status
echo ">>> Git commit + push in 3 seconds - press Ctrl+C to abort <<<"
sleep 1; echo "."
sleep 1; echo "."
sleep 1; echo "."
git commit -m "Update ${NAME} files"
git push

echo "Running upload script ..."
./upload.sh || exit $?

cd ${OLD_PWD}
echo "All done. Good job."
