Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.131])
 by sourceware.org (Postfix) with ESMTPS id 28AF53858406
 for <cygwin-patches@cygwin.com>; Wed, 12 Jan 2022 18:51:57 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 28AF53858406
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MCsLo-1nGUAN3hy4-008sna for <cygwin-patches@cygwin.com>; Wed, 12 Jan 2022
 19:51:55 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 6531FA80B83; Wed, 12 Jan 2022 19:51:55 +0100 (CET)
Date: Wed, 12 Jan 2022 19:51:55 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: doc: drop mention of 32-bit installer
Message-ID: <Yd8jSyIZCPmkKd1E@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20220112155241.1635-1-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220112155241.1635-1-jon.turney@dronecode.org.uk>
X-Provags-ID: V03:K1:MrKtBJa9OINM4EgxyoZV6dO4NM+96/P0rVWuZdvaUMquFxNje+w
 s9p+vcI1rgJnCdWJ4dk7Z0VQLYd1i2puo0xrErlPU6LjXQJt0jDSJS7Syms0Ix9GknmS8W0
 wYpvU+8lVOHLpZjs7bAiqc1ZfDHI5AliT4DZXIA2lRt6dgziDsUzdGj2F4h/7Q9efYj2eLj
 BxztXD2zeF+PTU7Ab4lGA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:N1OJBJFPSgc=:FMkY1pO7k+LU3hcjxHKckn
 cOhJnvzSHrwoAObIS2YhWcc60lGG+JnrGdxw08DfVgSqEdrw/BJyQc27uUpnxse8nxzOXR+Ky
 StSTWj4iVtwvph3QwIVMSYUKY1H+VMO+FNmHOQweZlJrw0IVGQbMkFjM9dW81vnAenH8aZE3N
 xHkgUQsKfM3lTwXHHq40SX05Bxlmmvg8TTVtTFXFVgO8+pekl8c1dxZ/FDvwrrrKknkD5QIh4
 9iKlpn1WUvszXwbepHntUcXKpFoFzHTX8Y6gSVFz3Ha07+x4NqvKVpNmhXooZTw1q9xqd6ktt
 GOOw/c39oHqBD7LjMN7/cobJgvboudMiEL8DkBGzbkUfR/UE17YLU9uVQQW7YPxGWn0lCsPmo
 ZzbPrvguUNwuHI/K0xST5pytfdAxOP04hinJYnoDZ9eGiLgbEXvwphnfw/pcxekYHwFI8JHUl
 NnlEuhCC9dNWRBCR5zYhaF+KyfZYEECGgDDN6Ldr4PXlBwGu9O+T4HXqjB1IQlys8+NZqC9YM
 XLNrY3hjWx7d2EALYxDrr7ga4tiZN5Qg9WWpvJp/484eapILEH3il3qwlpHhMhPgcjd/SNyOQ
 cMr0rrv/MChVgHJfDiAiJ9JjhMhd442Xf8NbBTGzst1qBazWZaBhOZ/EvElVicFIn2njIKVQu
 Bu4linJbxQQ1KEiAmD4mSzOE6BA2v59T1Hk58mM0NDus5Stjy75Zu6clY/Vgaf4qlhIOxKRCW
 c72Mjg7veczsFqD1
X-Spam-Status: No, score=-94.6 required=5.0 tests=BAYES_00,
 GOOD_FROM_CORINNA_CYGWIN, KAM_DMARC_NONE, KAM_DMARC_STATUS, RCVD_IN_DNSWL_NONE,
 RCVD_IN_MSPIKE_H4, RCVD_IN_MSPIKE_WL, SPF_FAIL, SPF_HELO_NONE,
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
X-List-Received-Date: Wed, 12 Jan 2022 18:51:58 -0000

On Jan 12 15:52, Jon Turney wrote:
> Drop mention of 32-bit installer, since it's offically discouraged, and
> planned to be dropped soon.
> 
> Adjust various references to be something more generic, like 'the Cygwin
> Setup program' to accomodate this.
> ---
>  winsup/doc/faq-setup.xml | 12 +++----
>  winsup/doc/setup-net.xml | 74 ++++++++++++++++------------------------
>  2 files changed, 34 insertions(+), 52 deletions(-)
> [...]
>  <para>
> -On Windows Vista and later, <command>setup.exe</command> will check by
> +On Windows Vista and later, <command>setup</command> will check by
              ^^^^^
This will have to be changed for the master branch to mention W7
instead.  Vista is a dead stinkin' fish at that time.  That reminds me,
we have to do this throughout.  Do you want to or shall I?

Other than that, :+1: and push at your discretion.


Corinna
