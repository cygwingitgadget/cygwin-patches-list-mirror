Return-Path: <cygwin-patches-return-3131-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 1167 invoked by alias); 6 Nov 2002 16:36:51 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 1153 invoked from network); 6 Nov 2002 16:36:49 -0000
Message-ID: <3DC9450F.8936C644@ieee.org>
Date: Wed, 06 Nov 2002 08:36:00 -0000
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
X-Accept-Language: en
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: patch 3: sshd 
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-SW-Source: 2002-q4/txt/msg00082.txt.bz2

Corinna,

Currently setuid on Win95/98/ME always returns success
but does not change the uid. That confuses some programs
that verify if the setuid has really succeeded.

It is literally a two line change in Cygwin to fix
that, but unfortunately changing uids breaks sshd
on Win95/98/ME.

So attached is a patch for sshd. The idea is that 
you would apply it starting with the next release
of openssh. After that is out, I will patch Cygwin.

Looks like I just missed the boat, this patch was for
the openssh version of yesterday. Hopefully it hasn't 
changed.

The sshd patch is written to be compatible both with the
current Cygwin and the future one.


Pierre


P.S.: There is an opposite problem in login. It doesn't
check if the setuid succeeds. If it fails (e.g. because
the sid is missing in /etc/passwd), login goes ahead
and starts the shell anyway. The user then finds herself
running as SYSTEM.




--- session.c.orig      2002-10-30 20:18:54.000000000 -0500
+++ session.c   2002-10-30 20:20:02.000000000 -0500
@@ -1162,7 +1162,7 @@ do_setusercontext(struct passwd *pw)
        char tty='\0';
 
 #ifdef HAVE_CYGWIN
-       if (is_winnt) {
+       {
 #else /* HAVE_CYGWIN */
        if (getuid() == 0 || geteuid() == 0) {
 #endif /* HAVE_CYGWIN */
@@ -1216,6 +1216,9 @@ do_setusercontext(struct passwd *pw)
                permanently_set_uid(pw);
 #endif
        }
+#ifdef HAVE_CYGWIN
+       if (is_winnt)
+#endif
        if (getuid() != pw->pw_uid || geteuid() != pw->pw_uid)
                fatal("Failed to set uids to %u.", (u_int) pw->pw_uid);
 }
