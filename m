Return-Path: <cygwin-patches-return-3472-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 21075 invoked by alias); 1 Feb 2003 04:56:48 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 21066 invoked from network); 1 Feb 2003 04:56:47 -0000
Date: Sat, 01 Feb 2003 04:56:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] system-cancel part2
Message-ID: <20030201045720.GA21649@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <Pine.WNT.4.44.0301151113240.93-300000@algeria.intern.net> <20030115163540.GF15975@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030115163540.GF15975@redhat.com>
User-Agent: Mutt/1.5.1i
X-SW-Source: 2003-q1/txt/msg00121.txt.bz2

On Wed, Jan 15, 2003 at 11:35:40AM -0500, Christopher Faylor wrote:
>>2003-01-15  Thomas Paff  <tpfaff@gmx.net>
>>
>>	* syscalls.cc (struct system_cleanup_args): New struct.
>>	(system_cleanup): New function.
>>	(system): Use pthread_cleanup_push and _pop to save and restore
>>	signal handlers and sigprocmask.
>
>Please do not check this in.  You are changing other parts of the code than the
>pthreads code and I want to study what you've done before you are approved to
>check this in.
>
>In other words, Robert's "as long as you have a test case" only applies to
>trivial changes or changes to pthread.cc, thread.cc, or thread.h.

Sorry for the long delay.  This patch looks ok to me.  Please feel free
to check it in along with your additional test cases.

cgf
