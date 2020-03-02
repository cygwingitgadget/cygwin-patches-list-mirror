Return-Path: <cygwin-patches-return-10161-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 91951 invoked by alias); 2 Mar 2020 21:12:13 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 91562 invoked by uid 89); 2 Mar 2020 21:12:13 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-6.0 required=5.0 tests=AWL,BAYES_00,FORGED_SPF_HELO,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS autolearn=no version=3.3.1 spammy=
X-HELO: re-prd-fep-042.btinternet.com
Received: from mailomta21-re.btinternet.com (HELO re-prd-fep-042.btinternet.com) (213.120.69.114) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 02 Mar 2020 21:12:11 +0000
Received: from re-prd-rgout-002.btmx-prd.synchronoss.net ([10.2.54.5])          by re-prd-fep-042.btinternet.com with ESMTP          id <20200302211209.ZUCK28880.re-prd-fep-042.btinternet.com@re-prd-rgout-002.btmx-prd.synchronoss.net>          for <cygwin-patches@cygwin.com>; Mon, 2 Mar 2020 21:12:09 +0000
Authentication-Results: btinternet.com;    auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com
X-OWM-Source-IP: 31.51.207.12 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
Received: from [192.168.1.106] (31.51.207.12) by re-prd-rgout-002.btmx-prd.synchronoss.net (5.8.340) (authenticated as jonturney@btinternet.com)        id 5E3A15B6042CD38B for cygwin-patches@cygwin.com; Mon, 2 Mar 2020 21:12:09 +0000
Subject: Re: [PATCH v2 1/4] Cygwin: console: Add workaround for broken IL/DL in xterm mode.
To: Cygwin Patches <cygwin-patches@cygwin.com>
References: <20200226153302.584-1-takashi.yano@nifty.ne.jp> <20200226153302.584-2-takashi.yano@nifty.ne.jp> <05cca441-eb83-4600-90f3-bf82ec7a0190@dronecode.org.uk> <20200228111409.149929dcf710cabf99a879b3@nifty.ne.jp> <20200228133122.GG4045@calimero.vinschen.de> <cc657f02-e3a4-1880-34a2-dcf04d6e902a@t-online.de> <ea1bcf99-d945-d06e-9be6-8a17d8fb166f@t-online.de> <20200301153849.4fcaaaf2a6ae8fe723339174@nifty.ne.jp> <20200302170337.GU4045@calimero.vinschen.de> <20200302195401.GW4045@calimero.vinschen.de>
From: Jon Turney <jon.turney@dronecode.org.uk>
Message-ID: <b9391706-3872-8034-1f0b-74a8ddfcf58c@dronecode.org.uk>
Date: Mon, 02 Mar 2020 21:12:00 -0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200302195401.GW4045@calimero.vinschen.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SW-Source: 2020-q1/txt/msg00267.txt

On 02/03/2020 19:54, Corinna Vinschen wrote:
> On Mar  2 18:03, Corinna Vinschen wrote:
>> On Mar  1 15:38, Takashi Yano wrote:
>>> Hi Hans,
[...]
> 
> I pushed wpbuf_put as a simple inline function as a stop-gap
> measure so Cygwin builds on gcc 9.2.0.

\o/

https://ci.appveyor.com/project/cygwin/cygwin/builds/31190427
