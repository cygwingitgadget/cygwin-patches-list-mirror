Return-Path: <cygwin-patches-return-9760-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 53366 invoked by alias); 17 Oct 2019 16:04:38 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 53336 invoked by uid 89); 17 Oct 2019 16:04:38 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-17.7 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE,SPF_PASS autolearn=ham version=3.3.1 spammy=H*i:sk:0c90ed2, H*MI:sk:0c90ed2, H*f:sk:0c90ed2, screen
X-HELO: atfriesa01.ssi-schaefer.com
Received: from atfriesa01.ssi-schaefer.com (HELO atfriesa01.ssi-schaefer.com) (193.186.16.100) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 17 Oct 2019 16:04:36 +0000
Received: from samail03.wamas.com (HELO mailhost.salomon.at) ([172.28.33.235])  by atfriesa01.ssi-schaefer.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Oct 2019 18:04:34 +0200
Received: from [172.28.53.83]	by mailhost.salomon.at with esmtps (UNKNOWN:AES128-SHA:128)	(Exim 4.77)	(envelope-from <michael.haubenwallner@ssi-schaefer.com>)	id 1iL8GP-0006Yj-K0; Thu, 17 Oct 2019 18:04:33 +0200
Subject: Re: [PATCH] Cygwin: pty: Change the timing of clear screen.
References: <20191016123409.457-1-takashi.yano@nifty.ne.jp> <20191016123409.457-2-takashi.yano@nifty.ne.jp> <0c90ed2b-ed1e-643c-5643-78f50444f97d@cornell.edu>
To: cygwin-patches@cygwin.com
From: Michael Haubenwallner <michael.haubenwallner@ssi-schaefer.com>
Message-ID: <2943cac3-3b48-3753-1d06-dff6590bb3b3@ssi-schaefer.com>
Date: Thu, 17 Oct 2019 16:04:00 -0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <0c90ed2b-ed1e-643c-5643-78f50444f97d@cornell.edu>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-SW-Source: 2019-q4/txt/msg00031.txt.bz2

On 10/17/19 4:55 PM, Ken Brown wrote:
> On 10/16/2019 8:34 AM, Takashi Yano wrote:
>> ---
>>   winsup/cygwin/fhandler_tty.cc | 26 +++++++++++++-------------
>>   1 file changed, 13 insertions(+), 13 deletions(-)
>>
>> diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
>> index 1095c82eb..baf3c9794 100644
>> --- a/winsup/cygwin/fhandler_tty.cc
>> +++ b/winsup/cygwin/fhandler_tty.cc

> 
> This and the previous patch look good to me, but we should probably wait 
> for Haubi to confirm that they fix the problems he reported.

I'm unsure what the first patch does address: It does not fix the 'ssh -t' testcase,
and I doubt it actually should.  But it doesn't seem to break anything here so far.

The second patch fixes the (minor) issue with the 'Last login' line as expected.

/haubi/
