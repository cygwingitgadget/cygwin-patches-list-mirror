Return-Path: <cygwin-patches-return-6002-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 9548 invoked by alias); 27 Nov 2006 08:33:53 -0000
Received: (qmail 9534 invoked by uid 22791); 27 Nov 2006 08:33:52 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.31.1) with ESMTP; Mon, 27 Nov 2006 08:33:44 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id D9B86544001; Mon, 27 Nov 2006 09:33:41 +0100 (CET)
Date: Mon, 27 Nov 2006 08:33:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [RFC][patch] cygwin/singal.h is not compatible with -std=c89 or -std=c99
Message-ID: <20061127083341.GB8385@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4568655E.6030403@sh.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4568655E.6030403@sh.cvut.cz>
User-Agent: Mutt/1.4.2i
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q4/txt/msg00020.txt.bz2

On Nov 25 16:46, V?clav Haisman wrote:
> [FreeBSD]
> struct sigaction {
>         union {
>                 void    (*__sa_handler)(int);
>                 void    (*__sa_sigaction)(int, struct __siginfo *, void *);
>         } __sigaction_u;                /* signal handler */
>         int     sa_flags;               /* see signal options below */
>         sigset_t sa_mask;               /* signal mask to apply */
> };
> 
> #define sa_handler      __sigaction_u.__sa_handler
> 
> So, the attached patch is the minimal patch [...]

>   struct sigaction
>   {
> !   __extension__ union
>     {
>       _sig_func_ptr sa_handler;  		/* SIG_DFL, SIG_IGN, or pointer to a function */
>       void  (*sa_sigaction) ( int, siginfo_t *, void * );

Thanks for the patch.  Looking into this, I'd rather use the FreeBSD
approach, which is similary used in Linux.  Please try the below patch.


Thanks,
Corinna


Index: include/cygwin/signal.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/include/cygwin/signal.h,v
retrieving revision 1.14
diff -u -p -r1.14 signal.h
--- include/cygwin/signal.h	23 Mar 2006 15:55:59 -0000	1.14
+++ include/cygwin/signal.h	27 Nov 2006 08:32:52 -0000
@@ -198,10 +198,12 @@ struct sigaction
   {
     _sig_func_ptr sa_handler;  		/* SIG_DFL, SIG_IGN, or pointer to a function */
     void  (*sa_sigaction) ( int, siginfo_t *, void * );
-  };
+  } __sigaction_u;
   sigset_t sa_mask;
   int sa_flags;
 };
+#define sa_handler   __sigaction_u.sa_handler
+#define sa_sigaction __sigaction_u.sa_sigaction
 
 #define SA_NOCLDSTOP 1   		/* Do not generate SIGCHLD when children
 					   stop */

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
