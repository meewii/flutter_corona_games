if [ "$OSTYPE" != "linux-gnu" ]
  then
    echo "release script must be run from a Linux host"
    exit -1
fi

if [ -z "$1" ]
  then
    echo "Need to add app name ./deploy_to_heroku.sh <app-name> \"<deploy message>\""
    exit -1
fi

if [ -z "$2" ]
  then
    echo "Need to add app name ./deploy_to_heroku.sh <app-name> \"<deploy message>\""
    exit -1
fi

APP_NAME="$1"
COMMIT_MESSAGE="$2"
CURRENT_DIR=${PWD}
SOURCE_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

echo "Move to source folder, delete build"
cd $SOURCE_DIR
rm -rf build

echo "Git clone from heroku"
heroku git:clone -a $APP_NAME build

echo "Add Procfile"
echo "web: bin/server" > build/Procfile

echo "Compiled Dart executable"
dart pub get
dart compile exe bin/server.dart -o build/bin/server

echo "Deploy to Heroku"
cd build
git add .
git commit -m "${COMMIT_MESSAGE}"
git push heroku master

echo "Clean-up"
cd ..
rm -rf build
cd $CURRENT_DIR

# reminder, to add the build pack to run binary from heroku use:
# heroku config:set BUILDPACK_URL=https://github.com/budius/heroku-binary-buildpack -a <app-name>
