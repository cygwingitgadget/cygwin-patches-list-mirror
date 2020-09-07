Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.134])
 by sourceware.org (Postfix) with ESMTPS id B313438708DF
 for <cygwin-patches@cygwin.com>; Mon,  7 Sep 2020 09:09:09 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org B313438708DF
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=corinna-cygwin@cygwin.com
Received: from calimero.vinschen.de ([217.91.18.234]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1M2NqA-1kGrJC1b26-003x8R for <cygwin-patches@cygwin.com>; Mon, 07 Sep 2020
 11:09:08 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 05112A83A8F; Mon,  7 Sep 2020 11:09:08 +0200 (CEST)
Date: Mon, 7 Sep 2020 11:09:07 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 3/3] fhandler_pty_slave::setup_locale: respect charset ==
 "UTF-8"
Message-ID: <20200907090907.GG4127@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20200902163836.GL4127@calimero.vinschen.de>
 <20200903175912.GP4127@calimero.vinschen.de>
 <20200904182149.18cd752eef58c67ee8d39135@nifty.ne.jp>
 <20200904124400.GQ4127@calimero.vinschen.de>
 <20200904235016.9c34d04e809b5ad9f2bdfdf3@nifty.ne.jp>
 <20200904192235.GW4127@calimero.vinschen.de>
 <20200905174301.adbb3c147122fbe0636a0d56@nifty.ne.jp>
 <20200905201506.8bbca09f51a2b2b06135affa@nifty.ne.jp>
 <20200907082738.GD4127@calimero.vinschen.de>
 <20200907173824.3c382c6a5924b25d5563e5bf@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200907173824.3c382c6a5924b25d5563e5bf@nifty.ne.jp>
X-Provags-ID: V03:K1:wdqYgzxHVZ+UD6fXYAfHMBLkEyvuo7vDg5bRf3IwiIc+ZBGe699
 fCQ5/apmAEpy3AJukmcUEGowF1lacsfT7bGrNAlxU0gfQCX8CUCIkqmVwINz9fujfN6s0xQ
 ccaC/efT4X7C1o5stvodJYsXXAiTpUROaZcJB6cpHf6se3oaP5qx9AZzsYHGhSMn8I6y7fL
 J4H2bGkeuHj8W4JeknGZQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:1ETd2WpzJwo=:2WES2yMF1m99qnBddp1nLR
 JOfMBPNt3UtzuY+qnyL7YNFlYgemagaETGX4GGj8rdghWd19ChY+yiv9pIc7xrWZF8qtMPFxG
 L0gymb2GcnxouraAmPIhXl/WHHEG6bJ8G1WGBFcIDyQ4D1hYJkmGb8thsUt0vM4B1lqH9LQhH
 c6kjVAKM3DlS0m5hpuYU1Q0toPjhqDGgT3vxgqEuUMRF2+Nh9O/guls37UzI2B/LPN8bEIB0L
 HC88f0SUxxVGkJKrEF7x0m7iXa/vj9B2TUH9hlcW45Epuf1Tv7pJ3e0kHscCe3Nq3JDidB4aW
 en9zYa2OK5C1kILisbnPfF+nE18mTcj03zz4TlE8okq0m85bIgptpQR03TSnPmFAFJiItMztZ
 TQwwmKV9mohFQAxSNxQ+8gFf1F2TjMIIO6MJsxTHqtPInZvu/e++PvNxwrxsJ9focJEdNiZOf
 knN7oBd7RSeZ9BARVn7WAOzVuUz/taMLKIKdgGQdKRUcCZYu82eXrkWiZjzVkPUkBe7PASGsd
 6nphFQIqxDwQ4FG3f1Wyxf6BhAn9tYIij+FQPQyL0tcqUKSYGmTQPlA6LR42LNzu/Gvwt2V2M
 DBSOfR7i8cOGmy7qAp9cS9XMbN/X9uRAqI79Ax87JCaWStgK4Vh13hBo+xgrwyillwq5v9Q40
 2dXDM90UM1W68ni6ztQzRC5f6rdaZr92LO8l6MWqTSRGMULnCfXvyaZG0qfw7Bx13CbuHsHDU
 hZ7Ac2dxgbhPBvmQvUvoJSrqv3C4apAL94Ha67B5ClFURSlydEx5Du82a++3Mwn2dJkEd2LLs
 vmnXLhMhzx5gze3nrjjBi6RQKi/0M14kM85q6cdQELHDNPNvfRFyPVNlLrWz03RKTzRUk6TB1
 AsAAaL2Q8dGyazC8KmFA==
X-Spam-Status: No, score=-100.3 required=5.0 tests=BAYES_00,
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
X-List-Received-Date: Mon, 07 Sep 2020 09:09:11 -0000

On Sep  7 17:38, Takashi Yano via Cygwin-patches wrote:
> On Mon, 7 Sep 2020 10:27:38 +0200
> Corinna Vinschen wrote:
> > On Sep  5 20:15, Takashi Yano via Cygwin-patches wrote:
> > > On Sat, 5 Sep 2020 17:43:01 +0900
> > > Takashi Yano via Cygwin-patches <cygwin-patches@cygwin.com> wrote:
> > > No. This does not fix enough.
> > > 
> > > In the test case above, if it does not call setlocale(),
> > > __eval_codepage_from_internal_charset() always returns "ASCII"
> > 
> > ??? __eval_codepage_from_internal_charset() never returns ASCII.
> > It returns UTF-8 by default.
> 
> Sorry, I meant __locale_charset (__get_global_locale ()) returns
> "ASCII".

Which is correct and translates to UTF8 as default charset.


Corinna
