Return-Path: <cygwin-patches-return-4635-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 30610 invoked by alias); 30 Mar 2004 09:50:47 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 30573 invoked from network); 30 Mar 2004 09:50:38 -0000
Date: Tue, 30 Mar 2004 09:50:00 -0000
From: Corinna Vinschen <vinschen@redhat.com>
To: cygwin-patches@cygwin.com
Cc: Thomas Pfaff <tpfaff@gmx.net>
Subject: [Dr.Volker.Zell@oracle.com: Re: uxterm from xterm-185-3 and xfontsel crashing when running under cygserver support]
Message-ID: <20040330095037.GA11907@cygbert.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com,
	Thomas Pfaff <tpfaff@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2i
X-SW-Source: 2004-q1/txt/msg00125.txt.bz2

Hi Thomas,

----- Forwarded message from "Dr. Volker Zell" <Dr.Volker.Zell@oracle.com> -----
> Date: Tue, 30 Mar 2004 09:30:52 +0200
> From: "Dr. Volker Zell" <Dr.Volker.Zell@oracle.com>
> Subject: Re: uxterm from xterm-185-3 and xfontsel crashing when running
>  under cygserver support
> To: cygwin-xfree@cygwin.com
> Reply-To: cygwin-xfree@cygwin.com
> 
> >>>>> "Corinna" == Corinna Vinschen writes:
> 
>     Corinna> I've build my own debug version of the X stuff today and I tracked the
>     Corinna> SEGV down.  It's an unfortunate combination of two bugs in the SHM
>     Corinna> implementation:
> [...]
> 
> I just tried your fix which seems to be in the 20040329 snapshot. But
> now /usr/sbin/cygserver doesn't start anymore. I installed it as a
> service with cygrunsrv. The same happens for my other cygwin service
> /sbin/init which also refuses to start. In the process list I could see
> 4 !! /bin/cygrunsrv processes so. Reverting to 1.5.9 and all is fine.
----- End forwarded message -----

I've tracked down this problem to the point that I know what change has
introduced this problem.  It happens with all snapshots since 20040326
and the change was this one:

2004-03-26 Thomas Pfaff <tpfaff@gmx.net>

	[...]
	(pthread::atforkprepare): Lock file pointer before fork.
	(pthread::atforkparent): Unlock file pointer after fork.
	(pthread::atforkchild): Ditto.

More exactly, the problem happens in pthread::atforkchild ():

	void
	pthread::atforkchild (void)
	{
	  MT_INTERFACE->fixup_after_fork (); 

	  __fp_unlock_all ();

	  [...]
	}

where it hangs in fixup_after_fork().  When turning around the order
of the above two commands, evrything seems to work fine:

	void
	pthread::atforkchild (void)
	{
	  __fp_unlock_all ();

	  MT_INTERFACE->fixup_after_fork ();

	  [...]
	}

Can you explain this?  Is the fix correct?


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
