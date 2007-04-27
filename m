Return-Path: <cygwin-patches-return-6076-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 20495 invoked by alias); 27 Apr 2007 06:20:29 -0000
Received: (qmail 20484 invoked by uid 22791); 27 Apr 2007 06:20:28 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.31.1) with ESMTP; Fri, 27 Apr 2007 07:20:25 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id 8EF1E6D4803; Fri, 27 Apr 2007 08:20:22 +0200 (CEST)
Date: Fri, 27 Apr 2007 06:20:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Dumper produces unuseable dumps (fix).
Message-ID: <20070427062022.GC4978@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <46310D90.8050703@portugalmail.pt>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46310D90.8050703@portugalmail.pt>
User-Agent: Mutt/1.4.2.2i
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2007-q2/txt/msg00022.txt.bz2

Hi Pedro,

On Apr 26 21:37, Pedro Alves wrote:
> Hi guys,
> 
> I noticed that dumper isn't working for me, silently exiting
> without producing a dump, so I tried building it from source.
> The problem was that the bfd_set_arch_mach (core_bfd, bfd_arch_i386, 0)
> call was failing.  I couldn't debug it, since it was linked
> into the system /usr/lib/libbfd.a, which doesn't come with
> debug info.  I then tried to link with with a cvs bfd, and that
> problem goes away.
> 
> But, I then found out that gdb wasn't reading the dumps.  After
> some investigation, I found that the core file is built with
> section headers, and no program headers.  Since it is
> bfd_make_section_from_phdr that makes the magic sections that
> gdb reads from, the current dumper makes useless core dumps.
> [...]
> The attached patch fixes it by programatically making a
> phdr for each section.  I now get readable dumps.
> [...]
> Could this fix be considered for inclusion, please?

Thanks for this patch.

Unfortunately, the patch is too big to fall under the trivial patch
rule, so Red Hat needs a signed copyright assignment from you.
Please have a look on http://cygwin.com/contrib.html, especially the
"Before you get started" section, which has a link to the assignment
form.  As soon as we got the signed form from you, the patch can go
in.


Thanks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
