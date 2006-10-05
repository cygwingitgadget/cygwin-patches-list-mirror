Return-Path: <cygwin-patches-return-5984-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 19146 invoked by alias); 5 Oct 2006 16:58:41 -0000
Received: (qmail 19116 invoked by uid 22791); 5 Oct 2006 16:58:39 -0000
X-Spam-Check-By: sourceware.org
Received: from pool-72-70-61-117.bstnma.fios.verizon.net (HELO cgf.cx) (72.70.61.117)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Thu, 05 Oct 2006 16:58:33 +0000
Received: by cgf.cx (Postfix, from userid 201) 	id 9297413C484; Thu,  5 Oct 2006 12:58:31 -0400 (EDT)
Date: Thu, 05 Oct 2006 16:58:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] cygcheck: follow symbolic links
Message-ID: <20061005165831.GA7222@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <Pine.GSO.4.63.0602161116540.22053@access1.cims.nyu.edu> <20060217113100.GT26541@calimero.vinschen.de> <Pine.GSO.4.63.0602170900350.1592@access1.cims.nyu.edu> <Pine.GSO.4.63.0602221335110.4972@access1.cims.nyu.edu> <20060223112956.GF4294@calimero.vinschen.de> <Pine.GSO.4.63.0602230913440.13565@access1.cims.nyu.edu> <Pine.GSO.4.63.0607191036580.13093@access1.cims.nyu.edu> <20060724111402.GG11991@calimero.vinschen.de> <Pine.GSO.4.63.0609280901120.15013@access1.cims.nyu.edu> <20061005152959.GB24684@calimero.vinschen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061005152959.GB24684@calimero.vinschen.de>
User-Agent: Mutt/1.5.11
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q4/txt/msg00002.txt.bz2

On Thu, Oct 05, 2006 at 05:29:59PM +0200, Corinna Vinschen wrote:
>On Sep 28 09:06, Igor Peshansky wrote:
>> On Mon, 24 Jul 2006, Corinna Vinschen wrote:
>> [...]
>> > The latest fax was about this change, so I think this should still be
>> > covered, shouldn't it?  Ping the guy nevertheless.  We should stay on
>> > the safe side in legal questions.
>> >[...]
>> Looks like I've been remiss in following up on this, though I regenerated
>> the patch that same day.  Attached is the new version of the patch.  I
>> believe "the fax" (the new one) has been sent, but I've received no
>> notification of that, presumably because Corinna is not around...
>> 	Igor
>
>I didn't receive any notification either, so this somehow got stuck on
>one side.  I'm going to check my side, would you mind to ping yours?
>
>As soon as that's clarified, I'll apply your patch.

Didn't we resolve a while ago not to worry about assignments for
cygcheck?  I don't see any reason to care since it is not really a core
cygwin component - it's more of a debugging tool, and I don't see it
as a big deal for any corporate customers.

cgf
