Return-Path: <cygwin-patches-return-1795-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 27526 invoked by alias); 26 Jan 2002 01:53:59 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 27382 invoked from network); 26 Jan 2002 01:53:55 -0000
Subject: Patch to fail with error message when pthread_t not defined
From: Thomas Fitzsimmons <fitzsim@redhat.com>
To: Robert Collins <robert.collins@itdomain.com.au>
Cc: "J. Johnston" <jjohnstn@redhat.com>, newlib@sources.redhat.com,
        cygwin-patches@cygwin.com
In-Reply-To: <014f01c1a5f3$1eb048f0$0200a8c0@lifelesswks>
References: 
	<1011834535.1278.46.camel@toggle>	<02ce01c1a488$156d32b0$0200a8c0@lifelesswk
	 s>	<1011892037.16026.53.camel@toggle>  <20020124174949.GA3123@redhat.com>
	<1011901690.1187.55.camel@toggle> <1011914014.18203.5.camel@lifelesswks>
	<3C50A86B.93F06373@redhat.com>  <014f01c1a5f3$1eb048f0$0200a8c0@lifelesswks>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0 (Preview Release)
Date: Fri, 25 Jan 2002 17:53:00 -0000
Message-Id: <1012010023.1187.60.camel@toggle>
Mime-Version: 1.0
X-SW-Source: 2002-q1/txt/msg00152.txt.bz2

On Fri, 2002-01-25 at 17:53, Robert Collins wrote:
> 
> Hmm, I wonder if
> #ifndef pthread_t
> #error pthread_t hasn't be specified for this platform, do you have the
> kernel includes available?
> #endif
> 
> will catch a missing typedef correctly? Assuming it won't, the correct
> define to check for in this case is _CYGWIN_TYPES_H.
> 
> Rob
>

Comments?

Index: signal.h
===================================================================
RCS file: /cvs/src/src/newlib/libc/include/sys/signal.h,v
retrieving revision 1.11
diff -c -r1.11 signal.h
*** signal.h	2002/01/25 00:47:44	1.11
--- signal.h	2002/01/26 01:41:42
***************
*** 159,164 ****
--- 159,169 ----
  int _EXFUN(sigpause, (int));
  
  #if defined(_POSIX_THREADS)
+ #ifdef __CYGWIN__
+ #  ifndef _CYGWIN_TYPES_H
+ #    error You need the winsup sources or a cygwin installation to
compile the cygwin version of newlib.
+ #  endif
+ #endif
  int _EXFUN(pthread_kill, (pthread_t thread, int sig));
  #endif
  
 
-- 
Thomas Fitzsimmons
Red Hat Canada Limited        e-mail: fitzsim@redhat.com
2323 Yonge Street, Suite 300
Toronto, ON M4P2C9
