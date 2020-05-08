Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
 by sourceware.org (Postfix) with ESMTPS id B9AAB396EC8C
 for <cygwin-patches@cygwin.com>; Fri,  8 May 2020 10:11:49 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org B9AAB396EC8C
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=corinna-cygwin@cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MEC8L-1jMnMf27nx-00ADOI for <cygwin-patches@cygwin.com>; Fri, 08 May 2020
 12:11:48 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 094F6A80656; Fri,  8 May 2020 12:11:48 +0200 (CEST)
Date: Fri, 8 May 2020 12:11:48 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 00/21] FIFO: Support multiple readers
Message-ID: <20200508101148.GJ3947@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20200507202124.1463-1-kbrown@cornell.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200507202124.1463-1-kbrown@cornell.edu>
X-Provags-ID: V03:K1:ih/n3PZTipNtVMVLMpEq2eS/NwEe/S0s8C7n/q5huUZkdZqnbMj
 th/eWw3nX0huOLNxf7HkRQ56uGaJIgiYb78MXVkNakW309I0vaikPdx18rEu2KHmBDZ6P3Y
 ml8VJ6KMphmK7iV9GZS5vAqNMsVsGo63U/Ya/cz+8tu3jpVIe4XESWGB+pyk3LUbLvkgpoD
 jPagrRAyN87nMS8PBTMGQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:0bBPx3PPyLY=:cAGzm2DYpavTvCDT2kFzuB
 zVQvNzc9sVxooAE9wIAMJBvXbZ76NFURYNUbfZJgG468mzFych2v3d9XFDKe6VO76OO0hdoO/
 0YambZLolSf5Imv/Ot1/iAi0OeT89/AYYDzXY4m6Nb86cly5w9zPdzgRtjkuYi2x2jF4KwRrJ
 nlyC6uXwEXVIW36S4GlpYg59U1eP8PeDsoOcw0Ux8YXXcIHfRlim6VhQ7U669vTOS781FDvY0
 Cbx0Qe4rnJ0YzINZptEfhw7cdBx1Iud3hF8CbfC7bg0ZIrYPc1WEIO78+ExBv+jRv0fi2nQH1
 QXNL0qzOxrQArT/YIP/SNnZt7ccYvYpMoX7/Gzei2jhJmsn8Kk/G1Nc3m3TMWaYPitgVRQT6u
 ZAy1xHFEqfvz+kPi64/C5TXpDdyoUtlHn3qOtiGRsnNYg2pgSF9+txgtrQzqrgglw88/zjA0B
 Bw/xrgrR124vF1TVTV5SZhrMk0LAfyia37uY7LdLgAcHtUF5mREkLTISpKmhwvbZ/USs/BF7j
 dN5NxgIk5M2zkofj/kWhqh0McbMsv5fWIJrpJkHsFY0EfZkr98HqixPCsKWCQ4ayv0+1twQqp
 +UQZvvMYuKy3HCpPs5YxYV8ihhK5ERM46Z/7UKpcQ5yyJvfd55s3raTeHAoME2irl6+v7IdJY
 8R1efGs1dApRWXT4lR7uqV+76hfhPQiJggIshX3owyhrJOTbMW02i+dV8d52c6VBawso6y58h
 5f9cwlr/8SZunGJ2UnLQuWkhuk7MvqSnWihelM9C2jYh62XVnx4RbUdL/HfZkI9AgOWGpmZLM
 uugr+Xbhll/lM5JtC9bFOMNaOa7/S741gx1ON0FhpnaXnQivG84M7sI0/pIrltSv6pS2iIe
X-Spam-Status: No, score=-98.1 required=5.0 tests=BAYES_00,
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
List-Unsubscribe: <http://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <http://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Fri, 08 May 2020 10:12:00 -0000

On May  7 16:21, Ken Brown via Cygwin-patches wrote:
> This project began as a an attempt to allow a FIFO to be opened
> multiple times for reading.  The initial motivation was that Midnight
> Commander running under tcsh does this (unsuccessfully on Cygwin).
> See
> 
>    https://sourceware.org/pipermail/cygwin/2019-December/243317.html
> 
> It quickly became apparent, however, that the current code doesn't
> even properly handle the case where the FIFO is *explicitly* opened
> only once for reading, but additional readers are created via
> dup/fork/exec.
> 
> This explained some of the bugs reported by Kristian Ivarsson.  See,
> for example, the thread starting here:
> 
>   https://sourceware.org/pipermail/cygwin/2020-March/000206.html
> 
> as well as later similar threads.
> 
> [The discussion continued in private email, with many bug reports and
> test programs by Kristian.  I'm very grateful to him for his reports
> and testing.]
> 
> The first 10 patches in this series make some improvements and bug
> fixes that came up along the way and don't specifically relate to
> multiple readers.  The next 10 patches, with the exception of "allow
> fc_handler list to grow dynamically", add the support for multiple
> readers.  The last one updates the commentary at the beginning of
> fhandler_fifo.cc that tries to explain how it all works.
> 
> The key ideas in these patches are:
> 
> 1. Use shared memory, so that all readers have the necessary
> information about the writers that are open.
> 
> 2. Designate one reader as the "owner".  This reader runs a thread
> that listens for connections and keeps track of the writers.
> 
> 3. Use a second shared memory block to be used for transfer of
> ownership.  Ownership must be transferred when the owner closes or
> execs.  And a reader that wants to read or run select must take
> ownership in order to be able to poll the writers for input.

This looks great.  Please push at your own discretion.


Thanks,
Corinna

-- 
Corinna Vinschen
Cygwin Maintainer
