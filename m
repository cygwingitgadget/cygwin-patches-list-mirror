Return-Path: <cygwin-patches-return-7997-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 29529 invoked by alias); 6 Jun 2014 17:08:11 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 29515 invoked by uid 89); 6 Jun 2014 17:08:10 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-1.4 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.2
X-HELO: smtp3-g21.free.fr
Received: from smtp3-g21.free.fr (HELO smtp3-g21.free.fr) (212.27.42.3) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 06 Jun 2014 17:08:08 +0000
Received: from [192.168.0.11] (unknown [78.224.52.79])	by smtp3-g21.free.fr (Postfix) with ESMTP id 0AEE4A623D;	Fri,  6 Jun 2014 19:08:04 +0200 (CEST)
From: Denis Excoffier <cygwin@Denis-Excoffier.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Jun 2014 17:08:00 -0000
Subject: typo correction in grp.cc
To: cygwin-patches@cygwin.com
Message-Id: <1EB3586B-FB0E-4DA3-8790-9964C54B0D81@Denis-Excoffier.org>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.2\))
X-IsSubscribed: yes
X-SW-Source: 2014-q2/txt/msg00020.txt.bz2

Hello,

The following patch (or equivalent) is needed in order for /usr/bin/id to r=
eturn the full set of groups
in case the user given as argument belongs to more than 10 groups:

diff -uNr cygwin-snapshot-20140523-1.original/winsup/cygwin/grp.cc cygwin-s=
napshot-20140523-1.patched/winsup/cygwin/grp.cc
--- cygwin-snapshot-20140523-1.original/winsup/cygwin/grp.cc	2014-05-23 12:=
31:13.000000000 +0200
+++ cygwin-snapshot-20140523-1.patched/winsup/cygwin/grp.cc	2014-05-26 15:0=
8:37.542897300 +0200
@@ -656,11 +656,11 @@
 	  groups[cnt] =3D grp->gr_gid;
 	++cnt;
       }
-  *ngroups =3D cnt;
   if (cnt > *ngroups)
     ret =3D -1;
   else
     ret =3D cnt;
+  *ngroups =3D cnt;
=20
   syscall_printf ( "%d =3D getgrouplist(%s, %u, %p, %d)",
 		  ret, user, gid, groups, *ngroups);


Please apply.

Regards,

Denis Excoffier.
