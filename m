Return-Path: <cygwin-patches-return-4637-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 25891 invoked by alias); 30 Mar 2004 13:09:13 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 25878 invoked from network); 30 Mar 2004 13:09:10 -0000
Date: Tue, 30 Mar 2004 13:09:00 -0000
From: Corinna Vinschen <vinschen@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Dr.Volker.Zell@oracle.com: Re: uxterm from xterm-185-3 and xfontsel crashing when running under cygserver support]
Message-ID: <20040330130909.GH17229@cygbert.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <15169.1080650540@www37.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15169.1080650540@www37.gmx.net>
User-Agent: Mutt/1.4.2i
X-SW-Source: 2004-q1/txt/msg00127.txt.bz2

On Mar 30 14:42, Thomas Pfaff wrote:
> Corinna Vinschen wrote:
> > 	void
> > 	pthread::atforkchild (void)
> > 	{
> > 	  __fp_unlock_all ();
> > 
> > 	  MT_INTERFACE->fixup_after_fork ();
> > 
> > 	  [...]
> > 	}
> > 
> > Can you explain this?  Is the fix correct?
> No.
> 
> The problem is caused by cygrunsrv which is started by the service control
> manager.
> Because of this it does not have a properly initialized mainthread. When it
> locks a mutex the owner will be the pthread_null instance.After the fork the
> child will be reinitialized and the pthread_self pointer is changed,
> therefore it is no longer able to unlock a mutex which was locked by its parent.
> 
> I think that there are 2 possible workarounds:
> 
> 1. The thread which is started by the service control manager must be
> initiallized, for example in the first get_tls_self_pointer call. Chris has made
> some changes to TLS, i do not know if _my_tls  can be used for a thread that is
> created from outside.

But that can't be caused by being started by the SCM.  In theory, the
situation should be equivalent for each process started by a non-cygwin
process, isn't it?

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
