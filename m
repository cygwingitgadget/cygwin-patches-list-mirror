Return-Path: <cygwin-patches-return-4636-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 11672 invoked by alias); 30 Mar 2004 12:42:25 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 11624 invoked from network); 30 Mar 2004 12:42:21 -0000
Date: Tue, 30 Mar 2004 12:42:00 -0000
From: "Thomas Pfaff" <tpfaff@gmx.net>
To: cygwin-patches@cygwin.com
MIME-Version: 1.0
Subject: Re: [Dr.Volker.Zell@oracle.com: Re: uxterm from xterm-185-3 and xfontsel crashing when running under cygserver support]
X-Authenticated: #623905
Message-ID: <15169.1080650540@www37.gmx.net>
X-Flags: 0001
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-SW-Source: 2004-q1/txt/msg00126.txt.bz2

Corinna Vinschen wrote:

> ----- Forwarded message from "Dr. Volker Zell"  -----
> > Date: Tue, 30 Mar 2004 09:30:52 +0200
> > From: "Dr. Volker Zell" 
> > Subject: Re: uxterm from xterm-185-3 and xfontsel crashing when running
> >  under cygserver support
> > To: cygwin-xfree@cygwin.com
> > Reply-To: cygwin-xfree@cygwin.com
> > 
> > >>>>> "Corinna" == Corinna Vinschen writes:
> > 
> >     Corinna> I've build my own debug version of the X stuff today and I
tracked the
> >     Corinna> SEGV down.  It's an unfortunate combination of two bugs in
the SHM
> >     Corinna> implementation:
> > [...]
> > 
> > I just tried your fix which seems to be in the 20040329 snapshot. But
> > now /usr/sbin/cygserver doesn't start anymore. I installed it as a
> > service with cygrunsrv. The same happens for my other cygwin service
> > /sbin/init which also refuses to start. In the process list I could see
> > 4 !! /bin/cygrunsrv processes so. Reverting to 1.5.9 and all is fine.
> ----- End forwarded message -----
> 
> I've tracked down this problem to the point that I know what change has
> introduced this problem.  It happens with all snapshots since 20040326
> and the change was this one:
> 
> 2004-03-26 Thomas Pfaff 
> 
> 	[...]
> 	(pthread::atforkprepare): Lock file pointer before fork.
> 	(pthread::atforkparent): Unlock file pointer after fork.
> 	(pthread::atforkchild): Ditto.
> 
> More exactly, the problem happens in pthread::atforkchild ():
> 
> 	void
> 	pthread::atforkchild (void)
> 	{
> 	  MT_INTERFACE->fixup_after_fork (); 
> 
> 	  __fp_unlock_all ();
> 
> 	  [...]
> 	}
> 
> where it hangs in fixup_after_fork().  When turning around the order
> of the above two commands, evrything seems to work fine:
> 
> 	void
> 	pthread::atforkchild (void)
> 	{
> 	  __fp_unlock_all ();
> 
> 	  MT_INTERFACE->fixup_after_fork ();
> 
> 	  [...]
> 	}
> 
> Can you explain this?  Is the fix correct?
No.

The problem is caused by cygrunsrv which is started by the service control
manager.
Because of this it does not have a properly initialized mainthread. When it
locks a mutex the owner will be the pthread_null instance.After the fork the
child will be reinitialized and the pthread_self pointer is changed,
therefore it is no longer able to unlock a mutex which was locked by its parent.

I think that there are 2 possible workarounds:

1. The thread which is started by the service control manager must be
initiallized, for example in the first get_tls_self_pointer call. Chris has made
some changes to TLS, i do not know if _my_tls  can be used for a thread that is
created from outside.

2. The pthread_self pointer should never change after a fork.
This requires some changes in pthread::init_mainthread. If
get_tls_self_pointer returns NULL pthread_null::_instance  should be used instead of creating 
a new thread object.

Thomas

-- 
+++ NEU bei GMX und erstmalig in Deutschland: TÜV-geprüfter Virenschutz +++
100% Virenerkennung nach Wildlist. Infos: http://www.gmx.net/virenschutz
