Return-Path: <cygwin-patches-return-2459-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 15036 invoked by alias); 18 Jun 2002 22:04:28 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 14880 invoked from network); 18 Jun 2002 22:04:18 -0000
Message-ID: <009101c21714$5615f6e0$6132bc3e@BABEL>
From: "Conrad Scott" <Conrad.Scott@dsl.pipex.com>
To: <cygwin-patches@cygwin.com>
Subject: Error output from maint scripts
Date: Tue, 18 Jun 2002 15:04:00 -0000
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_008E_01C2171C.B78ADF50"
X-Priority: 3
X-MSMail-Priority: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-SW-Source: 2002-q2/txt/msg00442.txt.bz2

This is a multi-part message in MIME format.

------=_NextPart_000_008E_01C2171C.B78ADF50
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-length: 692

I've been using Robert's maint scripts now that I've been committing
stuff into cvs and they work really well (except when I get something
wrong: no disasters yet tho'). One minor issue is that some of the
error messages go to stdout, which isn't too useful when some of the
scripts are intended to be run with their output re-directed to a file
(particular for those of us who can't ever type a command right first
time).

So, a little patch to put all the error messages on stderr.

// Conrad

2002-06-18  Conrad Scott  <conrad.scott@dsl.pipex.com>

 * cvsclosebranch: Send error messages to stderr.
 * cvsmerge: Ditto.
 * cvsmergeinit: Ditto.
 * cvsmkbranch: Ditto.
 * cvsmkpatch: Ditto.


------=_NextPart_000_008E_01C2171C.B78ADF50
Content-Type: application/octet-stream;
	name="maint.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="maint.patch"
Content-length: 4572

Index: cvsclosebranch=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/maint/cvsclosebranch,v=0A=
retrieving revision 1.1=0A=
diff -u -r1.1 cvsclosebranch=0A=
--- cvsclosebranch	24 Sep 2001 23:15:50 -0000	1.1=0A=
+++ cvsclosebranch	18 Jun 2002 21:51:14 -0000=0A=
@@ -50,6 +50,7 @@=0A=
 	ecvs -q rtag -r "$localtag" $tag $module || true=0A=
 	mergetag=3D"$mergetag2"=0A=
     else=0A=
+	exec >&2=0A=
 	echo "ERROR: There are remains in the branch. Cannot close without"=0A=
 	echo "       a tag name for the remains"=0A=
 	exit 1=0A=
Index: cvsmerge=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/maint/cvsmerge,v=0A=
retrieving revision 1.1=0A=
diff -u -r1.1 cvsmerge=0A=
--- cvsmerge	24 Sep 2001 23:15:50 -0000	1.1=0A=
+++ cvsmerge	18 Jun 2002 21:51:14 -0000=0A=
@@ -1,10 +1,12 @@=0A=
 #!/bin/sh -e=0A=
 if [ $# -ne 1 ]; then=0A=
+   exec >&2=0A=
    echo "Usage: $0 merge-from"=0A=
    echo "    where merge-from is the branch you want to merge changes from=
"=0A=
    exit 1=0A=
 fi=0A=
 if [ ! -f CVS/Root ] || [ ! -f CVS/Repository ]; then=0A=
+    exec >&2=0A=
     echo "ERROR: The script must be run from a CVS working directory"=0A=
     exit 1=0A=
 fi=0A=
@@ -39,6 +41,7 @@=0A=
 o Make sure there is no pending changes in the working directory=0A=
 diffl=3D`ecvs -z9 -q diff -kk | grep -v '^\?' | wc -l`=0A=
 if [ $diffl -ne 0 ]; then=0A=
+    exec >&2=0A=
     echo "ERROR: You must first commit any pending changes"=0A=
     exit 1=0A=
 fi=0A=
Index: cvsmergeinit=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/maint/cvsmergeinit,v=0A=
retrieving revision 1.1=0A=
diff -u -r1.1 cvsmergeinit=0A=
--- cvsmergeinit	24 Sep 2001 23:15:50 -0000	1.1=0A=
+++ cvsmergeinit	18 Jun 2002 21:51:14 -0000=0A=
@@ -1,5 +1,6 @@=0A=
 #!/bin/sh -e=0A=
 if [ $# -ne 2 -a $# -ne 1 ]; then=0A=
+   exec >&2=0A=
    cat <<- EOF=0A=
 	usage: $0 merge_from_tag [based_on_tag]=0A=
 	merge_from_tag is the tag to track in this tree=0A=
Index: cvsmkbranch=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/maint/cvsmkbranch,v=0A=
retrieving revision 1.1=0A=
diff -u -r1.1 cvsmkbranch=0A=
--- cvsmkbranch	24 Sep 2001 23:15:50 -0000	1.1=0A=
+++ cvsmkbranch	18 Jun 2002 21:51:14 -0000=0A=
@@ -1,5 +1,6 @@=0A=
 #!/bin/sh -e=0A=
 if [ $# -ne 1 ] || [ ! -f CVS/Repository ]; then=0A=
+    exec >&2=0A=
     echo "Usage: $0 branchname"=0A=
     echo ""=0A=
     echo "Creates a new branch from the current working directory"=0A=
@@ -16,6 +17,7 @@=0A=
 branch=3D`echo $1|sed -e 's/\./_/g'`=0A=
 workdir=3D../`echo $branch|sed -e's/_/./g'`=0A=
 if [ -d ../$workdir ]; then=0A=
+   exec >&2=0A=
    echo "Error! ../$workdir already exists"=0A=
    exit 1=0A=
 fi=0A=
Index: cvsmkpatch=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/maint/cvsmkpatch,v=0A=
retrieving revision 1.1=0A=
diff -u -r1.1 cvsmkpatch=0A=
--- cvsmkpatch	24 Sep 2001 23:15:50 -0000	1.1=0A=
+++ cvsmkpatch	18 Jun 2002 21:51:14 -0000=0A=
@@ -1,17 +1,20 @@=0A=
 #!/bin/bash -e=0A=
 if [ $# -ne 1 ]; then=0A=
+   exec >&2=0A=
    echo "Usage: $0 base-tag"=0A=
    echo "    where base-tag is the base branch the diff should start from"=
=0A=
    echo "    (usually HEAD, but you should know...)"=0A=
    exit 1=0A=
 fi=0A=
 if [ ! -f CVS/Root ] || [ ! -f CVS/Repository ]; then=0A=
+    exec >&2=0A=
     echo "ERROR: The script must be run from a CVS working directory"=0A=
     exit 1=0A=
 fi=0A=
 if [ -f CVS/Tag ]; then=0A=
     localtag=3D`cat CVS/Tag|cut -c2-`=0A=
 else=0A=
+    exec >&2=0A=
     echo "ERROR: The script can only be run from branches. Running"=0A=
     echo "it from the HEAD version does not make sense."=0A=
     exit 1=0A=

------=_NextPart_000_008E_01C2171C.B78ADF50
Content-Type: text/plain;
	name="maint.ChangeLog.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="maint.ChangeLog.txt"
Content-length: 196

2002-06-18  Conrad Scott  <conrad.scott@dsl.pipex.com>

	* cvsclosebranch: Send error messages to stderr.
	* cvsmerge: Ditto.
	* cvsmergeinit: Ditto.
	* cvsmkbranch: Ditto.
	* cvsmkpatch: Ditto.


------=_NextPart_000_008E_01C2171C.B78ADF50--

