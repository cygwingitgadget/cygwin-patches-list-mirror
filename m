Return-Path: <cygwin-patches-return-4992-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 24095 invoked by alias); 24 Sep 2004 02:39:39 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 24074 invoked from network); 24 Sep 2004 02:39:37 -0000
Message-Id: <3.0.5.32.20040923223513.0082d3f0@incoming.verizon.net>
X-Sender: vze1u1tg@incoming.verizon.net (Unverified)
Date: Fri, 24 Sep 2004 02:39:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Subject: Re: [PATCH] Fake POSIX behaviour in seteuid/setegid
In-Reply-To: <20040923162537.GA944@cygbert.vinschen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-SW-Source: 2004-q3/txt/msg00144.txt.bz2

At 06:25 PM 9/23/2004 +0200, Corinna Vinschen wrote:
>Hi folks,
>especially Pierre,
>
>I'm thinking of applying the below patch.  The idea is that an application
>which has changed real as well as effective id to values different from
>the saved (==original) id has no way to restore its old identity.
>
>That's obviously not correct from a Windows NT point of view, but this
>is a start to mimic the expected behaviour under POSIX.  For example
>OpenSSH's sshd calls seteuid/setuid to change to an unprivileged user
>and then it calls seteuid and setuid again, to test if it's possible
>to revert the identity to root.  If so, it exists with error.  Same for
>the gid.  The Cygwin version of OpenSSH currently disables these tests,
>but it might be a good idea to fake POSIXy behaviour from a portability
>point of view.
>
>Any thoughts appreciated.  I'd be interested if there's some serious
>reason not to do this at all, or if there's a better way to do this.
>One caveat of my patch is that changing from one privileged account to
>another privileged account disables changing uids, even though the
>second account would also have this right.  Perhaps the tests should
>be coupled with a check, whether the current effective uid has the
>appropriate permissions or not.  I'm also suspecting that the gid
>test is not far away from a total error in reasoning...
>


Corinna,

The patch does what you describe. The gid patch does not allow privileged
users to change the gids any way they want, which is unusual.

What surprised me is that OpenSSH takes the trouble to check if reversion is
impossible, although it's the standard POSIX behavior (well, not quite. POSIX
mentions "appropriate privileges" of the process). There must be cases where
it can be a problem. I assume it's not risky in Cygwin, because there will 
soon be an exec that will insure security.

Given that there might be issues, I think it's not good practice to mask the
real behavior when programs try to find what it is.
The more so when it comes to security.
I'd rather let the porter look at the issue and decide what's reasonable
for a given program on a given platform, as you did.

Let me sleep on this!

Pierre

