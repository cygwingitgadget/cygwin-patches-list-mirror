Return-Path: <cygwin-patches-return-5870-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 24344 invoked by alias); 24 May 2006 02:23:43 -0000
Received: (qmail 24332 invoked by uid 22791); 24 May 2006 02:23:42 -0000
X-Spam-Check-By: sourceware.org
Received: from py-out-1112.google.com (HELO py-out-1112.google.com) (64.233.166.182)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Wed, 24 May 2006 02:23:40 +0000
Received: by py-out-1112.google.com with SMTP id o67so2011916pye         for <cygwin-patches@cygwin.com>; Tue, 23 May 2006 19:23:38 -0700 (PDT)
Received: by 10.35.12.13 with SMTP id p13mr999550pyi;         Tue, 23 May 2006 19:23:38 -0700 (PDT)
Received: by 10.35.30.7 with HTTP; Tue, 23 May 2006 19:23:38 -0700 (PDT)
Message-ID: <ba40711f0605231923x35b494b4q3e97f438b31b320f@mail.gmail.com>
Date: Wed, 24 May 2006 02:23:00 -0000
From: "Lev Bishop" <lev.bishop@gmail.com>
To: cygwin-patches@cygwin.com
Subject: Re: fhandler_base::readv
In-Reply-To: <ba40711f0605231911q37040f58rfff1dd494f1b84a0@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;  	boundary="----=_Part_11724_7818834.1148437418798"
References: <ba40711f0605231728r3e349fd4m93b82a70ae058146@mail.gmail.com> 	 <20060524010002.GB14893@trixie.casa.cgf.cx> 	 <ba40711f0605231911q37040f58rfff1dd494f1b84a0@mail.gmail.com>
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q2/txt/msg00058.txt.bz2


------=_Part_11724_7818834.1148437418798
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Content-length: 402

On 5/23/06, Lev Bishop wrote:

> It does make sense. Try this version.

Sorry, no. I'm stupid - ignore that version. There's not much point in
doing assert(len>=3D0) given that len is unsigned, it's pretty much a
given :-) How about just removing the assert()?

So here's the 3rd attempt.

2006-05-23  Lev Bishop  <lev.bishop+cygwin@gmail.com>

	* fhandler.cc (readv): Deal with tot not precalculated.

------=_Part_11724_7818834.1148437418798
Content-Type: text/plain; name=fhandler.patch; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Attachment-Id: f_enl1vdp9
Content-Disposition: attachment; filename="fhandler.patch"
Content-length: 441

Index: fhandler.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/fhandler.cc,v
retrieving revision 1.251
diff -u -p -r1.251 fhandler.cc
--- fhandler.cc	22 Mar 2006 16:42:44 -0000	1.251
+++ fhandler.cc	24 May 2006 02:22:10 -0000
@@ -966,8 +966,6 @@ fhandler_base::readv (const struct iovec
       while (iovptr != iov);
     }
 
-  assert (tot >= 0);
-
   if (!len)
     return 0;
 

------=_Part_11724_7818834.1148437418798--
