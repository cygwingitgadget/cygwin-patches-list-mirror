Return-Path: <cygwin-patches-return-3629-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 23677 invoked by alias); 27 Feb 2003 03:25:31 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 23666 invoked from network); 27 Feb 2003 03:25:30 -0000
Message-Id: <3.0.5.32.20030226222310.007fcb40@mail.attbi.com>
X-Sender: phumblet@mail.attbi.com (Unverified)
Date: Thu, 27 Feb 2003 03:25:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
Subject: updating the internal copy of the gsid
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-SW-Source: 2003-q1/txt/msg00278.txt.bz2

Corinna,

Have you seen 
http://cygwin.com/ml/cygwin/2003-02/msg02069.html

A domain user had never run mkpasswd -d nor mkgroup -d
but had a local account with the same username.
When starting, Cygwin looks up /etc/passwd, finds the name
and associates the local uid with the domain sid. 
We could detect the clash, but we are nice and let the program
proceed normally. 

Actually things work out pretty well that way, except that in
internal_getlogin SetTokenInformation(PrimaryGroup) fails
(as it should) but the internal Cygwin copy of the group sid
is updated. Thus files created by Word have a different group
(showing up as ???????) than files created by Cygwin.

To mask the craziness of the situation, the patch below only 
updates the internal Cygwin copy if SetTokenInformation succeeds.
This has no effect in normal cases where the gid is one of the 
token groups.

2003-02-27  Pierre Humblet  <pierre.humblet@ieee.org>
 
	* uinfo.cc (internal_getlogin): Only update user.groups.pgsid
	if the call to set the primary group succeeds.
 


Index: uinfo.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/uinfo.cc,v
retrieving revision 1.111
diff -u -p -r1.111 uinfo.cc
--- uinfo.cc    6 Feb 2003 14:01:54 -0000       1.111
+++ uinfo.cc    27 Feb 2003 02:56:06 -0000
@@ -83,10 +83,11 @@ internal_getlogin (cygheap_user &user)
          if (gsid.getfromgr (internal_getgrgid (pw->pw_gid)))
            {
              /* Set primary group to the group in /etc/passwd. */
-             user.groups.pgsid = gsid;
              if (!SetTokenInformation (ptok, TokenPrimaryGroup,
                                        &gsid, sizeof gsid))
                debug_printf ("SetTokenInformation(TokenPrimaryGroup): %E");
+              else
+                user.groups.pgsid = gsid;
            }
          else
            debug_printf ("gsid not found in augmented /etc/group");
