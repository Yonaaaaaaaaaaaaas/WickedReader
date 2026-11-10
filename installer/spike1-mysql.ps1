# Spike 1: portable MySQL 8.4 LTS. Download the Windows ZIP archive from dev.mysql.com/downloads/mysql/ (8.4 LTS)
# and unzip it to installer\mysql\. Run from the repo root in PowerShell.
$ErrorActionPreference = 'Stop'
$base = Resolve-Path 'installer\mysql'
$data = Join-Path $env:TEMP 'wr-spike-mysql-data'
Remove-Item $data -Recurse -Force -ErrorAction SilentlyContinue
$cnf = Join-Path $env:TEMP 'wr-spike.cnf'
@"
[mysqld]
basedir=$($base -replace '\\','/')
datadir=$($data -replace '\\','/')
bind-address=127.0.0.1
port=33060
mysqlx=OFF
skip-name-resolve
innodb_buffer_pool_size=64M
innodb_log_buffer_size=8M
performance_schema=OFF
max_connections=20
table_open_cache=256
"@ | Set-Content $cnf -Encoding ascii
& "$base\bin\mysqld.exe" --defaults-file=$cnf --initialize-insecure --console
$sw = [Diagnostics.Stopwatch]::StartNew()
$p = Start-Process "$base\bin\mysqld.exe" "--defaults-file=$cnf --console" -PassThru -WindowStyle Hidden
do { Start-Sleep -Milliseconds 200; $ok = (& "$base\bin\mysqladmin.exe" -h127.0.0.1 -P33060 -uroot ping 2>$null) -match 'alive' } until ($ok -or $sw.Elapsed.TotalSeconds -gt 60)
"Startup seconds: {0:N1}" -f $sw.Elapsed.TotalSeconds
Start-Sleep 5
"Working set MB: {0:N0}" -f ((Get-Process mysqld).WorkingSet64 / 1MB)
"Unzipped size MB: {0:N0}" -f ((Get-ChildItem $base -Recurse | Measure-Object Length -Sum).Sum / 1MB)
$sw.Restart(); & "$base\bin\mysqladmin.exe" -h127.0.0.1 -P33060 -uroot shutdown; $p.WaitForExit(10000) | Out-Null
"Shutdown seconds: {0:N1}" -f $sw.Elapsed.TotalSeconds
"Processes left: " + (Get-Process mysqld -ErrorAction SilentlyContinue | Measure-Object).Count
