Return-Path: <cygwin-patches-return-4106-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 1614 invoked by alias); 19 Aug 2003 00:34:39 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 1605 invoked from network); 19 Aug 2003 00:34:39 -0000
Date: Tue, 19 Aug 2003 00:34:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: Signal handling tune up.
Message-ID: <20030819003438.GA4303@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20030818201736.0080e4e0@mail.attbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20030818201736.0080e4e0@mail.attbi.com>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q3/txt/msg00122.txt.bz2

On Mon, Aug 18, 2003 at 08:17:36PM -0400, Pierre A. Humblet wrote:
>During my work on using the multimedia timer for setitimer I noticed
>that Cygwin was not optimized to handle 1000 signals per second.
>It starts trashing under heavy load. Attached is a tune up patch.
>It also modestly improves performances at light load and fixes a
>race condition.
>   
>Some explanations are in order, here they are.

I will break down your patch and apply what I think is appropriate but
I would appreciate one patch/one bug in the future.

For now, I've applied this:

>*********************************************************************
>2)
>        movl    $0,%0                   # zero the signal number as a   \n\
>                                        # flag to the signal handler thread\n\
>                                        # that it is ok to set up sigsave\n\
>                                                                        \n\
>       call    _set_process_mask@4
>There is a race where the sigthread can start a handler for a signal that
>should be blocked.
>Simply interchanging the order still allows the sigthread to try to launch 
>a handler (before the mask is set), discovers that sigsave is busy and takes 
>cumbersome actions (e.g. Sleep).
>The patch moves set_process_mask all the way up to interrupt_setup(), so
>it is set in the sigthread itself.

cgf
