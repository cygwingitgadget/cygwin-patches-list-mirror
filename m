Return-Path: <cygwin-patches-return-4941-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 25244 invoked by alias); 10 Sep 2004 15:55:07 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 25229 invoked from network); 10 Sep 2004 15:55:05 -0000
From: "Bob Byrnes" <byrnes@curl.com>
Date: Fri, 10 Sep 2004 15:55:00 -0000
In-Reply-To: <20040910090123.GV17670@cygbert.vinschen.de>
       from Corinna Vinschen (Sep 10, 11:01am)
Organization: Curl Corporation
X-Address: 1 Cambridge Center, 10th Floor, Cambridge, MA 02142-1612
X-Phone: 617-761-1238
X-Fax: 617-761-1201
To: cygwin-patches@cygwin.com
Subject: Re: [Fwd: 1.5.11-1: sftp performance problem]
Message-Id: <20040910155505.48E86E538@carnage.curl.com>
X-SW-Source: 2004-q3/txt/msg00093.txt.bz2

On Sep 10, 11:01am, vinschen@redhat.com (Corinna Vinschen) wrote:
-- Subject: [Fwd: 1.5.11-1: sftp performance problem]
>
> this problem is easily reproducible with sftp.  It seems to be in some
> way related to your pipe patch.
> 
> Due to speed considerations, Cygwin's implementation of OpenSSH uses
> pipes for local IPC instead of socketpairs.  I switched back the whole
> OpenSSH suite to use socketpairs and the problem disappears.  Getting
> a 1.4Megs file takes about a minute when using pipes, a split second
> when using socketpairs.  For some reason only receiving files is affected,
> not sending.
> 
> Would you mind to have a look into that?

Sure, I'll look.  I don't use sftp much, but we pump *enormous* amounts
of data through sshd otherwise, so it's odd that I haven't noticed any
performance impact.

> Or is that perhaps a problem solved by one of your upcoming patches?
> 
-- End of excerpt from Corinna Vinschen

No, all of my patches are to avoid various deadlocks.  They don't
directly address performance, although of course I am trying not to make
things slower.

I guess it's possible that my patch interacts badly with some other
recent submissions; I did most of my testing with an earlier snapshot.

On Sep 10, 11:41am, vinschen@redhat.com (Corinna Vinschen) wrote:
-- Subject: Re: [Fwd: 1.5.11-1: sftp performance problem]
>
> Hmm, I just found that this can't be quite valid anymore.  Using
> socketpairs is way faster, even when using Cygwin 1.5.10.  I digged
> in the openssh-unix-dev ML archives and the decision to switch to
> USE_PIPES has been made 3 1/2 years ago.  I'm wondering if it's
> time to switch back to socketpairs...
> 
-- End of excerpt from Corinna Vinschen

One really annoying consequence of socketpairs for sshd is that
Windows-native (i.e. non-Cygwin) programs don't know how to write
directly to sockets on stdout (or stderr0, so if you try to use
them via ssh, their output silently disappears.  You can see this
by doing ...

    # no output
    cl -help

    # works normally
    cl -help | cat

... with an sshd that uses socketpairs instead of pipes.

I think OpenSSH uses pipes on most platforms by default, so I'm also
somewhat concerned that the socketpair-specific code in OpenSSH might be
a bit crufty.

It's not obvious to me why socketpairs would be inherently faster
than pipes.  Maybe my latest patch exacerbated a longstanding but
not-fully-appreciated performance problem ... I'd certainly be
interested in improving that.

--
Bob
