Return-Path: <cygwin-patches-return-10170-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 28974 invoked by alias); 3 Mar 2020 12:50:05 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 28965 invoked by uid 89); 3 Mar 2020 12:50:05 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-8.8 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_2,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=HX-Languages-Length:1464
X-HELO: conssluserg-01.nifty.com
Received: from conssluserg-01.nifty.com (HELO conssluserg-01.nifty.com) (210.131.2.80) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 03 Mar 2020 12:50:03 +0000
Received: from Express5800-S70 (ntsitm196171.sitm.nt.ngn.ppp.infoweb.ne.jp [125.0.207.171]) (authenticated)	by conssluserg-01.nifty.com with ESMTP id 023Cnfqj031424	for <cygwin-patches@cygwin.com>; Tue, 3 Mar 2020 21:49:42 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com 023Cnfqj031424
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1583239782;	bh=5CNFpEaaTnLWEzm8SJMGYOKN6FMsD16PD8qi6OjC/BM=;	h=Date:From:To:Subject:In-Reply-To:References:From;	b=qzk0iGjwBxVRMVWfVRdgfn0SMBhGsJQy5gjFTEDzVkJhSxB5vS7o/gUysI2JnwTA1	 UOM5ffl1zQcoxFmgYgWhWG7kccNU5c+BhqzdrL+E1b+Jgig6lepwCeRziMZsGCDvLw	 Vw1TZlEoQZjqf8viK6tLK0VeFb2K8AR0vpIqc4Ox20HECCInOPWwBVZaKda4u7P8bQ	 zHr3L1dU44xqw5Yuzjz8Qb5ZLEedSXDKE/FEdkeK+wPs+xu8tN/6iTKrdHpEBR+Cmx	 FthWZBDqD/PZog28swmk0REdPP8k/xIe3sc2N9mRsEQoMgU514hYcntqeD2w/7vsv4	 lxF+8VjRlTRbQ==
Date: Tue, 03 Mar 2020 12:50:00 -0000
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 1/1] Collect handling of wpixput and wpbuf into a helper class.
Message-Id: <20200303214950.e54d472c0241dfe3f75ad830@nifty.ne.jp>
In-Reply-To: <20200303111400.GZ4045@calimero.vinschen.de>
References: <877f246b-08c2-6ccd-faac-6c90661212e5@t-online.de>	<20200303111400.GZ4045@calimero.vinschen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
X-SW-Source: 2020-q1/txt/msg00276.txt

On Tue, 3 Mar 2020 12:14:00 +0100
Corinna Vinschen wrote:
> Btw., looking through the code with this change I wonder about ixput not
> being set to 0 in sendOut, right after calling WriteConsoleA.  That
> would drop the need to call empty after calls to sendOut and thus clean
> up the code, no?

This sounds reasonable. However, for the current console code,
most of wpixput = 0 can not be omitted by this.

For example,
          else if (*src == '7')         /* DECSC Save cursor position */
            {
              if (con.screen_alternated)
                {
                  /* For xterm mode only */
                  DWORD n;
                  /* Just send the sequence */
                  wpbuf_put (*src);
                  WriteConsoleA (get_output_handle (), wpbuf, wpixput, &n, 0);
                }
              else
                cursor_get (&con.savex, &con.savey);
              con.state = normal;
              wpixput = 0;  // <--- This can not be omitted.
            }

This can drop only two wpixput = 0.

                  /* Substitute "CSI Ps T" */
                  wpbuf_put ('[');
                  wpbuf_put ('T');
                }
              else
                wpbuf_put (*src);
              WriteConsoleA (get_output_handle (), wpbuf, wpixput, &n, 0);
              con.state = normal;
              wpixput = 0; // <--- Here
[...]
              /* ESC sequences below (e.g. OSC, etc) are left to xterm
                 emulation in xterm compatible mode, therefore, are not
                 handled and just sent them. */
              wpbuf_put (*src);
              /* Just send the sequence */
              DWORD n;
              WriteConsoleA (get_output_handle (), wpbuf, wpixput, &n, 0);
              con.state = normal;
              wpixput = 0; // <--- Here

So, this might not be worth much...

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
