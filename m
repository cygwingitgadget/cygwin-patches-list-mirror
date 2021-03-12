Return-Path: <johannes.schindelin@gmx.de>
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 by sourceware.org (Postfix) with ESMTPS id 09A6E3854835
 for <cygwin-patches@cygwin.com>; Fri, 12 Mar 2021 15:11:49 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 09A6E3854835
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.30.201.226] ([89.1.215.248]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MatRZ-1lqmLv21ZT-00cPMP for
 <cygwin-patches@cygwin.com>; Fri, 12 Mar 2021 16:11:48 +0100
Date: Fri, 12 Mar 2021 16:11:47 +0100 (CET)
From: Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To: cygwin-patches@cygwin.com
Subject: [PATCH 1/2] Treat Windows Store's "app execution aliases" as symbolic
 links
Message-ID: <nycvar.QRO.7.76.6.2103121611440.50@tvgsbejvaqbjf.bet>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:WKAU5MuBehPR5evrmTqilE5ApR5CXHNhMqbXGeRroS3K7ImAlTd
 DI0gyJ4QyY2W9CdgAw1yCIuQB7+xYS4O56zh0A1xXRHblqYQMZ9zrucBnKF2tVbTN7R9t3I
 UF1N7m2iEqEZ+XX02qPCrkiGeElwyqntte9C/+e8knIyoas9Yjg8Aonwj48tmIS47/NX56G
 1t/edtSZv4Fet54FDG/eQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:7cmdCEgzxM0=:5Lx7/phlVpiBJFe9B6XeMR
 BPacDMYBbwJMktvqlnEDIdgfKEpyrKnfsi4Pg0O11nyLo1iSzqKG5FhnDV7S4pskUiS6qU9WK
 iO0XHuVHoDtdsWaH9tjnxV4OrrQGWbpAPRmXdmF9g4iCzeLuqnWaSOLUbj0jbtIH8RGgCpLHa
 ekDlg84CFMh2UG5lJLHcH+PDHWSLyaJ/wrMXIA354zY9sxwNsy/aMsj3OOuQWKO9FMzuTEAsb
 XnIW6jzOJjzJJWJWtMSLNWwCoIZ9HNLRbxxFkmKEWcxcQzFYTA6YaISgNRdmdes+eEhVPEt45
 trWknii7rN6dJyoaepNhHaJADIRJ0QslGcFqzMRbX4RtWqPBZbQoMlZBt004oo/Dfdcjkb94s
 FdOMgbGjQ42GD1rOjp6eD35aUe0k8VNq/ezzgVOQZ5/z2S9P7Pt19Ld1OMg+otacvNcqYqSJM
 OvZ3u8uRZtdsGja+U0xbRsp6u7DxQnf76eLzj+6UeoFXWgcMnBlyQR3DZzOGjs4DO8Y2/q0y3
 t+63efQBoYyiNs56rE8dyMfrl47XbL/7PeqVZcDRun/lKToRbl7GpiyOSmSMwqDn3ufgM7ukR
 zRQRM5fljsY6EPwmlpV/XHsxv5ScydxiltOuGqUWDRDd3w3KIcXK5GQFwChaAWLrwoufqtKcz
 yyV5VcNda4qRrGlHKHDkumkEnS0wbQyS1Ydz9G4FUd/bqCqLuwl5pmDelEFXhLVUZBBrWUu5I
 acomoodIRQPys6+RuEsIvhpLBItQaXEtkoTwO9+51xX4EDJz6ooGyqpv2gNG5XtDX2229F863
 /wnd4i5+wmsAFc/dKM1eKrYFVPsrMxb077Wmf+yRYzdIyJnEGX79ypoLiuC8USMlc0LOwIZwK
 vWDcJX9eTU4dngs6nBj7VNcI8i/wsL1Wh8hyPw8Y4=
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.4 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, FREEMAIL_FROM, GIT_PATCH_0, RCVD_IN_BARRACUDACENTRAL,
 RCVD_IN_DNSWL_LOW, RCVD_IN_MSPIKE_H2, SPF_HELO_NONE, SPF_PASS,
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
X-List-Received-Date: Fri, 12 Mar 2021 15:11:51 -0000

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
 winsup/cygwin/path.cc | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/winsup/cygwin/path.cc b/winsup/cygwin/path.cc
index f3b9913bd0..63f377efb1 100644
=2D-- a/winsup/cygwin/path.cc
+++ b/winsup/cygwin/path.cc
@@ -2538,6 +2538,30 @@ check_reparse_point_target (HANDLE h, bool remote, =
PREPARSE_DATA_BUFFER rp,
       if (check_reparse_point_string (psymbuf))
 	return PATH_SYMLINK | PATH_REP;
     }
+  else if (!remote && rp->ReparseTag =3D=3D IO_REPARSE_TAG_APPEXECLINK)
+    {
+      /* App execution aliases are commonly used by Windows Store apps. *=
/
+      WCHAR *buf =3D (WCHAR *)(rp->GenericReparseBuffer.DataBuffer + 4);
+      DWORD size =3D rp->ReparseDataLength / sizeof(WCHAR), n;
+
+      /*
+         It seems that app execution aliases have a payload of four
+	 NUL-separated wide string: package id, entry point, executable
+	 and application type. We're interested in the executable. */
+      for (int i =3D 0; i < 3 && size > 0; i++)
+        {
+	  n =3D wcsnlen (buf, size - 1);
+	  if (i =3D=3D 2 && n > 0 && n < size)
+	    {
+	      RtlInitCountedUnicodeString (psymbuf, buf, n * sizeof(WCHAR));
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
2.30.2

