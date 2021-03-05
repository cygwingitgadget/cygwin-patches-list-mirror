Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
 by sourceware.org (Postfix) with ESMTPS id 738E63858025
 for <cygwin-patches@cygwin.com>; Fri,  5 Mar 2021 14:48:31 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 738E63858025
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MuUSa-1lZJAC0Ukc-00rZBk for <cygwin-patches@cygwin.com>; Fri, 05 Mar 2021
 15:48:30 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id BAE2AA8060B; Fri,  5 Mar 2021 15:48:29 +0100 (CET)
Date: Fri, 5 Mar 2021 15:48:29 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] cygwin-htdocs/lists.html: add note about attachment size
 limits
Message-ID: <YEJEvehu3dGVU77r@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20210304035556.10550-1-Brian.Inglis@SystematicSW.ab.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210304035556.10550-1-Brian.Inglis@SystematicSW.ab.ca>
X-Provags-ID: V03:K1:BXY+mpRd7hjYf08MSz6irQ+LRsmeqQLrypNQhleNzzm2S2ApDdw
 WSyMY7MZNgwbw1dM9ogKpdy6rfsue2JLWYi+3M7BsGV3HVE5HNVqYcs6J4eyo+Ga6gG0M0X
 h4pKTbwCaYV9OBSVZZTp9nJiWZ+uDC67U4NMxJjd5lYAzt62KBQvlHMey7zyLRU7Br0CeHY
 e4WEToWru+FaovKEBSXHA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:QxMxGn+BtOc=:hgNFfy017iu+fBRLHubLe9
 oEJPpu/gpOMD+jtf9Ompk4LynEv9chBDQrAn1/okOlIG1JodIt+RiXOUjOljxbtjt8OXVzLo1
 N2CrlRG44MuXh9BAJFwnleUmM/aQKc5JvH2MSuzRyUrTL+sSuZVMzTYfnmGGQWIuwQOPFfh2l
 Lqds6TRAeNx7I+wfVjK+a9X54gk5TvoFvtZiUnzSPCMSqNsayOWdANKvXh3kJ4PtqaihGLM0v
 xaGt23uENJom6RX44EMoSUSQcjO0JiZwu4Nd8+wR7MP/BzOniqfXw83Vg5z7EZmao/BGffxpN
 eAXYzusnMuZ3Pn/Aa9w/fc0LEtrEIB5LcMdBWbom0LX4JPYMMtQzdfoK5t8OhZ7SIBjigjUdh
 DMOUX1GaQLsY4hyQUgIjNvCrhPPlDQteTbAHEmXawC9un8Al8ltBTXjU/rg5E+6v2VIMZhdYG
 Q85b5awgvQ==
X-Spam-Status: No, score=-107.4 required=5.0 tests=BAYES_00, GIT_PATCH_0,
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
X-List-Received-Date: Fri, 05 Mar 2021 14:48:33 -0000

On Mar  3 20:55, Brian Inglis wrote:
> committer please adjust based on actual size limits if different:
> (256KB - 8KB email text)/1.37 overhead ~ 180KB
> 180KB * 1.37 overhead + 8KB email text ~ 256KB
> ---
>  lists.html | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 

> diff --git a/lists.html b/lists.html
> index fb784f8d2732..a3beda2d64e0 100755
> --- a/lists.html
> +++ b/lists.html
> @@ -42,7 +42,14 @@ answer.</p>
>  <div class="smaller">
>  <ul class="spaced">
>  
> -<li><b>None of the below lists accept <a href="https://sourceware.org/lists.html#html-mail">html mail</a>.  Use plain text only.</b></li>
> +<li><b>None of the below lists accept
> +<a href="https://sourceware.org/lists.html#html-mail">html mail</a>.
> +Use plain text only.</b>
> +If you include attachments, please try to ensure they are in plain text,
> +and limit them to about <b>180KB</b>, as with encoding and email overhead,
> +any larger will exceed the size limits for emails to these lists.</li>
> +<!-- 180KB * 1.37 overhead + 8KB email text ~ 256KB -->
> +<!-- (256KB - 8KB email text)/1.37 overhead ~ 180KB -->
>  
>  <li><b>Please do not feed the spammers by <a href="acronyms/#PCYMTNQREAIYR">including raw email addresses</a> in the body of your message.</b></li>
>  


Pushed.


Thanks,
Corinna
