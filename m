Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
 by sourceware.org (Postfix) with ESMTPS id 9723C382D83E
 for <cygwin-patches@cygwin.com>; Fri,  5 Mar 2021 15:12:23 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 9723C382D83E
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MLQl3-1l0FbJ0tpD-00IVUS for <cygwin-patches@cygwin.com>; Fri, 05 Mar 2021
 16:12:22 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id D7D23A8060B; Fri,  5 Mar 2021 16:12:21 +0100 (CET)
Date: Fri, 5 Mar 2021 16:12:21 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] Cygwin: console: Fix restoring console mode failure.
Message-ID: <YEJKVYTOQ8wzX7vi@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20210304101108.1312-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210304101108.1312-1-takashi.yano@nifty.ne.jp>
X-Provags-ID: V03:K1:eul4a/B72F+aU0PeSccY8rxd2QdFeFIRti2O7LoahXB3N+dX8zY
 StS4SJ89vUJedZG39LlY6YvbaB5kjx4tTOj8wQGm0ksfslpKb5v9thh5QxcBoQFDbIYJqb/
 /luRdv4HRo/MYlYRX5SKMF59+Zz0QnOuVqBmwPv49daO7od3dpk9EmjMJWcg7WlepCr+dqX
 e4kX4vCqL1123SuRkVqyA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:59aMQo04EMo=:0/+8gYRt8Pn5PKBpNQCdX5
 m3xW9crshnYMy5UiupDUlmpENX837Lghzvi5tx9pJ7neKTp7CI+QlEMQvszOtEnX95ivabgBY
 wNYE4S+vwA3ZvHDG6WSy6LKDvNBmkzM+UL42Ci+RQEFj5AlzybKEykg2wKzkigzmuFtuhfZMC
 eJXOwV9uEabOukDukDEZrxtaheJ98qjrGhlUOxBmIvCq3YmYtIrSeIZuyqU0SFQ+6u+huxpQz
 NdiICCUF9hCA6Wu6jBx300BV8fh4Jw1iAtXxsuyL9gh2TATrWebwiHyd1UhvOXhBhyFoozaCm
 3O8xY0yuii/P2MK1NrFhe/Ncmq2hp3EbSgd4nU6W03zkYPh6tR8X/y7W6OpAdQOpx09H3/uD3
 +ofkZHfVgsqQjk8Jh2qB54a4T+y9fnrYaXCcCCpZc7vdSdoqz8Z7q6LT2jtt9B0HUgcwCpahl
 Y5yz1Du6Fg==
X-Spam-Status: No, score=-101.4 required=5.0 tests=BAYES_00,
 GOOD_FROM_CORINNA_CYGWIN, KAM_DMARC_NONE, KAM_DMARC_STATUS, RCVD_IN_DNSWL_NONE,
 RCVD_IN_MSPIKE_H2, SPF_HELO_NONE, SPF_NEUTRAL,
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
X-List-Received-Date: Fri, 05 Mar 2021 15:12:24 -0000

On Mar  4 19:11, Takashi Yano via Cygwin-patches wrote:
> - Restoring console mode fails in the following scenario.
>    1) Start cygwin shell in command prompt.
>    2) Run 'exec chcp.com'.
>   This patch fixes the issue.
> ---
>  winsup/cygwin/fhandler.h |  1 +
>  winsup/cygwin/spawn.cc   | 14 ++++++++++----
>  2 files changed, 11 insertions(+), 4 deletions(-)

Pushed.


Thanks,
Corinna
