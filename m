Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
 by sourceware.org (Postfix) with ESMTPS id 3E2F33858292
 for <cygwin-patches@cygwin.com>; Mon, 11 Jul 2022 07:45:00 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 3E2F33858292
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MRBWU-1nycKj1ttk-00NDEb for <cygwin-patches@cygwin.com>; Mon, 11 Jul 2022
 09:44:57 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 9407DA80751; Mon, 11 Jul 2022 09:44:56 +0200 (CEST)
Date: Mon, 11 Jul 2022 09:44:56 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Update FAQs for removal of 32-bit Cygwin
Message-ID: <YsvU+P+djrd0OawP@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20220707114343.65340-1-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220707114343.65340-1-jon.turney@dronecode.org.uk>
X-Provags-ID: V03:K1:p78aL63z6EvcUx6PsnhH5RFDVm9ZYVOY1njGQwolkZrenVfPc9r
 jdHJC2BhlWSp8QJ8YUXSjKLrFQTuqQ1qDFjdXl+gXIP8fPKH/4HuFitb6gIexIKR9Eexd71
 9lMcUVzMZyHEH5XLoNk9tiB0ycAYQujnVbEVu+YyFOiDnwBWL1CbP4MKAZzsXWaWabMdDR/
 KnzC+EX76pIIBCKweO5nQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:b8xfUYEL7cc=:d9wWfVktebephDBTosD7ic
 /Kp7zrDw7HP5cmyFLCa58KpzcqIs3TM70YZhJjAFNj7QfrUTCjgheUXc6w8JxOLfCLQC+4u5p
 nh28mqhIlk8uYHDMtM0J1BpVfNJvVcXQEDkq9RPFolg4M9kItzr0alcYguzB5omnZ1Rz3PYk3
 iODqJEYGS10/5qPk06sPv0h4qVpWQixrSUKkH77T1ccpFuXhtM/45GCPc9DNaSit4P7Nkf21m
 QdzrMk4V5hQnN153UJofSDBkdHBu0aCyqqaY9tx/6iMZY23N94Qif1k0fcugnX3WzZZJFeJYn
 KL2CgHuXwf84TmGOJDm6zJ0kQu4p4urZCmAXlVJjuw0Z4yhCCJq/RBK/2uiAYrTVQEWGe4p7r
 00WdmrinUq5LVjAj1NBRwBPUhAilg9utJA+qSej74JO2pEWVncsnwHJrl8X54+/i4o8gffk7Q
 hGOsX6quxtKbYjWHJKRwtaoT/+XPlPWRpFwBHxJProOFav4hU51o7SK05vOM1L1suLxtqHXgV
 nsEt05FwRyU4hUw/H7boA/Pq2mDzHVoQJiNdEFzwFi1Tt9C0LLtj+Uu4SrHgTCSeU8ZHd2hJz
 WtSoiyRL62avg+MOY7t98DPIeKCJ4fO2i6Qe0R5xfeSEcYau7YBGRGt44HOIlGEBb9Oy4kcAC
 edK4wU8Cn4nNaz9ioAKEHvjgdHMclIiBuQZF/JD050PUiHzSNnpxXvHvhRENkBKQ11a//94/c
 n7ZL5s91ObujhPS/p067goD4RABlxJhh7O/Sfzhoq8A/1dYB6Nwh9JCvDLs=
X-Spam-Status: No, score=-95.1 required=5.0 tests=BAYES_00,
 GOOD_FROM_CORINNA_CYGWIN, KAM_DMARC_NONE, KAM_DMARC_STATUS, RCVD_IN_DNSWL_NONE,
 RCVD_IN_MSPIKE_H2, SPF_FAIL, SPF_HELO_NONE, TXREP,
 T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
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
X-List-Received-Date: Mon, 11 Jul 2022 07:45:02 -0000

On Jul  7 12:43, Jon Turney wrote:
> Update FAQs for removal of 32-bit Cygwin
> Also update FAQs for dropping support for Windows Vista/Server 20008
> ---
>  winsup/doc/faq-programming.xml |  4 +---
>  winsup/doc/faq-setup.xml       |  3 ---
>  winsup/doc/faq-what.xml        | 12 +++++-------
>  3 files changed, 6 insertions(+), 13 deletions(-)

LGTM

Thanks,
Corinna
