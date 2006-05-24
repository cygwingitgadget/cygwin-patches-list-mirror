Return-Path: <cygwin-patches-return-5869-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 20892 invoked by alias); 24 May 2006 02:11:55 -0000
Received: (qmail 20882 invoked by uid 22791); 24 May 2006 02:11:55 -0000
X-Spam-Check-By: sourceware.org
Received: from py-out-1112.google.com (HELO py-out-1112.google.com) (64.233.166.176)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Wed, 24 May 2006 02:11:51 +0000
Received: by py-out-1112.google.com with SMTP id o67so2009608pye         for <cygwin-patches@cygwin.com>; Tue, 23 May 2006 19:11:49 -0700 (PDT)
Received: by 10.35.39.2 with SMTP id r2mr247620pyj;         Tue, 23 May 2006 19:11:49 -0700 (PDT)
Received: by 10.35.30.7 with HTTP; Tue, 23 May 2006 19:11:48 -0700 (PDT)
Message-ID: <ba40711f0605231911q37040f58rfff1dd494f1b84a0@mail.gmail.com>
Date: Wed, 24 May 2006 02:11:00 -0000
From: "Lev Bishop" <lev.bishop@gmail.com>
To: cygwin-patches@cygwin.com
Subject: Re: fhandler_base::readv
In-Reply-To: <20060524010002.GB14893@trixie.casa.cgf.cx>
MIME-Version: 1.0
Content-Type: multipart/mixed;  	boundary="----=_Part_11496_13946336.1148436708974"
References: <ba40711f0605231728r3e349fd4m93b82a70ae058146@mail.gmail.com> 	 <20060524010002.GB14893@trixie.casa.cgf.cx>
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q2/txt/msg00057.txt.bz2


------=_Part_11496_13946336.1148436708974
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Content-length: 369

On 5/23/06, Christopher Faylor wrote:

> At this point in the code, tot is only used in the subsequent assert.
> If that is the rationale for this change wouldn't it make more sense to
> just check len in the assert?

It does make sense. Try this version.

2006-05-23  Lev Bishop  <lev.bishop+cygwin@gmail.com>

	* fhandler.cc (readv): Deal with tot not precalculated.

------=_Part_11496_13946336.1148436708974
Content-Type: text/plain; name=fhandler.patch; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Attachment-Id: f_enl1g9ld
Content-Disposition: attachment; filename="fhandler.patch"
Content-length: 1063

Index: fhandler.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/fhandler.cc,v
retrieving revision 1.251
diff -u -p -r1.251 fhandler.cc
--- fhandler.cc	22 Mar 2006 16:42:44 -0000	1.251
+++ fhandler.cc	24 May 2006 02:09:09 -0000
@@ -941,12 +941,11 @@ fhandler_base::write (const void *ptr, s
 
 ssize_t
 fhandler_base::readv (const struct iovec *const iov, const int iovcnt,
-		      ssize_t tot)
+		      ssize_t len)
 {
   assert (iov);
   assert (iovcnt >= 1);
 
-  size_t len = tot;
   if (iovcnt == 1)
     {
       len = iov->iov_len;
@@ -954,7 +953,7 @@ fhandler_base::readv (const struct iovec
       return len;
     }
 
-  if (tot == -1)		// i.e. if not pre-calculated by the caller.
+  if (len == -1)		// i.e. if not pre-calculated by the caller.
     {
       len = 0;
       const struct iovec *iovptr = iov + iovcnt;
@@ -966,7 +965,7 @@ fhandler_base::readv (const struct iovec
       while (iovptr != iov);
     }
 
-  assert (tot >= 0);
+  assert (len >= 0);
 
   if (!len)
     return 0;

------=_Part_11496_13946336.1148436708974--
