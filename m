Return-Path: <cygwin-patches-return-9160-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 107157 invoked by alias); 3 Aug 2018 09:39:52 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 107137 invoked by uid 89); 3 Aug 2018 09:39:51 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-2.5 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_LOW,SPF_PASS autolearn=ham version=3.3.2 spammy=Hx-spam-relays-external:ESMTPA
X-HELO: lb2-smtp-cloud9.xs4all.net
Received: from lb2-smtp-cloud9.xs4all.net (HELO lb2-smtp-cloud9.xs4all.net) (194.109.24.26) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 03 Aug 2018 09:39:50 +0000
Received: from webmail.xs4all.nl ([IPv6:2001:888:0:22:194:109:20:200])	by smtp-cloud9.xs4all.net with ESMTPA	id lWYlfgQ9rEJtclWYlfu5qj; Fri, 03 Aug 2018 11:39:48 +0200
Received: from a83-162-234-136.adsl.xs4all.nl ([83.162.234.136]) by webmail.xs4all.nl with HTTP (HTTP/1.1 POST); Fri, 03 Aug 2018 11:39:47 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Date: Fri, 03 Aug 2018 09:39:00 -0000
From: Houder <houder@xs4all.nl>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: fegetenv() in winsup/cygwin/fenv.cc should not disable exceptions!
In-Reply-To: <213765cb4acd51f933201d759e2752a7@xs4all.nl>
References: <1533253512-1717-1-git-send-email-houder@xs4all.nl> <20180803073647.GA6347@calimero.vinschen.de> <213765cb4acd51f933201d759e2752a7@xs4all.nl>
Message-ID: <dd884b3ef4447809db61c6352f9af483@xs4all.nl>
X-Sender: houder@xs4all.nl
User-Agent: XS4ALL Webmail
X-IsSubscribed: yes
X-SW-Source: 2018-q3/txt/msg00055.txt.bz2

On 2018-08-03 11:27, Houder wrote:
> I discovered a difference in behaviour between the x87 FPU and SSE.
> 
> When an exception is masked, a "default action" is carried out when
> an exception occurs. At the same time the associated status flag is
> set.
> (the manual speaks about a "reasonable" default action, an action
>  that is "sufficient" most of the times)
> 
> When the exception is enabled again, SSE is not bothered. However
> the next _FPU_ statement will notice the status flag set, and will
> set the "Exception Summary Bit" (in the FPU's status register).

To clarify:

SSE has a "control and status register". The x87 FPU has a control
register and a status register.

Flags are only set in x87 FPU's status register when FPU statements
are executed.

(the FPU is not "interested" in SSE's control and status register)

Henri
