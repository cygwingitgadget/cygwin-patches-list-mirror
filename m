Return-Path: <cygwin-patches-return-4639-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 21441 invoked by alias); 30 Mar 2004 13:55:18 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 21082 invoked from network); 30 Mar 2004 13:55:15 -0000
Date: Tue, 30 Mar 2004 13:55:00 -0000
From: Corinna Vinschen <vinschen@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Dr.Volker.Zell@oracle.com: Re: uxterm from xterm-185-3 and xfontsel crashing when running under cygserver support]
Message-ID: <20040330135514.GI17229@cygbert.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <7168.1080653666@www58.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7168.1080653666@www58.gmx.net>
User-Agent: Mutt/1.4.2i
X-SW-Source: 2004-q1/txt/msg00129.txt.bz2

On Mar 30 15:34, Thomas Pfaff wrote:
> Regardless whether a process is started from a cygwin app or not it will
> always start at mainCRTStartup. 
> 
> When it is started by the SCM however the service_main thread is created by
> the SCM. The situation is similar to calling CreateThread instead of
> pthread_create. The thread will be handled as anonymous since it is not in the thread
> list and has not been initialized in thread_init_wrapper.

Yeah, I just realized this while in the shower.

> I think the easiest way is to modify pthread::init_mainthread in a way that
> it handles such a situation properly and will keep the pthread_self pointer
> unchanged after a fork.

Do you have an appropriate patch?

> But you can also change cygrunsrv to create a thread via pthread_create and
> fork from this thread. This should work either.

That's not the way to go, IMO.  It requires *all* Cygwin applications
written to be started under SCM to be rewritten.

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
