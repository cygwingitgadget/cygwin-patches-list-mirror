Return-Path: <cygwin-patches-return-2389-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 22467 invoked by alias); 11 Jun 2002 03:59:13 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 22450 invoked from network); 11 Jun 2002 03:59:12 -0000
Message-Id: <3.0.5.32.20020610235623.007f5a80@worldnet>
X-Sender: pierre@worldnet
Date: Mon, 10 Jun 2002 20:59:00 -0000
To: cygwin-patches@cygwin.com,cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
Subject: Re: Reorganizing internal_getlogin()
In-Reply-To: <20020611022812.GA30113@redhat.com>
References: <3D04C62B.E7804DC0@ieee.org>
 <3.0.5.32.20020609231253.008044d0@mail.attbi.com>
 <20020610035228.GC6201@redhat.com>
 <20020610111359.R30892@cygbert.vinschen.de>
 <20020610151016.GG6201@redhat.com>
 <3D04C62B.E7804DC0@ieee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-SW-Source: 2002-q2/txt/msg00372.txt.bz2

At 10:28 PM 6/10/2002 -0400, Christopher Faylor wrote:
>Yes, this was one of the things that I've wanted to do for a while.
>
>It's checked in now, btw, along with your "Define sec_attribs and call
>sec_user_nih() only once" change in spawn_guts' change.

Thanks

>But, we know (in some cases, at least) if it's going to be a cygwin
>process or not.  There may be no reason to go to the effort of filling
>out the environment if we know we're not starting a normal windows
>program.

That's fine with me too. I was going for minimum impact changes.

>However, I'm not convinced that we shouldn't just set the environment
>correctly in setuid, rather than doing it in spawn_guts.  I think the normal
>use of setuid is something like:
>
>if (!fork ())
>  {
>    setuid (...);
>    exec (...);
>  }

Yes, that's typical of sshd, telnetd, etc.. and my changes
would improve that case (e.g. avoid duplications and don't 
read the passwd file in the exec'ed program. That's not 
yet apparent in what I have sent, testing it now).

But there are also many programs (e.g. mail & pop servers) 
that look like

if (!fork ())
  {
    setuid (...);
    do some work without exec
    exit(0);
  }
That's mainly what I am trying to optimize.
 
Pierre
