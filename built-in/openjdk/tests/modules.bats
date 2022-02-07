#!/usr/bin/env bats

setup() {
  module load CBI openjdk/"${VERSION}"
}

@test "OpenJDK: java exists" {
  run java -version
  [ $status -eq 0 ]
  [[ "${lines[0]}" =~ ^"openjdk version \"${VERSION}"* ]]
}

@test "OpenJDK: javac exists" {
  command -v javac || skip
  run javac -version
  [ $status -eq 0 ]
  [[ "${lines[0]}" =~ ^"javac ${VERSION}"* ]]
}

@test "OpenJDK: dirname(javac) == dirname(java)" {
  command -v javac || skip
  [ "$(dirname "$(command -v javac)")" == "$(dirname "$(command -v java)")" ]
}
