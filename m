Return-Path: <cygwin-patches-return-6056-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 15658 invoked by alias); 4 Apr 2007 08:26:59 -0000
Received: (qmail 15647 invoked by uid 22791); 4 Apr 2007 08:26:59 -0000
X-Spam-Check-By: sourceware.org
Received: from icculus.org (HELO icculus.org) (67.106.77.212)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Wed, 04 Apr 2007 09:26:56 +0100
Received: (qmail 26846 invoked by uid 305); 4 Apr 2007 04:26:19 -0400
Received: from icculus@icculus.org by gamehenge by uid 305 with qmail-scanner-1.22   (clamdscan: 0.75.1.  Clear:RC:1(75.181.37.52):.   Processed in 1.390896 secs); 04 Apr 2007 08:26:19 -0000
Received: from unknown (HELO ?192.168.1.121?) (icculus@75.181.37.52)   by icculus.org with ESMTPA; 4 Apr 2007 04:26:17 -0400
Message-ID: <46136153.8030000@icculus.org>
Date: Wed, 04 Apr 2007 08:26:00 -0000
From: "Ryan C. Gordon" <icculus@icculus.org>
User-Agent: Thunderbird 1.5.0.10 (Macintosh/20070221)
MIME-Version: 1.0
To:  cygwin-patches@cygwin.com
Subject: Re: [PATCH] getmntent()->mnt_type values that match Linux...
References: <45FE2DF8.40709@icculus.org>
In-Reply-To: <45FE2DF8.40709@icculus.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2007-q2/txt/msg00002.txt.bz2


> mnt_type is always "system" or "user" ... this patch changes this to 
> make an earnest effort to match what a GNU/Linux system would report, 
> and moves the system/user string to mnt_opts.

I sent in the copyright assignment paperwork for this around two weeks 
ago...just wanted to follow up to see if that was ever received, and if 
so, if this patch can be committed or needs further work.

Thanks,
--ryan.
