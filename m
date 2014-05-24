Return-Path: <cygwin-patches-return-7985-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 4854 invoked by alias); 24 May 2014 22:00:15 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 4821 invoked by uid 89); 24 May 2014 22:00:15 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=0.9 required=5.0 tests=AWL,BAYES_00,FREEMAIL_FROM,KAM_COUK,RCVD_IN_BL_SPAMCOP_NET,SPF_PASS autolearn=no version=3.3.2
X-HELO: out.ipsmtp4nec.opaltelecom.net
Received: from out.ipsmtp4nec.opaltelecom.net (HELO out.ipsmtp4nec.opaltelecom.net) (62.24.202.76) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (CAMELLIA256-SHA encrypted) ESMTPS; Sat, 24 May 2014 22:00:13 +0000
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AqsBAEUVgVNPRtQK/2dsb2JhbAANTINZrgmVaYQYPRYYAwIBAgFYBgIBAbpipUQXjm+EKgSRTIE6iCqJWotJ
X-IPAS-Result: AqsBAEUVgVNPRtQK/2dsb2JhbAANTINZrgmVaYQYPRYYAwIBAgFYBgIBAbpipUQXjm+EKgSRTIE6iCqJWotJ
Received: from 79-70-212-10.dynamic.dsl.as9105.com (HELO [127.0.0.1]) ([79.70.212.10])  by out.ipsmtp4nec.opaltelecom.net with ESMTP; 24 May 2014 23:00:09 +0100
Message-ID: <53811668.5010208@tiscali.co.uk>
Date: Sat, 24 May 2014 22:00:00 -0000
From: David Stacey <drstacey@tiscali.co.uk>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: [PATCH] cygwin_rexec() returns pointer to deallocated memory
Content-Type: multipart/mixed; boundary="------------050108070005070909000204"
X-IsSubscribed: yes
X-SW-Source: 2014-q2/txt/msg00008.txt.bz2

This is a multi-part message in MIME format.
--------------050108070005070909000204
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-length: 557

In function cygwin_rexec(), a pointer to local buffer 'ahostbuf' is 
returned through 'ahost'. However, the buffer will have been deallocated 
at the end of the function, and so the contents of 'ahost' will be 
undefined. A trivial patch (attached) fixes the problem by making 
'ahostbuf' static.

This patch fixes Coverity bug ID #60028.

Change Log:
2014-05-24  David Stacey  <drstacey@tiscali.co.uk>

         * libc/rexec.cc (cygwin_rexec):
         Corrected returning a pointer to a buffer that will have gone 
out of
         scope.

Cheers,

Dave.


--------------050108070005070909000204
Content-Type: text/plain; charset=windows-1252;
 name="cygwin_rexec.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="cygwin_rexec.patch"
Content-length: 362

--- cygwin-orig/libc/rexec.cc	2013-04-23 10:44:35.000000000 +0100
+++ cygwin/libc/rexec.cc	2014-05-24 22:37:39.764370000 +0100
@@ -317,7 +317,7 @@
 	u_short port = 0;
 	int s, timo = 1, s3;
 	char c;
-	char ahostbuf[INTERNET_MAX_HOST_NAME_LENGTH + 1];
+	static char ahostbuf[INTERNET_MAX_HOST_NAME_LENGTH + 1];
 
 	myfault efault;
 	if (efault.faulted (EFAULT))

--------------050108070005070909000204--
