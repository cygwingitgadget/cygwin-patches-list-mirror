Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
 by sourceware.org (Postfix) with ESMTPS id C52623851C2F
 for <cygwin-patches@cygwin.com>; Mon,  1 Feb 2021 09:40:11 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org C52623851C2F
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1Mo7eX-1llOKn06VX-00pfWE for <cygwin-patches@cygwin.com>; Mon, 01 Feb 2021
 10:40:10 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 86C2FA80D7F; Mon,  1 Feb 2021 10:40:09 +0100 (CET)
Date: Mon, 1 Feb 2021 10:40:09 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: fhandler_serial.cc: MARK and SPACE parity for serial port
Message-ID: <20210201094009.GD375565@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <CAGEXLhUUtV-kKxO-jQo4427R=N=Uo1aT_LrHGpc1r55umbb92w@mail.gmail.com>
 <20210128100802.GW4393@calimero.vinschen.de>
 <20210128101429.GX4393@calimero.vinschen.de>
 <4d88d636-8274-5dea-67f8-f224a63b49a9@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4d88d636-8274-5dea-67f8-f224a63b49a9@gmail.com>
X-Provags-ID: V03:K1:YzrqDod0rz6B6/s25ljoFKX55LgfwGJKt4+WXjxtG9baIpRWS8T
 bTVaIDnt8y4rHmi+QCfbtExGPZBxMK3EvxnnqHVqgoEN3vlIe8p+nAMejg0OjKsXk5PNI3H
 dj3nG0AoEv4t4CeZg6KCRD7vEsoQaPNK6hYe5UwL/gQKGi5mFNUBVnz5wooEyhRZgHRZoRn
 wnjb22O96l4wo1qN5+LSA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:BHAAZBbPyCQ=:qkZJvTAiXJWvbk/sq8NxW3
 GvY46l9LU6VT+NBVYtXS8t+gKhOSMH2fAmGtFEXaa+65D2ulCM/KzmQR/mNkLbQsdPL8SgcuU
 LCJ3XVyZ4MZRoTfTDRfLbSpSvh0+rT8nzjgohQxPHRxjvPceLhJKx0fOoLcrVK2+QX0iBgapz
 uRR6FOoyTs0aHqaR9LzJ7IFNTa3fTZxPE++fx6GAsP4tAygLoW99xzhz/Zjon1YnqqNlo4sx+
 b186D6ttgqqStvkxvAT5T91bjigh8KZVH8t+iFq8EZ6Zesy96F+XBk/I0qpNFNY8mboKJNNm+
 oLmt0U9ywb3Yt40NtaLiXGn0QqO1uyMPBIirAS89zHFO42L2lgmY4csw6MCFvFkSw5pJDr80C
 IfdfIgvfvv3lWToY9SZSxJxLVU0Rd7ug/1XTqEY6W7zH0pN8bYfmcy5WgUu/IkydAKRk6ElRr
 s3VmaBicyQ==
X-Spam-Status: No, score=-101.0 required=5.0 tests=BAYES_00,
 GOOD_FROM_CORINNA_CYGWIN, JMQ_SPF_NEUTRAL, KAM_DMARC_NONE, KAM_DMARC_STATUS,
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
X-List-Received-Date: Mon, 01 Feb 2021 09:40:13 -0000

On Jan 29 23:06, Marek Smetana via Cygwin-patches wrote:
> Hi,
> 
> I have modified the patch as recommended and am sending it as an attachment.

Great, but can you please attach the entire output of
`git format-patch -1' including the commit message?


Thanks,
Corinna
