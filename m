Return-Path: <cygwin-patches-return-7724-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 9130 invoked by alias); 17 Oct 2012 16:38:14 -0000
Received: (qmail 7830 invoked by uid 22791); 17 Oct 2012 16:37:58 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)    by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Wed, 17 Oct 2012 16:37:51 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id D51682C0469; Wed, 17 Oct 2012 18:37:48 +0200 (CEST)
Date: Wed, 17 Oct 2012 16:38:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [patch]: Decouple cygwin building from in-tree mingw/w32api building
Message-ID: <20121017163748.GC10578@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <CAEwic4ZBrjVPDV1Y3tc6r7baGzxNbrjgj1MUgse6zYSMHiCUhQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAEwic4ZBrjVPDV1Y3tc6r7baGzxNbrjgj1MUgse6zYSMHiCUhQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2012-q4/txt/msg00001.txt.bz2

Hi Kai,

On Oct 17 18:13, Kai Tietz wrote:
> Hello everybody,
> 
> This patch modifies the bits of build-process so that cygwin and mingw
> building is decoupled from each other.
> Additionally the patch decouples cygwin's build from the w32api of mingw.org.
> By this change it is now possible to build cygwin (and utilities) with
> mingw.org's and mingw-w64's psdk and compilers.  Later are necessary
> to build cygwin's native utils, which have not to depend on
> cygwin1.dll.
> These changes are also necessary for having 64-bit build support in
> future. By this reason the mingw-script in utils/ had to learn about
> the host's architecture and about how to search for an installed
> mingw-toolchain for given architecture.  As Corinna told me that
> cygwin wants to use in question the -w64- mingw-environment, this
> script is searching first for -w64- based toolchain.  On second
> attempt it searches for any mingw triplet for given architecture.

obviously I know your patch since I tested it already (and even
accidentally checked in parts of it into the 64bit branch), so I know it
works.  However, your patch submission is broken due to wrong
line-breaks.  Can you please resend the patch, if you don't trust your
MUA, maybe better as text/plain attachment?

Oh and, btw., in the Cygwin ChangeLogs we tend to use up to 80 chars
per line.  That's not a big problem, I just want you to know for future
patch submissions.


Thanks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
