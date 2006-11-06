Return-Path: <cygwin-patches-return-5992-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 26048 invoked by alias); 6 Nov 2006 16:31:17 -0000
Received: (qmail 26037 invoked by uid 22791); 6 Nov 2006 16:31:16 -0000
X-Spam-Check-By: sourceware.org
Received: from pool-71-248-179-54.bstnma.fios.verizon.net (HELO cgf.cx) (71.248.179.54)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Mon, 06 Nov 2006 16:31:09 +0000
Received: by cgf.cx (Postfix, from userid 201) 	id CA04D13D3C7; Mon,  6 Nov 2006 11:31:07 -0500 (EST)
Date: Mon, 06 Nov 2006 16:31:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com, "Loh, Joe" <joel@pivot3.com>
Subject: Re: Missing DEV_SD1_MAJOR in dtable.cc
Message-ID: <20061106163107.GB7471@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com, "Loh, Joe" <joel@pivot3.com>
References: <E05F1FD208D5AA45B78B3983479ECF08E431E6@saturn.p3corpnet.pivot3.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E05F1FD208D5AA45B78B3983479ECF08E431E6@saturn.p3corpnet.pivot3.com>
User-Agent: Mutt/1.5.11
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q4/txt/msg00010.txt.bz2

On Mon, Nov 06, 2006 at 10:23:15AM -0600, Loh, Joe wrote:
>Thank you so much Eric for setting us straight on submitting patches,
>and Corinna for making change before we had a chance to followup with
>Eric's recommendation.
>
>We will be sorting out the necessary documentation in order to
>submitting the non-trivial patch for mapping up to 64 volumes, as
>pointed out by Eric.
>
>One other behavior we noticed is that /proc/partition currently shows
>multiple entries of /dev/sdz if number of volumes exceeds 26.  It's a
>pretty benign behavior and we don't have any recommended patches.
>
>Thank you all for your support of Cygwin.

You're welcome, but since this isn't actually a patch, please don't
clutter the mailing list with this kind of thing.

cgf
