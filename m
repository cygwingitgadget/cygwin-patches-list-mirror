From: Corinna Vinschen <corinna@vinschen.de>
To: cygpatch <cygwin-patches@sourceware.cygnus.com>
Subject: [PATCH]: Fixed some ntsec/samba problems
Date: Wed, 24 May 2000 13:23:00 -0000
Message-id: <392C3A0E.1BA90A04@vinschen.de>
X-SW-Source: 2000-q2/msg00082.html

I have patched dir.cc, syscalls.cc and security.cc in
some details to fix problems when working on samba
shares. For some reason it was sometimes impossible to
copy files with the previously created ACLs to samba
shares with dubious results ("File already exists" or
a copy with messed up file name). The same ACLs had
no problems on local or remote NTFS drives.

I have still a problem which maybe related to
another samba feature. The problem is that I'm unable
to remove any read permission from any file on a
samba share with ntsec. But that's a minor problem,
IMHO. I will contact Jeremy Allison. Maybe he knows
a solution.

Corinna
