Return-Path: <cygwin-patches-return-4643-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 8888 invoked by alias); 30 Mar 2004 16:24:08 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 8870 invoked from network); 30 Mar 2004 16:24:04 -0000
Date: Tue, 30 Mar 2004 16:24:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Dr.Volker.Zell@oracle.com: Re: uxterm from xterm-185-3 and xfontsel crashing when running under cygserver support]
Message-ID: <20040330162402.GB8138@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <7168.1080653666@www58.gmx.net> <20040330135514.GI17229@cygbert.vinschen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040330135514.GI17229@cygbert.vinschen.de>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2004-q1/txt/msg00133.txt.bz2

On Tue, Mar 30, 2004 at 03:55:14PM +0200, Corinna Vinschen wrote:
>On Mar 30 15:34, Thomas Pfaff wrote:
>> Regardless whether a process is started from a cygwin app or not it will
>> always start at mainCRTStartup. 
>> 
>> When it is started by the SCM however the service_main thread is created by
>> the SCM. The situation is similar to calling CreateThread instead of
>> pthread_create. The thread will be handled as anonymous since it is not in the thread
>> list and has not been initialized in thread_init_wrapper.
>
>Yeah, I just realized this while in the shower.
>
>> I think the easiest way is to modify pthread::init_mainthread in a way that
>> it handles such a situation properly and will keep the pthread_self pointer
>> unchanged after a fork.
>
>Do you have an appropriate patch?
>
>> But you can also change cygrunsrv to create a thread via pthread_create and
>> fork from this thread. This should work either.
>
>That's not the way to go, IMO.  It requires *all* Cygwin applications
>written to be started under SCM to be rewritten.

Right.  I've been working hard to keep cygwin functional with cygrunsrv
and SCM.  In fact, I think I've removed the requirement that inetd has
to fork a process after it calls SCM so that signals are delivered properly.

Since this is a breaking of backwards compatibility we won't even consider
changing applications.

I've read the rest of the thread and know that there is a patch ready but I
wanted to get these thoughts into the archive.

cgf
