Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.74])
 by sourceware.org (Postfix) with ESMTPS id 01DEA384C005
 for <cygwin-patches@cygwin.com>; Thu,  9 Jul 2020 07:56:22 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 01DEA384C005
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=corinna-cygwin@cygwin.com
Received: from calimero.vinschen.de ([217.91.18.234]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1Mt7x1-1kmUqS2lTN-00tXOb for <cygwin-patches@cygwin.com>; Thu, 09 Jul 2020
 09:56:21 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 39DE2A8068F; Thu,  9 Jul 2020 09:56:21 +0200 (CEST)
Date: Thu, 9 Jul 2020 09:56:21 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 1/2] fhandler_proc.cc(format_proc_cpuinfo): add microcode
 registry lookup values
Message-ID: <20200709075621.GM514059@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20200707190036.3404-1-Brian.Inglis@SystematicSW.ab.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200707190036.3404-1-Brian.Inglis@SystematicSW.ab.ca>
X-Provags-ID: V03:K1:kJ1m43y6ptUiacWoDlN/Vgf2vCvQVDtqMIJZsdoGt81kFvjZdVN
 3+ozXSycQFBMMeM3g2arLvUHfy5a7GUiFSadXghG/z7JEt5e2tAxz4tJ0vrWfr53wJC0uNG
 LW4NFQyyVjRWPk7IQfhlEhxBHVkFekFqYf/NiLyZfbikxXU6Ze0OyfR1gHBgnovRxLj67Iq
 ZNu/H9/0oZkRk9SLjGGSQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:jJGeLtMJv9w=:3/jtuDn0heMEjzligKeBcB
 lM1Ifqz33/nfNp5t6yi6LyrARmzdLXOEzK8G4BAKL9t/Ova7skEWJjU+gbIhDDp3fOMTTAFqi
 4IrfOHKC03usRYGtcGgrL6OCD0IRpl7Bi1OXYgYPyEJAaIx2WE+jVqmPJNlbVp4A/AlZ5NJOE
 6XrpEJWAg2x/g/HD8bP2owgzmV7rlnrWuvrtMRxl9flk20t0iHXGUF/phxnOrkZF6R96WNYNO
 UCTexFOO5JfPR1dAcBebKZ0t93TYRPk70r7wexxPdC3eEwAe7uo7azVk2WroPf6iZ+HEfgJqh
 hbeEcVZpaxgqqnA4KTeiSKJ0D9iRkC1P2WNkLY/0SlxykBh7rSaW0Yql2cyw0WW7cXfmEIMWW
 jLmNTLTp0SsU6c+RihngncvdgmAXEPaYzPc0UINk62nmTRhPApuYsn4xDgBCJyE4vcABBleWF
 uQQKHp9pfZ3aF69Ou5wQNphLlJLgjjNaz/7p28e/DA5wIkGn4VUn9tCaW+dD8f9fCsBlixkR2
 nCgkD1FI25xgX5bF7Bf3JmEtj73v4LgkxwVmLqio4l1eIs0/mrFiSuVAL59Bpe6XCR8m/hqwS
 Mi2tv1yEVPp1Hggji9wl++JpdNTVCvRxrszaYbA78ayfP75ow09B0wtp/3uY77NpZO0J3w0HI
 gFWXtUHy4zqNC0mrHqZgk2JjIrfJhWre26dP27kA02BBbuEwkHfqZnKbGxMzej/lt3Ym0DGzI
 ExX+4FXmmgw3f+FM+lSZ13k4GHmpgdlQXQjkUXBvcEYgwmUBcOLN6kBvODe5+DoqA6tkDqzII
 zLMtYyK3RLQuYANfMNMgOVr1hGMh9gDLQwP1YY8ZkUvidQ3mRqw/eySThU7tC58CivTUWOdnu
 sCPGrIsj5qvbK/bJGF1A==
X-Spam-Status: No, score=-98.1 required=5.0 tests=BAYES_00,
 GOOD_FROM_CORINNA_CYGWIN, KAM_DMARC_STATUS, RCVD_IN_DNSWL_NONE,
 RCVD_IN_MSPIKE_H2, SPF_HELO_NONE, SPF_NEUTRAL,
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
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <http://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Thu, 09 Jul 2020 07:56:24 -0000

On Jul  7 13:00, Brian Inglis wrote:
> Re: CPU microcode reported wrong in /proc/cpuinfo
>     https://sourceware.org/pipermail/cygwin/2020-May/245063.html
> earlier Windows releases used different registry values to store microcode
> revisions depending on the MSR name being used to get microcode revisions:
> add these alternative registry values to the cpuinfo registry value lookup;
> iterate thru the registry data until a valid microcode revision is found;
> some revision values are in the high bits, so if the low bits are all clear,
> shift the revision value down into the low bits
> ---
>  winsup/cygwin/fhandler_proc.cc | 44 +++++++++++++++++++++++++++-------
>  1 file changed, 35 insertions(+), 9 deletions(-)

Series pushed.  I'm going to release Cygwin 3.1.6 today.


Thanks,
Corinna

-- 
Corinna Vinschen
Cygwin Maintainer
