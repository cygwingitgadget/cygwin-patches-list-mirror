Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.135])
 by sourceware.org (Postfix) with ESMTPS id 74DB63858D28
 for <cygwin-patches@cygwin.com>; Tue, 18 Jan 2022 15:22:16 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 74DB63858D28
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MkHhB-1mUCxa0f8L-00kiSc for <cygwin-patches@cygwin.com>; Tue, 18 Jan 2022
 16:22:15 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 1F2A5A80719; Tue, 18 Jan 2022 16:22:14 +0100 (CET)
Date: Tue, 18 Jan 2022 16:22:14 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [EXTERNAL] Re: [PATCH 2/5] Cygwin: resolver: Process options
 forward (not backwards)
Message-ID: <YebbJg3DZArOdlP2@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20220117180314.29064-1-lavr@ncbi.nlm.nih.gov>
 <20220117180314.29064-3-lavr@ncbi.nlm.nih.gov>
 <YeaXUdGyYg3uirHv@calimero.vinschen.de>
 <DM8PR09MB70957B6BFEAE91059D1371A6A5589@DM8PR09MB7095.namprd09.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <DM8PR09MB70957B6BFEAE91059D1371A6A5589@DM8PR09MB7095.namprd09.prod.outlook.com>
X-Provags-ID: V03:K1:6wup1o2NVt7OsDiNq9Rxe9y7H1wQV1wQOs/iIMm/P6ej7spi5KR
 zrOWgOMY7hqJplp7NA1uwYQbBc9NDner2v/2Ht87afcig17O/IYFuCvV5+SK/Z2dyycLYHw
 GdG7KfkPpW9Ve1G9cSihBaMr+jREoccBXMTglx9cV5/34hJknhbVEWoGn1aiBtO537USAAK
 /eu4f+o80EAc97Y4xD0lA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:BiXR6KHpEmc=:z1ndL+j+WRCng788vt4mY2
 COQ2isRl+df187CWdFOQIeS0l7aXtY119WtdRpSmfBTYnrvq6gOayLhXnSHV7lxGRBWDiqBMa
 3tYtj7Dznsst2FF56w8y1wrM1pzcCaR7nBkoBV/4r2XEmT8vhvmYKYiMhRsw5DIYqZBIgRQcH
 nUPoJm98RHc75r0oxXweDfS8PqipISAmqEd+4OlcWbOC1p/SA5+dF7GjbEMCtACOs15qcuE8D
 JePDPpdt4Y0Nur3QvCcV5uQqY3lAmGh4BkpN4N8+laQyMNHHYr8Ep9lbvQOZ3uuJFoDoIGFY4
 59ip81hjSaWVKhd+kdlSHMJ1RkIo6G0cn9tvl4+m6LBFHXZK+F/TBQVBN7lM4ADb0BYkFP4F6
 rjqpV4FnkgCS32TCEzJG8IDfB/qpaB0LD0Omd25j9aGnbCQOZP9UqkpThEnUywNkThg3JcPWr
 aIzd9+2rNb8v2KW0+VhnHU4oGUQO28UK4yi4CJBIgEcBoKFbpHZmrNg1r30rI5rqaZMtkgjCl
 vo4cqt8rdCTtdnyjGCwCgzSZj7mvPpShZbWlN3iub11O3By6rRIjZmVWaBT0ne3vOTezdyhK3
 7bJfucxkvIMQCwCMWMmDfpjznPRXShHzJhHUAd9bh2Ox7LY2T1IDewzcw8f94Pnkq46cgck+p
 8AgCIVawlEkEH6hlxptzwOVBfnjmJU3LB4z67EB9ueA47DNyGE7d6NWODlO0nu5X97fHQwd5D
 pvMEjd1HYi6rw6Nm
X-Spam-Status: No, score=-96.8 required=5.0 tests=BAYES_00,
 GOOD_FROM_CORINNA_CYGWIN, KAM_DMARC_NONE, KAM_DMARC_STATUS, RCVD_IN_DNSWL_NONE,
 RCVD_IN_MSPIKE_H5, RCVD_IN_MSPIKE_WL, SPF_FAIL, SPF_HELO_NONE,
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
X-List-Received-Date: Tue, 18 Jan 2022 15:22:18 -0000

On Jan 18 13:58, Lavrentiev, Anton (NIH/NLM/NCBI) [C] via Cygwin-patches wrote:
> > I pushed patches 1 and 3 to 5.  I fixed the consitency typo
> > throughout.
> 
> Thanks!  (and oops :-)
> 
> > Right now, the debug flag gets set in several places throughout the
> > code.  Given you set the debug flag above, doesn't that mean several
> > code snippets setting the debug flag later in the code can go away?
> 
> No, they can't.  The flag can be propagated from "res_init()" from the user
> land.  When /etc/resolv.conf gets loaded, its "options" can also specify the
> debug setting (so it should become active since then), but formerly the code was
> using only the init-provided value in "get_resolv()" yet the debug setting from
> "options" (parsed by "get_options()") only affected the options themselves,
> but not the calling code in "get_resolv()", which kept on using the initial value.
> That made the remainder of the file parse to continue "silent" unless "res_init()"
> was previously called with RES_DEBUG.
> 
> So that was, again, inconsistent! (see, I can spell it this time around :-)
> 
> Post-"get_options()" assignment is not an additional assignment, it's a refresh
> of a possibly changed value (for a local "debug" variable).  I think the patch is correct,
> and it works, for what I am concerned, -- I checked that and was using it.

Thanks for the description.  Would you mind to recreate your patch with
a matching commit message text explaining the debug flag setting?


Thanks,
Corinna
