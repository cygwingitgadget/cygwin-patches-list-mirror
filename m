Return-Path: <cygwin-patches-return-2901-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 23358 invoked by alias); 31 Aug 2002 03:38:56 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 23339 invoked from network); 31 Aug 2002 03:38:56 -0000
Date: Fri, 30 Aug 2002 20:38:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: [franck.leray@cheops.fr: tcsetattr timeout problem ?]
Message-ID: <20020831033855.GA18122@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20020830145541.GB1402@redhat.com> <136198673817.20020830214611@logos-m.ru> <5199249725.20020830215547@logos-m.ru> <147200259187.20020830221236@logos-m.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <147200259187.20020830221236@logos-m.ru>
User-Agent: Mutt/1.3.23.1i
X-SW-Source: 2002-q3/txt/msg00349.txt.bz2

On Fri, Aug 30, 2002 at 10:12:36PM +0400, egor duda wrote:
>ed> Actually, the patch is wrong :(. I'm looking into it and post a
>ed> correct one asap.
>
>Forgot to include fhandler_tty.cc part.
>
>Please check it if possible and feel free to apply it, as i will be
>away from computer for some time.

I took a look at your patch but it didn't seem right to me.

You were asking about circumventing the 'ready_for_read' code and,
since fhandler_tty_slave::read has the ability to detect a signal,
removal of fhandler_tty_slave::ready_for_read is the right way to
go, AFAICT.  So, I did that.

That meant that I just had to get rid of the

  if (vmin == 0)
    time_to_wait == INFINITE

lines in fhandler_tty::ready_for_read, for things to work correctly.
I wrote a test program and it worked the same way on linux and
cygwin after my patch.

Thanks for looking into this.

cgf
