Return-Path: <cygwin-patches-return-2412-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 10485 invoked by alias); 13 Jun 2002 14:03:40 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 10455 invoked from network); 13 Jun 2002 14:03:38 -0000
Date: Thu, 13 Jun 2002 07:03:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Reorganizing internal_getlogin()
Message-ID: <20020613160337.K30892@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20020609231253.008044d0@mail.attbi.com> <20020610035228.GC6201@redhat.com> <20020610111359.R30892@cygbert.vinschen.de> <20020610151016.GG6201@redhat.com> <3D04C62B.E7804DC0@ieee.org> <20020611022812.GA30113@redhat.com> <20020612053233.GA21398@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020612053233.GA21398@redhat.com>
User-Agent: Mutt/1.3.22.1i
X-SW-Source: 2002-q2/txt/msg00395.txt.bz2

On Wed, Jun 12, 2002 at 01:32:33AM -0400, Chris Faylor wrote:
> I tried to keep most of the logic the same but a couple of things
> bothered me in internal_getlogin.  They were probably there for a
> good reason, but I changed them anyway.

Yeah, it doesn't work currently.

> One thing that I changed was to not query for a user name if you've
> already gotten the user name from GetUserName.  I also changed the HOME

This isn't correct since GetUserName() returns the old username after
impersonating another user so it returns a value but it's incorrect.
Therefore we can't rely on that value in NT.  It's just used for 9x
and it's used in NT to get a string for debug_printf.

However, ssh/sshd are still not working.  I fixed a stack corruption
problem in cygheap already but I still can't start sshd as service
and trying to login using sshd running on CLI doesn't work, too.

I'm looking into finding the other problem.  It's probably another
stack corruption problem.

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
