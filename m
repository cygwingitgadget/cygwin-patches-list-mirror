Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
 by sourceware.org (Postfix) with ESMTPS id DCE3A3858C27
 for <cygwin-patches@cygwin.com>; Mon, 25 Jan 2021 10:30:58 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org DCE3A3858C27
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MnagF-1ll33c27ZV-00jYbJ for <cygwin-patches@cygwin.com>; Mon, 25 Jan 2021
 11:30:57 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 1C868A80D56; Mon, 25 Jan 2021 11:30:57 +0100 (CET)
Date: Mon, 25 Jan 2021 11:30:57 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v3 1/8] syscalls.cc: unlink_nt: Try
 FILE_DISPOSITION_IGNORE_READONLY_ATTRIBUTE
Message-ID: <20210125103057.GB4393@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20210122105201.GD810271@calimero.vinschen.de>
 <20210122154712.3207-1-ben@wijen.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210122154712.3207-1-ben@wijen.net>
X-Provags-ID: V03:K1:qbkGBSC8Wv9X0nrQ5VWKf5Ky9Ndyvy/wPEebgdJCn79ge4c8Xtu
 1tAM6EnUH0dz1B+kJnsclKEnEbtgxJaxSTt2hXB9i6HMEmLvaiXGJFjwKDOp5E9/QXcaU5v
 lgKgIe0ILrgnlp0d6zSu3iMWSk1FISa7h8pBSxgKtBF+XrSZdUbOHNf3Yrupg6RenxSZPRV
 Lg5Y6DYPNJWrDeA4kX6JQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:CAF63Pdg4Pk=:bPTTvpBhTBQBYhn4ad6Z5k
 J8CwRsO212swavHLKuBgh//RqxXN2R7ez9L0SltWt2HZvTlK/CKC7n+hhu8+s/poc6jMRptjT
 zidUeCdVCqJZ+gXyRs4dSEoVtJ9YLrfAtD7z5n925yFujYfmcZGpcopKJmK0WsAT7+kiCOHSO
 up2+dO1AGUwqfg4HxBJL7CZBi+TK8U639WihZs5Mxz37k/k2E7aQxbFhClvbR0KsD4AZFAz0h
 Edik3/os7FsjTM8h3qZNa5qrF9qSQRM1gPqJ3TjEpb/2k/XlnHFhgrzYLBmm9CmPnf+INtNal
 2NFLJMnyGaDjNx7z45DuOU5ojWZdFhFrKBRaiolbStyDClV77QTxTqR8/Mf8M6omqcc2ACilM
 Qi0VnyVmArENNnapan7HiF5YyrAXaoOzn6pliW15GXIPKJLDB+7GhNxlxVfcD0Y6WnUZXP054
 V0E12Psvgw==
X-Spam-Status: No, score=-101.1 required=5.0 tests=BAYES_00,
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
X-List-Received-Date: Mon, 25 Jan 2021 10:31:02 -0000

Hi Ben,

On Jan 22 16:47, Ben Wijen wrote:
> I think we don't need an extra flag as we can utilize: access & FILE_WRITE_ATTRIBUTES
> What do you think?

Good idea.  Pushed.


Corinna
