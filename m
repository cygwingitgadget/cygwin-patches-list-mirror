Return-Path: <cygwin-patches-return-3703-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 32043 invoked by alias); 13 Mar 2003 05:59:39 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 31933 invoked from network); 13 Mar 2003 05:59:38 -0000
Message-ID: <004901c2e925$6dc2a610$0400a8c0@robertcollins.net>
Reply-To: "Cygwin \(Robert Collins\)" <rbcollins@cygwin.com>
From: "Cygwin \(Robert Collins\)" <rbcollins@cygwin.com>
To: "Thomas Pfaff" <tpfaff@gmx.net>,
	<cygwin-patches@cygwin.com>
References: <Pine.WNT.4.44.0302271057100.285-400000@algeria.intern.net>
Subject: Re: [PATCH]: Updated pthread_cond patch.
Date: Thu, 13 Mar 2003 05:59:00 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-SW-Source: 2003-q1/txt/msg00352.txt.bz2

I * think* this one is ok. No red flags glared at me :}.

So, please, go ahead.

Rob
===
----- Original Message ----- 
From: "Thomas Pfaff" <tpfaff@gmx.net>
To: <cygwin-patches@cygwin.com>
Sent: Thursday, February 27, 2003 11:27 PM
Subject: [PATCH]: Updated pthread_cond patch.


> 
> This is a slightly modified version of my still pending patch. The
> modifications were made to support rwlocks.
> 
> 2003-02-27  Thomas Pfaff  <tpfaff@gmx.net>
> 
> * thread.h (pthread_cond::ExitingWait): Remove.
> (pthread_cond::mutex): Ditto.
> (pthread_cond::cond_access): Ditto.
> (pthread_cond::win32_obj_id): Ditto.
> (pthread_cond::TimedWait): Ditto.
> (pthread_cond::BroadCast): Ditto.
> (pthread_cond::Signal): Ditto.
> (pthread_cond::waiting): Change type to unsigned long.
> (pthread_cond::pending): New member.
> (pthread_cond::semWait): Ditto.
> (pthread_cond::mtxIn): Ditto.
> (pthread_cond::mtxOut): Ditto.
> (pthread_cond::mtxCond): Ditto.
> (pthread_cond::UnBlock): New method.
> (pthread_cond::Wait): Ditto.
> * thread.cc: Update list of cancellation points.
> (pthread_cond::pthread_cond): Rewrite.
> (pthread_cond::~pthread_cond): Ditto.
> (pthread_cond::TimedWait): Remove.
> (pthread_cond::BroadCast): Ditto.
> (pthread_cond::Signal): Ditto.
> (pthread_cond::UnBlock): Implement.
> (pthread_cond::Wait): Ditto.
> (pthread_cond::fixup_after_fork): Rewrite.
> (pthread_mutex::fixup_after_fork): Remove DETECT_BAD_APP
> conditional.
> (__pthread_cond_broadcast): Just return 0 if the condition is
> not initialized. Call pthread_cond::UnBlock to release blocked
> threads.
> (__pthread_cond_signal): Ditto.
> (__pthread_cond__dowait): Rewrite.
> (pthread_cond_timedwait): Add pthread_testcancel call. Fix
> waitlength calculation.
> (pthread_cond_wait): Add pthread_testcancel call.
> 
> 
> 
