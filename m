Return-Path: <cygwin-patches-return-4638-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 3042 invoked by alias); 30 Mar 2004 13:34:31 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 3026 invoked from network); 30 Mar 2004 13:34:28 -0000
Date: Tue, 30 Mar 2004 13:34:00 -0000
From: "Thomas Pfaff" <tpfaff@gmx.net>
To: cygwin-patches@cygwin.com
MIME-Version: 1.0
Subject: Re: [Dr.Volker.Zell@oracle.com: Re: uxterm from xterm-185-3 and xfontsel crashing when running under cygserver support]
X-Authenticated: #623905
Message-ID: <7168.1080653666@www58.gmx.net>
X-Flags: 0001
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-SW-Source: 2004-q1/txt/msg00128.txt.bz2

Corinna Vinschen wrote:
> On Mar 30 14:42, Thomas Pfaff wrote:
> > Corinna Vinschen wrote:
> > > 	void
> > > 	pthread::atforkchild (void)
> > > 	{
> > > 	  __fp_unlock_all ();
> > > 
> > > 	  MT_INTERFACE->fixup_after_fork ();
> > > 
> > > 	  [...]
> > > 	}
> > > 
> > > Can you explain this?  Is the fix correct?
> > No.
> > 
> > The problem is caused by cygrunsrv which is started by the service
control
> > manager.
> > Because of this it does not have a properly initialized mainthread. When
it
> > locks a mutex the owner will be the pthread_null instance.After the fork
the
> > child will be reinitialized and the pthread_self pointer is changed,
> > therefore it is no longer able to unlock a mutex which was locked by its
parent.
> > 
> > I think that there are 2 possible workarounds:
> > 
> > 1. The thread which is started by the service control manager must be
> > initiallized, for example in the first get_tls_self_pointer call. Chris
has made
> > some changes to TLS, i do not know if _my_tls  can be used for a thread
that is
> > created from outside.
> 
> But that can't be caused by being started by the SCM.  In theory, the
> situation should be equivalent for each process started by a non-cygwin
> process, isn't it?
> 

Regardless whether a process is started from a cygwin app or not it will
always start at mainCRTStartup. 

When it is started by the SCM however the service_main thread is created by
the SCM. The situation is similar to calling CreateThread instead of
pthread_create. The thread will be handled as anonymous since it is not in the thread
list and has not been initialized in thread_init_wrapper.

I think the easiest way is to modify pthread::init_mainthread in a way that
it handles such a situation properly and will keep the pthread_self pointer
unchanged after a fork.

But you can also change cygrunsrv to create a thread via pthread_create and
fork from this thread. This should work either.

Thomas

-- 
+++ NEU bei GMX und erstmalig in Deutschland: TÜV-geprüfter Virenschutz +++
100% Virenerkennung nach Wildlist. Infos: http://www.gmx.net/virenschutz
