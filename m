Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
 by sourceware.org (Postfix) with ESMTPS id 41418386F421
 for <cygwin-patches@cygwin.com>; Thu, 27 Aug 2020 08:47:58 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 41418386F421
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=corinna-cygwin@cygwin.com
Received: from calimero.vinschen.de ([217.91.18.234]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MaIzb-1k5KI52uZh-00WCdf for <cygwin-patches@cygwin.com>; Thu, 27 Aug 2020
 10:47:56 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 24F5EA83A77; Thu, 27 Aug 2020 10:47:56 +0200 (CEST)
Date: Thu, 27 Aug 2020 10:47:56 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pty: Disable pseudo console if TERM is dumb or
 not set.
Message-ID: <20200827084756.GU3272@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20200826120015.1188-1-takashi.yano@nifty.ne.jp>
 <20200826173606.GP3272@calimero.vinschen.de>
 <20200827130720.f9f618c1313e18848a995f8c@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200827130720.f9f618c1313e18848a995f8c@nifty.ne.jp>
X-Provags-ID: V03:K1:O6KBUpavbBHdhxyqYYKh9b3EWeTJaxNOTMJoMh96SlpXkFfbUyD
 AQTpHrhQIIKyy7d//3EYwFLP8BdUS+xu/23SmCaigpUnEROrFee3JlUQ3p8F/kHeiVBHwuX
 bZZINztBjwabK6PRsXtgtT2bvcDmYTkpY9C0FubZKsQn7W6Q9DTZ41ih/xFrw2LRDkrZvs/
 fIlaRnIp0vDwcijUSkFFA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:kFfMlIs78cM=:AZk+SMRH/aihmvu7SaOXD/
 m/xw+pkKDLaG2edeelf0t74JaM0IapiG95IT0B3om1HtKocK7hSvg/WDpj7Pmpg7V6xPEwScu
 dkfDNX4YwTeYrp/ky6LI52MrpOkRRRnawA61k+l53GR1+HSFMO1GObzYKfEYnJuxr0YBWvrfz
 XxANd/Of9JiuGVcW/tVnsYeaDG19HRflcjX4Rs3r0zHC3TcbvpnfVn3AJmlLHWcnNGqo+zT/Q
 y50WuKto9KpIhk4KVEYik0fJ8OILNdQhvYWij9EbnQTmx0q9bIj//pgJChTMRJp6/UHRDyIOV
 de3dhnoXrVvYGShEyLGxopo5rM0km+1dwUUYx+pnZ4UWyal1cJ5B3gz43A10uLtqfFi2x+yxk
 7yb41n06miuHesjB40WN9v6VfS5R10iURMbP/a2jJ7ozFJiPxm0CU+n250flP84A35CFD9CSC
 LEP46hOQ2Vin6VgR6T8A1gBtUx07VVzqcbjAGd6vlEEDIZIa7t6/zD8DFSIZHr8bmIT+/laAJ
 u8M9ns2LwEa4FTLd9Z/04GP9nGZodxa2joQCXJFWIHhYOH0LrNBwL4ktp+UrnQmNblb8M8cQ0
 vV5FENAqqpKNrpSEIm0yhx+iBokvk6wSrqx6OIxZ6YiTt4+P2K5rbDiadVVk1Y0ImvZpDpUP6
 cYIbSn5BumiyQWXPX2WVEfQQQuaR/0VNXns5yk1NLA6+XXu3qK8EMeY3WDNtHwoxP95LP0Zn0
 RelLY8i/B9lmJL89wUivSRUUcF6WRuioIWZwygcEO1KEp8AD2ZI9yoyX1ZH90O8Xtn3axuj4b
 piZewFMKIpV/F2d72t8Csnc453PGugitB3dBS8umOVINR9iaOh0RabTW+dtWhFQXFjjWt4vel
 BrPvaHBqHKOWFn+S/Tuw==
X-Spam-Status: No, score=-99.8 required=5.0 tests=BAYES_00,
 GOOD_FROM_CORINNA_CYGWIN, JMQ_SPF_NEUTRAL, KAM_DMARC_STATUS,
 RCVD_IN_DNSWL_NONE, RCVD_IN_MSPIKE_H2, SPF_HELO_NONE, SPF_NEUTRAL,
 TXREP autolearn=ham autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
 server2.sourceware.org
X-BeenThere: cygwin-patches@cygwin.com
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Cygwin core component patch submission and discussion
 <cygwin-patches.cygwin.com>
List-Unsubscribe: <https://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <https://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Thu, 27 Aug 2020 08:47:59 -0000

On Aug 27 13:07, Takashi Yano via Cygwin-patches wrote:
> On Wed, 26 Aug 2020 19:36:06 +0200
> Corinna Vinschen wrote:
> > On Aug 26 21:00, Takashi Yano via Cygwin-patches wrote:
> > > Pseudo console generates escape sequences on execution of non-cygwin
> > > apps.  If the terminal does not support escape sequence, output will
> > > be garbled. This patch prevents garbled output in dumb terminal by
> > > disabling pseudo console.
> > 
> > I'm a bit puzzled by this patch.  We had code handling emacs and dumb
> > terminals explicitely in the early forms of the first incarnation of
> > the pseudo tty code, but fortunately you found a way to handle this
> > without hardcoding terminal types into Cygwin.  Why do you think we
> > have to do this now?
> 
> What previously disccussed was the problem that the clearing
> screen at pty startup displays garbage (^[[H^[[2J) in emacs.
> Finally, this was settled by eliminating clear-screen and
> triggering redraw-screen instead at the first execution of
> non-cygwin app.
> 
> However, the problem reported in
> https://cygwin.com/pipermail/cygwin/2020-August/245983.html
> still remains. 
> 
> What's worse in the new implementation, pseudo console sends
> ESC[6n (querying cursor position) internally on startup and
> waits for a response. This causes hang if pseudo console is
> started in dumb terminal.
> 
> This patch is for fixing this issue.

Would it be feasible to implement this using a timeout instead?
If the response isn't sent within, say, 100ms, just skip it?


Corinna
