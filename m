Return-Path: <cygwin-patches-return-6348-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 23123 invoked by alias); 5 Aug 2008 14:35:55 -0000
Received: (qmail 23110 invoked by uid 22791); 5 Aug 2008 14:35:53 -0000
X-Spam-Check-By: sourceware.org
Received: from pool-72-74-94-104.bstnma.fios.verizon.net (HELO ednor.cgf.cx) (72.74.94.104)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Tue, 05 Aug 2008 14:35:18 +0000
Received: by ednor.cgf.cx (Postfix, from userid 201) 	id C2AB94930AA; Tue,  5 Aug 2008 10:35:16 -0400 (EDT)
Date: Tue, 05 Aug 2008 14:35:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] fix profiling
Message-ID: <20080805143516.GA10807@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4897E0E8.AB669CAC@dessent.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4897E0E8.AB669CAC@dessent.net>
User-Agent: Mutt/1.5.16 (2007-06-09)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2008-q3/txt/msg00011.txt.bz2

On Mon, Aug 04, 2008 at 10:11:04PM -0700, Brian Dessent wrote:
>2008-08-04  Brian Dessent
>
>	* config/i386/profile.h (mcount): Mark asms volatile.

Go ahead and check this in and I'll roll a new release.

Please use your best judgement about the +r/=r thing given Dave's
comments.

cgf
