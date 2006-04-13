Return-Path: <cygwin-patches-return-5821-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 10134 invoked by alias); 13 Apr 2006 16:25:00 -0000
Received: (qmail 10120 invoked by uid 22791); 13 Apr 2006 16:24:59 -0000
X-Spam-Check-By: sourceware.org
Received: from fios.cgf.cx (HELO cgf.cx) (71.248.179.247)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Thu, 13 Apr 2006 16:24:57 +0000
Received: by cgf.cx (Postfix, from userid 201) 	id 5DA1813C01E; Thu, 13 Apr 2006 12:24:56 -0400 (EDT)
Date: Thu, 13 Apr 2006 16:25:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Patch for silent crash with Cygwin1.dll v 1.5.19-4
Message-ID: <20060413162456.GD26309@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20060412154109.GA13171@trixie.casa.cgf.cx> <20060413124822.4608.qmail@web53001.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060413124822.4608.qmail@web53001.mail.yahoo.com>
User-Agent: Mutt/1.5.11
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q2/txt/msg00009.txt.bz2

On Thu, Apr 13, 2006 at 05:48:22AM -0700, Gary Zablackis wrote:
>> The exception handler is supposed to be initialized
>> in
>> _cygtls::init_thread which is called from
>> initialize_main_tls.
>> Why is that not happening?
>
>It does happen.  However, later on when the program calls dlopen ()
>(which will happen, e.g., when a python program imports a dll),
>LoadLibrary () gets called.  LoadLibrary () then installs its own
>exception handler.  The MS exception handler does NOT pass control back
>to the Cygwin exception handler (it is not obligated to).

You haven't proved that the cygwin exception handler is actually
installed at the time when you are reporting problems.  Repeating
that "it does happen" is not a proof.

>What is causing our problem is that when LoadLibrary () loads a dll,
>the following sequence of events occurs (NOTE: I have left out some of
>the intervening calls in the following sequence):
>  _cygwin_dll_entry@12 () calls dll_dllcrt0 ()
>                    which calls dll::init()
>                    which calls per_module::run_ctors
>()
>                    which calls pthread::once ()
>                    which calls pthread_key_create ()
>                    which calls 
>                         verifyably_object_isvalid ()
>                    which has the code:
>                     myfault efault;
>                     if (efault.faulted ())
>                       return INVALID_OBJECT;
>                    ...
>                     if ((*object)->magic != magic)
>                      return INVALID_OBJECT;
>                     return VALID_OBJECT;
>
>This last bit generates an exception which gets handled by the MS
>exception handler which decides the error must be fatal to the loading
>of the dll and sends us back to dlopen ().

There *really* is no reason to repeat this.  It has been explained many
times.  One thing missing from the above, however, is something which
shows that the cygwin exception handler is actually installed at the
point when this all occurs.

cgf
