Return-Path: <towo@towo.net>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
 by sourceware.org (Postfix) with ESMTPS id BCF3E385801A
 for <cygwin-patches@cygwin.com>; Tue, 23 Feb 2021 17:15:14 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org BCF3E385801A
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=towo.net
Authentication-Results: sourceware.org; spf=none smtp.mailfrom=towo@towo.net
Received: from [192.168.178.74] ([91.65.218.78]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1Mi4un-1ljFGi0jvF-00e5EF for <cygwin-patches@cygwin.com>; Tue, 23 Feb 2021
 18:15:13 +0100
Subject: Re: [PATCH] Cygwin: pty: Fix segfault caused when tcflush() is called.
To: cygwin-patches@cygwin.com
References: <20210220224516.1740-1-takashi.yano@nifty.ne.jp>
 <YDN+lx5V2I3W3bbw@calimero.vinschen.de>
 <20210222204100.698efc916f1eacacb89b9ab8@nifty.ne.jp>
 <YDO4M0jllqibv4aq@calimero.vinschen.de>
 <22bb210b-bb7d-3863-e2e9-0394e506cae3@towo.net>
 <20210223221352.aa792dd9afe6c2afbd364b17@nifty.ne.jp>
 <20210223223358.96ba58e9d805b6f0caf3cf4b@nifty.ne.jp>
From: Thomas Wolff <towo@towo.net>
Message-ID: <a361d770-0ef6-0e02-2bc2-9c2758d6116a@towo.net>
Date: Tue, 23 Feb 2021 18:15:12 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210223223358.96ba58e9d805b6f0caf3cf4b@nifty.ne.jp>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:I6lNsg35CLneQyq72rBaivnBvi/ntQsyieY6sLrU0HcayGQpqab
 dz5YRhkvrmLpEYbm3TVoMi3UXI3aQWQWXk3pnQNfvFGsX4GESQqqMUbsKz29M800/NtjVKA
 JkgoN8xGO9va3pGmbXD3TIqdpLhZyabUlL1mkoS5thDuAkWfncnQ2ZTXZPySOLC9rJsjD5t
 FR//h32cv3lSyvvjaw2SQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:UQTTKP3dfbY=:SR5SyuB8luN+GcMPJUbkEC
 DNDr1Wrud7wNda83LlSxfWFoAqIfPUNsMyIjKMZk6z3nITaM8SChlbIi/IG5R+MdvZFjBSZo9
 WXuQT0/Mld5ZXEZIjE+82DBV9GxzQppvaXzUuEPNkzp/zhbGQvhms3rwvuMtsspcU6LPRFf0R
 SatlYiC6+EyoH6AviSgsuFDo4Ws8vSwFRNxjWxRxmZt7gMSu1F9PRVLb0HY4/TIMCx9qvc2tj
 /PSO5qsHWN6FTqAr7VBvlQp5JrlUI7xAuV6DJ4udB4XTLIY/5lYFqJHUgKwCt0lfHrlGnuuRQ
 UWJppVX7cZvECGNp054Dph+E99ncHbuVzbzRxFmY7MOElk/CweRp12qiT974JDdKOt+mK+UGg
 8dkT9mbzg0LnGu0tXJgVDPT1BWXx6yivcufPO0V44XDMmDktHmdd/t+r9KNWY
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00, KAM_DMARC_STATUS,
 KAM_LAZY_DOMAIN_SECURITY, NICE_REPLY_A, RCVD_IN_DNSWL_NONE, RCVD_IN_MSPIKE_H2,
 SPF_HELO_NONE, SPF_NONE, TXREP autolearn=no autolearn_force=no version=3.4.2
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
X-List-Received-Date: Tue, 23 Feb 2021 17:15:16 -0000



Am 23.02.2021 um 14:33 schrieb Takashi Yano via Cygwin-patches:
> On Tue, 23 Feb 2021 22:13:52 +0900
> Takashi Yano wrote:
>> Hi Thomas,
>>
>> On Tue, 23 Feb 2021 12:24:09 +0100
>> Thomas Wolff wrote:
>>> I've downloaded yesterday's snapshot (2021-02-22) for some testing.
>>> If I compile mintty (which passes without problem) and try to run it, it
>>> just exits silently (no window popped up).
>>> After reverting to 3.1.7, it runs just fine (even the one compiled with
>>> the snapshot).
>> Thanks for testing. However, I cannot reproduce your problem.
>> I downloaded mintty-3.4.6-1-src.tar.xz and extract it.
>> Then run
>> cygport mintty-3.4.6-1.cygport prep
>> cygport mintty-3.4.6-1.cygport compile
>>
>> The binary in build/bin directory works with cygwin snapshot
>> 2021-02-22. I have tried both 32bit and 64bit build, and both
>> work without problem.
>>
>> Could you please provide some more information?
> Difference of compiler version?
> I am using gcc-g++ 10.2.0-1.
Apologies, I confused this. I *wanted* to try the snapshot but then 
tried a self-compiled dll instead (fresh git pull).
The snapshot works. The git pull doesn't but that may have other 
mysterious reasons.
Thomas
