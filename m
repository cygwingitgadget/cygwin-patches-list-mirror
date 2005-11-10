Return-Path: <cygwin-patches-return-5674-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 19533 invoked by alias); 10 Nov 2005 03:24:36 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 19490 invoked by uid 22791); 10 Nov 2005 03:24:32 -0000
Received: from polonium.mailguard.com.au (HELO polonium.mailguard.com.au) (70.84.128.4)
    by sourceware.org (qpsmtpd/0.30-dev) with ESMTP; Thu, 10 Nov 2005 03:24:32 +0000
Received: from localhost (polonium.mailguard.com.au [127.0.0.1])
	by polonium.mailguard.com.au (Postfix) with ESMTP id D4CDFD005F
	for <cygwin-patches@cygwin.com>; Thu, 10 Nov 2005 14:24:30 +1100 (EST)
Received: from web_email.pacombell.com.au (unknown [61.95.26.98])
	by polonium.mailguard.com.au (Postfix) with ESMTP id 0773ED0031
	for <cygwin-patches@cygwin.com>; Thu, 10 Nov 2005 14:24:29 +1100 (EST)
Received: from [192.168.3.87] (D-SCOTT-F [192.168.3.87]) by web_email.pacombell.com.au with SMTP (Microsoft Exchange Internet Mail Service Version 5.5.2656.59)
	id V5CWC7D5; Thu, 10 Nov 2005 14:25:54 +1100
Message-ID: <4372BDD6.6060109@pacom.com>
Date: Thu, 10 Nov 2005 03:24:00 -0000
From: Scott Finneran <scottf@pacom.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
MIME-Version: 1.0
To:  cygwin-patches@cygwin.com
Subject: Patch to fix defined but undeclared sigrelse() function.
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-MailGuard-ID: 4372bd6e1720e3
X-Filtered: by MailGuard - visit http://www.mailguard.com.au
X-SW-Source: 2005-q4/txt/msg00016.txt.bz2

Hello,

Below is a single line patch to fix what I assume is an issue with 
sigrelse(). The function is correctly defined in 
winsup/src/cygwin/exceptions.cc. However, the function is not declared 
in signal.h.

Of course I don't know the history of support for this function within 
cygwin other than the fact that it was added recently. As such, I am 
assuming that this missing declaration is indeed a bug and not a way of 
preventing people from using the function at this time.

Any feedback would be appreciated.

Kind Regards,

Scott

Index: cygwin/include/cygwin/signal.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/include/cygwin/signal.h,v
retrieving revision 1.7
diff -u -p -r1.7 signal.h
--- cygwin/include/cygwin/signal.h	28 Sep 2005 22:56:47 -0000	1.7
+++ cygwin/include/cygwin/signal.h	10 Nov 2005 03:13:44 -0000
@@ -222,6 +222,7 @@ struct sigaction
  int sigwait (const sigset_t *, int *);
  int sigwaitinfo (const sigset_t *, siginfo_t *);
  int sighold (int);
+int sigrelse (int);
  int sigqueue(pid_t, int, const union sigval);
  int siginterrupt (int, int);
  #ifdef __cplusplus

-- 
Message protected by MailGuard: e-mail anti-virus, anti-spam and content filtering.
http://www.mailguard.com.au/mg

