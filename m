Return-Path: <cygwin-patches-return-2722-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 3883 invoked by alias); 25 Jul 2002 21:26:33 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 3869 invoked from network); 25 Jul 2002 21:26:33 -0000
Message-ID: <20020725212633.90069.qmail@web14504.mail.yahoo.com>
Date: Thu, 25 Jul 2002 14:26:00 -0000
From: =?iso-8859-1?q?Danny=20Smith?= <danny_r_smith_2001@yahoo.co.nz>
Subject: Re: qt patch for winnt.h
To: cygwin-patches@cygwin.com
In-Reply-To: <20020725201524.GA6611@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-SW-Source: 2002-q3/txt/msg00170.txt.bz2

 --- Christopher Faylor <cgf@redhat.com> wrote: > On Thu, Jul 25, 2002 at
09:43:16PM +0200, Ralf Habacker wrote:
> >> I do prefer feature-centric ifdefs, but I don't think that adding this
> >> particular definition of HANDLE to the windows headers makes sense.
> >

What I don't like is the precedent.  Featuritis is catching.  

> I'm sure that Danny will comment on this.  He's probably doing something
> selfish like sleeping or eating breakfast right now.

And typing on a keyboard -- all at the same time.

I do not like this patch, because it means more work for me when YA typedef
conflict arises and someone else submits a patch (followed by YA long-winded
discussion) to fix that one, and that one breaks someone else's idea of what
the typedef should be and ...

The "standard" for the w32api is MSDN docs. Why can't projects that use the
w32api follow those standards?

Now I'd better unlock the garage and let the kids out.

Danny

> >I'm not sure, how this would look in real code, do you have an example ?
> 
> #define HANDLE foo_handle
> #include <winnt.h>
> #undef HANDLE
> 
> 
> cgf 


http://digital.yahoo.com.au - Yahoo! Digital How To
- Get the best out of your PC!
