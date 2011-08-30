Return-Path: <cygwin-patches-return-7504-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 19316 invoked by alias); 30 Aug 2011 16:29:04 -0000
Received: (qmail 19301 invoked by uid 22791); 30 Aug 2011 16:29:03 -0000
X-SWARE-Spam-Status: No, hits=-1.1 required=5.0	tests=AWL,BAYES_00,SPF_NEUTRAL
X-Spam-Check-By: sourceware.org
Received: from smtp3.epfl.ch (HELO smtp3.epfl.ch) (128.178.224.226)    by sourceware.org (qpsmtpd/0.43rc1) with SMTP; Tue, 30 Aug 2011 16:28:42 +0000
Received: (qmail 11564 invoked by uid 107); 30 Aug 2011 16:28:37 -0000
Received: from 1055hostc2.starwoodbroadband.com (HELO discarded) (66.17.246.2) (authenticated)  by smtp3.epfl.ch (AngelmatoPhylax SMTP proxy) with ESMTPA; Tue, 30 Aug 2011 18:28:39 +0200
Message-ID: <4E5CFA53.5060601@cs.utoronto.ca>
Date: Tue, 30 Aug 2011 16:29:00 -0000
From: Ryan Johnson <ryan.johnson@cs.utoronto.ca>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:5.0) Gecko/20110624 Thunderbird/5.0
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] profile support
References: <CADEiHqLZAuJkDJKh4pJ4AOJ1JwUwV06RSkq3GdNihSKhiUswGw@mail.gmail.com> <20110820084946.GA30978@calimero.vinschen.de> <4E533502.4060207@gmail.com> <20110823054003.GA10003@ednor.casa.cgf.cx> <4E5BF23F.8060806@gmail.com> <20110829202346.GA26708@ednor.casa.cgf.cx> <4E5C0177.3090002@gmail.com>
In-Reply-To: <4E5C0177.3090002@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2011-q3/txt/msg00080.txt.bz2

On 29/08/2011 2:15 PM, jojelino wrote:
> On 2011-08-30 AM 5:23, Christopher Faylor wrote:
>> Maybe Corinna will disagree but I think there is way too much code
>> change here for me to be comfortable with including it.  It looks like
>> it would be an ongoing maintenance issue, requiring constant vigilance
>> to avoid code rot.  And, it would have to be very carefully studied to
>> make sure there aren't more gotchas like 'if "" ""'.
>>
> Yes, I see. but there would be months for the missing comments, and i 
> have not enough time to test this patch for now.
> and there were bugs in previous patch. so i attach the revised one.

I haven't been studying the code, but the phrases "lots of code", "no 
comments" and "not tested" ring major alarm bells for me...

$0.02
Ryan
