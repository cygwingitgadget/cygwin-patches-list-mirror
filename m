Return-Path: <cygwin-patches-return-9031-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 118943 invoked by alias); 22 Feb 2018 11:04:23 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 118932 invoked by uid 89); 22 Feb 2018 11:04:23 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-0.9 required=5.0 tests=AWL,BAYES_00,KAM_LAZY_DOMAIN_SECURITY autolearn=no version=3.3.2 spammy=pine, Pine, astounding, claims
X-HELO: m0.truegem.net
Received: from m0.truegem.net (HELO m0.truegem.net) (69.55.228.47) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 22 Feb 2018 11:04:19 +0000
Received: from localhost (mark@localhost)	by m0.truegem.net (8.12.11/8.12.11) with ESMTP id w1MB4HVp079305	for <cygwin-patches@cygwin.com>; Thu, 22 Feb 2018 03:04:17 -0800 (PST)	(envelope-from mark@maxrnd.com)
Date: Thu, 22 Feb 2018 11:04:00 -0000
From: Mark Geisert <mark@maxrnd.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] doc/ntsec.xml: Fix typo
In-Reply-To: <1403214d-ca26-02ad-5d59-eea94b7039bb@gmail.com>
Message-ID: <Pine.BSF.4.63.1802220257200.76751@m0.truegem.net>
References: <f1047ae4-4edf-6343-2929-c193e6cee77c@gmail.com> <20180221210534.GA7576@calimero.vinschen.de> <9501f8b9-f84a-ea43-93da-c0eeb8ca9d35@SystematicSw.ab.ca> <20180221213714.GB7576@calimero.vinschen.de> <dbe0ccb9-4752-cd76-e90b-8d88b5899302@Systemat <1403214d-ca26-02ad-5d59-eea94b7039bb@gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-IsSubscribed: yes
X-SW-Source: 2018-q1/txt/msg00039.txt.bz2

On Thu, 22 Feb 2018, David Macek wrote:
> On 2018-02-21 14:05, Corinna Vinschen wrote:
>> The patch is malformed.  It claims to contain 7 lines (6 lines context,
>> one line changed), but actually it has only 4 lines context.  Please
>> check your git settings.
>
> On 21. 2. 2018 22:56, Brian Inglis wrote:
>> I can see why you strenuously request git format-patch/send-email 
>> attachments ;^>
>
> I did use `git format-patch` to make that message (then sent using TB).
> I guess I'll have to try something else next time.

Been there, done that, even the "I'll have to try something else".  It's 
astounding how SeaMonkey, Pine, and probably gmane bork up the formatting 
of something that looks so benignly laid out to begin with.

After much experience putting up with these and other MUAs from us, 
Corinna really does know *the* solution that just works.  'git 
format-patch' followed by 'git send-email'.

With cheers and understanding,

..mark
