Return-Path: <cygwin-patches-return-1893-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 29811 invoked by alias); 25 Feb 2002 17:15:04 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 29748 invoked from network); 25 Feb 2002 17:15:02 -0000
Date: Mon, 25 Feb 2002 10:01:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: Christian LESTRADE <christian.lestrade@free.fr>
Cc: cygwin-patches@cygwin.com, bub@io.com
Subject: Re: Terminal input processing fix
Message-ID: <20020225181453.A29036@cygbert.vinschen.de>
Mail-Followup-To: Christian LESTRADE <christian.lestrade@free.fr>,
	cygwin-patches@cygwin.com, bub@io.com
References: <4.3.2.7.2.20020118224857.00aa3720@mail.oreka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4.3.2.7.2.20020118224857.00aa3720@mail.oreka.com>
User-Agent: Mutt/1.3.22.1i
X-SW-Source: 2002-q1/txt/msg00250.txt.bz2

On Fri, Jan 18, 2002 at 10:59:10PM +0100, Christian LESTRADE wrote:
> Hello,
> 
> I would like to submit the following bugfix for theses bugs which appear
> mainly when using rxvt:
> 
> * Unable to effectively disable c_cc[] input chars processing (like ^C) 
> using
>   $ stty intr '^-'
>   When I type CTRL-SPACE, I enter a NULL char which is interpreted like ^C
> 
> * In raw mode (stty -icanon), the VDISCARD key (^O) should not be 
> recognized,
>   but should be passed to the application

Hi Christian,

your assignment *finally* arrived.

So we could go ahead and apply your patch but... actually I would like
to ask you to change it.  The reason is that the _POSIX_VDISABLE
constant is typically defined in some header file in /usr/include.  As
is the functionality of CC_EQUAL which is called CCEQ, at least in Linux.

So what I'd like you to ask is, could you tweak your patch so that these
macros are defined in some appropriate header files, e.g. sys/termios.h?

I'm looking forward,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
