Return-Path: <cygwin-patches-return-3666-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 22394 invoked by alias); 4 Mar 2003 00:30:34 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 22335 invoked from network); 4 Mar 2003 00:30:33 -0000
Message-Id: <3.0.5.32.20030303192941.007f6890@mail.attbi.com>
X-Sender: phumblet@mail.attbi.com (Unverified)
Date: Tue, 04 Mar 2003 00:30:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
Subject: [PATCH] docs/install.texinfo
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-SW-Source: 2003-q1/txt/msg00315.txt.bz2

Joshua,

here is an upgrade to the FAQ.

Pierre


Index: install.texinfo
===================================================================
RCS file: /cvs/src/src/winsup/doc/install.texinfo,v
retrieving revision 1.44
diff -u -p -r1.44 install.texinfo
--- install.texinfo	21 Feb 2003 20:37:47 -0000	1.44
+++ install.texinfo	4 Mar 2003 00:25:03 -0000
@@ -194,14 +194,49 @@ character as a word delimiter.  Under ce
 possible to get around this with various shell quoting mechanisms, but
 you are much better off if you can avoid the problem entirely.
 
-In particular, the environment variables @samp{USER} and @samp{HOME} are
-set for you in /etc/profile.  By default these derive from your Windows
-logon name.  You may edit this file and set them explicitly to something
-without spaces.
-
-(If you use the @samp{login} package or anything else that reads
-/etc/passwd, you may need to make corresponding changes there.  See the
-README file for that package.)
+On Windows NT/2000/XP you have two choices:
+@enumerate
+
+@item You can rename the user in the Windows User Manager GUI and then
+run mkpasswd.
+
+@item You can simply edit the /etc/passwd file and change the Cygwin user name 
+(first field). It's also a good idea to avoid spaces in the home directory.
+
+@end enumerate
+
+On Windows 95/98/ME you can create a new user and run mkpasswd, 
+or you can delete the offending entry from /etc/passwd. 
+Cygwin will then use the name in the default entry with uid 500.
+
+@subsection My @samp{HOME} environment variable is not what I want.
+
+When starting Cygwin from Windows, @samp{HOME} is determined as follows
+in order of decreasing priority:
+
+@enumerate
+
+@item @samp{HOME} from the Windows environment, translated to POSIX form.
+
+@item The entry in /etc/passwd
+
+@item @samp{HOMEDRIVE} and @samp{HOMEPATH} from the Windows environment
+
+@item /
+
+@end enumerate
+
+When using Cygwin from the network (telnet, ssh,...), @samp{HOME} is set 
+from /etc/passwd.
+
+If your @samp{HOME} is set to a value such as /cygdrive/c, it is likely 
+that it was set in Windows. Start a DOS Command Window and type 
+"set HOME" to verify if this is the case.
+
+Access to shared drives is often restricted when starting from the network,
+thus Domain users may wish to have a different @samp{HOME} in the 
+Windows environment (on shared drive) than in /etc/passwd (on local drive).
+Note that ssh only considers /etc/passwd, disregarding @samp{HOME}. 
 
 @subsection How do I uninstall individual packages?
 


