Return-Path: <cygwin-patches-return-2139-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 11813 invoked by alias); 2 May 2002 15:31:16 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 11794 invoked from network); 2 May 2002 15:31:13 -0000
Date: Thu, 02 May 2002 08:31:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygpatch <cygwin-patches@cygwin.com>
Subject: Re: SSH -R problem
Message-ID: <20020502173110.A15039@cygbert.vinschen.de>
Mail-Followup-To: cygpatch <cygwin-patches@cygwin.com>
References: <3.0.5.32.20020429205809.007f2920@mail.attbi.com> <3.0.5.32.20020429205809.007f2920@mail.attbi.com> <3.0.5.32.20020430073223.007e3e00@mail.attbi.com> <20020430142039.D1214@cygbert.vinschen.de> <3CCEA638.E357EFE2@ieee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3CCEA638.E357EFE2@ieee.org>
User-Agent: Mutt/1.3.22.1i
X-SW-Source: 2002-q2/txt/msg00123.txt.bz2

On Tue, Apr 30, 2002 at 10:12:08AM -0400, Pierre A. Humblet wrote:
> Corinna Vinschen wrote:
> > 
> > That makes sense... but doesn't that again break something else?
> 
> What it might break is the case for which linger was added in the first 
> place, i.e. processes terminating and Windows flushing their outgoing 
> packet queue (in the case of slow connections), as opposed to Unix, 
> which maintains the queue for a while after process termination.
> [...]
> Short of something like this we are between a rock and a hard place.
> I would think that applications that go to the trouble of setting the
> socket to non-blocking care more about not blocking than about potentially
> dropping packets at the end of their life.

The really ugly situation is that even a non-blocking connection
oriented socket (tcp) is expected to behave reliable.  That means
it shouldn't drop packets near the end of it's life time unless
it's absolutely necessary (e. g.  a defined connection timeout).
Did I say that I hate Winsock?

I'd propose to try it first as I said in my previous mail:

   if nonblocking
     set to blocking
   set linger to 2MSL
   closesocket

The nice thing is that nobody holds us from experimenting with that.
If we find that it more hurts than helps we could do a hard close
for nonblocking sockets as you proposed.

Would that be ok with you?

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
