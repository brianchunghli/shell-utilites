
build() {
  if [ ! -f "$(pwd)/CMakeLists.txt" ]; then
    echo "$(basename $0): '$(pwd)' does not contain a cmake compilation file.";
    return
  fi;
  case "$1" in
    "release") 
        cmake -S . -B build/ -DCMAKE_BUILD_TYPE=Release
        cmake --build build/
        ;;
    "clean")
        if [ -d "$(pwd)/build" ] && [ -f "$(pwd)/CMakeLists.txt" ]; then
          rm -rf build/ && mkdir build/ ||
          { echo "error occurred when deleting build folder"; return; }
        fi;;
    *)
      cmake -S . -B build/ -DCMAKE_BUILD_TYPE=Debug
      cmake --build build/
       ;;
  esac
}

viteBuild () {
  if [ -z "$@" ]; then 
    echo missing parameters
    return;
  fi 
  npm create vite@latest "$1" -- --template react-ts  &&
  cd "$1"                                             &&
  npm i vite-plugin-react --save-dev                  &&
  echo "=> moving to '$1'"                            &&
  npm i tailwindcss autoprefixer --save-dev           &&
  echo "=> adding packages ...\n"                     &&
  npm i react react-dom                               &&
  echo                                                &&
  npm i react-router-dom                              &&
  echo                                                &&
  npm i eslint@latest --save-dev                      &&
  echo "\n=> eslint setup ...\n"                      &&
  npm init @eslint/config                             &&
  npx tailwindcss init                                &&
}
