Return-Path: <cygwin-patches-return-5288-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 17118 invoked by alias); 24 Dec 2004 09:26:58 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 16913 invoked from network); 24 Dec 2004 09:26:39 -0000
Received: from unknown (HELO dessent.net) (66.17.244.20)
  by sourceware.org with SMTP; 24 Dec 2004 09:26:39 -0000
Received: from localhost ([127.0.0.1] helo=dessent.net)
	by dessent.net with esmtp (Exim 4.34)
	id 1ChlkT-0002e1-IH; Fri, 24 Dec 2004 09:28:37 +0000
Message-ID: <41CBE1E1.51CB9AE6@dessent.net>
Date: Fri, 24 Dec 2004 09:26:00 -0000
From: Brian Dessent <brian@dessent.net>
Organization: My own little world...
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
CC: ptsekov@gmx.net
Subject: stopping floppy seeks (Was: available for test: findutils-20041219-1)
References: <20041219203809.GA32005@trixie.casa.cgf.cx> <41CB9C86.DF363492@dessent.net> <20041224043943.GB22309@trixie.casa.cgf.cx> <41CBA34D.13D639A5@dessent.net> <20041224050451.GA22543@trixie.casa.cgf.cx> <41CBACDA.59ABD12C@dessent.net>
Content-Type: multipart/mixed;
 boundary="------------DF72E8FB2BDC27CEF1026522"
X-SW-Source: 2004-q4/txt/msg00289.txt.bz2

This is a multi-part message in MIME format.
--------------DF72E8FB2BDC27CEF1026522
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-length: 1912

Brian Dessent wrote:

> > Let me say it again.  This is not new behavior:
> >
> > 2003-08-05  Pavel Tsekov  <ptsekov AT gmx.net>
> >
> >         * path.cc (cygdrive_getmntent): Do not skip over drives of type
> >         DRIVE_REMOVABLE.
> >
> > Perhaps you should be discussing this with Pavel.
> 
> Okay, I misunderstood.  I thought that you were saying someone had
> posted a patch that would prevent checking floppy drives in that section
> of the code.  I now see that it used to be the case that this was done,
> and the above patch removed that functionality.
> 
> I have no idea what Pavel's intentions were with his change.  I can only
> guess it was to support /cygdrive use with some form of removable media,
> perhaps floppy, perhaps otherwise.  However at the time it was
> committed, there was no mount checking code in find, and so there were
> no spurious floppy seeks for opening a login shell and many other
> activities.  I will CC him on this email to see if he wants to clarify.
> It seems to me that making this behavior settable through a CYGWIN env
> option would satisy everyone, but I'm also quite sure that no patch I
> submit to implement this would be accepted, mainly due to not having a
> copyright assignment on file.

Here is a patch.  If $CYGWIN does not contain "removable" (or contains
"noremovable") then /cygdrive's where GetDriveType() returns
DRIVE_REMOVABLE are skipped, avoiding the annoying floppy seeks. 
CYGWIN=removable works the same as current code.

Note: I don't know if this would be considered trivial or not.  Nor do I
know if it satisfies Pavel's needs.  Just thought I'd post it anyway.

2004-12-24  Brian Dessent  <brian@dessent.net>

	* environ.cc: Add extern decl for `cygdrive_removable'.
	(struct parse_thing): Add entry for `[no]removable'. 
	* path.cc (cygdrive_getmntent): Ignore drive letters of 
	removable drives, unless `cygdrive_removable' set.
--------------DF72E8FB2BDC27CEF1026522
Content-Type: text/plain; charset=us-ascii;
 name="removable.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="removable.diff"
Content-length: 2100

Index: src/winsup/cygwin/environ.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/environ.cc,v
retrieving revision 1.105
diff -u -p -r1.105 environ.cc
--- src/winsup/cygwin/environ.cc	3 Dec 2004 23:49:06 -0000	1.105
+++ src/winsup/cygwin/environ.cc	24 Dec 2004 09:12:45 -0000
@@ -31,6 +31,7 @@ extern bool ignore_case_with_glob;
 extern bool allow_ntea;
 extern bool allow_smbntsec;
 extern bool allow_winsymlinks;
+extern bool cygdrive_removable;
 extern bool strip_title_path;
 extern int pcheck_case;
 extern int subauth_id;
@@ -537,6 +538,7 @@ static struct parse_thing
   {"ntea", {func: set_ntea}, isfunc, NULL, {{0}, {s: "yes"}}},
   {"ntsec", {func: set_ntsec}, isfunc, NULL, {{0}, {s: "yes"}}},
   {"smbntsec", {func: set_smbntsec}, isfunc, NULL, {{0}, {s: "yes"}}},
+  {"removable", {&cygdrive_removable}, justset, NULL, {{false}, {true}}},
   {"reset_com", {&reset_com}, justset, NULL, {{false}, {true}}},
   {"strip_title", {&strip_title_path}, justset, NULL, {{false}, {true}}},
   {"subauth_id", {func: &subauth_id_init}, isfunc, NULL, {{0}, {0}}},
Index: src/winsup/cygwin/path.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/path.cc,v
retrieving revision 1.335
diff -u -p -r1.335 path.cc
--- src/winsup/cygwin/path.cc	23 Dec 2004 21:37:43 -0000	1.335
+++ src/winsup/cygwin/path.cc	24 Dec 2004 09:12:57 -0000
@@ -2301,6 +2301,9 @@ mount_item::getmntent ()
   return fillout_mntent (native_path, posix_path, flags);
 }
 
+/* If true, removable /cygdrive's should be returned by getmntent() */
+bool cygdrive_removable;
+
 static struct mntent *
 cygdrive_getmntent ()
 {
@@ -2316,7 +2319,8 @@ cygdrive_getmntent ()
 	  break;
 
       __small_sprintf (native_path, "%c:\\", drive);
-      if (GetFileAttributes (native_path) == INVALID_FILE_ATTRIBUTES)
+      if ((!cygdrive_removable && GetDriveType (native_path) == DRIVE_REMOVABLE) ||
+	  GetFileAttributes (native_path) == INVALID_FILE_ATTRIBUTES)
 	{
 	  _my_tls.locals.available_drives &= ~mask;
 	  continue;


--------------DF72E8FB2BDC27CEF1026522--
