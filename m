Return-Path: <cygwin-patches-return-3902-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 28785 invoked by alias); 26 May 2003 15:38:00 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 26343 invoked from network); 26 May 2003 15:36:40 -0000
Message-ID: <008f01c3239c$63fc3810$c800a8c0@docbill>
From: "Bill C Riemers" <cygwin@docbill.net>
To: "Corinna Vinschen" <cygwin-patches@cygwin.com>
References: <053f01c3216e$947cc570$6400a8c0@FoxtrotTech0001> <20030524175530.GB5604@redhat.com> <20030524202421.GE19367@cygbert.vinschen.de> <00d501c322f9$ad228e70$6400a8c0@FoxtrotTech0001> <20030526080817.GA5976@cygbert.vinschen.de>
Subject: Re: Proposed change for Win9x file permissions...
Date: Mon, 26 May 2003 15:38:00 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
X-SW-Source: 2003-q2/txt/msg00129.txt.bz2

I'm not saying there won't be problems if someone using this patch does something like:
    umask 777

I'm just saying it is a recoverable mistake.  The umask local to the current process at it's children only.  Executables should
still execute, but scripts probably won't.  However, just changing the umask back to something more reasonable recovers the file
permissions.  So even the person who edits the change into their .profile or /etc/profile will be able to restore the previous
value.

As I said, a better patch would be to modify the "mount" command to use a "umask" for each mounted file system.  But I wanted to
keep the change minimal, since I can not really test Win9x systems.

                                                   Bill

----- Original Message ----- 
From: "Corinna Vinschen" <cygwin-patches@cygwin.com>
To: <cygwin-patches@cygwin.com>
Sent: Monday, May 26, 2003 4:08 AM
Subject: Re: Proposed change for Win9x file permissions...


> On Sun, May 25, 2003 at 04:10:10PM -0400, Bill C. Riemers wrote:
> >
> > > I like the idea as well but wouldn't that eventually cause problems if
> > > the umask disables the user bits?  I'm a bit concerned about the new
> > > arriving questions on the cygwin ML due to applications checking these
> > > bits in combination with clueless users.  It would be better, IMHO, if
> > > the umask couldn't mask the user bits at all, just the group and other
> > > bits.
> >
> > I seriously doubt it would result in serious problem, since the patch only
> > changes the file permissions that are visible via a "stat()" command, not
> > the actual permissions that Windows will use.  Case and point:  /cygdrive/c
> > shows up with perms 000 under cygwin, but there are not any serious
> > consequences of that bug, other than user confusion.
>
> What I mean are applications calling stat and getting permissions back
> which they don't like.  E.g. a shell which checks the permissions and
> refuses to run a script because it's not executable.
>
> Corinna
>
> -- 
> Corinna Vinschen                  Please, send mails regarding Cygwin to
> Cygwin Developer                                mailto:cygwin@cygwin.com
> Red Hat, Inc.
>

