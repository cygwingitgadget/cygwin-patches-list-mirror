Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
 by sourceware.org (Postfix) with ESMTPS id 538223858C54
 for <cygwin-patches@cygwin.com>; Wed, 27 Apr 2022 09:42:25 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 538223858C54
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1Mjjvp-1o8HQ43kfT-00lCHa for <cygwin-patches@cygwin.com>; Wed, 27 Apr 2022
 11:42:23 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 5B77EA8065D; Wed, 27 Apr 2022 11:42:23 +0200 (CEST)
Date: Wed, 27 Apr 2022 11:42:23 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: Fix "0x0x" in gmondump and ssp man pages
Message-ID: <YmkP/++U9czyLzbP@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20220422053633.6128-1-mark@maxrnd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220422053633.6128-1-mark@maxrnd.com>
X-Provags-ID: V03:K1:bIizJDxm7bYaHMPuetahpmqPH+v3gTWeWL8nc7s5gzN7/Fy0prh
 bpQ0Kl+X72iL+zDBYvc9P6hOqvvv1AqdEDMf214F+qP20gcw24tsErIutehlxiJRPoClQ9t
 u+vT3ud5XAWBORJJFXZT2ccUcN2nsz/9syybqd1wYphor6EebVB+kRe3hP6fwu3khVbRUK+
 55vO1eIjBJ9kvf7zLhbVQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:jO3CObHRAaw=:Dk2+V8NqbEdMoP2wcTLoXT
 mPwprhMEOSDeV+utZJnZ4tsJfdg59boycO1QrmJnHbG2UrZEqR7Tq8OJ2MKF35/x8a8XG0E/s
 vDGGx2uHQ2f/DZWYYE7NcNk+pJntbPROJFGmpThT2fPN6aBOeik1dd0M1xvEr0R7xNnDV8ryL
 hrVx9km4QXbbwzjvm3AsqP/gdeBzqK3L39BA20NKXKfrLJZ+bpVAL47Pkmkxo3buJmt5hKUpT
 KSdbJTUGH7tQ2YLm8e1xdx2Vgy9moUDgSP4Ky0WFRcKuwbMvH/ao+jKYK/O9MweYi+SWAZU4k
 PrTbRTYgw0XC3yAp1MozLV3dYL7TyoV2IClbxDRe0tdZQUZIaYraJeUT1p9v5jRafbkxGI3q5
 F235cxtTUxRZqBAiUO8CODhVj4jw7x/jZADoRWGlzm4/7XsY6m4GVyXXRPI6YvAo6PfASTQui
 ITS63w/OCiH36uQH0ZITTPe9ih2CndsJMtqcqte1tPZAV4VyQC+Z3x/Efr2MM1Ly4pBvZU5YZ
 x3dWuhMTwLtMLights/qIDyESaocHJsdcREQrU9+dDaG8I4W7WvkLyOoXMUD580aKVcJlhDQs
 5bCqqBObRfGP2COIcrS7kHY2XwpM7wMJ35ZmYqtWUukK+a7UbOOR7NdlCSPuYevaZ0meTx2P1
 PVuYc6RlYyrzo/ryQra53FJ26632tNKVFExhSF6hrMuQyMi9abEiXPXbUNudVKHNzPT+rfOEr
 r7eZoGUhYgGkJWBB
X-Spam-Status: No, score=-94.8 required=5.0 tests=BAYES_00,
 GOOD_FROM_CORINNA_CYGWIN, KAM_DMARC_NONE, KAM_DMARC_STATUS, RCVD_IN_MSPIKE_H2,
 SPF_FAIL, SPF_HELO_NONE, TXREP autolearn=ham autolearn_force=no version=3.4.4
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
X-List-Received-Date: Wed, 27 Apr 2022 09:42:26 -0000

On Apr 21 22:36, Mark Geisert wrote:
> A recent patch fixed gmondump to stop printing "0x0x" as an address
> prefix.  It turns out the Cygwin User's Guide and the gmondump and
> ssp man pages (all from utils.xml) have examples of the same error.
> 
> ---
>  winsup/cygwin/release/3.3.5 | 2 +-
>  winsup/doc/utils.xml        | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)

Pushed.


Thanks,
Corinna
