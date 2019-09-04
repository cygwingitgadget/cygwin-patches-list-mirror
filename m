Return-Path: <cygwin-patches-return-9605-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 61475 invoked by alias); 4 Sep 2019 02:47:20 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 61466 invoked by uid 89); 4 Sep 2019 02:47:20 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-2.5 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=proprietary, sessions, screen
X-HELO: smtp-out-no.shaw.ca
Received: from smtp-out-no.shaw.ca (HELO smtp-out-no.shaw.ca) (64.59.134.9) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 04 Sep 2019 02:47:18 +0000
Received: from [192.168.1.114] ([24.64.172.44])	by shaw.ca with ESMTP	id 5LKEivGv8UIS25LKFiGAK6; Tue, 03 Sep 2019 20:47:16 -0600
Reply-To: Brian.Inglis@SystematicSw.ab.ca
Subject: Re: [PATCH 2/2] Cygwin: pty: Disable clear screen on new pty if TERM=dumb or emacs*.
To: cygwin-patches@cygwin.com
References: <20190904014618.1372-1-takashi.yano@nifty.ne.jp> <20190904014618.1372-3-takashi.yano@nifty.ne.jp>
From: Brian Inglis <Brian.Inglis@SystematicSw.ab.ca>
Openpgp: preference=signencrypt
Message-ID: <e8c3b43a-7988-bb2c-a52b-dc792677dd96@SystematicSw.ab.ca>
Date: Wed, 04 Sep 2019 02:47:00 -0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190904014618.1372-3-takashi.yano@nifty.ne.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
X-SW-Source: 2019-q3/txt/msg00125.txt.bz2

On 2019-09-03 19:46, Takashi Yano wrote:
> - Pseudo console support introduced by commit
>   169d65a5774acc76ce3f3feeedcbae7405aa9b57 shows garbage ^[[H^[[J in
>   some of emacs screens. These screens do not handle ANSI escape
>   sequences. Therefore, clear screen is disabled on these screens.

Dealing with escape sequences is way out of the scope of any pty driver.
It is up to the terminal emulator or applications running in the terminal to
handle terminal characteristics appropriately.

The pty driver should not touch *ANY* escape sequences coming from the system,
nor should it generate any to it, as TERM may not be set at the time, or
appropriately or usefully in some shells e.g. cmd or powershell.

Most folks probably use mintty or cmd as their Cygwin terminal, but some use
other terminals, like various flavours of xterm and rxvt, with ssh sessions in
and out, so they could be on Linux consoles or proprietary AIX/HP-UX/Sun
terminals, and operate properly as long as they have a good terminfo definition.

I see this issue as similar to the Windows text file handling changes required
when coreutils/textutils went POSIX and removed '\r\n' crlf handling to give the
same results as on Unix systems.
To handle terminal characteristics properly would require terminfo support in
the pty driver: I doubt anyone wants that, so the best approach is to do
nothing, and let the terminal or application handle it: they are more likely to
have the configuration options or hooks to do so easily.

-- 
Take care. Thanks, Brian Inglis, Calgary, Alberta, Canada

This email may be disturbing to some readers as it contains
too much technical detail. Reader discretion is advised.
