Return-Path: <towo@towo.net>
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.74])
 by sourceware.org (Postfix) with ESMTPS id A59F93858D33
 for <cygwin-patches@cygwin.com>; Tue, 23 Feb 2021 11:24:10 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org A59F93858D33
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=towo.net
Authentication-Results: sourceware.org; spf=none smtp.mailfrom=towo@towo.net
Received: from [192.168.178.72] ([91.65.218.78]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MDQqe-1l57sd0g22-00AUdE for <cygwin-patches@cygwin.com>; Tue, 23 Feb 2021
 12:24:09 +0100
Subject: Re: [PATCH] Cygwin: pty: Fix segfault caused when tcflush() is called.
To: cygwin-patches@cygwin.com
References: <20210220224516.1740-1-takashi.yano@nifty.ne.jp>
 <YDN+lx5V2I3W3bbw@calimero.vinschen.de>
 <20210222204100.698efc916f1eacacb89b9ab8@nifty.ne.jp>
 <YDO4M0jllqibv4aq@calimero.vinschen.de>
From: Thomas Wolff <towo@towo.net>
Message-ID: <22bb210b-bb7d-3863-e2e9-0394e506cae3@towo.net>
Date: Tue, 23 Feb 2021 12:24:09 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <YDO4M0jllqibv4aq@calimero.vinschen.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:k15fnEhGruKE9EnKjedCwHBCOJGnrZ1v88BBr+bJ+nvimnZMv4V
 l+xyktkFkgLentME8ymAAXgVHxUcDPbSdHbPaS9OUoeKaHqq+TPhz2NdA5ngaYilfv/JM79
 +Os2/mp43QwjmhH+DXLFMPOUe78I/Kn4XwDZkECpzi3K1nESh+6ViGsDLjzAvpN0uSOeKiw
 IZqvLZ3vB7TRVnQc/RotQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:NzwtEwhamqA=:mSxfYf5AfSsVo2HpYeKjzA
 Z5c/fGXL76eq6o8cheGl2mVDD+vD8Awl8XIYXax2YU0+TKHpXkrpSGegUDC/l9+jNq65WKgNU
 CM2QFPzIgNGuEnlmcZXItQI9vF94330LQQNJ8g0gdBGwy81GsHaA+IjpU37Lifhpbx7SPeuyR
 XfYTdB9h3AQkH2bM9aq/Z71M4bKQd0Bn3vnX/5q5ih01bvv39U/bO1UuJk2Xyu8f80S9JttGb
 xHUxnzx+ZcZlMgBl9y3MiYF1aSW0QoZvPROt4hr3/LPTojdHwz3w4RW7rFHs8JX3h9gn4+t5U
 PtGXMohj70ZrIZRWdkZ9twmmUq7WVsnzF56Nth2b4iolxDoGNs/z6IvRXvQ5HGX7WTt8qkG42
 FmTHOpF5+XQNlXsr/lc2rHF9rpKGak7F1Hfi3OzPchVV4GEqjBIGqV0ccz7K1
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
X-List-Received-Date: Tue, 23 Feb 2021 11:24:12 -0000


Am 22.02.2021 um 14:57 schrieb Corinna Vinschen via Cygwin-patches:
> On Feb 22 20:41, Takashi Yano via Cygwin-patches wrote:
>> On Mon, 22 Feb 2021 10:51:19 +0100
>> Corinna Vinschen wrote:
>>> So, what do you think is the state of the console code, Takashi?
>>> Shall we start a release cycle next week?
>> I think all the fixes and improvements that come to mind at this
>> point have been completed. As for releasing, I believe I've done
>> enough testing, but honestly I'm not without anxiety because total
>> amount of changes for pty and console code is relatively large
>> since the beginning of this year.
>>
>> On the other hand, I also want people to use new features as soon
>> as possible.
> Then let's do it.  I'll start with the usual test releases...
I've downloaded yesterday's snapshot (2021-02-22) for some testing.
If I compile mintty (which passes without problem) and try to run it, it 
just exits silently (no window popped up).
After reverting to 3.1.7, it runs just fine (even the one compiled with 
the snapshot).
