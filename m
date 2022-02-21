Return-Path: <johannes.schindelin@gmx.de>
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 by sourceware.org (Postfix) with ESMTPS id 988933858D37
 for <cygwin-patches@cygwin.com>; Mon, 21 Feb 2022 13:36:39 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 988933858D37
Authentication-Results: sourceware.org;
 dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1645450598;
 bh=v4j8uubP1Nl9AFAS4tjpTNgyuT7ojbVV/Dr0U+4+KH0=;
 h=X-UI-Sender-Class:Date:From:To:Subject:In-Reply-To:References;
 b=fmsNJ1zgA+DAgN5Hw7V6TGzeQiq82VFRKKjuxdueHvCJtZ5TvzhhXjwbijIMXWb8/
 vu3BqF7oNFVU+r4CYF+fRvhPTMmEcUJCv4iE9T5VIW3H6CqO2/d+YxeUt6PBpeHTpP
 ZYLeVSwUvP11eyxC46TztU5Ak+fHNSL+Px/AW1dw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.28.129.168] ([89.1.212.236]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MVeMA-1nnjrG17x6-00RZbm for
 <cygwin-patches@cygwin.com>; Mon, 21 Feb 2022 14:36:38 +0100
Date: Mon, 21 Feb 2022 14:36:37 +0100 (CET)
From: Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To: cygwin-patches@cygwin.com
Subject: [PATCH 1/2] Implicitly support the /dev/fd symlink and friends
In-Reply-To: <cover.1645450518.git.johannes.schindelin@gmx.de>
Message-ID: <3a2c29ef16c74f83237d5e55119e8b1e2f069f36.1645450518.git.johannes.schindelin@gmx.de>
References: <cover.1645450518.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:6WxUex6F2RhsdYaZa98c51tIDUGQl9PttL4iiz2rRy/vIq0Wa9w
 16r1Wweh/VcQ0W1PuXTS9JtRNKZV4j0xahYjZSSwjcGtm92zfimtCN32xFAEXmxNNTrfAsp
 cXENRZdrEJr4zwSaW1NrfMF1KkB3Vovy+a3dPymplQeAnvddG5pKJNsxAzAhsIF5otpHv3b
 sIfEqLHNf57BrJNdpbzFQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:vAMw5gRWsac=:flLq2/Udb2myASu/Yjmrx7
 WG5cMuG3+/uch6/GPeIVug5oNot7raCBFpa45QycRrMDwgzx8VYNKAwDCVqWqFf6d1NvsjGIA
 uV397z62mXvX2ZxWrkGfCNXoHf0Tj4dgzDLva4JkoEQv2o4ggQymHIxhX+s2daloyUGSdv6XN
 xGKhYHuISmIjBp2w/uvpbe47l+JYImMbtzyfTqMfJ/OBmwI95N+w5knBo3BaFdcrqsEV7Cm9Q
 s1etf5VYMCLRXSGHUoDOsKn2RzMv4NYAM9SwxdCKerHkV6q2+b/H3lYpTSNLiBS09E8GDl8T+
 gtydPhwMv3jnf3LUmCCC0xLJcg1Uz89D9WxaZ8moGSlb3VnQKoVqpnngjB9qEQXI1O2oGG5JV
 RHcQa1J6GJxzFmFAYkyp/mY/6+j/R2+W0qrTXXIrjpYZIf1O3PKFUuPwcTSuHCKDgQvVSBfQQ
 luniEgxbhIBWM+UJEzV0DIeyIcX4ZSr4QEUn4h+EYvTsT4r0pYHJFRtGE4OeOwrcjERlH4/tX
 VigmE1ML3NymiNZPYMNqqxq9gLEIfJ+7eVDkizKo/8DDQFpG+vtZOF5zfWLAelZV9bKl05ihC
 9+cv+SCrRV8dFmByJLNq5TLRj3YKZouCMuCdzh9LRPyVZ9+C7dO/OE0zdR+WF6R6I546ubkFL
 dxVy8EmQBZQv17alKoQ2Z5t/HVhRPI4d0JNh92WC9Yq4NovUS7alZjOk1S3zELeExjUlQFYwv
 FhoyBIPXKqZlDRCBmLGkeO6UgoSJY4M91RTcIORu5UodAUJjOFqdZgaSghcKuarGEh3B0aGfX
 w/S+iFmJCX+3x5rQUYEEO7dpUdQqB0yYvAO4raBQ9zE5c8BA6kHj7g0E+iKlJdHQpdYDEDBNu
 wbjFyUIufaqKL0hacK0dN/H83IA/X4vagCU4DRzgPI1UZltMvCB6Refmz3RzocORaeBXVEptJ
 oOCDcTF9VvvrSqw6g+67Nz14ryzujg2hPe6eFnKHEqdumaDbp+hiXYNxX6BQFiiq+Y7RGDxir
 a1TFXMNotVLFhE8gejs/yzxD1FboyLl61rteeKO4Ey0ivaDOZsEtgCUJFcAWBh1oenDhf0BXU
 a8YsMQV7067IMI=
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-10.8 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, FREEMAIL_FROM, GIT_PATCH_0, RCVD_IN_DNSWL_LOW, RCVD_IN_MSPIKE_H2,
 SPF_HELO_NONE, SPF_PASS, TXREP,
 T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
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
X-List-Received-Date: Mon, 21 Feb 2022 13:36:41 -0000

Bash has a very convenient feature that is called process substitution
(e.g. `diff -u <(seq 0 10) <(seq 1 11)`). To make this work, Bash
requires the `/dev/fd` symlink to exist, and Cygwin therefore creates
this symlink (together with the `stdin`, `stdout` and `stderr` ones)
upon start-up.

This strategy is incompatible with the idea of providing a subset of
Cygwin in a `.zip` file (because there is no standard way to represent
symlinks in `.zip` files, and besides, older Windows versions would
potentially lack support for them anyway).

That type of `.zip` file is what Git for Windows wants to use, though,
bundling a minimal subset for third-party applications in MinGit (see
https://github.com/git-for-windows/git/wiki/MinGit for details).

Let's side-step this problem completely by creating those symlinks
implicitly, similar to the way `/dev/` is populated with special
devices.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
=2D--
 winsup/cygwin/Makefile.am        |  1 +
 winsup/cygwin/devices.h          |  3 +-
 winsup/cygwin/devices.in         |  4 +++
 winsup/cygwin/dtable.cc          |  3 ++
 winsup/cygwin/fhandler.h         | 28 +++++++++++++++++
 winsup/cygwin/fhandler_dev_fd.cc | 53 ++++++++++++++++++++++++++++++++
 6 files changed, 91 insertions(+), 1 deletion(-)
 create mode 100644 winsup/cygwin/fhandler_dev_fd.cc

diff --git a/winsup/cygwin/Makefile.am b/winsup/cygwin/Makefile.am
index 2b8e87fcd0..c8936354b8 100644
=2D-- a/winsup/cygwin/Makefile.am
+++ b/winsup/cygwin/Makefile.am
@@ -230,6 +230,7 @@ DLL_FILES=3D \
 	fhandler_console.cc \
 	fhandler_cygdrive.cc \
 	fhandler_dev.cc \
+	fhandler_dev_fd.cc \
 	fhandler_disk_file.cc \
 	fhandler_dsp.cc \
 	fhandler_fifo.cc \
diff --git a/winsup/cygwin/devices.h b/winsup/cygwin/devices.h
index 4310f435fe..fbbde6ab9c 100644
=2D-- a/winsup/cygwin/devices.h
+++ b/winsup/cygwin/devices.h
@@ -70,6 +70,7 @@ enum fh_devices
   FH_NETDRIVE=3D FHDEV (DEV_VIRTFS_MAJOR, 194),
   FH_DEV     =3D FHDEV (DEV_VIRTFS_MAJOR, 193),
   FH_CYGDRIVE=3D FHDEV (DEV_VIRTFS_MAJOR, 192),
+  FH_DEV_FD  =3D FHDEV (DEV_VIRTFS_MAJOR, 191),

   FH_SIGNALFD=3D FHDEV (DEV_VIRTFS_MAJOR, 13),
   FH_TIMERFD =3D FHDEV (DEV_VIRTFS_MAJOR, 14),
@@ -436,7 +437,7 @@ extern const _device dev_fs_storage;
 #define isprocsys_dev(devn) (devn =3D=3D FH_PROCSYS)

 #define isvirtual_dev(devn) \
-  (isproc_dev (devn) || devn =3D=3D FH_CYGDRIVE || devn =3D=3D FH_NETDRIV=
E)
+  (isproc_dev (devn) || devn =3D=3D FH_CYGDRIVE || devn =3D=3D FH_NETDRIV=
E || devn =3D=3D FH_DEV_FD)

 #define iscons_dev(n) \
   ((device::major ((dev_t) (n)) =3D=3D DEV_CONS_MAJOR) \
diff --git a/winsup/cygwin/devices.in b/winsup/cygwin/devices.in
index f33510eb7e..7506dfe9cb 100644
=2D-- a/winsup/cygwin/devices.in
+++ b/winsup/cygwin/devices.in
@@ -175,6 +175,10 @@ const _device dev_error_storage =3D
 "/dev/fd%(0-15)d", BRACK(FHDEV(DEV_FLOPPY_MAJOR, {$1})), "\\Device\\Flopp=
y{$1}", exists_ntdev, S_IFBLK
 "/dev/scd%(0-15)d", BRACK(FHDEV(DEV_CDROM_MAJOR, {$1})), "\\Device\\CdRom=
{$1}", exists_ntdev, S_IFBLK
 "/dev/sr%(0-15)d", BRACK(FHDEV(DEV_CDROM_MAJOR, {$1})), "\\Device\\CdRom{=
$1}", exists_ntdev, S_IFBLK
+"/dev/fd", BRACK(FH_DEV_FD), "/proc/self/fd", exists, S_IFLNK
+"/dev/stdin", BRACK(FH_DEV_FD), "/proc/self/fd/0", exists, S_IFLNK
+"/dev/stdout", BRACK(FH_DEV_FD), "/proc/self/fd/1", exists, S_IFLNK
+"/dev/stderr", BRACK(FH_DEV_FD), "/proc/self/fd/2", exists, S_IFLNK
 %other	{return	NULL;}
 %%
 #undef BRACK
diff --git a/winsup/cygwin/dtable.cc b/winsup/cygwin/dtable.cc
index ce5f6411b3..28d7697259 100644
=2D-- a/winsup/cygwin/dtable.cc
+++ b/winsup/cygwin/dtable.cc
@@ -579,6 +579,9 @@ fh_alloc (path_conv& pc)
 	case FH_DEV:
 	  fh =3D cnew (fhandler_dev);
 	  break;
+	case FH_DEV_FD:
+	  fh =3D cnew (fhandler_dev_fd);
+	  break;
 	case FH_CYGDRIVE:
 	  fh =3D cnew (fhandler_cygdrive);
 	  break;
diff --git a/winsup/cygwin/fhandler.h b/winsup/cygwin/fhandler.h
index f764eccd33..6c1b2a8025 100644
=2D-- a/winsup/cygwin/fhandler.h
+++ b/winsup/cygwin/fhandler.h
@@ -3009,6 +3009,33 @@ class fhandler_procnet: public fhandler_proc
   }
 };

+class fhandler_dev_fd: public fhandler_virtual
+{
+ public:
+  fhandler_dev_fd ();
+  virtual_ftype_t exists();
+
+  int __reg2 fstat (struct stat *buf);
+  bool fill_filebuf ();
+
+  fhandler_dev_fd (void *) {}
+
+  virtual void copy_from (fhandler_base *x)
+  {
+    pc.free_strings ();
+    *this =3D *reinterpret_cast<fhandler_dev_fd *> (x);
+    _copy_from_reset_helper ();
+  }
+
+  virtual fhandler_dev_fd *clone (cygheap_types malloc_type =3D HEAP_FHAN=
DLER)
+  {
+    void *ptr =3D (void *) ccalloc (malloc_type, 1, sizeof (fhandler_dev_=
fd));
+    fhandler_dev_fd *fh =3D new (ptr) fhandler_dev_fd (ptr);
+    fh->copy_from (this);
+    return fh;
+  }
+};
+
 class fhandler_signalfd : public fhandler_base
 {
   sigset_t sigset;
@@ -3208,6 +3235,7 @@ typedef union
   char __dev_raw[sizeof (fhandler_dev_raw)];
   char __dev_tape[sizeof (fhandler_dev_tape)];
   char __dev_zero[sizeof (fhandler_dev_zero)];
+  char __dev_fd[sizeof (fhandler_dev_fd)];
   char __disk_file[sizeof (fhandler_disk_file)];
   char __fifo[sizeof (fhandler_fifo)];
   char __netdrive[sizeof (fhandler_netdrive)];
diff --git a/winsup/cygwin/fhandler_dev_fd.cc b/winsup/cygwin/fhandler_dev=
_fd.cc
new file mode 100644
index 0000000000..6462838317
=2D-- /dev/null
+++ b/winsup/cygwin/fhandler_dev_fd.cc
@@ -0,0 +1,53 @@
+/* fhandler_process_fd.cc: fhandler for the /dev/{fd,std{in,out,err}} sym=
links
+
+This file is part of Cygwin.
+
+This software is a copyrighted work licensed under the terms of the
+Cygwin license.  Please consult the file "CYGWIN_LICENSE" for
+details. */
+
+#include "winsup.h"
+#include "path.h"
+#include "fhandler.h"
+
+fhandler_dev_fd::fhandler_dev_fd ():
+  fhandler_virtual ()
+{
+}
+
+virtual_ftype_t
+fhandler_dev_fd::exists ()
+{
+  return virt_symlink;
+}
+
+int __reg2
+fhandler_dev_fd::fstat (struct stat *buf)
+{
+  const char *path =3D get_name ();
+  debug_printf ("fstat (%s)", path);
+
+  fhandler_base::fstat (buf);
+
+  buf->st_mode =3D S_IFLNK | STD_RBITS | S_IWUSR | S_IWGRP | S_IWOTH | ST=
D_XBITS;
+  buf->st_ino =3D get_ino ();
+
+  return 0;
+}
+
+bool
+fhandler_dev_fd::fill_filebuf ()
+{
+  const char *path =3D get_name ();
+  debug_printf ("fill_filebuf (%s)", path);
+
+  const char *native =3D get_native_name ();
+  if (!native)
+    {
+      return false;
+    }
+
+  free(filebuf);
+  filebuf =3D cstrdup (native);
+  return true;
+}
=2D-
2.35.1


