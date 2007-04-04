Return-Path: <cygwin-patches-return-6059-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 27031 invoked by alias); 4 Apr 2007 18:18:44 -0000
Received: (qmail 27017 invoked by uid 22791); 4 Apr 2007 18:18:42 -0000
X-Spam-Check-By: sourceware.org
Received: from pool-71-248-179-87.bstnma.fios.verizon.net (HELO cgf.cx) (71.248.179.87)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Wed, 04 Apr 2007 19:18:35 +0100
Received: by cgf.cx (Postfix, from userid 201) 	id 7D0C02B41A; Wed,  4 Apr 2007 14:18:33 -0400 (EDT)
Date: Wed, 04 Apr 2007 18:18:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] getmntent()->mnt_type values that match Linux...
Message-ID: <20070404181833.GA17836@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <45FE2DF8.40709@icculus.org> <46136153.8030000@icculus.org> <20070404084930.GK20261@calimero.vinschen.de> <20070404160309.GB1672@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070404160309.GB1672@calimero.vinschen.de>
User-Agent: Mutt/1.5.14 (2007-02-12)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2007-q2/txt/msg00005.txt.bz2

On Wed, Apr 04, 2007 at 06:03:09PM +0200, Corinna Vinschen wrote:
>Ryan,
>
>On Apr  4 10:49, Corinna Vinschen wrote:
>> On Apr  4 04:26, Ryan C. Gordon wrote:
>> > 
>> > >mnt_type is always "system" or "user" ... this patch changes this to 
>> > >make an earnest effort to match what a GNU/Linux system would report, 
>> > >and moves the system/user string to mnt_opts.
>> > 
>> > I sent in the copyright assignment paperwork for this around two weeks 
>> > ago...just wanted to follow up to see if that was ever received, and if 
>> > so, if this patch can be committed or needs further work.
>> 
>> Sorry, I didn't get the note from our dept so far.  I'll investigate...
>
>your assignment arrived and has been signed.
>
>Chris, are you going to review the patch?

Yep.  I'll do it in the next couple of days.

cgf
