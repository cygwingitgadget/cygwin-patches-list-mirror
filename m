Return-Path: <cygwin-patches-return-3015-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 31559 invoked by alias); 21 Sep 2002 19:30:55 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 31545 invoked from network); 21 Sep 2002 19:30:54 -0000
Message-ID: <00c601c261a5$da1ac200$6132bc3e@BABEL>
From: "Conrad Scott" <Conrad.Scott@dsl.pipex.com>
To: <cygwin-patches@cygwin.com>
Subject: cygwin_daemon merge
Date: Sat, 21 Sep 2002 12:30:00 -0000
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_00C3_01C261AE.3B7A4DB0"
X-Priority: 3
X-MSMail-Priority: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
X-SW-Source: 2002-q3/txt/msg00463.txt.bz2

This is a multi-part message in MIME format.

------=_NextPart_000_00C3_01C261AE.3B7A4DB0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-length: 892

The attached patch is the (small) subset of the cygwin_daemon merge that
I need clearance on.  The files affected are:

src/winsup/cygwin/Makefile.in
src/winsup/cygwin/dcrt0.cc
src/winsup/cygwin/fhandler_tty.cc
src/winsup/cygwin/tty.cc

There are just two changes reflected here:

* The code only connects to cygserver when necessary, rather than at
startup.  This is also the reason for the changes to the
`cygserver_running' checks.

* The cygserver request objects are now stack rather than heap
allocated.

I've not attached the whole patch since it is about 300Kb (oops); the
accumulated ChangeLog entries alone amount to over a 1000 lines.  If
anyone wants to see this, I'll happily post it or put it up on my
website.  Effectively I'm intending to merge all outstanding changes
except for those to cygwin.din, i.e., I'm excluding all the System V IPC
entry points.

Cheers,

// Conrad

------=_NextPart_000_00C3_01C261AE.3B7A4DB0
Content-Type: text/plain;
	name="clearance.patch.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="clearance.patch.txt"
Content-length: 7526

Index: src/winsup/cygwin/Makefile.in
diff -u src/winsup/cygwin/Makefile.in:1.102 src/winsup/cygwin/Makefile.in:1=
.63.2.23
--- src/winsup/cygwin/Makefile.in:1.102	Wed Sep  4 06:11:29 2002
+++ src/winsup/cygwin/Makefile.in	Fri Sep  6 02:48:10 2002
@@ -118,24 +118,28 @@
 DLL_IMPORTS:=3D$(w32api_lib)/libuuid.a $(w32api_lib)/libshell32.a $(w32api=
_lib)/libkernel32.a
=20
 # Please maintain this list in sorted order, with maximum files per 80 col=
 line
-DLL_OFILES:=3Dassert.o autoload.o cygheap.o cygserver_client.o \
-	cygserver_transport.o cygserver_transport_pipes.o \
-	cygserver_transport_sockets.o cygthread.o dcrt0.o debug.o delqueue.o \
-	dir.o dlfcn.o dll_init.o dtable.o environ.o errno.o exceptions.o \
-	exec.o external.o fcntl.o fhandler.o fhandler_clipboard.o \
-	fhandler_console.o fhandler_disk_file.o fhandler_dsp.o \
-	fhandler_floppy.o fhandler_mem.o fhandler_proc.o fhandler_process.o \
-	fhandler_random.o fhandler_raw.o fhandler_registry.o fhandler_serial.o \
-	fhandler_socket.o fhandler_tape.o fhandler_termios.o fhandler_tty.o \
-	fhandler_virtual.o fhandler_windows.o fhandler_zero.o fnmatch.o fork.o \
-	glob.o grp.o heap.o init.o ioctl.o ipc.o localtime.o malloc.o \
-	malloc_wrapper.o miscfuncs.o mmap.o net.o ntea.o passwd.o path.o \
-	pinfo.o pipe.o poll.o pthread.o regcomp.o regerror.o regexec.o \
-	regfree.o registry.o resource.o scandir.o sched.o sec_acl.o \
-	sec_helper.o security.o select.o shared.o shm.o signal.o \
-	sigproc.o smallprint.o spawn.o strace.o strsep.o sync.o syscalls.o \
-	sysconf.o syslog.o termios.o thread.o times.o tty.o uinfo.o uname.o \
-	v8_regexp.o v8_regerror.o v8_regsub.o wait.o wincap.o window.o \
+DLL_OFILES:=3D								\
+	assert.o autoload.o cygheap.o cygserver_client.o		\
+	cygserver_transport.o cygserver_transport_pipes.o		\
+	cygserver_transport_sockets.o cygthread.o dcrt0.o debug.o	\
+	delqueue.o dir.o dlfcn.o dll_init.o dtable.o environ.o errno.o	\
+	exceptions.o exec.o external.o fcntl.o fhandler.o		\
+	fhandler_clipboard.o fhandler_console.o fhandler_disk_file.o	\
+	fhandler_dsp.o fhandler_floppy.o fhandler_mem.o			\
+	fhandler_proc.o fhandler_process.o fhandler_random.o		\
+	fhandler_raw.o fhandler_registry.o fhandler_serial.o		\
+	fhandler_socket.o fhandler_tape.o fhandler_termios.o		\
+	fhandler_tty.o fhandler_virtual.o fhandler_windows.o		\
+	fhandler_zero.o fnmatch.o fork.o glob.o grp.o heap.o init.o	\
+	ioctl.o ipc.o localtime.o malloc.o malloc_wrapper.o		\
+	miscfuncs.o mmap.o msg.o net.o ntea.o passwd.o path.o pinfo.o	\
+	pipe.o poll.o pthread.o regcomp.o regerror.o regexec.o		\
+	regfree.o registry.o resource.o scandir.o sched.o sec_acl.o	\
+	sec_helper.o security.o select.o sem.o shared.o shm.o signal.o	\
+	sigproc.o smallprint.o spawn.o strace.o strsep.o sync.o		\
+	syscalls.o sysconf.o syslog.o termios.o thread.o times.o tty.o	\
+	uinfo.o uname.o v8_regexp.o v8_regerror.o v8_regsub.o wait.o	\
+	wincap.o window.o						\
 	$(EXTRA_DLL_OFILES) $(EXTRA_OFILES) $(MALLOC_OFILES) $(MT_SAFE_OBJECTS)
=20
 GMON_OFILES:=3Dgmon.o mcount.o profil.o
@@ -207,7 +211,7 @@
=20
 install_target: cygserver.exe
 	$(INSTALL_PROGRAM) cygserver.exe $(bindir)/cygserver.exe
-=09
+
 install_host:
=20
=20
@@ -333,9 +337,6 @@
=20
 cygserver_client_outside.o: cygserver_client.cc
 	 $(COMPILE_CXX) -D__OUTSIDE_CYGWIN__ -o $@ $<
-
-cygserver_shm.o: cygserver_shm.cc
-	$(COMPILE_CXX) -D__OUTSIDE_CYGWIN__ -o $@ $<
=20
 cygserver.exe: cygserver.o cygserver_shm.o cygserver_transport_outside.o c=
ygserver_transport_pipes_outside.o cygserver_transport_sockets_outside.o cy=
gserver_client_outside.o cygserver_process.o threaded_queue.o wincap.o vers=
ion.o smallprint.o
 	$(CXX) -o $@ $^ -lstdc++
Index: src/winsup/cygwin/dcrt0.cc
diff -u src/winsup/cygwin/dcrt0.cc:1.149 src/winsup/cygwin/dcrt0.cc:1.112.2=
.25
--- src/winsup/cygwin/dcrt0.cc:1.149	Thu Sep 19 08:12:48 2002
+++ src/winsup/cygwin/dcrt0.cc	Thu Sep 19 14:51:22 2002
@@ -34,8 +34,6 @@
 #include "cygwin_version.h"
 #include "dll_init.h"
 #include "cygthread.h"
-#include "cygwin/cygserver_transport.h"
-#include "cygwin/cygserver.h"
=20
 #define MAX_AT_FILE_LEVEL 10
=20
@@ -685,8 +683,6 @@
=20
   /* Initialize signal/subprocess handling. */
   sigproc_init ();
-
-  cygserver_init ();
=20
   /* Connect to tty. */
   tty_init ();
Index: src/winsup/cygwin/fhandler_tty.cc
diff -u src/winsup/cygwin/fhandler_tty.cc:1.71 src/winsup/cygwin/fhandler_t=
ty.cc:1.49.2.17
--- src/winsup/cygwin/fhandler_tty.cc:1.71	Sun Sep  8 12:35:41 2002
+++ src/winsup/cygwin/fhandler_tty.cc	Thu Sep 12 03:07:49 2002
@@ -24,7 +24,6 @@
 #include "pinfo.h"
 #include "cygheap.h"
 #include "shared_info.h"
-#include "cygwin/cygserver_transport.h"
 #include "cygwin/cygserver.h"
 #include "cygthread.h"
=20
@@ -490,8 +489,8 @@
   HANDLE from_master_local, to_master_local;
=20
   if (!wincap.has_security () ||
-      cygserver_running!=3DCYGSERVER_OK ||
-      !cygserver_attach_tty ( &from_master_local, &to_master_local))
+      cygserver_running =3D=3D CYGSERVER_UNAVAIL ||
+      !cygserver_attach_tty (&from_master_local, &to_master_local))
     {
       termios_printf ("cannot dup handles via server. using old method.");
=20
@@ -547,29 +546,15 @@
   if (!from_master_ptr || !to_master_ptr)
     return 0;
=20
-  client_request_attach_tty *request =3D
-	new client_request_attach_tty ((DWORD) GetCurrentProcessId (),
-				      (DWORD) get_ttyp ()->master_pid,
-				      (HANDLE) get_ttyp ()->from_master,
-				      (HANDLE) get_ttyp ()->to_master);
+  client_request_attach_tty req ((DWORD) get_ttyp ()->master_pid,
+				 (HANDLE) get_ttyp ()->from_master,
+				 (HANDLE) get_ttyp ()->to_master);
=20
-  if (cygserver_request (request) !=3D 0 ||
-	request->header.error_code !=3D 0)
+  if (req.make_request () =3D=3D -1 || req.error_code ())
     return 0;
=20
-/*
-  struct request_attach_tty req;
-  INIT_REQUEST (req, CYGSERVER_REQUEST_ATTACH_TTY);
-  req.pid =3D GetCurrentProcessId ();
-  req.master_pid =3D get_ttyp ()->master_pid;
-  req.from_master =3D get_ttyp ()->from_master;
-  req.to_master =3D get_ttyp ()->to_master;
-  if (cygserver_request ((struct request_header*) &req) !=3D 0)
-    return 0;
-*/
-  *from_master_ptr =3D request->from_master ();
-  *to_master_ptr =3D request->to_master ();
-  delete request;
+  *from_master_ptr =3D req.from_master ();
+  *to_master_ptr =3D req.to_master ();
   return 1;
 }
=20
Index: src/winsup/cygwin/tty.cc
diff -u src/winsup/cygwin/tty.cc:1.42 src/winsup/cygwin/tty.cc:1.29.2.14
--- src/winsup/cygwin/tty.cc:1.42	Sun Sep  8 12:35:41 2002
+++ src/winsup/cygwin/tty.cc	Thu Sep 12 03:07:50 2002
@@ -22,7 +22,6 @@
 #include "dtable.h"
 #include "cygheap.h"
 #include "pinfo.h"
-#include "cygwin/cygserver_transport.h"
 #include "cygwin/cygserver.h"
 #include "shared_info.h"
 #include "cygthread.h"
@@ -405,10 +404,17 @@
   /* FIXME: we shold NOT set the security wide open when the
      daemon is running
    */
-  if (wincap.has_security () && cygserver_running !=3D CYGSERVER_OK &&
-      (SetKernelObjectSecurity (hMainProc, DACL_SECURITY_INFORMATION,
-			       get_null_sd ()) =3D=3D FALSE))
-    system_printf ("Can't set process security, %E");
+  if (wincap.has_security ())
+    {
+      if (cygserver_running =3D=3D CYGSERVER_UNKNOWN)
+	cygserver_init ();
+
+      if (cygserver_running !=3D CYGSERVER_OK
+	  && !SetKernelObjectSecurity (hMainProc,
+				       DACL_SECURITY_INFORMATION,
+				       get_null_sd ()))
+	system_printf ("Can't set process security, %E");
+    }
=20
   /* Create synchronisation events */
=20

------=_NextPart_000_00C3_01C261AE.3B7A4DB0--

