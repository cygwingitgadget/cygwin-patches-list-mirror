Return-Path: <cygwin-patches-return-4956-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 16237 invoked by alias); 12 Sep 2004 14:08:06 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 16162 invoked from network); 12 Sep 2004 14:08:02 -0000
Date: Sun, 12 Sep 2004 14:08:00 -0000
From: Corinna Vinschen <vinschen@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Fwd: 1.5.11-1: sftp performance problem]
Message-ID: <20040912140847.GA11786@cygbert.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20040911130247.GB17670@cygbert.vinschen.de> <20040911172454.6F9DEE538@carnage.curl.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040911172454.6F9DEE538@carnage.curl.com>
User-Agent: Mutt/1.4.2i
X-SW-Source: 2004-q3/txt/msg00108.txt.bz2

On Sep 11 13:24, Bob Byrnes wrote:
> On Sep 11,  3:02pm, Corinna Vinschen wrote:
> -- Subject: Re: [Fwd: 1.5.11-1: sftp performance problem]
> >
> > http://cygwin.com/acronyms/#PCYMTNQREAIYR
> 
> Sorry ... done.
> 
> > | One really annoying consequence of socketpairs for sshd is that
> > | Windows-native (i.e. non-Cygwin) programs don't know how to write
> > | directly to sockets on stdout (or stderr), so if you try to use
> > | them via ssh, their output silently disappears.
> > 
> > Oh lord!  I tried it with `net', `ping' and `nslookup', which are roughly
> > the only Windows applications I use on the command line, and all three
> > have no problems.  I'm wondering how the above can happen since the
> > interactive application side is running in a PTY (which *is* a pipe),
> > not on socketpairs.
> 
> Try it without a pty:
> 
>     ssh cygwin-system-with-sshd-using-sockpairs "win32-native-command"
> 
> vs.
> 
>     ssh cygwin-system-with-sshd-using-sockpairs "win32-native-command | cat"

Yeah, sure.  But native apps are not our first concern and the above can
also easily be done with

  ssh -t cygwin-system-with-sshd-using-sockpairs "win32-native-command"

> And we'd still have the problem with win32-native apps, which I think
> is a show-stopper for socketpairs.

I'm actually in doubt that this should be a showstopper.


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          mailto:cygwin@cygwin.com
Red Hat, Inc.
