Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.131])
 by sourceware.org (Postfix) with ESMTPS id 990EE398D062
 for <cygwin-patches@cygwin.com>; Thu,  8 Jul 2021 14:48:30 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 990EE398D062
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MBUZr-1lt1ve0ddX-00D2Zh for <cygwin-patches@cygwin.com>; Thu, 08 Jul 2021
 16:48:29 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id A66B8A807A2; Thu,  8 Jul 2021 16:48:28 +0200 (CEST)
Date: Thu, 8 Jul 2021 16:48:28 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] Cygwin: respect PC_SYM_FOLLOW and PC_SYM_NOFOLLOW_REP
 with inner links
Message-ID: <YOcQPNGJmy8R1jJz@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <alpine.BSO.2.21.2105291322180.30039@resin.csoft.net>
 <alpine.BSO.2.21.2105291600460.30039@resin.csoft.net>
 <alpine.BSO.2.21.2105292259570.30039@resin.csoft.net>
 <alpine.BSO.2.21.2105301213380.30039@resin.csoft.net>
 <YLSYIC/yYFz2IdMS@calimero.vinschen.de>
 <YLSbqEipANVY8KSZ@calimero.vinschen.de>
 <alpine.BSO.2.21.2107071146320.56404@resin.csoft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.BSO.2.21.2107071146320.56404@resin.csoft.net>
X-Provags-ID: V03:K1:xFALg++iOPO6F89AUsHeOQ828JvKpGOdjf8S/tgsuz9mi8yPJ78
 uSSf+j7seGKV1DeXf3dh67VdAu0+nPw4gK9DTTtKKjBDvvy45tLPc7WAnWDI76YE1f2e/ze
 hUKeQt2fQKiv8UPG7e5Egmo92p9NM8MwCHMRfzqXb3Fqj1NZVGEOOKIvntPPgqyATTF34uE
 8w0UloFYi5Qtc/Nzuz+lw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:enFUnyvIyNM=:7WyHw/Yx/lHZF/5YXifHQR
 8jgLcfAFDxYOVTrrU4bSN8LrKlDqeGbG2UD39H7WH1bW6uZBdR4PWlNdqNLAtO6Ghbz6/UNKV
 wPsFmuzwcvpTcrE6h07ukz2kjJQ30uLQYnVqsd8y8ydMGajVhPt89ZR8xPLDf21SP/INPX81D
 oYi46Si+dSZ+nScNyGzkxtnkBJECzF0p3uLlyAzn+SyDy30kF7zKX2kI2zDusdikeK9VX/LOL
 tzAyoyfXPDJdr9/yk7OFpVa3uemHdVBnyNyAOxlf42Tq3WgwWz230qZ2rINUg0z6Vvspvr40i
 CzUQYcSlji2ac9ZZ4Imi5+CtKKfbANdTAsdHWdE9RLRnPxKev8JxZS0VFK11i+2c3dI3lUm8L
 vvQCI8AOnsXdH8OaK2+8PgfPwSqWvl4rAiKTI8J7iw3/RMtB5gE6Wt/KAVyhIjOTaIwn8ARtN
 cLfx69RUUbhx3JDgjt6XXDlsiulX3QG1p0LEdEV4WdepGD3hiiszAJaY2Jaqq4/en+ZicqzGG
 oapVZOx3b9J/ZmKh3y1GwyIFZpfgT0Vi8Tg5S2Cq6qhqySFK726hb7TASjbP/qHehmNrUztl3
 JXyXEv65wHqTX6HpoWgV2vghu9hQWCsjxQdLmBh7C7W5qXMzp9jAPTgUZRjj/ImBS061RquH0
 gWf91PFH1TTqq5DiZggJnKgh/yxy8kL6JgiC5dt6j3wU3uWCzrpAVI2/g254NuLynV8BqOZeP
 kJJSdf7xNbeyZSQCLVkoDApovBsCZBIZ+JM5kJ/4QvCFfasxmOyRemIndEXQfwXypVuJUJxtX
 tJOKHYxHlhYnGfxaO63MXJGRnCyjpU4BZV/Wxm5Bvp9IBOYOdgw1F+ljZjIP0wIGM+3lGpXCc
 ToEFkz5S5BX6VJZ18/bQ==
X-Spam-Status: No, score=-100.1 required=5.0 tests=BAYES_00,
 GOOD_FROM_CORINNA_CYGWIN, JMQ_SPF_NEUTRAL, KAM_DMARC_NONE, KAM_DMARC_STATUS,
 RCVD_IN_DNSWL_NONE, SPF_HELO_NONE, SPF_NEUTRAL,
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
X-List-Received-Date: Thu, 08 Jul 2021 14:48:32 -0000

On Jul  7 11:52, Jeremy Drake via Cygwin-patches wrote:
> On Mon, 31 May 2021, Corinna Vinschen wrote:
> 
> > So we have two contradict problems, one which is solved by following
> > inner symlinks, one which is solved by not doing that...
> 
> I hesitate to suggest it, but maybe an option/setting in the CYGWIN
> variable as to whether to use this new behavior?  I am pretty much out of
> ideas on how to make it work with native programs where they expect to see
> the subst or mapped drive, not the target or UNC path.  Then MSYS2 could
> either patch to change the default, or else just tell the (probably few)
> people who hit it how to change the setting.

If MSYS2 has to patch the code anyway, why not go the entire way and
move the full patch to MSYS2?  Lets not add more CYGWIN options for rare
border cases, please.


Corinna
