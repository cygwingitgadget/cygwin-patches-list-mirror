Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conssluserg-02.nifty.com (conssluserg-02.nifty.com
 [210.131.2.81])
 by sourceware.org (Postfix) with ESMTPS id 13C203858D35
 for <cygwin-patches@cygwin.com>; Tue, 16 Nov 2021 13:20:09 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 13C203858D35
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from Express5800-S70 (z221123.dynamic.ppp.asahi-net.or.jp
 [110.4.221.123]) (authenticated)
 by conssluserg-02.nifty.com with ESMTP id 1AGDJt2x006879
 for <cygwin-patches@cygwin.com>; Tue, 16 Nov 2021 22:19:55 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com 1AGDJt2x006879
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
 s=dec2015msa; t=1637068795;
 bh=CezsAF81+6o632ue/MaVHCW026QjVhHWfrbE94JKKg0=;
 h=Date:From:To:Subject:In-Reply-To:References:From;
 b=xp6TiS+NYSWc9w3f49bnCqet/akcVPdNOr3w6dSTr3e5pAHGXz4P8kD7vfbU42Aif
 iCtppn7ysC/Nr5DwqrMDVze8WIfe9GIb5PzNBQugcB+O/hUMEQ8JxiGQYUxrULymWY
 BhKmrTphSFxnIwCvtDKqP0Tx2BIr0Qz5t0LKqlQSnP1Ju9wMRtdrlfbXIT0WTQdXW8
 2Ikt6b7m0PtKs6f0b/bhmfJKd23J8GGWYH5Iqb75CGW5uny1CWosftq9028XW9AbHC
 KAvIDK4DlBQhCdlJzhVUghc9viXEnQvlUevJFCkncugnmVMbPh4+zWuz6qUEtoYN90
 qifOXJX+qI2pQ==
X-Nifty-SrcIP: [110.4.221.123]
Date: Tue, 16 Nov 2021 22:19:58 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] console: handle Unicode surrogate pairs
Message-Id: <20211116221958.aa98712827563090a83a2565@nifty.ne.jp>
In-Reply-To: <nycvar.QRO.7.76.6.2111161125300.21127@tvgsbejvaqbjf.bet>
References: <nycvar.QRO.7.76.6.2111161125300.21127@tvgsbejvaqbjf.bet>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-11.0 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, GIT_PATCH_0, NICE_REPLY_A,
 RCVD_IN_DNSWL_NONE, SPF_HELO_NONE, SPF_PASS,
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
X-List-Received-Date: Tue, 16 Nov 2021 13:20:13 -0000

On Tue, 16 Nov 2021 11:26:10 +0100 (CET)
Johannes Schindelin wrote:
> When running Cygwin's Bash in the Windows Terminal (see
> https://docs.microsoft.com/en-us/windows/terminal/ for details), Cygwin
> is receiving keyboard input in the form of UTF-16 characters.
> 
> UTF-16 has that awkward challenge that it cannot map the full Unicode
> range, and to make up for it, there are the ranges U+D800-U+DBFF and
> U+DC00-U+DFFF which are illegal except when they come in a pair encoding
> for Unicode characters beyond U+FFFF.
> 
> Cygwin does not handle such surrogate pairs correctly at the moment, as
> can be seen e.g. when running Cygwin's Bash in the Windows Terminal and
> then inserting an emoji (e.g. via Windows + <dot>, which opens an emoji
> picker on recent Windows versions): Instead of showing an emoji, this
> shows the infamous question mark in a black triangle, i.e. the invalid
> Unicode character.
> 
> Let's special-case surrogate pairs in this scenario.
> 
> This fixes https://github.com/git-for-windows/git/issues/3281
> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
> 
> 	This applies without merge conflict all the way back to
> 	cygwin_2_7_0-release.
> 
>  winsup/cygwin/fhandler_console.cc | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/winsup/cygwin/fhandler_console.cc b/winsup/cygwin/fhandler_console.cc
> index 3e17fd9a41..d11f4a4770 100644
> --- a/winsup/cygwin/fhandler_console.cc
> +++ b/winsup/cygwin/fhandler_console.cc
> @@ -453,7 +453,22 @@ fhandler_console::read (void *pv, size_t& buflen)
>  	    }
>  	  else
>  	    {
> -	      nread = con.con_to_str (tmp + 1, 59, unicode_char);
> +	      WCHAR second = unicode_char >= 0xd800 && unicode_char <= 0xdbff
> +		  && i + 1 < total_read ?
> +		  input_rec[i + 1].Event.KeyEvent.uChar.UnicodeChar : 0;
> +
> +	      if (second < 0xdc00 || second > 0xdfff)
> +		{
> +		  nread = con.con_to_str (tmp + 1, 59, unicode_char);
> +		}
> +	      else
> +		{
> +		  /* handle surrogate pairs */
> +		  WCHAR pair[2] = { unicode_char, second };
> +		  nread = sys_wcstombs (tmp + 1, 59, pair, 2);
> +		  i++;
> +		}
> +
>  	      /* Determine if the keystroke is modified by META.  The tricky
>  		 part is to distinguish whether the right Alt key should be
>  		 recognized as Alt, or as AltGr. */
> --
> 2.34.0.rc2.windows.1
> 

Thanks for the patch. LGTM.
I will push the patch to the master branch.


Corinna,

Should we apply this patch also to cygwin-3_3-branch?
Or should only the bug fix be for cygwin-3_3-branch?

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
