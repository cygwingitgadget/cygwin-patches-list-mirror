Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.134])
 by sourceware.org (Postfix) with ESMTPS id 7E56C3844025
 for <cygwin-patches@cygwin.com>; Tue, 13 Oct 2020 11:28:31 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 7E56C3844025
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=corinna-cygwin@cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1M58vU-1kRC1349zw-0018rs for <cygwin-patches@cygwin.com>; Tue, 13 Oct 2020
 13:28:30 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 619C2A81873; Tue, 13 Oct 2020 13:28:29 +0200 (CEST)
Date: Tue, 13 Oct 2020 13:28:29 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2 5/6] Cygwin: AF_UNIX: listen_pipe: check for
 STATUS_SUCCESS
Message-ID: <20201013112829.GH26704@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20201004164948.48649-1-kbrown@cornell.edu>
 <20201004164948.48649-6-kbrown@cornell.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201004164948.48649-6-kbrown@cornell.edu>
X-Provags-ID: V03:K1:KW5BXlLaVV8ebLjzk+8cqinQW3wr1N7NwpoTIdefjfrWRgbMY+s
 VIxgSL2Rli6eq2tstE73/kxWOGU/Ufm41T+1IDk9P5i73oCWrnAeAiCPB5bPNcCmKjZKGnF
 o5qF7Z7DaHdBX5rFD26PQO8G/YiuZxp9QvEcXduU3q/gw6TAktdG0SCU6Ng9D4klNWce8iI
 Dch0PGpxtIfLP41FClZgA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ujaZgDJPoWo=:vGJfYGQ0EBRFfKtl4stgdL
 qwRJXx6URN4OAyWIr5Rn34O48UB10910AB6S6EhZY1FyZprzK/49y0K4tOmxxlRlyXpA8PilG
 nPTOC4LO+BcRThFJ1R5E9K4LXS8GD3M0yisN8k+4+YDfynG1vXogjzdOaCLhvFiAESVGtxTG9
 npJtLP0cvT4GGHsbgZfeRlh7ANn7dvbduHlUmrMqqFxNuqVK8IaDLBhWSa5J5j6ahAWzjzPFS
 EnC34CtQyzPGnbRZwVR+WEKoVHOpcRD/VAuRyJJVdYcUhjgM+hu3Yqz8RTEDtLz5vZzRZYNW6
 9v7Ohnp9eNtzAqBR40PR8aV/DEaW+4mYPdK7fXFKXU3Jxd0B0NedDSuwKkkC/cXAQd1jqSXJy
 hysqVFfNkajiQpiFbEBHEhDKvD+HZdzRMGye1JBEmLdbWN7uBxWZTNFMvHrmflILgdlQ3POUA
 LTWlnlgNqX4xzkU6KWmEu0hBXJ/8g1lw1cKYgg8o1xy9sVKrpiLfUbh9D1LfLSNvKO2EbPfWP
 gzpr6PP+7w0EdycxnOhmAGiu3OxWSS5nIi0kfWYYujKgQAfpR0D2A4ZOU3YaupeKQDvhWqdOW
 31gmIAmkksoxAGTr89B8BGl/chRi376pLpssrks0akvH6WKYFmFN3RzI6fAo4hGR5PP6jle62
 kucJvzcVwiHvHokyu1gJ41FJ5TpD8Kgpl8jNSkhIaOeY10gx8dcrOj5tS3NFzAotl8eLWPC29
 mgTM2hqGQdyYgmbhGZ4PQOoPQeCEJqxDdBB6rl6vG6X/0S/iCd+pVctsGT2/lJ9SntJtJUU5O
 048FkvugFfrn3MwuRgZo2HVmR5qSXtUKTpPM93vxNtFnqHQJ0Mbc33kStRSy1ufgo7rdzEhzK
 fsJZqkY6+lyslMkV7p0Q==
X-Spam-Status: No, score=-100.4 required=5.0 tests=BAYES_00,
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
List-Unsubscribe: <https://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <https://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Tue, 13 Oct 2020 11:28:32 -0000

On Oct  4 12:49, Ken Brown via Cygwin-patches wrote:
> A successful connection can be indicated by STATUS_SUCCESS or
> STATUS_PIPE_CONNECTED.

THanks for catching but... huh?  How does Windows generate two different
status codes for the same result from the same function?


Corinna
