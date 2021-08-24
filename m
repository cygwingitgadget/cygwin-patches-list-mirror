Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
 by sourceware.org (Postfix) with ESMTPS id 80E7F3858003
 for <cygwin-patches@cygwin.com>; Tue, 24 Aug 2021 07:57:06 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 80E7F3858003
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MBUyX-1mBX9c31sl-00CyXc; Tue, 24 Aug 2021 09:57:03 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 11DB4A80D9E; Tue, 24 Aug 2021 09:57:03 +0200 (CEST)
Date: Tue, 24 Aug 2021 09:57:03 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: =?utf-8?B?0JDQu9C10LrRgdCw0L3QtNGAINCc0LDQu9C40LrQvtCy?= <schn27@gmail.com>
Cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH] fix race condition in List_insert
Message-ID: <YSSmT+QRgZ0ak4WE@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: =?utf-8?B?0JDQu9C10LrRgdCw0L3QtNGAINCc0LDQu9C40LrQvtCy?=
 <schn27@gmail.com>, cygwin-patches@cygwin.com
References: <20210823142748.1012-1-schn27@gmail.com>
 <YSO4hmZcdL/5w44q@calimero.vinschen.de>
 <CAGdYWrY=tydw+Bu_dYVef_enUh-_ndBC4kQGUgfL=D6AZuqb+Q@mail.gmail.com>
 <YSPkOY8WbIppas+R@calimero.vinschen.de>
 <CAGdYWra=w_t=5sDTRmPLswmp7dgAYV+U+yfgEdjEbc=e3WGtdA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGdYWra=w_t=5sDTRmPLswmp7dgAYV+U+yfgEdjEbc=e3WGtdA@mail.gmail.com>
X-Provags-ID: V03:K1:dHLEHUuy/DIrfXs2ZIaEa9aRhP+HxAOHi1rIm76bU3tx2U+aUI9
 PmWr7BueupeItAliyd2w5EfgGMkm+5cSKfV8hLsNEWKJh9mZDzTFPdYjie6dSpCwviRzF4f
 /ZTf98JBlrv0b2jc11fUNHhfz9Z5tqDKaiBthZqLZff36GaJxippABTmaurlhB7RBYQ4/lF
 xrn8lC2I71uoEADE0VHWg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:PWMd3CYYgu0=:h87uUuauMd7P//RkKG3tvk
 z02IxT7TZcNpsE2PvHT3f+MLsAIE9Mk5OvjAxnPztaO+L4VKSMDw+4bK9w2zoj9h+S3oI6+ci
 /HRoVB+fCxrKCetX0I+hMsI7WyrE2y4EY/J/FpW3maHJA0EwXxtQbxMIzk5kBLn8zZrddp9TF
 VOGWfmURbZzDAmnjbPOWdtPYNvseYGWsktfWtbjBYcfpVsyYhfb96LN1l/r4VlJEg5gOrEMtO
 SBD7GndtCletx1RliaLHrQvAS8mnooHXV64J7ye30jsiC8ZAQn6cMGi5rG5ZtymyPtckE4AuA
 NZ94uzwQd8JplZUbo31KklTZqNxGzuJ9MC6yVfdzpL/slPUSGeDnkfH2WYGktvWaUeQA/UtWJ
 krk0cdSp7A8SaKGVVWjSKqwIUl5Q0LBamT3jM+Rwp3mQaB0mw2ZtjjFL/l0OXb7ERnXrorMBJ
 Xb1Y62P7+4OX1BIIofp5jbLB2RzxJqIik+5RyULVEHjukDEwhRE+Q9ejGoOYTRVNc+W7vjNba
 y4N5aNWNa4A/Q4DrseIodijLl8fnMpKn65v9WDJJ8lRsSJ3meEJ0hOKOXRp3L6OBQbKkgrcMg
 l5f7yQfrTC8vSF3B/jnYIXwKM+tXdaLgwHEAzv3EUhM4YZuiF0Gea4yx/Lb50wOosy1XgYkAJ
 bbqyetsfZj1nZBb+2Io7pZh/ynOWlo2LPrHzMJC9Ob5HKiMi2vVWyv5YIdV2NyhB3ebYroy/a
 SRkcDNQACuCeTkbFgaSPzf49cb3gOrZWrnJd8vjZHWrRttGhWCr4LV4lRQHYED8eqI54N9vgS
 wDqCUJatx1wO4RcFZYDruQpqYmBvskwdLoy1uDMf6Kq4dC+qewPdfcQj7/wlxsw1r2/Adrldb
 RoM4LswIik1Y8e0i41gQ==
X-Spam-Status: No, score=-98.6 required=5.0 tests=BAYES_00, BODY_8BITS,
 GOOD_FROM_CORINNA_CYGWIN, KAM_DMARC_NONE, KAM_DMARC_STATUS, RCVD_IN_DNSWL_NONE,
 RCVD_IN_MSPIKE_H2, SPF_HELO_NONE, SPF_NEUTRAL,
 TXREP autolearn=ham autolearn_force=no version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
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
X-List-Received-Date: Tue, 24 Aug 2021 07:57:07 -0000

Hi Александр,

On Aug 23 22:05, Александр Маликов wrote:
> I'm completely new to all this BSD-2 stuff etc... What exactly should I do
> to 'provide my BSD-2 waiver'?
> This patch is licenced under 2-clause BSD.
> Is it enough?

Yes, that's ok.  You just have to write that all your Cygwin patches
will be licensed under BSD-2 as outlined in winsup/CONTRIBUTORS.  I'll
add you to the file and that's it for the future.

I pushed your patch.


Thanks,
Corinna
