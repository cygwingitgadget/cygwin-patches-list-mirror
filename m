Return-Path: <cygwin-patches-return-5865-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 4740 invoked by alias); 24 May 2006 00:04:35 -0000
Received: (qmail 4689 invoked by uid 22791); 24 May 2006 00:04:34 -0000
X-Spam-Check-By: sourceware.org
Received: from py-out-1112.google.com (HELO py-out-1112.google.com) (64.233.166.182)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Wed, 24 May 2006 00:04:33 +0000
Received: by py-out-1112.google.com with SMTP id o67so1983877pye         for <cygwin-patches@cygwin.com>; Tue, 23 May 2006 17:04:31 -0700 (PDT)
Received: by 10.35.49.4 with SMTP id b4mr2975739pyk;         Tue, 23 May 2006 17:04:31 -0700 (PDT)
Received: by 10.35.30.7 with HTTP; Tue, 23 May 2006 17:04:31 -0700 (PDT)
Message-ID: <ba40711f0605231704u29b8860ayd6d30fab02602c70@mail.gmail.com>
Date: Wed, 24 May 2006 00:04:00 -0000
From: "Lev Bishop" <lev.bishop@gmail.com>
To: cygwin-patches@cygwin.com
Subject: select.cc exitsock error cleanup
MIME-Version: 1.0
Content-Type: multipart/mixed;  	boundary="----=_Part_9481_14510454.1148429071446"
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q2/txt/msg00053.txt.bz2


------=_Part_9481_14510454.1148429071446
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Content-length: 127

2006-05-23  Lev Bishop  <lev.bishop+cygwin@gmail.com>

	* select.cc (start_thread_socket): Clean up exitsock in case of error.

------=_Part_9481_14510454.1148429071446
Content-Type: text/plain; name=select.patch; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Attachment-Id: f_enkwm8f3
Content-Disposition: attachment; filename="select.patch"
Content-length: 467

Index: select.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/select.cc,v
retrieving revision 1.124
diff -u -p -r1.124 select.cc
--- select.cc	21 May 2006 17:27:14 -0000	1.124
+++ select.cc	23 May 2006 23:32:47 -0000
@@ -1446,6 +1446,7 @@ start_thread_socket (select_record *me, 
 err:
   set_winsock_errno ();
   closesocket (si->exitsock);
+  _my_tls.locals.exitsock = INVALID_SOCKET;
   return -1;
 }
 


------=_Part_9481_14510454.1148429071446--
