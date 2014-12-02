#!/bin/bash



echo CXXConstructorDecl Users/julian/Documents/projects/dark/dark/graphics/Scene.hpp:27:5, MeshIterator 'void (void)'
echo CXXConstructorDecl Users/julian/Documents/projects/dark/dark/graphics/Scene.hpp:28:5, invalid MeshIterator 'void (int)'
echo CXXConstructorDecl Users/julian/Documents/projects/dark/dark/graphics/Scene.hpp:30:5, invalid MeshIterator 'void (int)'
echo CXXConstructorDecl Users/julian/Documents/projects/dark/dark/graphics/Scene.hpp:31:5, MeshIterator 'void (const class Scene::MeshIterator &)'
echo CXXConstructorDecl Users/julian/Documents/projects/dark/dark/graphics/Scene.hpp:49:5, Range 'void (void)'
echo CXXConstructorDecl Users/julian/Documents/projects/dark/dark/graphics/Scene.hpp:50:5, invalid Range 'void (int)'
echo CXXConstructorDecl Users/julian/Documents/projects/dark/dark/graphics/Scene.hpp:53:3, Scene 'void (void)'
echo CXXDestructorDecl Users/julian/Documents/projects/dark/dark/graphics/Scene.hpp:32:5, ~MeshIterator 'void (void)'
echo FieldDecl Users/julian/Documents/projects/dark/dark/graphics/Scene.hpp:67:3, invalid camera 'class Camera'
echo FieldDecl Users/julian/Documents/projects/dark/dark/graphics/Scene.hpp:68:3, invalid meshes 'int'

exit

./clang-query \
  -extra-arg-before="-fno-color-diagnostics" \
  -extra-arg-before="std=c++1y" \
  -extra-arg-before="-isystem /usr/include" \
  -extra-arg-before="-isystem /usr/local/include" \
  -extra-arg-before="-isystem /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/../lib/c++/v1" \
  -extra-arg-before="-isystem /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/include" \
  -extra-arg-before="-isystem /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/../lib/clang/5.1/include" \
  -c "set output dump" \
  -c "m constructorDecl(isExpansionInMainFile())" \
  -c "m destructorDecl(isExpansionInMainFile())" \
  -c "m fieldDecl(isExpansionInMainFile())" \
  -c "m functionDecl(isExpansionInMainFile())" \
  -c "m methodDecl(isExpansionInMainFile())" \
  -c "m recordDecl(isExpansionInMainFile())" \
  $1 -- 2> /dev/null | \
  sed -e '/^Match/d' -e '/^Binding for/d' -e '/^|/d' -e '/^ *`/d' -e '/^$/d' -e '/ matches.$/d' -e '/ match.$/d' | \
  sed -e 's: .*</: :' | \
  cut -d ' ' -f1,2,5-
