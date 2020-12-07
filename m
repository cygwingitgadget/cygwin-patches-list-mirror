Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.131])
 by sourceware.org (Postfix) with ESMTPS id 5D2213896823
 for <cygwin-patches@cygwin.com>; Mon,  7 Dec 2020 09:43:22 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 5D2213896823
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MRn0U-1kbePM0N4M-00TAuC; Mon, 07 Dec 2020 10:43:18 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 97CAAA80668; Mon,  7 Dec 2020 10:43:17 +0100 (CET)
Date: Mon, 7 Dec 2020 10:43:17 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Cc: Jon TURNEY <jon.turney@dronecode.org.uk>
Subject: Re: [PATCH 1/1] cygwin: use CREATE_DEFAULT_ERROR_MODE in spawn
Message-ID: <20201207094317.GI5295@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com,
 Jon TURNEY <jon.turney@dronecode.org.uk>
References: <alpine.BSO.2.21.2012031317260.9707@resin.csoft.net>
 <20201204121043.GB5295@calimero.vinschen.de>
 <alpine.BSO.2.21.2012041028060.9707@resin.csoft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.BSO.2.21.2012041028060.9707@resin.csoft.net>
X-Provags-ID: V03:K1:Mt6rOgSKKMM5HIj4z8KjZgf0tFgK0NVdNT8vhGeXIaXXCMcypUk
 WzqRx3CQs0I5JKfmfEUkbb5l5NZpvo1xzGh3rr3Via+AVraeC1mrHV+qWvpgh13U7c0DTFI
 AcAvzQxfOxHvXTsj6saq1OPBvOwthILKVXgeyPn1uTNUTSvdyfUuHRtdN5/EOKqkSx3X4Ky
 hwJDQcxeEvQX6K9SaqQJA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:njf5UQefB1I=:ruA3FQ0a7Ubpfc5IbWo7Da
 7OKqVE10m8+xDe7mg5bAffq9NVh9lpZhPoreM75FL/6Civ5aYHsv3UMNC75r1eOPFhe5E/p/G
 XyjxUf/sZRnwRxmv3p1QWWoJcpd2oxn2X5g/E7uYDItMdjeerJXUJDBzZ76MSl0xR8rWGqvhF
 zBlqdx0e1yNOTKZs8PgNrWC6EdzuaV7BELRCm+DWwK1To7YSmgylFAjSxFhHH7YvR1LP9UJdW
 JlofW985noaZKTjgxLVqSF2F5ODkrui3+VNLcKXZ+10P3lcC2LIizfeFoMjmfT8MiLmOLdRd8
 6ZFMYuMjYuCvXXsZVNZMl8Yobnn8svZNL9IeHkXluI2JYCZkn2d/D+ERWsTScT+cYU3WspGX3
 USwK9TbMcrTpRodpGp38/q1dEiPgqCmN31OY9UnDv/mtjPvp2Qyik+5TS29WkvwHJZk8oOz8n
 Uw2UJqv0fg==
X-Spam-Status: No, score=-100.7 required=5.0 tests=BAYES_00,
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
X-List-Received-Date: Mon, 07 Dec 2020 09:43:23 -0000

On Dec  4 10:35, Jeremy Drake via Cygwin-patches wrote:
> On Fri, 4 Dec 2020, Corinna Vinschen via Cygwin-patches wrote:
> 
> > I'm not happy about a new CYGWIN option.
> >
> > Wouldn't it make sense, perhaps, to switch to CREATE_DEFAULT_ERROR_MODE
> > for all non-Cygwin processes by default instead?
> 
> In fact, my first iteration was to set that flag unconditionally (relying
> on the fact that SetErrorMode is called extremely early in Cygwin process
> startup rather than only setting it for non-Cygwin processes), but I
> received feedback that it would be better to put it behind an option:
> 
> https://github.com/msys2/msys2-runtime/pull/18#issuecomment-723683606

Jon, thoughts on that as GDB maintainer?


Thanks,
Corinna
