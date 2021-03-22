Return-Path: <johannes.schindelin@gmx.de>
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 by sourceware.org (Postfix) with ESMTPS id 13A4D3858004
 for <cygwin-patches@cygwin.com>; Mon, 22 Mar 2021 15:51:40 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 13A4D3858004
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.27.144.62] ([213.196.212.127]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mg6Zw-1lsS053Ncc-00haud for
 <cygwin-patches@cygwin.com>; Mon, 22 Mar 2021 16:51:39 +0100
Date: Mon, 22 Mar 2021 16:51:41 +0100 (CET)
From: Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To: cygwin-patches@cygwin.com
Subject: [PATCH v2 1/2] Treat Windows Store's "app execution aliases" as
 symbolic links
In-Reply-To: <cover.1616428114.git.johannes.schindelin@gmx.de>
Message-ID: <529cb4ad541c5d0414569dc23f44097b0557a03d.1616428115.git.johannes.schindelin@gmx.de>
References: <nycvar.QRO.7.76.6.2103121606540.50@tvgsbejvaqbjf.bet>
 <cover.1616428114.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:b1qP/1gq+UMwCjxO6U+GURpCTkeuXfPO2bACO+ur9Rg1+peKeB9
 6bHfZdJRABevvvMLKUaEvSE69AASkMZiQ9SE3gm8XDMnCtdfyzSIkghUPNod5yd+iGMAa4M
 anf+xqgicrGYTQeTLkc+Hy1YYlLTTCwZ25PzhFhQcv+Iymglhb/L855XAKPdOtx4hGiIUkL
 V0Y0VHSYioxhW2pieVBEA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:MHFpqe5Ci3k=:I8xm+gnAroz2OwVOb6W7Oy
 X/0eHPn5cgHaxCVPyBCyS0IMdiyQgFzXawe8XbcA2Mulgw8taTE0AqWTQm54szKpzbWFwIvC/
 fw7jgnId9hd6rhrgPxWblN9rkYaBZSlMjbW4yMYs/BFkjIKXFLsJGqZJXxSOx1voR3kVfiCZF
 82midvdU4JLY+AxBORStDwMleCd2G/UAnCN5r/s/TlOguXkDa2yixsYn1wIuPYqvLUinLbGw6
 JkO+DLXXMEJBkojBRQamd+PxKw78rUAa/XcgRR2eZ5THXkZdxvSX40kJhON7OILsuSODu6k2a
 PGekP4htHGKqVJnb82wlDzHHFGLbvEdyZa93hFOk1YiQAGnaSuNGllwC1ktLSHOJH1yN53tV+
 ZCHrR61tSbs3jF/NzUT2TU6396GvPv1ipDs1jpUJ6HSa7Z4qOtc6IziKGoL9hQQowhLftNp7N
 heoZz0fGWmao0kyIHID1l+RdUWSMxbB4sFedsyVNx6AI7vr0sLmnDKml8beKhCepbWFyQYlP4
 +akWUAg46HcP1Rldilzlr20h9TzcZQiztPCvU8vTPktoWz7RGm6XbR9LxQ0iLhgoMhjp7w9Qw
 2FPoP5hkVqIJzaA8473B5UoWNzKZ9oDw0h/4++F2JWUxdCSHl8tilBBBn4GFc/9lzFc3PIkJE
 NI+YTafUKsoRNOugxiQwFPJSLWKM2mmTrdGD7vgEk8xB/NvA4WtqoFGFvAqLRQMfnKOvhgnzf
 S7sXnZwo/6ZDkls1vRWUexIgbJgxa4NXtFNLkIBTep7+6QpLM+fG+AvXY6l8Yzjgh/UCnin8X
 +ZJSTc4x0jA/o1YQMRS/uXlIcWX2L1E97MayG+tD7TJZpPYEd/uK8FIUqiPa3jYSxSgKdvrtc
 89Z7zjC4jVUvFnTpzE/tH1/+C9i19xtxq5Dppkx8A=
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.3 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, FREEMAIL_FROM, GIT_PATCH_0, RCVD_IN_BARRACUDACENTRAL,
 RCVD_IN_DNSWL_LOW, SPF_HELO_NONE, SPF_PASS,
 TXREP autolearn=ham autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
 server2.sourceware.org
X-BeenThere: cygwin-patches@cygwin.com
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Cygwin core component patch submission and discussion
 <cygwin-patches.cygwin.com>
List-Unsubscribe: <https://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <https://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Mon, 22 Mar 2021 15:51:42 -0000

When the Windows Store version of Python is installed, so-called "app
execution aliases" are put into the `PATH`. These are reparse points
under the hood, with an undocumented format.

We do know a bit about this format, though, as per the excellent analysis:
https://www.tiraniddo.dev/2019/09/overview-of-windows-execution-aliases.ht=
ml

	The first 4 bytes is the reparse tag, in this case it's
	0x8000001B which is documented in the Windows SDK as
	IO_REPARSE_TAG_APPEXECLINK. Unfortunately there doesn't seem to
	be a corresponding structure, but with a bit of reverse
	engineering we can work out the format is as follows:

	Version: <4 byte integer>
	Package ID: <NUL Terminated Unicode String>
	Entry Point: <NUL Terminated Unicode String>
	Executable: <NUL Terminated Unicode String>
	Application Type: <NUL Terminated Unicode String>

Let's treat them as symbolic links. For example, in this developer's
setup, this will result in the following nice output:

	$ cd $LOCALAPPDATA/Microsoft/WindowsApps/

	$ ls -l python3.exe
	lrwxrwxrwx 1 me 4096 105 Aug 23  2020 python3.exe -> '/c/Program Files/Wi=
ndowsApps/PythonSoftwareFoundation.Python.3.7_3.7.2544.0_x64__qbz5n2kfra8p=
0/python.exe'

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
=2D--
 winsup/cygwin/path.cc | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/winsup/cygwin/path.cc b/winsup/cygwin/path.cc
index f3b9913bd0..56834963a2 100644
=2D-- a/winsup/cygwin/path.cc
+++ b/winsup/cygwin/path.cc
@@ -2439,6 +2439,22 @@ symlink_info::check_sysfile (HANDLE h)
   return res;
 }

+typedef struct _REPARSE_APPEXECLINK_BUFFER
+{
+  DWORD ReparseTag;
+  WORD  ReparseDataLength;
+  WORD  Reserved;
+  struct {
+    DWORD Version;       /* Take member name with a grain of salt. */
+    WCHAR Strings[1];    /* Four serialized, NUL-terminated WCHAR strings=
:
+			   - Package ID
+			   - Entry Point
+			   - Executable Path
+			   - Application Type
+			   We're only interested in the Executable Path */
+  } AppExecLinkReparseBuffer;
+} REPARSE_APPEXECLINK_BUFFER,*PREPARSE_APPEXECLINK_BUFFER;
+
 static bool
 check_reparse_point_string (PUNICODE_STRING subst)
 {
@@ -2538,6 +2554,30 @@ check_reparse_point_target (HANDLE h, bool remote, =
PREPARSE_DATA_BUFFER rp,
       if (check_reparse_point_string (psymbuf))
 	return PATH_SYMLINK | PATH_REP;
     }
+  else if (!remote && rp->ReparseTag =3D=3D IO_REPARSE_TAG_APPEXECLINK)
+    {
+      /* App execution aliases are commonly used by Windows Store apps. *=
/
+      PREPARSE_APPEXECLINK_BUFFER rpl =3D (PREPARSE_APPEXECLINK_BUFFER) r=
p;
+      WCHAR *buf =3D rpl->Strings;
+      DWORD size =3D rp->ReparseDataLength / sizeof (WCHAR), n;
+
+      /* It seems that app execution aliases have a payload of four
+	 NUL-separated wide string: package id, entry point, executable
+	 and application type. We're interested in the executable. */
+      for (int i =3D 0; i < 3 && size > 0; i++)
+	{
+	  n =3D wcsnlen (buf, size - 1);
+	  if (i =3D=3D 2 && n > 0 && n < size)
+	    {
+	      RtlInitCountedUnicodeString (psymbuf, buf, n * sizeof (WCHAR));
+	      return PATH_SYMLINK | PATH_REP;
+	    }
+	  if (i =3D=3D 2)
+	    break;
+	  buf +=3D n + 1;
+	  size -=3D n + 1;
+	}
+    }
   else if (rp->ReparseTag =3D=3D IO_REPARSE_TAG_LX_SYMLINK)
     {
       /* WSL symlink.  Problem: We have to convert the path to UTF-16 for
=2D-
2.31.0

