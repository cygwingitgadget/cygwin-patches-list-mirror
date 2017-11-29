Return-Path: <cygwin-patches-return-8941-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 8143 invoked by alias); 29 Nov 2017 11:27:55 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 8131 invoked by uid 89); 29 Nov 2017 11:27:54 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-0.6 required=5.0 tests=AWL,BAYES_00,KAM_LAZY_DOMAIN_SECURITY,KB_WAM_FROM_NAME_SINGLEWORD autolearn=no version=3.3.2 spammy=American, american, Hx-languages-length:470, H*Ad:U*cygwin-patches
X-HELO: m0.truegem.net
Received: from m0.truegem.net (HELO m0.truegem.net) (69.55.228.47) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 29 Nov 2017 11:27:53 +0000
Received: from localhost (mark@localhost)	by m0.truegem.net (8.12.11/8.12.11) with ESMTP id vATBRq7p077954	for <cygwin-patches@cygwin.com>; Wed, 29 Nov 2017 03:27:52 -0800 (PST)	(envelope-from mark@maxrnd.com)
Date: Wed, 29 Nov 2017 11:27:00 -0000
From: Mark Geisert <mark@maxrnd.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Initialize IO_STATUS_BLOCK for pread, pwrite
In-Reply-To: <e7c6061c-be0e-5c36-b135-5796f9cd5da0@maxrnd.com>
Message-ID: <Pine.BSF.4.63.1711290324100.77443@m0.truegem.net>
References: <20171128075357.224-1-mark@maxrnd.com> <79e8acbf-bb27-7b68-eddc-c89d6567927f@maxrnd.com> <20171128093240.GO547@calimero.vinschen.de> <42633315-b082-232c-e310-31e05306d06f@maxrnd.com> <20171128105334.GQ547@calimero.vinschen.de> <e7c6061c-be0e-5c36-b135-5796f9cd5da0@maxrnd.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-IsSubscribed: yes
X-SW-Source: 2017-q4/txt/msg00071.txt.bz2

On Wed, 29 Nov 2017, I wrote:
> I added the printf()s and, what do you know, it shows all the NtWriteFile()s
                              ^^^^^^^^^^^^^^^^
That's an American English idiom and is not meant to be taken literally. 
It's like "How about that?" or "Can you believe it?". Perhaps y'all know 
this idiom already but it was only while contemplating a cerveza that I 
realized it might have come across badly.
Cheers & Regards,

..mark
