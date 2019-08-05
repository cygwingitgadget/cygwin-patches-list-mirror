Return-Path: <cygwin-patches-return-9544-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 40898 invoked by alias); 5 Aug 2019 05:04:32 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 40889 invoked by uid 89); 5 Aug 2019 05:04:32 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-2.6 required=5.0 tests=AWL,BAYES_00 autolearn=ham version=3.3.1 spammy=2nd, para
X-HELO: m0.truegem.net
Received: from m0.truegem.net (HELO m0.truegem.net) (69.55.228.47) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 05 Aug 2019 05:04:30 +0000
Received: from localhost (mark@localhost)	by m0.truegem.net (8.12.11/8.12.11) with ESMTP id x7554Tal022963	for <cygwin-patches@cygwin.com>; Sun, 4 Aug 2019 22:04:29 -0700 (PDT)	(envelope-from mark@maxrnd.com)
Date: Mon, 05 Aug 2019 05:04:00 -0000
From: Mark Geisert <mark@maxrnd.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] Cygwin: Implement CPU_SET(3) macros
In-Reply-To: <20190804224546.59957-1-mark@maxrnd.com>
Message-ID: <Pine.BSF.4.63.1908042159540.22298@m0.truegem.net>
References: <20190730121212.GV11632@calimero.vinschen.de> <20190804224546.59957-1-mark@maxrnd.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-IsSubscribed: yes
X-SW-Source: 2019-q3/txt/msg00064.txt.bz2

Sorry for the repetition...

On Sun, 4 Aug 2019, Mark Geisert wrote:
> This patch supplies an implementation of the CPU_SET(3) processor
> affinity macros as documented on the relevant Linux man page.
>
> There is a different implementation of cpusets under libc/sys/RTEMS that
> has FreeBSD compatibility and is built on top of FreeBSD bitsets.  This
> implementation can be combined with that one if necessary in the future.

If the 2nd para is to be kept, please adjust it to read as follows:

There is a mostly superset implementation of cpusets under newlib's
libc/sys/RTEMS/include/sys that has Linux and FreeBSD compatibility
and is built on top of FreeBSD bitsets.  This Cygwin implementation
and the RTEMS one could be combined if desired at some future point.

Thanks,

..mark
