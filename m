Return-Path: <cygwin-patches-return-2058-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 25536 invoked by alias); 15 Apr 2002 14:28:15 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 25493 invoked from network); 15 Apr 2002 14:28:11 -0000
Date: Mon, 15 Apr 2002 07:28:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygpatch <cygwin-patches@cygwin.com>
Subject: Re: Workaround patch for MS CLOSE_WAIT bug
Message-ID: <20020415162809.P29277@cygbert.vinschen.de>
Mail-Followup-To: cygpatch <cygwin-patches@cygwin.com>
References: <3.0.5.32.20020414152944.007ec460@mail.attbi.com> <20020415141743.N29277@cygbert.vinschen.de> <3CBADAE5.92A542FE@ieee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3CBADAE5.92A542FE@ieee.org>
User-Agent: Mutt/1.3.22.1i
X-SW-Source: 2002-q2/txt/msg00042.txt.bz2

On Mon, Apr 15, 2002 at 09:51:33AM -0400, Pierre A. Humblet wrote:
> Corinna Vinschen wrote:
> > 
> > Your patch looks good. What I didn't quite get is, how the
> > code now looks like (ideally) when using the new FD_SETCF 
> > functionality.
> 
> See 4 lines below not starting with > > 
> > > int oldsocks[2^32];  /* I'll be smarter */
> > > sock = socket()     
> fcntl(sock, F_SETCF, 0)  (1)
> > > bind(sock)
> > > listen(sock)
> > > while (1) {
> > >  select()
> > >  newsock = accept(sock)
> > >  pid = fork()
> > >  if (pid == 0) {
> /*    close(sock)   */   (2)
> > >     child works
> > >  }
> > >  if (pid > 0) {
> > >     oldsocks[pid] = newsock
> fcntl(newsock, F_SETCF, 0) (3)
> > >  }
> > > }
> > > sigchild_handler()
> > > {
> > >   pid = waitpid()
> shutdown(oldsocks[pid], 2) (4)
> > >   close(oldsocks[pid]) 

Sorry if I'm dense but... shouldn't the new FD_SETCF functionality
allow to do the "right thing" without adding the oldsocks variable
at all?!?  You wrote about the disadvantage that the child inherits
that array...

> By the way, is it safe to call shutdown() & close() directly
> from a handler?

It should.

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
