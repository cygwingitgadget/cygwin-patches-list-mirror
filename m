Return-Path: <cygwin-patches-return-3232-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 32419 invoked by alias); 25 Nov 2002 01:20:36 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 32410 invoked from network); 25 Nov 2002 01:20:35 -0000
Message-Id: <3.0.5.32.20021124201818.0082b5e0@mail.attbi.com>
X-Sender: phumblet@mail.attbi.com
Date: Sun, 24 Nov 2002 17:20:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
Subject: Win98/ME home directory
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-SW-Source: 2002-q4/txt/msg00183.txt.bz2

Corinna

This fixes the Win98 home directory issue reported on the cygwin
list. It affects most Win98/ME users that don't have a passwd entry
for their Windows username, so it may be worth making a special
release. Sorry about that.
There is a related fix: cygheap->user.name is now set properly
on Win98/Me when the Windows and Cygwin usernames differ.

Also, looking at the output of mkpasswd on Win9X made me think
it would be more secure to set the passwd field to *.

Pierre

2002-11-24  Pierre Humblet <pierre.humblet@ieee.org>

	* passwd.cc (read_etc_passwd): Never add an entry when starting
	on Win95/98/ME if a default entry is present.
	* uinfo.cc (internal_getlogin): Look for the default uid if needed.
	Always call user.set_name ().
	


--- passwd.cc.orig      2002-11-24 11:40:44.000000000 -0500
+++ passwd.cc   2002-11-24 15:48:24.000000000 -0500
@@ -198,6 +198,8 @@ read_etc_passwd ()
              && (searchentry = !internal_getpwsid (tu)))
            default_uid = DEFAULT_UID_NT;
        }
+      else if (myself->uid == ILLEGAL_UID)
+       searchentry = !search_for (DEFAULT_UID, NULL);
       if (searchentry &&
          (!(pw = search_for (0, cygheap->user.name ())) ||
           (myself->uid != ILLEGAL_UID &&
--- uinfo.cc.orig       2002-11-24 09:31:20.000000000 -0500
+++ uinfo.cc    2002-11-24 16:08:04.000000000 -0500
@@ -61,20 +61,21 @@ internal_getlogin (cygheap_user &user)
         from the Windows user name */
       if (ret)
        {
-         if ((pw = internal_getpwsid (tu)))
-           user.set_name (pw->pw_name);
+         pw = internal_getpwsid (tu);
          /* Set token owner to the same value as token user */
          if (!SetTokenInformation (ptok, TokenOwner, &tu, sizeof tu))
            debug_printf ("SetTokenInformation(TokenOwner): %E");
         }
     }
 
-  if (!pw && !(pw = getpwnam (user.name ())))
-    debug_printf("user name not found in augmented /etc/passwd");
+  if (!pw && !(pw = getpwnam (user.name ())) 
+      && !(pw = getpwuid32 (DEFAULT_UID)))
+    debug_printf("user not found in augmented /etc/passwd");
   else
     {
       myself->uid = pw->pw_uid;
       myself->gid = pw->pw_gid;
+      user.set_name (pw->pw_name);
       if (wincap.has_security ())
         {
          cygsid gsid;
