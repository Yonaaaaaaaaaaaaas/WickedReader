# Spike 2: needs JDK 21 and Maven. Builds the service, makes a jlink runtime, runs the JAR without system Java.
$ErrorActionPreference = 'Stop'
mvn -B -f service\pom.xml -DskipTests package
$jar = (Get-ChildItem service\target\*.jar | Where-Object { $_.Name -notmatch 'original' } | Select-Object -First 1).FullName
$mods = & "$env:JAVA_HOME\bin\jdeps.exe" --ignore-missing-deps --multi-release 21 --print-module-deps $jar
if (-not $mods) { $mods = 'java.base,java.logging,java.sql,java.naming,java.management,java.instrument,java.desktop,java.xml,java.security.jgss,jdk.unsupported' }
Remove-Item installer\build\jre -Recurse -Force -ErrorAction SilentlyContinue
& "$env:JAVA_HOME\bin\jlink.exe" --add-modules "$mods,jdk.crypto.ec" --strip-debug --no-header-files --no-man-pages --compress zip-6 --output installer\build\jre
"JRE image MB: {0:N0}" -f ((Get-ChildItem installer\build\jre -Recurse | Measure-Object Length -Sum).Sum / 1MB)
$env:WR_PORT = '18080'
$p = Start-Process installer\build\jre\bin\java.exe "-jar $jar" -PassThru -WindowStyle Hidden
Start-Sleep 10
Invoke-RestMethod http://127.0.0.1:18080/api/app/health
Stop-Process $p
