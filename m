Return-Path: <cygwin-patches-return-1752-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 2527 invoked by alias); 19 Jan 2002 05:21:50 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 2513 invoked from network); 19 Jan 2002 05:21:49 -0000
Message-ID: <911C684A29ACD311921800508B7293BA037D2A87@cnmail>
From: Mark Bradshaw <bradshaw@staff.crosswalk.com>
To: 'Corinna Vinschen' <cygwin-patches@cygwin.com>
Subject: New addition to cygwin: recvmsg and sendmsg
Date: Fri, 18 Jan 2002 21:21:00 -0000
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_000_01C1A0A9.30EB9FF0"
X-SW-Source: 2002-q1/txt/msg00109.txt.bz2

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_000_01C1A0A9.30EB9FF0
Content-Type: text/plain
Content-length: 1117

In getting bind 9.2.0 to compile on cygwin I found I needed these functions.
The original source is from openbsd:
http://www.openbsd.org/cgi-bin/cvsweb/src/kerberosIV/src/lib/roken/recvmsg.c
?rev=1.1.1.1&content-type=text/x-cvsweb-markup

and

http://www.openbsd.org/cgi-bin/cvsweb/src/kerberosIV/src/lib/roken/sendmsg.c
?rev=1.1.1.1&content-type=text/x-cvsweb-markup

The license is free from the advert clause, so there should be no issues
there.  Both functions were modified slightly.   The return value was
changed to int, the internal calls to recvfrom and sendto where changed to
cygwin_recvfrom and cygwin_sendto respectively, and I added some explicit
type casting.  Other than that, it built OOTB.

To verify its operation I built a clean version of bind (with some minor
touchups to get around other issues) and was able to transmit DNS queries
correctly.  

Mark

====================

Changelog:
2002-01-19  Mark Bradshaw  <bradshaw@staff.crosswalk.com>

	* cygwin.din: added recvmsg and sendmsg
	* net.cc: added cygwin_recvmsg and cygwin_sendmsg
	* /usr/include/sys/socket.h: added recvmsg and sendmsg


------_=_NextPart_000_01C1A0A9.30EB9FF0
Content-Type: text/plain;
	name="Changelog.txt"
Content-Disposition: attachment;
	filename="Changelog.txt"
Content-length: 207

2002-01-19  Mark Bradshaw  <bradshaw@staff.crosswalk.com>

	* cygwin.din: added recvmsg and sendmsg
	* net.cc: added cygwin_recvmsg and cygwin_sendmsg
	* /usr/include/sys/socket.h: added recvmsg and sendmsg

------_=_NextPart_000_01C1A0A9.30EB9FF0
Content-Type: application/octet-stream;
	name="socket.h.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="socket.h.diff"
Content-length: 786

--- socket.h.orig	Fri Jan 18 23:27:57 2002=0A=
+++ socket.h	Fri Jan 18 23:01:52 2002=0A=
@@ -35,7 +35,9 @@ extern "C"=0A=
   int recv (int, void *__buff, int __len, unsigned int __flags);=0A=
   int recvfrom (int, char *__buff, int __len, int __flags,=0A=
 			 struct sockaddr *__from, int *__fromlen);=0A=
+  int recvmsg(int s, struct msghdr *msg, int flags);=0A=
   int send (int, const void *__buff, int __len, unsigned int __flags);=0A=
+  int sendmsg(int s, const struct msghdr *msg, int flags);=0A=
   int sendto (int, const void *, int, unsigned int, const struct sockaddr =
*, int);=0A=
   int setsockopt (int __s, int __level, int __optname, const void *optval,=
 int __optlen);=0A=
   int getsockopt (int __s, int __level, int __optname, void *__optval, int=
 *__optlen);=0A=

------_=_NextPart_000_01C1A0A9.30EB9FF0
Content-Type: application/octet-stream;
	name="net.cc.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="net.cc.diff"
Content-length: 3148

Index: cygwin.din=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cygwin/cygwin.din,v=0A=
retrieving revision 1.42=0A=
diff -b -u -p -r1.42 cygwin.din=0A=
--- cygwin.din	2002/01/17 10:39:36	1.42=0A=
+++ cygwin.din	2002/01/19 05:20:35=0A=
@@ -1036,6 +1036,8 @@ setsockopt =3D cygwin_setsockopt=0A=
 inet_aton =3D cygwin_inet_aton=0A=
 inet_ntoa =3D cygwin_inet_ntoa=0A=
 recvfrom =3D cygwin_recvfrom=0A=
+recvmsg =3D cygwin_recvmsg=0A=
+sendmsg =3D cygwin_sendmsg=0A=
 sendto =3D cygwin_sendto=0A=
 shutdown =3D cygwin_shutdown=0A=
 sethostent=0A=
Index: net.cc=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cygwin/net.cc,v=0A=
retrieving revision 1.95=0A=
diff -b -u -p -r1.95 net.cc=0A=
--- net.cc	2002/01/09 20:57:55	1.95=0A=
+++ net.cc	2002/01/19 05:20:45=0A=
@@ -34,6 +34,7 @@ details. */=0A=
 #include "sigproc.h"=0A=
 #include "pinfo.h"=0A=
 #include "registry.h"=0A=
+#include <sys/uio.h>=0A=
=20=0A=
 extern "C" {=0A=
 int h_errno;=0A=
@@ -2519,3 +2520,63 @@ extern "C" void=0A=
 endhostent (void)=0A=
 {=0A=
 }=0A=
+=0A=
+/* exported as recvmsg: standards? */=0A=
+extern "C" int=20=0A=
+cygwin_recvmsg(int s, struct msghdr *msg, int flags)=0A=
+{=0A=
+    int ret, nb;=0A=
+    size_t tot =3D 0;=0A=
+    int i;=0A=
+    char *buf, *p;=0A=
+    struct iovec *iov =3D msg->msg_iov;=0A=
+=0A=
+    for(i =3D 0; i < msg->msg_iovlen; ++i)=0A=
+	tot +=3D iov[i].iov_len;=0A=
+    buf =3D (char *) malloc(tot);=0A=
+    if (tot !=3D 0 && buf =3D=3D NULL) {=0A=
+	errno =3D ENOMEM;=0A=
+	return -1;=0A=
+    }=0A=
+    nb =3D ret =3D cygwin_recvfrom (s, buf, tot, flags,=20=0A=
+      (struct sockaddr *) msg->msg_name, (int *) &msg->msg_namelen);=0A=
+    p =3D buf;=0A=
+    while (nb > 0) {=0A=
+	ssize_t cnt =3D min(nb, iov->iov_len);=0A=
+=0A=
+	memcpy (iov->iov_base, p, cnt);=0A=
+	p +=3D cnt;=0A=
+	nb -=3D cnt;=0A=
+	++iov;=0A=
+    }=0A=
+    free(buf);=0A=
+    return ret;=0A=
+}=0A=
+=0A=
+/* exported as sendmsg: standards? */=0A=
+extern "C" int=0A=
+cygwin_sendmsg(int s, const struct msghdr *msg, int flags)=0A=
+{=0A=
+    int ret;=0A=
+    size_t tot =3D 0;=0A=
+    int i;=0A=
+    char *buf, *p;=0A=
+    struct iovec *iov =3D msg->msg_iov;=0A=
+=0A=
+    for(i =3D 0; i < msg->msg_iovlen; ++i)=0A=
+	tot +=3D iov[i].iov_len;=0A=
+    buf =3D (char *) malloc(tot);=0A=
+    if (tot !=3D 0 && buf =3D=3D NULL) {=0A=
+	errno =3D ENOMEM;=0A=
+	return -1;=0A=
+    }=0A=
+    p =3D buf;=0A=
+    for (i =3D 0; i < msg->msg_iovlen; ++i) {=0A=
+	memcpy (p, iov[i].iov_base, iov[i].iov_len);=0A=
+	p +=3D iov[i].iov_len;=0A=
+    }=0A=
+    ret =3D cygwin_sendto (s, buf, tot, flags,=20=0A=
+      (struct sockaddr *) msg->msg_name, msg->msg_namelen);=0A=
+    free (buf);=0A=
+    return ret;=0A=
+}=0A=
\ No newline at end of file=0A=

------_=_NextPart_000_01C1A0A9.30EB9FF0--
