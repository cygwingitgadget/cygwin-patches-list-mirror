Return-Path: <cygwin-patches-return-2761-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 14821 invoked by alias); 2 Aug 2002 02:00:55 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 14805 invoked from network); 2 Aug 2002 02:00:55 -0000
Message-Id: <3.0.5.32.20020801215654.0080f950@mail.attbi.com>
X-Sender: phumblet@mail.attbi.com
Date: Thu, 01 Aug 2002 19:00:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
Subject: The Everyone group
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-SW-Source: 2002-q3/txt/msg00209.txt.bz2

Corinna,

I am now compiling applications using setgroups and I run
into a strange situation.

The Windows Everyone group is a good way to allow universal
access in a world based on ACLs. However because everybody
is in Everyone, it is not a group (even less a supplementary
group) in the Unix sense.

For example, if I do a setgroups(0, NULL) to remove all 
supplementary groups, I am still in Everyone and getgroups()
reports so. I don't think this is logical. Everyone should
not be considered a supplementary group.

Similarly it makes no sense to setgid () to Everyone (nothing
is gained) nor to set a file group to Everyone. In fact this
causes some strange effects:
> ls -l README
-rwxrwxrwx    1 PHumblet Domain U    14463 Jul 22 04:59 README*
> chgrp Everyone README
> ls -l README
-rwxrwx---    1 PHumblet Everyone    14463 Jul 22 04:59 README*
So it's not a group in the Unix sense, it's more like a reserved 
keyword. 

3 patches are included: those to syscalls.cc and security.cc
are minor optimizations related to setgroups. The one to
grp.cc removes Everyone from the output of getgroups32
(as if it weren't in /etc/group).

Additionally I would suggest modifying mkpasswd and mkgroup to
- remove Everyone from the output
- set the gid of SYSTEM to 544 (instead of 18, which is redundant anyway).
  Without this, doing setgroups(0, NULL) while running as SYSTEM removes
  the Administrators group, which is not at all what happens in Unix when
  running as root.
If you think it's a good idea I'll get to that in a couple of weeks,
after some vacations.
Note that if Everyone is removed from /etc/group applying the patch to 
grp.cc makes no difference.

Pierre

2002-08-01 Pierre Humblet <Pierre.Humblet@ieee.org>

	* security.cc (verify_token): Do not reject a token just because
	the supplementary group list is missing Everyone or a groupsid
	equal to usersid, or because the primary group is not in the token,
	as long as it is equal to the usersid.
	* syscalls.cc (seteuid32): Use common code for all successful returns.
	* grp.cc (getgroups32): Never includes Everyone in the output.


--- security.cc.orig    2002-07-29 20:19:02.000000000 -0400
+++ security.cc 2002-08-01 20:22:56.000000000 -0400
@@ -779,13 +779,16 @@
              saw[pos] = TRUE;
            else if (groups.pgsid == gsid)
              sawpg = TRUE;
-           else
+           else if (gsid != well_known_world_sid &&
+                    gsid != usersid)
              goto done;
          }
       for (int gidx = 0; gidx < groups.sgsids.count; gidx++)
        if (!saw[gidx])
          goto done;
-      if (sawpg || groups.sgsids.contains (groups.pgsid))
+      if (sawpg || 
+         groups.sgsids.contains (groups.pgsid) ||
+         groups.pgsid == usersid)
        ret = TRUE;
     }
 done:



--- syscalls.cc.orig    2002-08-01 20:19:24.000000000 -0400
+++ syscalls.cc 2002-08-01 20:23:12.000000000 -0400
@@ -2003,7 +2003,7 @@
       else
        {
          CloseHandle (ptok);
-         return 0; /* No change */
+         goto success; /* No change */
        }
     }
 
@@ -2024,7 +2024,7 @@
              CloseHandle (ptok);
              if (!ImpersonateLoggedOnUser (cygheap->user.token))
                system_printf ("Impersonating in seteuid failed: %E");
-             return 0; /* No change */
+             goto success; /* No change */
            }
        }
     }
@@ -2096,6 +2096,7 @@
       CloseHandle (sav_token);
   cygheap->user.set_name (pw_new->pw_name);
   cygheap->user.set_sid (usersid);
+ success:
   myself->uid = uid;
   groups.ischanged = FALSE;
   return 0;

--- grp.cc.orig 2002-07-29 20:19:02.000000000 -0400
+++ grp.cc      2002-08-01 20:23:04.000000000 -0400
@@ -365,7 +365,8 @@
              for (int gidx = 0; (gr = internal_getgrent (gidx)); ++gidx)
                if (sid.getfromgr (gr))
                  for (DWORD pg = 0; pg < groups->GroupCount; ++pg)
-                   if (sid == groups->Groups[pg].Sid)
+                   if (sid == groups->Groups[pg].Sid && 
+                       sid != well_known_world_sid)
                      {
                        if (cnt < gidsetsize)
                          grouplist[cnt] = gr->gr_gid;
@@ -516,5 +517,4 @@
         grouplist32[i] = grouplist[i];
     }
   return setgroups32 (ngroups, grouplist32);
-
 }
