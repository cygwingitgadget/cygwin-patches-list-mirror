Return-Path: <cygwin-patches-return-4951-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 5793 invoked by alias); 11 Sep 2004 13:02:04 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 5775 invoked from network); 11 Sep 2004 13:02:03 -0000
Date: Sat, 11 Sep 2004 13:02:00 -0000
From: Corinna Vinschen <vinschen@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Fwd: 1.5.11-1: sftp performance problem]
Message-ID: <20040911130247.GB17670@cygbert.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20040910090123.GV17670@cygbert.vinschen.de> <20040910155505.48E86E538@carnage.curl.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040910155505.48E86E538@carnage.curl.com>
User-Agent: Mutt/1.4.2i
X-SW-Source: 2004-q3/txt/msg00103.txt.bz2

Bob,

On Sep 10 11:55, Bob Byrnes wrote:
> On Sep 10, 11:01am, XXXXXXXX@XXXXXX.XXX (Corinna Vinschen) wrote:


http://cygwin.com/acronyms/#PCYMTNQREAIYR


> > Hmm, I just found that this can't be quite valid anymore.  Using
> > socketpairs is way faster, even when using Cygwin 1.5.10.  I digged
> > in the openssh-unix-dev ML archives and the decision to switch to
> > USE_PIPES has been made 3 1/2 years ago.  I'm wondering if it's
> > time to switch back to socketpairs...
> > 
> -- End of excerpt from Corinna Vinschen
> 
> One really annoying consequence of socketpairs for sshd is that
> Windows-native (i.e. non-Cygwin) programs don't know how to write
> directly to sockets on stdout (or stderr0, so if you try to use
> them via ssh, their output silently disappears.  You can see this
> by doing ...
> 
>     # no output
>     cl -help
> 
>     # works normally
>     cl -help | cat
> 
> ... with an sshd that uses socketpairs instead of pipes.

Oh lord!  I tried it with `net', `ping' and `nslookup', which are roughly
the only Windows applications I use on the command line, and all three
have no problems.  I'm wondering how the above can happen since the
interactive application side is running in a PTY (which *is* a pipe),
not on socketpairs.

> I think OpenSSH uses pipes on most platforms by default, so I'm also

Only on those platforms which have known problems with (or no implementation
of) socketpairs.

> somewhat concerned that the socketpair-specific code in OpenSSH might be
> a bit crufty.

Why?  Socketpairs are in the same shape as any other socket connection
since they are using the same code.  And I surely do care for socket
operations.  See the ChangeLogs.  What especially do you think is "crufty"?

> It's not obvious to me why socketpairs would be inherently faster
> than pipes.  Maybe my latest patch exacerbated a longstanding but
> not-fully-appreciated performance problem ... I'd certainly be
> interested in improving that.

Glad to hear that.  I'm looking forward.


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          mailto:cygwin@cygwin.com
Red Hat, Inc.
