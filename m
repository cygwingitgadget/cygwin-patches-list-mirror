Return-Path: <cygwin-patches-return-2111-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 20040 invoked by alias); 25 Apr 2002 04:47:01 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 20018 invoked from network); 25 Apr 2002 04:46:58 -0000
Message-Id: <3.0.5.32.20020425003552.00804100@mail.attbi.com>
X-Sender: phumblet@mail.attbi.com
Date: Wed, 24 Apr 2002 21:47:00 -0000
To: Corinna Vinschen <cygwin-patches@cygwin.com>
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
Subject: Re: Workaround patch for MS CLOSE_WAIT bug
In-Reply-To: <20020415162809.P29277@cygbert.vinschen.de>
References: <3CBADAE5.92A542FE@ieee.org>
 <3.0.5.32.20020414152944.007ec460@mail.attbi.com>
 <20020415141743.N29277@cygbert.vinschen.de>
 <3CBADAE5.92A542FE@ieee.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=====================_1019723752==_"
X-SW-Source: 2002-q2/txt/msg00095.txt.bz2

--=====================_1019723752==_
Content-Type: text/plain; charset="us-ascii"
Content-length: 1267

Corinna Vinschen wrote: 

> Your patch looks good.  What I didn't quite get is, how the above
> code now looks like (ideally) when using the new FD_SETCF functionality.
> Could you write a short example?  If inetd (what about sshd?) could
> benefit, I'd like to see how to do it.  

FYI, attached are patches for inetd and sshd. I tested the standalone sshd
and sshd from inetd on Win98. No CLOSE_WAIT.
In addition I let the following loop run > 200 times
 i=0; while true; do i=$(($i +1)); ssh the_server echo $i; done
Without patches it stops after 50 to 83 times and all networking
on the server returns WSAENOBUFS (as reported by others). 

Although only a few lines of code need to be changed in the applications,
it would of course be better if Cygwin itself could take care of the bug
once and for all, as discussed last week.
For example, the bug is probably still active (but can be fixed)
in sshd when using ssh -R xxxxxx
   
The patches are not exactly as I had explained. Shutdown() is apparently
not needed but the socket must (?) be blocking when calling close() for 
the last time. I threw in linger = off (default behavior) just to be on the 
safe side. More testing is needed, but it's useless if Cygwin itself gets
to take care of the issue.

Pierre
--=====================_1019723752==_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="sshd.c.diff"
Content-length: 1781

--- sshd.c.in	Sun Apr 21 20:49:32 2002
+++ sshd.c	Wed Apr 24 22:36:06 2002
@@ -265,10 +265,14 @@
 {
 	int save_errno =3D errno;
 	int status;
+	pid_t pid;

-	while (waitpid(-1, &status, WNOHANG) > 0)
-		;
-
+	while ((pid =3D waitpid(-1, &status, WNOHANG)) > 0) {
+#ifdef HAVE_CYGWIN
+	    if (msbug_close(pid, -1))
+			error("msbug_close %s", strerror(errno));
+#endif
+	}
 	signal(SIGCHLD, main_sigchld_handler);
 	errno =3D save_errno;
 }
@@ -888,11 +892,17 @@
 				verbose("socket: %.100s", strerror(errno));
 				continue;
 			}
+#ifndef HAVE_CYGWIN
 			if (fcntl(listen_sock, F_SETFL, O_NONBLOCK) < 0) {
 				error("listen_sock O_NONBLOCK: %s", strerror(errno));
 				close(listen_sock);
 				continue;
 			}
+#else /* Don't dup listen_sock in forked processes */
+			if (fcntl(listen_sock, F_SETCF, 0) < 0) {
+			    error("listen_sock F_SETCF: %s", strerror(errno));
+			}
+#endif
 			/*
 			 * Set socket options.  We try to make the port
 			 * reusable and have it close as fast as possible
@@ -1091,7 +1101,11 @@
 						 */
 						startup_pipe =3D startup_p[1];
 						close_startup_pipes();
+#ifndef HAVE_CYGWIN
 						close_listen_socks();
+#else   /* Not opened in CYGWIN */
+						num_listen_socks =3D -1;
+#endif
 						sock_in =3D newsock;
 						sock_out =3D newsock;
 						log_init(__progname, options.log_level, options.log_facility, log_st=
derr);
@@ -1117,9 +1131,14 @@
 				}

 				arc4random_stir();
-
+#ifndef HAVE_CYGWIN
 				/* Close the new socket (the child is now taking care of it). */
 				close(newsock);
+#else
+				if (msbug_close(pid, newsock))
+				    error("msbug_close %s", strerror(errno));
+#endif
+
 			}
 			/* child process check (or debug mode) */
 			if (num_listen_socks < 0)
@@ -1519,3 +1538,4 @@
 #endif
 	debug("KEX done");
 }
+

--=====================_1019723752==_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="bsd-cygwin_util.h.diff"
Content-length: 341

--- bsd-cygwin_util.h.in	Fri Dec 28 22:08:30 2001
+++ bsd-cygwin_util.h	Mon Apr 22 18:57:48 2002
@@ -27,6 +27,7 @@
 int check_nt_auth(int pwd_authenticated, struct passwd *pw);
 int check_ntsec(const char *filename);
 void register_9x_service(void);
+int msbug_close(pid_t pid, int fd);
 
 #define open binary_open
 #define pipe binary_pipe

--=====================_1019723752==_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="bsd-cygwin_util.c.diff"
Content-length: 2002

--- bsd-cygwin_util.c.in	Fri Dec 28 22:08:30 2001
+++ bsd-cygwin_util.c	Wed Apr 24 23:41:54 2002
@@ -163,4 +163,63 @@
 	RegisterServiceProcess(0, 1);
 }

+/* This is a part of a workaround for the following Microsft bug
+   on Win95/98/Me:
+   http://support.microsoft.com/default.aspx?scid=3Dkb;en-us;Q198663
+   http://support.microsoft.com/default.aspx?scid=3Dkb;EN-US;q229658
+
+   msbug_close(pid, fd) is normally called twice.
+   The first time fd is >=3D 0.
+   On Win95/98/Me it then records the fd as belonging to the pid,
+   instead of closing it outright, and it sets the
+   "close on fork" flag to avoid further duplications.
+   The function is called again with fd < 0 when the pid exits.
+   It then closes the associated fd.
+   The two calls can safely be made in different threads.
+
+   The function returns the value of the fcntl() or close() call
+   it makes, if any, else 0.
+*/
+#include <fcntl.h>
+#include <unistd.h>
+#include "log.h"
+#define msbug_MAXFD 128 /* Plenty for small systems */
+int msbug_close(pid_t pid, int fd)
+{
+  int i;
+  static struct {
+    pid_t pid;
+      int fd;
+  } info[msbug_MAXFD] =3D {};
+
+  if (GetVersion() < 0x80000000) {
+    if (fd >=3D 0) return close(fd);
+    else return 0;
+  }
+  if (fd >=3D 0) {
+    for (i =3D 0; i < msbug_MAXFD; i++){
+      if (info[i].pid =3D=3D 0) {
+        info[i].fd =3D fd;
+        info[i].pid =3D pid; /* Done last */
+        return fcntl(fd, F_SETCF, 0);
+      }
+    }
+    return close(fd); /* Better now than never */
+  }
+  else {
+    struct linger linger =3D {};
+    for (i =3D 0; i < msbug_MAXFD; i++){
+      if (info[i].pid =3D=3D pid) {
+        fd =3D info[i].fd;
+        info[i].pid =3D 0; /* Done last */
+        fcntl(fd, F_SETFL, 0); /* Blocking */
+        setsockopt(fd, SOL_SOCKET, SO_LINGER,
+                   &linger, sizeof(linger));
+        return close(fd);
+      }
+    }
+    error("could not find pid %d", pid);
+    return 0;
+  }
+}
 #endif /* HAVE_CYGWIN */

--=====================_1019723752==_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="inetd.c.diff"
Content-length: 2761

--- inetd.c.in	Sun Jan  6 04:05:42 2002
+++ inetd.c	Wed Apr 24 23:49:54 2002
@@ -590,6 +590,64 @@
   SetServiceStatus(ssh, &ss);
 }

+/* This is a part of a workaround for the following Microsft bug
+   on Win95/98/Me:
+   http://support.microsoft.com/default.aspx?scid=3Dkb;en-us;Q198663
+   http://support.microsoft.com/default.aspx?scid=3Dkb;EN-US;q229658
+
+   msbug_close(pid, fd) is normally called twice.
+   The first time fd is >=3D 0.
+   On Win95/98/Me it then records the fd as belonging to the pid,
+   instead of closing it outright, and it sets the
+   "close on fork" flag to avoid further duplications.
+   The function is called again with fd < 0 when the pid exits.
+   It then closes the associated fd.
+   The two calls can safely be made in different threads.
+
+   The function returns the value of the fcntl() or close() call
+   it makes, if any, else 0.
+*/
+#include <fcntl.h>
+#include <unistd.h>
+#define msbug_MAXFD 128 /* Plenty for small systems */
+static int msbug_close(pid_t pid, int fd)
+{
+  int i;
+  static struct {
+    pid_t pid;
+      int fd;
+  } info[msbug_MAXFD] =3D {};
+
+  if (GetVersion() < 0x80000000) {
+    if (fd >=3D 0) return close(fd);
+    else return 0;
+  }
+  if (fd >=3D 0) {
+    for (i =3D 0; i < msbug_MAXFD; i++){
+      if (info[i].pid =3D=3D 0) {
+        info[i].fd =3D fd;
+        info[i].pid =3D pid; /* Done last */
+        return fcntl(fd, F_SETCF, 0);
+      }
+    }
+    return close(fd); /* Better now than never */
+  }
+  else {
+    struct linger linger =3D {};
+    for (i =3D 0; i < msbug_MAXFD; i++){
+      if (info[i].pid =3D=3D pid) {
+        fd =3D info[i].fd;
+        info[i].pid =3D 0; /* Done last */
+        fcntl(fd, F_SETFL, 0); /* Blocking */
+        setsockopt(fd, SOL_SOCKET, SO_LINGER,
+                   &linger, sizeof(linger));
+        return close(fd);
+      }
+    }
+    return 0;
+  }
+}
+
 void WINAPI
 service_main(DWORD argc, LPSTR *argv)
 #else
@@ -920,7 +978,11 @@
 			    }
 		    }
 		    if (!sep->se_wait && sep->se_socktype =3D=3D SOCK_STREAM)
-			    close(ctrl);
+#ifdef __CYGWIN__
+		      msbug_close(pid, ctrl);
+#else
+		      close(ctrl);
+#endif
 		}
 	}
 }
@@ -1061,6 +1123,9 @@
 		if (debug)
 			fprintf(stderr, "%d reaped, status %#x\n",
 				pid, status);
+#ifdef __CYGWIN__
+		msbug_close(pid, -1);
+#endif
 		for (sep =3D servtab; sep; sep =3D sep->se_next)
 			if (sep->se_wait =3D=3D pid) {
 				if (status)
@@ -1256,8 +1321,12 @@
 		}
 		return;
 	}
-	if (sep->se_socktype =3D=3D SOCK_STREAM)
+	if (sep->se_socktype =3D=3D SOCK_STREAM) {
+#ifdef __CYGWIN__
+		if (!sep->se_wait) fcntl(sep->se_fd, F_SETCF, 0);
+#endif
 		listen(sep->se_fd, 10);
+	}
 	FD_SET(sep->se_fd, &allsock);
 	nsock++;
 	if (sep->se_fd > maxsock)

--=====================_1019723752==_--
