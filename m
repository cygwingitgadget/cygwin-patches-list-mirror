Return-Path: <cygwin-patches-return-2057-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 8936 invoked by alias); 15 Apr 2002 13:48:27 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 8922 invoked from network); 15 Apr 2002 13:48:27 -0000
Message-ID: <3CBADAE5.92A542FE@ieee.org>
Date: Mon, 15 Apr 2002 06:48:00 -0000
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
X-Accept-Language: en,pdf
MIME-Version: 1.0
To: Corinna Vinschen <cygwin-patches@cygwin.com>
Subject: Re: Workaround patch for MS CLOSE_WAIT bug
References: <3.0.5.32.20020414152944.007ec460@mail.attbi.com> <20020415141743.N29277@cygbert.vinschen.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-SW-Source: 2002-q2/txt/msg00041.txt.bz2

Corinna Vinschen wrote:
> 
> Your patch looks good. What I didn't quite get is, how the
> code now looks like (ideally) when using the new FD_SETCF 
> functionality.

See 4 lines below not starting with > > 
> > int oldsocks[2^32];  /* I'll be smarter */
> > sock = socket()     
fcntl(sock, F_SETCF, 0)  (1)
> > bind(sock)
> > listen(sock)
> > while (1) {
> >  select()
> >  newsock = accept(sock)
> >  pid = fork()
> >  if (pid == 0) {
/*    close(sock)   */   (2)
> >     child works
> >  }
> >  if (pid > 0) {
> >     oldsocks[pid] = newsock
fcntl(newsock, F_SETCF, 0) (3)
> >  }
> > }
> > sigchild_handler()
> > {
> >   pid = waitpid()
shutdown(oldsocks[pid], 2) (4)
> >   close(oldsocks[pid]) 
> > }
> Could you write a short example?  If inetd (what about sshd?) could
> benefit, I'd like to see how to do it.  Btw., the sources are in the
> inetutils-1.3.2-17-src.tar.bz2 file, obviously, which you can get
> by using setup.exe.
Silly me. I got fooled by the n/a[available?/applicable?] acronym
in setup. OK, I'll look at it in the coming days.
By the way, is it safe to call shutdown() & close() directly
from a handler?

Pierre
