From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygpatch <cygwin-patches@cygwin.com>
Subject: Re: [PATCH] syscalls.cc for statfs/df under Win9x problem
Date: Tue, 13 Mar 2001 07:42:00 -0000
Message-id: <20010313164211.F569@cygbert.vinschen.de>
References: <0GA500EHC3LE2O@pmismtp04.wcomnet.com> <20010313155155.C569@cygbert.vinschen.de> <3AAE3916.45474F5F@yahoo.com>
X-SW-Source: 2001-q1/msg00179.html

On Tue, Mar 13, 2001 at 10:13:26AM -0500, Earnie Boyd wrote:
> Corinna Vinschen wrote:
> >   but so:               if ()
> >                           {
> >                             body
> >                           }
> >                         else
> >                           {
> >                           }
> > 
> 
> Sorry for asking on this list but this is an example of what I need. 
> Does anyone know how to tell VIM to automagically do the above
> indentation?  If I `:set cindent' it does the second "not so" and I
> would like to change it to be correct.

Assuming ``shiftwidthÂ´Â´ is 4.

set cino=...,{.5s,...

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
