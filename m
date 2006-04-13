Return-Path: <cygwin-patches-return-5820-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 1292 invoked by alias); 13 Apr 2006 12:48:28 -0000
Received: (qmail 1281 invoked by uid 22791); 13 Apr 2006 12:48:28 -0000
X-Spam-Check-By: sourceware.org
Received: from web53001.mail.yahoo.com (HELO web53001.mail.yahoo.com) (206.190.49.31)     by sourceware.org (qpsmtpd/0.31) with SMTP; Thu, 13 Apr 2006 12:48:24 +0000
Received: (qmail 4610 invoked by uid 60001); 13 Apr 2006 12:48:22 -0000
Message-ID: <20060413124822.4608.qmail@web53001.mail.yahoo.com>
Received: from [69.141.137.97] by web53001.mail.yahoo.com via HTTP; Thu, 13 Apr 2006 05:48:22 PDT
Date: Thu, 13 Apr 2006 12:48:00 -0000
From: Gary Zablackis <gzabl@yahoo.com>
Subject: Re: Patch for silent crash with Cygwin1.dll v 1.5.19-4
To: cygwin-patches@cygwin.com, Bernhard Loos <bernloos@web.de>
In-Reply-To: <20060412154109.GA13171@trixie.casa.cgf.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q2/txt/msg00008.txt.bz2

> The exception handler is supposed to be initialized
> in
> _cygtls::init_thread which is called from
> initialize_main_tls.
> Why is that not happening?
> 
> cgf
> 

It does happen. However, later on when the program
calls dlopen () (which will happen, e.g., when a
python program imports a dll), LoadLibrary () gets
called. LoadLibrary () then installs its own exception
handler. The MS exception handler does NOT pass
control back to the Cygwin exception handler (it is
not obligated to).

What is causing our problem is that when LoadLibrary
() loads a dll, the following sequence of events
occurs (NOTE: I have left out some of the intervening
calls in the following sequence):
  _cygwin_dll_entry@12 () calls dll_dllcrt0 ()
                    which calls dll::init()
                    which calls per_module::run_ctors
()
                    which calls pthread::once ()
                    which calls pthread_key_create ()
                    which calls 
                         verifyably_object_isvalid ()
                    which has the code:
                     myfault efault;
                     if (efault.faulted ())
                       return INVALID_OBJECT;
                    ...
                     if ((*object)->magic != magic)
                      return INVALID_OBJECT;
                     return VALID_OBJECT;

This last bit generates an exception which gets
handled by the MS exception handler which decides the
error must be fatal to the loading of the dll and
sends us back to dlopen ().

Gary

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
