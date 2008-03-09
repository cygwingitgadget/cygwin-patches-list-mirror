Return-Path: <cygwin-patches-return-6260-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 18595 invoked by alias); 9 Mar 2008 04:14:17 -0000
Received: (qmail 18585 invoked by uid 22791); 9 Mar 2008 04:14:16 -0000
X-Spam-Check-By: sourceware.org
Received: from dessent.net (HELO dessent.net) (69.60.119.225)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Sun, 09 Mar 2008 04:14:00 +0000
Received: from localhost ([127.0.0.1] helo=dessent.net) 	by dessent.net with esmtp (Exim 4.50) 	id 1JYCv8-0003Ln-8p 	for cygwin-patches@cygwin.com; Sun, 09 Mar 2008 04:13:58 +0000
Message-ID: <47D36406.F7D7AB61@dessent.net>
Date: Sun, 09 Mar 2008 04:14:00 -0000
From: Brian Dessent <brian@dessent.net>
X-Mailer: Mozilla 4.79 [en] (Windows NT 5.0; U)
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [patch] cygcheck.cc update for cygpath()
References: <47D2E28C.3FC392D3@dessent.net> <20080308212718.GB5863@ednor.casa.cgf.cx> <47D3550B.76D34355@dessent.net> <20080309032437.GB6777@ednor.casa.cgf.cx>
Content-Type: multipart/mixed;  boundary="------------8CB7ED44FB024791D17A1C8D"
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2008-q1/txt/msg00034.txt.bz2

This is a multi-part message in MIME format.
--------------8CB7ED44FB024791D17A1C8D
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-length: 1098

Christopher Faylor wrote:

> It looks like yo can still unindent this by  changing the == to !=, putting
> the temppath under that and keeping all of the if's at the same level:

Oh, I see now what you mean.

> If the if block is that small, then I think I'd prefer just one comment
> at the beginning which describes what it is doing.  Otherwise, I got
> lost in what was happening while trying to see where the comments line
> up.  I don't feel really strongly about that, though, so feel free to
> ignore me.  I would prefer not having the nested if's though.
> 
> Otherwise, this looks good.  If you make the above suggestions, feel
> free to check this in.

I chopped each comment down to a single line //-style which I think
helps the clutter, and removed the nesting.

Also, there are a few tweaks to cygcheck.cc necessary as a result, see
attached.  The main idea is that when normalizing a link's target in
find_app_on_path, we should temporarily set the CWD to the same dir as
the link, otherwise relative links will get normalized relative to
whatever dir cygcheck was run from.  

Brian
--------------8CB7ED44FB024791D17A1C8D
Content-Type: text/plain; charset=us-ascii;
 name="cygcheck_cygpath_update.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cygcheck_cygpath_update.patch"
Content-length: 2976

2008-03-08  Brian Dessent  <brian@dessent.net>

	* cygcheck.cc (save_cwd_helper): New helper function for saving
	the current directory.
	(find_app_on_path): Use sizeof instead of hardcoded array sizes
	throughout.  Change into the dir of the link when normalizing
	its target.  Don't worry about converting slashes as cygpath ()
	now handles that.

 cygcheck.cc |   45 ++++++++++++++++++++++++++++++++++++---------
 1 file changed, 36 insertions(+), 9 deletions(-)

Index: cygcheck.cc
===================================================================
RCS file: /cvs/src/src/winsup/utils/cygcheck.cc,v
retrieving revision 1.97
diff -u -p -r1.97 cygcheck.cc
--- cygcheck.cc	13 Jan 2008 13:41:45 -0000	1.97
+++ cygcheck.cc	9 Mar 2008 03:52:07 -0000
@@ -807,6 +807,31 @@ ls (char *f)
     display_error ("ls: CloseHandle()");
 }
 
+/* If s is non-NULL, save the CWD in a static buffer and set the CWD
+   to the dirname part of s.  If s is NULL, restore the CWD last
+   saved.  */
+static
+void save_cwd_helper (const char *s)
+{
+  static char cwdbuf[MAX_PATH + 1];
+  char dirnamebuf[MAX_PATH + 1];
+
+  if (s)
+    {
+      GetCurrentDirectory (sizeof (cwdbuf), cwdbuf);
+
+      /* Remove the filename part from s.  */
+      strncpy (dirnamebuf, s, MAX_PATH);
+      dirnamebuf[MAX_PATH] = '\0';   // just in case strlen(s) > MAX_PATH
+      char *lastsep = strrchr (dirnamebuf, '\\');
+      if (lastsep)
+        lastsep[1] = '\0';
+      SetCurrentDirectory (dirnamebuf);
+    }
+  else
+    SetCurrentDirectory (cwdbuf);
+}
+
 // Find a real application on the path (possibly following symlinks)
 static const char *
 find_app_on_path (const char *app, bool showall = false)
@@ -822,25 +847,27 @@ find_app_on_path (const char *app, bool 
   if (is_symlink (fh))
     {
       static char tmp[4000] = "";
-      char *ptr;
-      if (!readlink (fh, tmp, 3999))
+      if (!readlink (fh, tmp, sizeof (tmp)-1))
 	display_error("readlink failed");
-      ptr = cygpath (tmp, NULL);
-      for (char *p = ptr; (p = strchr (p, '/')); p++)
-	*p = '\\';
+      
+      /* When resolving the linkname, set the CWD to the context of
+         the link, so that relative links are correctly resolved.  */
+      save_cwd_helper (papp);
+      char *ptr = cygpath (tmp, NULL);
+      save_cwd_helper (NULL);
       printf (" -> %s\n", ptr);
       if (!strchr (ptr, '\\'))
 	{
 	  char *lastsep;
-	  strncpy (tmp, cygpath (papp, NULL), 3999);
-	  for (char *p = tmp; (p = strchr (p, '/')); p++)
-	    *p = '\\';
+	  strncpy (tmp, cygpath (papp, NULL), sizeof (tmp)-1);
 	  lastsep = strrchr (tmp, '\\');
-	  strncpy (lastsep+1, ptr, 3999-(lastsep-tmp));
+	  strncpy (lastsep+1, ptr, (sizeof (tmp)-1) - (lastsep-tmp));
 	  ptr = tmp;
 	}
       if (!CloseHandle (fh))
 	display_error ("find_app_on_path: CloseHandle()");
+      /* FIXME: We leak the ptr returned by cygpath() here which is a
+         malloc()d string.  */
       return find_app_on_path (ptr, showall);
     }
 

--------------8CB7ED44FB024791D17A1C8D--
