Return-Path: <cygwin-patches-return-3898-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 9428 invoked by alias); 26 May 2003 08:08:19 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 9397 invoked from network); 26 May 2003 08:08:19 -0000
Date: Mon, 26 May 2003 08:08:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Proposed change for Win9x file permissions...
Message-ID: <20030526080817.GA5976@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <053f01c3216e$947cc570$6400a8c0@FoxtrotTech0001> <20030524175530.GB5604@redhat.com> <20030524202421.GE19367@cygbert.vinschen.de> <00d501c322f9$ad228e70$6400a8c0@FoxtrotTech0001>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00d501c322f9$ad228e70$6400a8c0@FoxtrotTech0001>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q2/txt/msg00125.txt.bz2

On Sun, May 25, 2003 at 04:10:10PM -0400, Bill C. Riemers wrote:
> 
> > I like the idea as well but wouldn't that eventually cause problems if
> > the umask disables the user bits?  I'm a bit concerned about the new
> > arriving questions on the cygwin ML due to applications checking these
> > bits in combination with clueless users.  It would be better, IMHO, if
> > the umask couldn't mask the user bits at all, just the group and other
> > bits.
> 
> I seriously doubt it would result in serious problem, since the patch only
> changes the file permissions that are visible via a "stat()" command, not
> the actual permissions that Windows will use.  Case and point:  /cygdrive/c
> shows up with perms 000 under cygwin, but there are not any serious
> consequences of that bug, other than user confusion.

What I mean are applications calling stat and getting permissions back
which they don't like.  E.g. a shell which checks the permissions and
refuses to run a script because it's not executable.

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
