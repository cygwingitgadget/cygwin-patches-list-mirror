Return-Path: <cygwin-patches-return-4989-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 30749 invoked by alias); 23 Sep 2004 16:24:46 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 30648 invoked from network); 23 Sep 2004 16:24:42 -0000
Date: Thu, 23 Sep 2004 16:24:00 -0000
From: Corinna Vinschen <vinschen@redhat.com>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Fake POSIX behaviour in seteuid/setegid
Message-ID: <20040923162537.GA944@cygbert.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2i
X-SW-Source: 2004-q3/txt/msg00141.txt.bz2

Hi folks,
especially Pierre,

I'm thinking of applying the below patch.  The idea is that an application
which has changed real as well as effective id to values different from
the saved (==original) id has no way to restore its old identity.

That's obviously not correct from a Windows NT point of view, but this
is a start to mimic the expected behaviour under POSIX.  For example
OpenSSH's sshd calls seteuid/setuid to change to an unprivileged user
and then it calls seteuid and setuid again, to test if it's possible
to revert the identity to root.  If so, it exists with error.  Same for
the gid.  The Cygwin version of OpenSSH currently disables these tests,
but it might be a good idea to fake POSIXy behaviour from a portability
point of view.

Any thoughts appreciated.  I'd be interested if there's some serious
reason not to do this at all, or if there's a better way to do this.
One caveat of my patch is that changing from one privileged account to
another privileged account disables changing uids, even though the
second account would also have this right.  Perhaps the tests should
be coupled with a check, whether the current effective uid has the
appropriate permissions or not.  I'm also suspecting that the gid
test is not far away from a total error in reasoning...


Corinna


	* syscalls.cc (seteuid32): Mimic POSIX behaviour.  After giving up
	real and effective uid, don't allow to change uids again.
	(setegid32): Ditto for gids.

Index: syscalls.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/syscalls.cc,v
retrieving revision 1.348
diff -p -u -r1.348 syscalls.cc
--- syscalls.cc	17 Sep 2004 09:10:53 -0000	1.348
+++ syscalls.cc	23 Sep 2004 16:16:56 -0000
@@ -2004,6 +2004,15 @@ seteuid32 (__uid32_t uid)
       return 0;
     }
 
+  /* Mimic POSIX behaviour.  After giving up the real uid, don't allow
+     to change uids again. */
+  if (cygheap->user.real_uid != cygheap->user.saved_uid
+      && myself->uid != cygheap->user.saved_uid)
+    {
+      set_errno (EPERM);
+      return -1;
+    }
+
   cygsid usersid;
   user_groups &groups = cygheap->user.groups;
   HANDLE ptok, new_token = INVALID_HANDLE_VALUE;
@@ -2184,6 +2193,15 @@ setegid32 (__gid32_t gid)
       return 0;
     }
 
+  /* Mimic POSIX behaviour.  After giving up the real gid, don't allow
+     to change gids again. */
+  if (cygheap->user.real_gid != cygheap->user.saved_gid
+      && myself->gid != cygheap->user.saved_gid)
+    {
+      set_errno (EPERM);
+      return -1;
+    }
+
   user_groups * groups = &cygheap->user.groups;
   cygsid gsid;
   HANDLE ptok;

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          mailto:cygwin@cygwin.com
Red Hat, Inc.
