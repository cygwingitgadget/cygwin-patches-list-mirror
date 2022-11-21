Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
	by sourceware.org (Postfix) with ESMTPS id 76A4B385840C
	for <cygwin-patches@cygwin.com>; Mon, 21 Nov 2022 11:48:13 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 76A4B385840C
Authentication-Results: sourceware.org; dmarc=fail (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MYNW8-1oReTy2O0Y-00VQWT; Mon, 21 Nov 2022 12:48:08 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 506B5A80974; Mon, 21 Nov 2022 12:48:07 +0100 (CET)
Date: Mon, 21 Nov 2022 12:48:07 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: Takashi Yano <takashi.yano@nifty.ne.jp>
Cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pty, console: Encapsulate spawn.cc code related
 to pty/console.
Message-ID: <Y3tldy9QiY4mN8A1@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: Takashi Yano <takashi.yano@nifty.ne.jp>,
	cygwin-patches@cygwin.com
References: <20221120094336.1637-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221120094336.1637-1-takashi.yano@nifty.ne.jp>
X-Provags-ID: V03:K1:J4342RJHIm4OMFWfvk6ea3TUFivivv87TR1fPbu8KN5eAhFopu4
 /t5kfSJhgaZ4H/mDDny4s9sZ01bm0M61XZijbWqCtv9IPWceylpJe+80BipN9pfksd161Xw
 pCPyGdviggoO7oAIJ6eIBkIVL9wGtfL23nwr5GjvNTqwr8ulbyWiXnzeWin6/DJls+VoIff
 Tge6089zaNVpIwuaG1AxA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:s4+1NuPmFrY=:4Q6Mjvu9Xq3gkgSNEsa1Ax
 +B4LfJH+DNaQ09Eyf0e4o+O03Yo83uENt0A7Uk5O9IdwgrJLz8NEFW/ThBJINNdKra0Zr0MN5
 dqn6lnXoRmeCw0m/o5klm2sTYlDp6XLwRpITSsPtYeKmeIEMyCNAurWW05jQMpIAhBoZMDYCR
 yPHYqPLSAqQ89vev92Mqm28WxIX9U1FegKlefcdwX/vcs4zdjW5+IFy8mXuGd1XbrnTx2QFHQ
 p3aW+zsI8AedgQ3NjN7SpbYKiIICbEm/lNta0So10jIVEqPK/IMQJ5fHy1JtgUAq7IGgzViJ0
 EhmAzLLumKTnSHTB2+uF9dtQxXZEGaCkxRjvI8xBWDP87sF8M69sDgZwNjgorEDCmbXcH3Nhk
 gUi72CP/d8IK4NnegDHqipapG+ikecwgpIoaqXHFD5Nm5DMiEjvAaOJUTk+D5E1cnYSag1a22
 iWt5GWs0F9nNoPpaKiAudc/E83/tOpUqeiq0eAr/GvVwbd8JnAv0zE/h3rXhAAwK/5/NrQHHL
 D95kn5OwkrYU0sB86QhobojhJXKTCcbeNfU90/0QnYczcHNz1b1tJVcaTowvj3jssPiICLN/y
 wunFR0GBd2Z56vM/mubutV80dm9dnxbHhRAvEbW7kR9sTz0VdJaI846JHqJlRWtFcP8UZgY9K
 mmnceZ6rKNHoNEVBJJJGnnStO5oFokIJvhdFH17b0GeR6LNXpkohzadTCEOqn00znsBPlYCTl
 FI1B2G2QTdo+JE5t1y9C8jJqSeSJUpcEKkOIgLHfOb/VixwyQM4+ppUUnMXHG/PsVv/faQHGx
 ynpXMfxs+6k+Y8cc5+9o8IxqVqlAQ==
X-Spam-Status: No, score=-96.0 required=5.0 tests=BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_DMARC_NONE,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_FAIL,SPF_HELO_NONE,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Nov 20 18:43, Takashi Yano wrote:
> - The codes related to pty and console in spawn.cc have been moved
>   into the new class fhandler_termios::spawn_worker, and make spawn.cc
>   call them. The functionality has not been changed at all.

This is great, thanks!


Corinna
