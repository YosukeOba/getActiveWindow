$code = @'
    [DllImport("user32.dll")]
     public static extern IntPtr GetForegroundWindow();
    [DllImport("user32.dll")]
    public static extern IntPtr GetWindowThreadProcessId(IntPtr hWnd, out int ProcessId);
'@

Add-Type $code -Name Utils -Namespace Win32
$myPid = [IntPtr]::Zero;

while(1){
    $hwnd = [Win32.Utils]::GetForegroundWindow()
    $null = [Win32.Utils]::GetWindowThreadProcessId($hwnd, [ref] $myPid)
    Write-Host (Get-Process | Where-Object ID -eq $myPid | Select-Object Name,processName,Id,Path,MainWindowTitle)
    Start-Sleep -Milliseconds 500

$port=5000
$TcpClient=New-Object System.Net.Sockets.TcpClient([IPAddress]::Loopback, $port)
 
$GetStream = $TcpClient.GetStream()
$StreamWriter = New-Object System.IO.StreamWriter $GetStream
 
$positions=Get-Process | Where-Object ID -eq $myPid | Select-Object Name,processName,Id,Path,MainWindowTitle
 
$StreamWriter.Write($positions)
 
$StreamWriter.Dispose()
$GetStream.Dispose()
$TcpClient.Dispose()
}