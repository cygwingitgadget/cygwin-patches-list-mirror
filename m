Return-Path: <cygwin-patches-return-3800-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 30312 invoked by alias); 10 Apr 2003 01:43:23 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 30303 invoked from network); 10 Apr 2003 01:43:23 -0000
Message-Id: <3.0.5.32.20030409213911.007f6920@mail.attbi.com>
X-Sender: phumblet@mail.attbi.com (Unverified)
Date: Thu, 10 Apr 2003 01:43:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
Subject: utils.sgml
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=====================_1049953151==_"
X-SW-Source: 2003-q2/txt/msg00027.txt.bz2

--=====================_1049953151==_
Content-Type: text/plain; charset="us-ascii"
Content-length: 30

Joshua:

as promised,

Pierre

--=====================_1049953151==_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="utils.diff"
Content-length: 3360

Index: utils.sgml
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/utils/utils.sgml,v
retrieving revision 1.38
diff -u -p -r1.38 utils.sgml
--- utils.sgml	27 Mar 2003 18:46:16 -0000	1.38
+++ utils.sgml	10 Apr 2003 01:39:59 -0000
@@ -366,17 +366,16 @@ SIGUSR2     31    user defined signal 2
 <sect2 id=3D"mkgroup"><title>mkgroup</title>

 <screen>
-Usage: mkgroup [OPTION]... [domain]
+Usage: mkgroup [OPTION]... [domain]...

 This program prints a /etc/group file to stdout

 Options:
    -l,--local             print local group information
    -c,--current           print current group, if a domain account
-   -d,--domain            print global group information from the domain
-                          specified (or from the current domain if there is
-                          no domain specified)
-   -o,--id-offset offset  change the default offset (10000) added to uids
+   -d,--domain            print global group information (from current
+                          domain if no domains specified).
+   -o,--id-offset offset  change the default offset (10000) added to gids
                           in domain accounts.
    -s,--no-sids           don't print SIDs in pwd field
                           (this affects ntsec)
@@ -435,7 +434,7 @@ while the local machine is disconnected
 <sect2 id=3D"mkpasswd"><title>mkpasswd</title>

 <screen>
-Usage: mkpasswd [OPTION]... [domain]
+Usage: mkpasswd [OPTION]... [domain]...

 This program prints a /etc/passwd file to stdout

@@ -443,15 +442,15 @@ Options:
    -l,--local              print local user accounts
    -c,--current            print current account, if a domain account
    -d,--domain             print domain accounts (from current domain
-                           if no domain specified)
+                           if no domains specified)
    -o,--id-offset offset   change the default offset (10000) added to uids
                            in domain accounts.
    -g,--local-groups       print local group information too
-                           if no domain specified
+                           if no domains specified
    -m,--no-mount           don't use mount points for home dir
    -s,--no-sids            don't print SIDs in GCOS field
                            (this affects ntsec)
-   -p,--path-to-home path  use specified path instead of user account home=
 dir
+   -p,--path-to-home path  use specified path and not user account home di=
r or /home
    -u,--username username  only return information for the specified user
    -h,--help               displays this message
    -v,--version            version information and exit
@@ -500,7 +499,8 @@ directory of H: could mount them differe
 option omits the NT Security Identifier (SID).  For more information on
 SIDs, see <Xref Linkend=3D"ntsec"> in the Cygwin User's Guide.  The
 <literal>-p</literal> option causes <command>mkpasswd</command> to
-use a prefix other than <literal>/home/</literal>. For example, this comma=
nd:
+use the specified prefix instead of the account home dir or <literal>/home/
+</literal>. For example, this command:

 <example><title>Using an alternate home root</title>
 <screen>

--=====================_1049953151==_--
