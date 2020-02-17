# OK Defender
OK Defender is a simple powershell script that runs in the background and periodically checks if Windows Defender real-time protection is enabled, and if it is the script will disable it.

In order for this script to work properly, you need to manually disable 'Tamper Protection' feature of Windows Defender. Open `Windows Settings` > `Update & Security` > `Windows Security` > `Virus & threat protection` > `Virus & threat protection settings` > `Manage settings` and set 'Tamper Protection' switch to Off.


## FAQ
Q: Why would I want to disable Windows Defender real-time protection?

A: Normally, you wouldn't. But disabling real-time protection can speed things in some situations, like reading or writing a lot of small files, scanning media or preset libraries, indexing, searching, installing programs etc) and can generally improve startup and response time in most applications.


Q: Why not just disable real-time protection manually via Windows Defender UI?

A: Windows Defender systematically checks the status of real-time protection service, and if it finds it disabled it will turn it back on automatically. This works in a random fasion so you never know when real-time protection will be turned on next time. Could be in 5 minutes or several hours. Totally unpredictible. The purpose of OK Defender script is to run in the background and try to stop real-time protection every 15 seconds. No matter if real-time protection is actually running or not.


Q: Is it safe to disable Windows Defender real-time protection?

A: Not really. You effectively stop Windows Defender from scanning new files and monitoring running processes. This makes your system less secure. But to be fair, you are not stopping Windows Defender itself, but only some of its real-time monitoring features.


Q: Does this script use undocumented registry tweaks or some other hacks to do its work?

A: No. OK Defender uses only builtin native powershell commands designed by Microsoft for that specific purpose.
