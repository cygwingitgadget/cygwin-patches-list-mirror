From: Corinna Vinschen <corinna@vinschen.de>
To: cygpatch <cygwin-patches@sourceware.cygnus.com>
Subject: [PATCH]: Changes in process startup code
Date: Mon, 19 Jun 2000 10:55:00 -0000
Message-id: <394E5E78.FC4D70F@vinschen.de>
X-SW-Source: 2000-q2/msg00109.html

I have just checked in a patch which adds the following
features to cygwin when running on NT/W2K:

- User SID is now only retrieved if ntsec is ON.

That should result in a considerable speed up if ntsec is OFF.

- User logon informations are now only retrieved on the
  first parent process or if the user context changes
  (eg. via sshd, ftpd, login).
- First the code tries to get that information from the
  localhost and only if that failes, it tries to get them
  from the logon server.

Advantage of the above patches should be a considerable
speed up with ntsec ON and at least some speed up with
ntsec OFF.

- If user context changes, the environment is adjusted.
  The following variable are changed according to the new
  user:

	HOMEDRIVE
	HOMEPATH
	LOGONSERVER
	USERDOMAIN
	USERNAME
	USERPROFILE

- If a new process is spawned in a new user context
  (CreateProcessAsUser), the dll tries to load the users
  registry hive.

  Advantage: Each user has it's own mount points also when
  logged on via telnet/ssh etc.

  Disadvantage: Changes made to the users registry hive
  in a telnet/ssh session are lost on reboot because there's
  currently no code which would be able to save the hive
  back again. 

COrinna
