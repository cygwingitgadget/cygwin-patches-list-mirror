Return-Path: <cygwin-patches-return-2388-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 31395 invoked by alias); 11 Jun 2002 02:27:53 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 31365 invoked from network); 11 Jun 2002 02:27:52 -0000
Date: Mon, 10 Jun 2002 19:27:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: Reorganizing internal_getlogin()
Message-ID: <20020611022812.GA30113@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20020609231253.008044d0@mail.attbi.com> <20020610035228.GC6201@redhat.com> <20020610111359.R30892@cygbert.vinschen.de> <20020610151016.GG6201@redhat.com> <3D04C62B.E7804DC0@ieee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D04C62B.E7804DC0@ieee.org>
User-Agent: Mutt/1.3.23.1i
X-SW-Source: 2002-q2/txt/msg00371.txt.bz2

On Mon, Jun 10, 2002 at 11:30:51AM -0400, Pierre A. Humblet wrote:
>Christopher Faylor wrote:
>> 
>> 
>> Ok.  I'm in favor of getting rid of sexec in 1.3.11, then.
>> 
>> I'll do that sometime today.
>> 
>Then you can also junk the first argument (token) in _spawnve()
>and spawn_guts() (FYI).

Yes, this was one of the things that I've wanted to do for a while.

It's checked in now, btw, along with your "Define sec_attribs and call
sec_user_nih() only once" change in spawn_guts' change.

>By the way, here is a diagram of what I proposed:
>
>Currently:
>PARENT
>seteuid   internal_getlogin (1 & 2)  spawn_guts
>CHILD
>             uinfo_init   internal_getlogin (1 & 2)
>
>Proposed:
>PARENT
>seteuid   spawn_guts   internal_getlogin (2)   
>CHILD
>             uinfo_init   internal_getlogin (1)
>
>Another reason that 2) can't be pushed to the child 
>is that it might be a non Cygwin process, expecting
>a correct Windows environment.

But, we know (in some cases, at least) if it's going to be a cygwin
process or not.  There may be no reason to go to the effort of filling
out the environment if we know we're not starting a normal windows
program.

However, I'm not convinced that we shouldn't just set the environment
correctly in setuid, rather than doing it in spawn_guts.  I think the normal
use of setuid is something like:

if (!fork ())
  {
    setuid (...);
    exec (...);
  }

So, setting the environment variables in setuid is no big deal.  The
only time it really could be a potential performance issue is if there
is a lot of switching back and forth between uids but I don't think that
is the norm.

cgf
