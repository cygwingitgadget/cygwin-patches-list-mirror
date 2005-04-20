Return-Path: <cygwin-patches-return-5414-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 31497 invoked by alias); 20 Apr 2005 11:33:06 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 31386 invoked from network); 20 Apr 2005 11:32:54 -0000
Received: from unknown (HELO dessent.net) (66.17.244.20)
  by sourceware.org with SMTP; 20 Apr 2005 11:32:54 -0000
Received: from localhost ([127.0.0.1] helo=dessent.net)
	by dessent.net with esmtp (Exim 4.44)
	id 1DODLh-0003Ds-6s
	for cygwin-patches@cygwin.com; Wed, 20 Apr 2005 11:26:29 +0000
Message-ID: <42663D0B.D913AC34@dessent.net>
Date: Wed, 20 Apr 2005 11:33:00 -0000
From: Brian Dessent <brian@dessent.net>
Organization: My own little world...
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: [patch] cygdrive and user/system documentation clarification
References: <BAY10-F31320CAABACB6330AD865EE9290@phx.gbl> <426449CF.CD24BEB8@dessent.net> <wkd5sq1tgn.fsf@mx0.connact.com> <20050419193940.GF26832@trixie.casa.cgf.cx> <wkmzruzcbv.fsf@mx0.connact.com> <4265F5D6.2458C631@dessent.net> <20050420104114.GX16098@cygbert.vinschen.de>
Content-Type: multipart/mixed;
 boundary="------------416B7ED695304DC88657E4B5"
X-SW-Source: 2005-q2/txt/msg00010.txt.bz2

This is a multi-part message in MIME format.
--------------416B7ED695304DC88657E4B5
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-length: 546

Corinna Vinschen wrote:

> Looks good to me.  However, please send patches to cygwin-patches and
> add a ChangeLog entry.

As requested.  I include two patches and two ChangeLog entries since the
two files are in different directories.  Is that the preferred way?

utils/
2005-04-20  Brian Dessent  <brian@dessent.net>

	* utils.sgml (mount): Clarify setting cygdrive prefix for user
	and system-wide.

doc/
2005-04-20  Brian Dessent  <brian@dessent.net>

	* pathnames.sgml (mount-table): Indicate that user-specific
	mounts override system-wide.
--------------416B7ED695304DC88657E4B5
Content-Type: text/plain; charset=us-ascii;
 name="mounts_docpatch1.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mounts_docpatch1.patch"
Content-length: 1153

Index: utils.sgml
===================================================================
RCS file: /cvs/src/src/winsup/utils/utils.sgml,v
retrieving revision 1.51
diff -u -r1.51 utils.sgml
--- utils.sgml	24 Feb 2005 04:32:45 -0000	1.51
+++ utils.sgml	20 Apr 2005 11:20:15 -0000
@@ -729,9 +729,11 @@
 </screen>
 </example>
 
-<para>Note that if you set a new prefix in this manner, you can
-specify the <literal>-s</literal> flag to make this the system-wide default 
-prefix.  By default, the cygdrive-prefix applies only to the system-wide setting.  
+<para>Note that the cygdrive prefix can be set both per-user and system-wide, 
+and that as with all mounts, a user-specific mount takes precedence over the 
+system-wide setting.  The <command>mount</command> utility creates system-wide 
+mounts by default if you do not specify a type.  Use the <literal>-s</literal> 
+or <literal>-u</literal> flag to indicate a system or user mount, respectively.
 You can always see the user and system cygdrive prefixes with the 
 <literal>-p</literal> option.  Using the <literal>-b</literal>
 flag with <literal>--change-cygdrive-prefix</literal> makes all new 

--------------416B7ED695304DC88657E4B5
Content-Type: text/plain; charset=us-ascii;
 name="mounts_docpatch2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mounts_docpatch2.patch"
Content-length: 873

Index: pathnames.sgml
===================================================================
RCS file: /cvs/src/src/winsup/doc/pathnames.sgml,v
retrieving revision 1.18
diff -u -r1.18 pathnames.sgml
--- pathnames.sgml	6 Mar 2005 02:46:54 -0000	1.18
+++ pathnames.sgml	20 Apr 2005 11:25:41 -0000
@@ -47,7 +47,9 @@
 where &lt;version&gt; is the latest registry version associated with
 the Cygwin library (this version is not the same as the release
 number).  The system-wide table is located under the same subkeys
-under HKEY_LOCAL_SYSTEM.</para>
+under HKEY_LOCAL_SYSTEM.  The user mount table takes precedence over 
+the system-wide table if a path is mounted in both.  This includes the
+setting of the cygdrive prefix.</para>
 
 <para>Since Windows uses drive letters instead of a single filesystem
 root, the POSIX root <filename>/</filename> must be set to a directory

--------------416B7ED695304DC88657E4B5--

