Return-Path: <cygwin-patches-return-2874-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 4322 invoked by alias); 28 Aug 2002 10:37:45 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 4255 invoked from network); 28 Aug 2002 10:37:44 -0000
Date: Wed, 28 Aug 2002 03:37:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Readv/writev patch
Message-ID: <20020828123735.B10870@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <01aa01c24dda$cc5384b0$6132bc3e@BABEL>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01aa01c24dda$cc5384b0$6132bc3e@BABEL>
User-Agent: Mutt/1.3.22.1i
X-SW-Source: 2002-q3/txt/msg00322.txt.bz2

On Tue, Aug 27, 2002 at 04:02:43PM +0100, Conrad Scott wrote:
> I've tried to reduce the size of the patch by sending in some
> unrelated parts over the last couple of days but I realize that
> this is still quite large.  If you'ld like me to split the patch
> up (e.g. into the base fhandler part and the socket part), give me
> a call and I'll see if I can find the energy to do so; London's

Yes, please.  Especially I'm reluctant to introduce your changes
to the sendto and recvfrom implementation since I know there is
a good reason to use the WinSock1 calls in the non-blocking case
even though I don't recall why, right now.  Please skip that
beautyifing patches and just add the readv/writev functionality.

I've just checked in a patch which adds SIGPIPE handling to
sendto().  I'd appreciate if you could take this into account.

I also don't like these C++ cast operators since the Plain-C casts
are doing quite the same but are way easier to read.  Perhaps I'm
just old-fashioned.

And as you said, I think it would be wise to split the fhandler_base
from the fhandler_socket part.

Other than that it looks like a good patch.

Thanks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
