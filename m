Return-Path: <cygwin-patches-return-4996-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 27842 invoked by alias); 24 Sep 2004 18:07:04 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 27643 invoked from network); 24 Sep 2004 18:07:03 -0000
Message-ID: <4154623B.13A72BF7@phumblet.no-ip.org>
Date: Fri, 24 Sep 2004 18:07:00 -0000
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Reply-To: pierre.humblet@ieee.org
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Fake POSIX behaviour in seteuid/setegid
References: <20040923162537.GA944@cygbert.vinschen.de> <3.0.5.32.20040923223513.0082d3f0@incoming.verizon.net> <20040924080750.GA9050@cygbert.vinschen.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-SW-Source: 2004-q3/txt/msg00148.txt.bz2


Corinna Vinschen wrote:
> 
> Hi Pierre,
> 
> On Sep 23 22:35, Pierre A. Humblet wrote:
> > At 06:25 PM 9/23/2004 +0200, Corinna Vinschen wrote:
> > >[about security fake]
> > The patch does what you describe. The gid patch does not allow privileged
> > users to change the gids any way they want, which is unusual.
> 
> Hmm, well, yes.  Changing the gid should be possible as often as you like
> as long as your real or effective uid is equal to the original uid.
> So, if we follow this through, the test in gid should check for the uid,
> not the gid.  That would come closer, wouldn't it?

Yes.

> > What surprised me is that OpenSSH takes the trouble to check if reversion is
> > impossible, although it's the standard POSIX behavior (well, not quite. POSIX
> > mentions "appropriate privileges" of the process). There must be cases where
> > it can be a problem. I assume it's not risky in Cygwin, because there will
> > soon be an exec that will insure security.
> 
> Note that this code is not only in portable OpenSSH, but also in the
> stock OpenBSD version!
> 
> OpenSSH == paranoia :-)
> 
> > Given that there might be issues, I think it's not good practice to mask the
> > real behavior when programs try to find what it is.
> 
> ACK.
> 
> Actually it was a team member of the OpenSSH team who asked me in PM,
> what stops Cygwin to enforce this.  The argumentation was based on
> portability, not on security.

Providing a --without-paranoia configuration switch would enhance the
portability of OpenSSH, without instilling a false sense of security 
by introducing artificial blocking measures in Cygwin.
 
> I'm also not entirely convinced that this step is really going into
> the right direction.  But I thin we should look on both sides of the
> medal :-)
> 
> > Let me sleep on this!

Implementing the idea would break exim. When it is started by a non-system
privileged user (e.g. on Win2003), exim setuids to SYSTEM. The advantage
is that it is a known sid, and all files are setup in advance to be
accessible by that sid.
Your improved idea where we consider the privilege level of the new uid
would solve that issue.
However if the "exim" user exists, exim setuids to that instead (the
files permissions must have been setup appropriately). It thus runs with
a non-privileged thread token, while still being able to setuid to another
user when doing a local delivery (this mimics what happens on a real Unix,
where it execs a suid copy of itself to do the local delivery).
That wouldn't work anymore, but I doubt that it's much used.
 
Considering that you have already done the work of patching OpenSSH, I
would keep this idea on the back burner until there is a second case of
an application that would benefit from something like it. We can then
reconsider.

Pierre
