Return-Path: <cygwin-patches-return-2496-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 3876 invoked by alias); 23 Jun 2002 14:01:06 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 3837 invoked from network); 23 Jun 2002 14:00:57 -0000
Message-ID: <06b601c21abe$9e7d10a0$6132bc3e@BABEL>
From: "Conrad Scott" <Conrad.Scott@dsl.pipex.com>
To: "Robert Collins" <robert.collins@syncretize.net>
Cc: <cygwin-patches@cygwin.com>
References: <000601c21a8b$bd8324e0$0200a8c0@lifelesswks> <062501c21a99$47da4300$6132bc3e@BABEL> <002901c21aa7$eb2ab360$1800a8c0@LAPTOP>
Subject: Re: Resubmission of cygwin_daemon patch.
Date: Sun, 23 Jun 2002 10:40:00 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-SW-Source: 2002-q2/txt/msg00479.txt.bz2

"Robert Collins" <robert.collins@syncretize.net> wrote:
> From: "Conrad Scott" <Conrad.Scott@dsl.pipex.com>
> > About instance detection: you're right that something better could
be
> > done here. What I've ended up with is really a security patch:
it's
> > possible for another process to create an instance of a named
pipe,
> > wait for clients to connect and then impersonate them.
>
> It will always be possible to do that. Anyone can build the
cygserver and
> insert hostile code into their build. Code interception is a
standard
> technique for reverse engineering, runtime patching and the like.

No: the problem is that someone without privileges on a machine could
create a server that listens on that named pipe and then wait for
other (more privileged) clients to connect to their "server", so that
they could impersonate them and then do what they want with the
privileges. There's code lying around on the internet to do exactly
this: it creates an instance of a named pipe and listens for
connections, then impersonates the client and launches a shell or
whatever else you want. If the cygserver itself were to connect to
such a fake server it would be giving it a chance to impersonate a
privileged process. Unclever. The usual case is if the attacker can
race the server to create the first pipe instance: since cygserver
will start as a system process of some kind, it ought to be up and
running before anything has a chance to run, so that's less likely as
an attack.

> In terms of preventing someone hostilely opening the same
socket/pipe, I'd
> have thought windows prevented multiple listening pipes with the
same
> name.

The idea is that multiple listening pipes *are* created, usually by
multiple threads in the same process (tho' this isn't quite what
cygserver does). You've got to control the rights on the pipe to avoid
other people also creating instances of the same pipe (as I understand
it: I've read the references but I've not tried it). Actually, since
cygserver will run as a privileged process, unprivileged processes may
not have enough privilege to create such duplicates anyhow, but there
is a particular privilege that cygserver ought to exclude on creating
the named pipe to deny other processes also creating pipe instances.
Again, there are exploits on the web for this. And a whole sequence of
MS security patches for, e.g., telnet, where they got it wrong. This
is why the new file flag got added, as before that it was impossible
for a server to protect itself against some of these attacks.

Cheers for the moment,

// Conrad


