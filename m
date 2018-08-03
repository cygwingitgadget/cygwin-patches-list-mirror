Return-Path: <cygwin-patches-return-9163-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 99670 invoked by alias); 3 Aug 2018 12:02:45 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 98324 invoked by uid 89); 3 Aug 2018 12:02:44 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-2.5 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_LOW,SPF_PASS autolearn=ham version=3.3.2 spammy=Hx-languages-length:265, Hx-spam-relays-external:ESMTPA
X-HELO: lb2-smtp-cloud7.xs4all.net
Received: from lb2-smtp-cloud7.xs4all.net (HELO lb2-smtp-cloud7.xs4all.net) (194.109.24.28) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 03 Aug 2018 12:02:38 +0000
Received: from webmail.xs4all.nl ([IPv6:2001:888:0:22:194:109:20:216])	by smtp-cloud7.xs4all.net with ESMTPA	id lYmyf7KgW6brUlYmyfCvgv; Fri, 03 Aug 2018 14:02:36 +0200
Received: from a83-162-234-136.adsl.xs4all.nl ([83.162.234.136]) by webmail.xs4all.nl with HTTP (HTTP/1.1 POST); Fri, 03 Aug 2018 14:02:36 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Date: Fri, 03 Aug 2018 12:02:00 -0000
From: Houder <houder@xs4all.nl>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: fegetenv() in winsup/cygwin/fenv.cc should not disable exceptions!
In-Reply-To: <9d3b0bda096f6b7dbf5d7dd07eeb05e6@xs4all.nl>
References: <1533253512-1717-1-git-send-email-houder@xs4all.nl> <20180803073647.GA6347@calimero.vinschen.de> <213765cb4acd51f933201d759e2752a7@xs4all.nl> <20180803103917.GC6347@calimero.vinschen.de> <9d3b0bda096f6b7dbf5d7dd07eeb05e6@xs4all.nl>
Message-ID: <84de745e8b5028aaa07b563b9cac7c80@xs4all.nl>
X-Sender: houder@xs4all.nl
User-Agent: XS4ALL Webmail
X-IsSubscribed: yes
X-SW-Source: 2018-q3/txt/msg00058.txt.bz2

On 2018-08-03 14:00, Houder wrote:
[snip]

> As far as I tell, it is neither the machine nor "fenv" that devices
> to switch from x87 FPU to SSE ...

s/devices/decides/

Sorry.
