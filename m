Return-Path: <cygwin-patches-return-3248-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 7599 invoked by alias); 30 Nov 2002 22:25:26 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 7590 invoked from network); 30 Nov 2002 22:25:25 -0000
Date: Sat, 30 Nov 2002 14:25:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] fhandler_tty read_retval fix
Message-ID: <20021130222603.GB29907@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20021129200410.A20532@eris.io.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021129200410.A20532@eris.io.com>
User-Agent: Mutt/1.5.1i
X-SW-Source: 2002-q4/txt/msg00199.txt.bz2

On Fri, Nov 29, 2002 at 08:04:10PM -0600, Steve O wrote:
>This patch fixes a premature EOF if the tty_slave happens to 
>read read_retval as the pty_master is executing accept_input. 

I think this one needs at least three years of testing before it
can go in.

.
.
.

Just kidding.  :-)

Applied.
Thanks,
cgf

P.S.  Btw, did you notice that the return value for accept_input
is not being used, AFAICT?  I had always wanted to do something
with that but it never seemed to be necessary.

>ChangeLog entry
>2002-11-29 Steve O <bub@io.com>
>
>	* fhandler_tty.cc (fhandler_pty_master::accept_input): Moved
>	  read_retval assignment to prevent race condition.  Removed
>	  read_retval from return statement.
