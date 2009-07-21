Return-Path: <cygwin-patches-return-6575-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 30232 invoked by alias); 21 Jul 2009 12:09:19 -0000
Received: (qmail 30222 invoked by uid 22791); 21 Jul 2009 12:09:18 -0000
X-SWARE-Spam-Status: No, hits=-1.4 required=5.0 	tests=AWL,BAYES_00,HK_OBFDOM,J_CHICKENPOX_62,SPF_SOFTFAIL
X-Spam-Check-By: sourceware.org
Received: from qmta15.emeryville.ca.mail.comcast.net (HELO QMTA15.emeryville.ca.mail.comcast.net) (76.96.27.228)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Tue, 21 Jul 2009 12:09:11 +0000
Received: from OMTA14.emeryville.ca.mail.comcast.net ([76.96.30.60]) 	by QMTA15.emeryville.ca.mail.comcast.net with comcast 	id JbqJ1c0021HpZEsAFc9BUx; Tue, 21 Jul 2009 12:09:11 +0000
Received: from [192.168.0.101] ([24.10.247.15]) 	by OMTA14.emeryville.ca.mail.comcast.net with comcast 	id Jc991c0040Lg2Gw8ac9ADT; Tue, 21 Jul 2009 12:09:10 +0000
Message-ID: <4A65AFE8.1070903@byu.net>
Date: Tue, 21 Jul 2009 12:09:00 -0000
From: Eric Blake <ebb9@byu.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.22) Gecko/20090605 Thunderbird/2.0.0.22 Mnenhy/0.7.6.666
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: bug in dup2
Content-Type: multipart/mixed;  boundary="------------060602020700010109040701"
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2009-q3/txt/msg00029.txt.bz2

This is a multi-part message in MIME format.
--------------060602020700010109040701
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-length: 737

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

POSIX requires dup2(1,1) to return 1 (if stdout is open), not 0.  I wonder
how long that bug has been present?  And the STC:

#include <unistd.h>
int main() { return dup2 (1, 1); }

2009-07-21  Eric Blake  <ebb9@byu.net>

	* dtable.cc (dup2): Correct return value for no-op.

- --
Don't work too hard, make some time for fun as well!

Eric Blake             ebb9@byu.net
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (Cygwin)
Comment: Public key at home.comcast.net/~ericblake/eblake.gpg
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEUEARECAAYFAkplr+gACgkQ84KuGfSFAYBSRwCXVTmu0J1jhB22KZLl7kVPEtL2
8QCghsc7m0X7YsfqJDEHT3NLgRu23Bs=
=W7zw
-----END PGP SIGNATURE-----

--------------060602020700010109040701
Content-Type: text/plain;
 name="cygwin.patch17"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cygwin.patch17"
Content-length: 427

Index: dtable.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/dtable.cc,v
retrieving revision 1.199
diff -u -p -r1.199 dtable.cc
--- dtable.cc	6 Jul 2009 15:11:30 -0000	1.199
+++ dtable.cc	21 Jul 2009 12:07:48 -0000
@@ -621,7 +621,7 @@ dtable::dup2 (int oldfd, int newfd)
 
   if (newfd == oldfd)
     {
-      res = 0;
+      res = newfd;
       goto done;
     }
 

--------------060602020700010109040701--
