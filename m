Return-Path: <cygwin-patches-return-4953-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 10815 invoked by alias); 11 Sep 2004 17:24:56 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 10795 invoked from network); 11 Sep 2004 17:24:55 -0000
From: "Bob Byrnes" <byrnes@curl.com>
Date: Sat, 11 Sep 2004 17:24:00 -0000
In-Reply-To: <20040911130247.GB17670@cygbert.vinschen.de>
       from Corinna Vinschen (Sep 11,  3:02pm)
Organization: Curl Corporation
X-Address: 1 Cambridge Center, 10th Floor, Cambridge, MA 02142-1612
X-Phone: 617-761-1238
X-Fax: 617-761-1201
To: cygwin-patches@cygwin.com
Subject: Re: [Fwd: 1.5.11-1: sftp performance problem]
Message-Id: <20040911172454.6F9DEE538@carnage.curl.com>
X-SW-Source: 2004-q3/txt/msg00105.txt.bz2

On Sep 11,  3:02pm, Corinna Vinschen wrote:
-- Subject: Re: [Fwd: 1.5.11-1: sftp performance problem]
>
> http://cygwin.com/acronyms/#PCYMTNQREAIYR

Sorry ... done.

> | One really annoying consequence of socketpairs for sshd is that
> | Windows-native (i.e. non-Cygwin) programs don't know how to write
> | directly to sockets on stdout (or stderr), so if you try to use
> | them via ssh, their output silently disappears.
> 
> Oh lord!  I tried it with `net', `ping' and `nslookup', which are roughly
> the only Windows applications I use on the command line, and all three
> have no problems.  I'm wondering how the above can happen since the
> interactive application side is running in a PTY (which *is* a pipe),
> not on socketpairs.

Try it without a pty:

    ssh cygwin-system-with-sshd-using-sockpairs "win32-native-command"

vs.

    ssh cygwin-system-with-sshd-using-sockpairs "win32-native-command | cat"

> | I think OpenSSH uses pipes on most platforms by default, so I'm also
> 
> Only on those platforms which have known problems with (or no implementation
> of) socketpairs.

OK, maybe I am misremembering, or the default changed ages ago.
I see that sshd on Linux uses socketpairs.

> | somewhat concerned that the socketpair-specific code in OpenSSH might be
> | a bit crufty.
> 
> Why?  Socketpairs are in the same shape as any other socket connection
> since they are using the same code.  And I surely do care for socket
> operations.  See the ChangeLogs.  What especially do you think is "crufty"?
>
-- End of excerpt from Corinna Vinschen

My concern was about the state of the OpenSSH code base, not Cygwin, and
it was just a vague fear, based on the previous (I guess now incorrect)
[mis]understanding that OpenSSH prefers to use pipes.

> | It's not obvious to me why socketpairs would be inherently faster
> | than pipes.

It occurred to me after I wrote this that if no pipes were used at all,
then the select_pipe thread would not be spawned ... the select_socket
thread would handle everything.  This might be win, but we'd need to
measure to see if the effect is significant.

And we'd still have the problem with win32-native apps, which I think
is a show-stopper for socketpairs.

--
Bob
