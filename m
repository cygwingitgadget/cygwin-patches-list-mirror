Return-Path: <cygwin-patches-return-2056-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 28918 invoked by alias); 15 Apr 2002 12:17:56 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 28880 invoked from network); 15 Apr 2002 12:17:45 -0000
Date: Mon, 15 Apr 2002 05:17:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Workaround patch for MS CLOSE_WAIT bug
Message-ID: <20020415141743.N29277@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20020414152944.007ec460@mail.attbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20020414152944.007ec460@mail.attbi.com>
User-Agent: Mutt/1.3.22.1i
X-SW-Source: 2002-q2/txt/msg00040.txt.bz2

On Sun, Apr 14, 2002 at 03:29:44PM -0400, Pierre A. Humblet wrote:
> Fixing the application
> **********************
> To keep sock open in the parent, the ported application 
> structure can be changed to:
> 
> int oldsocks[2^32];  /* I'll be smarter */
> sock = socket()     (1)
> bind(sock)
> listen(sock)
> while (1) {
>  select()
>  newsock = accept(sock)
>  pid = fork()
>  if (pid == 0) { 
>     close(sock)     (2)
>     child works 
>  }
>  if (pid > 0) {
>     oldsocks[pid] = newsock
>                  <= (3)
>  }
> }
> sigchild_handler()
> { 
>   pid = waitpid()
>   close(oldsocks[pid]) (4)
> }

Your patch looks good.  What I didn't quite get is, how the above
code now looks like (ideally) when using the new FD_SETCF functionality.
Could you write a short example?  If inetd (what about sshd?) could
benefit, I'd like to see how to do it.  Btw., the sources are in the
inetutils-1.3.2-17-src.tar.bz2 file, obviously, which you can get
by using setup.exe.

> Problems with duplicate LISTEN have also been reported
> by me and others
> http://sources.redhat.com/ml/cygwin/2002-01/msg01579.html
> http://sources.redhat.com/ml/cygwin/2002-04/msg00515.html
> No progress there, it's mind boggling. My problem occurs 
> only when the server re-execs itself while a child is 
> running. "close on fork" doesn't seem to help.

That's a pity.  I have no idea what the cause for that is.  As Chris
noted, there's a listening socket created in start_thread_socket()
in select.cc but from all I can see it's closed correctly when it's
not used anymore.

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
