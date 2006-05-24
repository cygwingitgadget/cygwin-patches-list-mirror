Return-Path: <cygwin-patches-return-5866-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 10324 invoked by alias); 24 May 2006 00:29:03 -0000
Received: (qmail 10312 invoked by uid 22791); 24 May 2006 00:29:02 -0000
X-Spam-Check-By: sourceware.org
Received: from py-out-1112.google.com (HELO py-out-1112.google.com) (64.233.166.178)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Wed, 24 May 2006 00:29:00 +0000
Received: by py-out-1112.google.com with SMTP id o67so1988739pye         for <cygwin-patches@cygwin.com>; Tue, 23 May 2006 17:28:58 -0700 (PDT)
Received: by 10.35.112.3 with SMTP id p3mr1644019pym;         Tue, 23 May 2006 17:28:58 -0700 (PDT)
Received: by 10.35.30.7 with HTTP; Tue, 23 May 2006 17:28:58 -0700 (PDT)
Message-ID: <ba40711f0605231728r3e349fd4m93b82a70ae058146@mail.gmail.com>
Date: Wed, 24 May 2006 00:29:00 -0000
From: "Lev Bishop" <lev.bishop@gmail.com>
To: cygwin-patches@cygwin.com
Subject: fhandler_base::readv
MIME-Version: 1.0
Content-Type: multipart/mixed;  	boundary="----=_Part_9781_11834493.1148430538475"
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q2/txt/msg00054.txt.bz2


------=_Part_9781_11834493.1148430538475
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Content-length: 112

2006-05-23  Lev Bishop  <lev.bishop+cygwin@gmail.com>

	* fhandler.cc (readv): Deal with tot not precalculated.

------=_Part_9781_11834493.1148430538475
Content-Type: text/plain; name=fhandler.patch; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Attachment-Id: f_enkxsid9
Content-Disposition: attachment; filename="fhandler.patch"
Content-length: 459

Index: fhandler.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/fhandler.cc,v
retrieving revision 1.251
diff -u -p -r1.251 fhandler.cc
--- fhandler.cc	22 Mar 2006 16:42:44 -0000	1.251
+++ fhandler.cc	24 May 2006 00:24:46 -0000
@@ -964,6 +964,7 @@ fhandler_base::readv (const struct iovec
 	  len += iovptr->iov_len;
 	}
       while (iovptr != iov);
+      tot = len;
     }
 
   assert (tot >= 0);

------=_Part_9781_11834493.1148430538475--
