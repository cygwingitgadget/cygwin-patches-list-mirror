Return-Path: <cygwin-patches-return-4421-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 511 invoked by alias); 18 Nov 2003 03:42:13 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 502 invoked from network); 18 Nov 2003 03:42:12 -0000
Message-Id: <3.0.5.32.20031117224143.00828850@incoming.verizon.net>
X-Sender: vze1u1tg@incoming.verizon.net (Unverified)
Date: Tue, 18 Nov 2003 03:42:00 -0000
To: David Starks-Browning <david@starks-browning.com>,
 cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Subject: Re: Small patch for the FAQ
In-Reply-To: <8135-Thu13Nov2003223751+0000-david@starks-browning.com>
References: <20030829121814.GR614@emcb.co.uk>
 <20030829121814.GR614@emcb.co.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=====================_1069144903==_"
X-SW-Source: 2003-q4/txt/msg00140.txt.bz2

--=====================_1069144903==_
Content-Type: text/plain; charset="us-ascii"
Content-length: 559

At 10:37 PM 11/13/2003 +0000, David Starks-Browning wrote:
>
>It will be *quite* some time before I am able to wade through the
main
>cygwin list and discover things for the FAQ on my own.  But I
should
>be able to apply patches on a fairly regular and timely basis,
at
>least for a while.
>

Thanks David.

I attach a patch to install.texinfo that covers 
http://www.cygwin.com/ml/cygwin/2003-03/msg00447.html and
http://cygwin.com/ml/cygwin-patches/2003-q1/msg00315.html

but not (among others)
http://www.cygwin.com/ml/cygwin/2003-04/msg01416.html

Pierre

--=====================_1069144903==_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="install.texinfo.diff"
Content-length: 4063

Index: install.texinfo
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/doc/install.texinfo,v
retrieving revision 1.45
diff -u -p -r1.45 install.texinfo
--- install.texinfo	10 Apr 2003 20:09:35 -0000	1.45
+++ install.texinfo	18 Nov 2003 03:35:33 -0000
@@ -40,6 +40,31 @@ from the rest of your Windows system dis
 (In the past, there had been genuine bugs that would cause problems
 for people who installed in C:\, but we believe those are gone now.)

+@subsection How are file permissions determined
+
+The directories and files created by setup inherit the default ACL of their
+parent directory. Thus in a fresh installation all permissions are initial=
ly
+determined by the ACL of the top directory  (e.g. @samp{C:\} for an
+installation in @samp{C:\cygwin}).
+
+After running setup it is a good idea to verify the permissions with the
+Windows program ``cacls'', which shows the true ACL,
+or with ``ls -l /bin'', which shows the mapping of the ACL to Posix permis=
sions.
+If you are not happy with what you see, set the permissions as you
+wish by using commands such as:
+@enumerate
+@item ``cd /''
+
+@item ``chmod -R a+r .''
+
+@item ``chmod -R a+x bin usr/sbin usr/local/bin lib/gcc-lib usr/X11R6/bin''
+@end enumerate
+You can also change the group and the owner with ``chgrp -R'' and/or ``cho=
wn -R''.
+
+Note that programs executed by services (such as inetd or cron) must be ex=
ecutable
+by SYSTEM, which is in the ``Administrators'' and ``Everyone'' groups but =
not
+e.g. in ``Users'' nor in ``Authenticated Users''.
+
 @subsection Can I use Cygwin Setup to update a B18, B19, B20, B20.1 or CD-=
ROM (1.0) installation of Cygwin?

 No, you must start from scratch with the new Cygwin Setup.  The
@@ -198,14 +223,49 @@ character as a word delimiter.  Under ce
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
+@item You can simply edit the /etc/passwd file and change the Cygwin user =
name
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


--=====================_1069144903==_--
