Return-Path: <cygwin-patches-return-3850-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 19086 invoked by alias); 6 May 2003 14:26:04 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 18919 invoked from network); 6 May 2003 14:26:03 -0000
Date: Tue, 06 May 2003 14:26:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Fix nanosleep
Message-ID: <20030506142602.GA4979@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <Pine.WNT.4.44.0305061513150.1572-200000@algeria.intern.net> <20030506133450.GB3312@redhat.com> <3EB7C06F.6090709@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3EB7C06F.6090709@gmx.net>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q2/txt/msg00077.txt.bz2

On Tue, May 06, 2003 at 04:02:23PM +0200, Thomas Pfaff wrote:
>Christopher Faylor wrote:
>>I don't know what you're investigating but the basic problem with threads
>>and signals is that you can't send a signal to a thread.  I never 
>>implemented
>>that part of signal delivery.
>
>Indeed you are right:
>
>pthread_kill does not work as expected, instead of sending a signal to 
>the specified thread all threads are woken up and the signal handler is 
>not called in the context of that particular thread but in the context 
>of the main thread. Since all threads are waiting for the same global 
>signal_arrived and not for thread specific one it is clear that this 
>does not work.
>
>And i would like to know why every thread has its own sigaction 
>structure. AFAIK signals are global in the process and not thread 
>specific, and only the delivery to a thread can be blocked via 
>pthread_sigmask.

I assume it is just pure meanness as usual.

cgf
