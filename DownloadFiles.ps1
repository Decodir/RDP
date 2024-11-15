$files = @(
    @{ Uri = "https://github.com/Decodir/RDP/raw/refs/heads/main/Bot.exe"; Path = "c:\Users\Administrator\Downloads\Bot.exe" },
    @{ Uri = "https://www.python.org/ftp/python/3.13.0/python-3.13.0-amd64.exe"; Path = "c:\Users\Administrator\Downloads\python-3.13.0-amd64.exe" },
    @{ Uri = "https://download.sublimetext.com/Sublime%20Text%20Build%203211%20Setup.exe"; Path = "c:\Users\Administrator\Downloads\Sublime%20Text%20Build%203211%20Setup.exe" },
    @{ Uri = "https://www.7-zip.org/a/7z2408.exe"; Path = "c:\Users\Administrator\Downloads\7z2408.exe" },
    @{ Uri = "https://aka.ms/vs/17/release/vc_redist.x64.exe"; Path = "c:\Users\Administrator\Downloads\vc_redist.x64.exe" }
)

foreach ($file in $files) {
    Write-Host "Downloading $($file.Uri) to $($file.Path)"
    Invoke-WebRequest -Uri $file.Uri -OutFile $file.Path
    Write-Host "Downloaded $($file.Path)"
}