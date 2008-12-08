Return-Path: <cygwin-patches-return-6378-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 29362 invoked by alias); 8 Dec 2008 22:45:57 -0000
Received: (qmail 29346 invoked by uid 22791); 8 Dec 2008 22:45:57 -0000
X-Spam-Check-By: sourceware.org
Received: from an-out-0708.google.com (HELO an-out-0708.google.com) (209.85.132.248)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Mon, 08 Dec 2008 22:45:09 +0000
Received: by an-out-0708.google.com with SMTP id b2so549492ana.38         for <cygwin-patches@cygwin.com>; Mon, 08 Dec 2008 14:45:06 -0800 (PST)
Received: by 10.64.210.3 with SMTP id i3mr3285284qbg.30.1228776305868;         Mon, 08 Dec 2008 14:45:05 -0800 (PST)
Received: from ?192.168.0.100? (S0106001346f94b85.wp.shawcable.net [24.76.249.6])         by mx.google.com with ESMTPS id k7sm8554860qba.6.2008.12.08.14.45.04         (version=TLSv1/SSLv3 cipher=RC4-MD5);         Mon, 08 Dec 2008 14:45:05 -0800 (PST)
Message-ID: <493DA370.30006@users.sourceforge.net>
Date: Mon, 08 Dec 2008 22:45:00 -0000
From: "Yaakov (Cygwin/X)" <yselkowitz@users.sourceforge.net>
User-Agent: Thunderbird 2.0.0.18 (Windows/20081105)
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: <resolv.h> requires <netinet/in.h>
Content-Type: multipart/mixed;  boundary="------------020507010807010602020706"
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2008-q4/txt/msg00022.txt.bz2

This is a multi-part message in MIME format.
--------------020507010807010602020706
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-length: 849

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

This affects both minires-1.02 and Cygwin 1.7.0-34.  STC based on a
configure test:

$ cat > test-resolv.c <<EOF
#include <resolv.h>

int
main (void) {
    return res_ninit (&_res);
}
EOF

$ gcc -Wall -o test-resolv.exe test-resolv.c
In file included from test-resolv.c:1:
/usr/include/resolv.h:162: error: field `nsaddr_list' has incomplete type
/usr/include/resolv.h:172: error: field `addr' has incomplete type
/usr/include/resolv.h:195: error: field `sin' has incomplete type

The missing typedef is sockaddr_in.  Patch attached.


Yaakov
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (Cygwin)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEAREIAAYFAkk9o3AACgkQpiWmPGlmQSNjeACg3/FBU9KSNBTigpifYBq4YX3Y
zAMAn2yGnzZryM0g1Qbz0AKq4NnOFjQZ
=NM7d
-----END PGP SIGNATURE-----

--------------020507010807010602020706
Content-Type: text/x-patch;
 name="resolv_h-sockaddr_in.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="resolv_h-sockaddr_in.patch"
Content-length: 594

2008-Dec-08  Yaakov Selkowitz  <yselkowitz@users.sourceforge.net>

	* resolv.h: #include <netinet/in.h> for sockaddr_in typedef.


Index: resolv.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/include/resolv.h,v
retrieving revision 1.2
diff -u -r1.2 resolv.h
--- resolv.h	17 Jun 2008 10:05:28 -0000	1.2
+++ resolv.h	8 Dec 2008 22:42:27 -0000
@@ -66,6 +66,7 @@
 #include <sys/socket.h>
 #include <stdio.h>
 #include <arpa/nameser.h>
+#include <netinet/in.h>
 
 /*
  * Revision information.  This is the release date in YYYYMMDD format.

--------------020507010807010602020706--
