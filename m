Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
 by sourceware.org (Postfix) with ESMTPS id 730763857013
 for <cygwin-patches@cygwin.com>; Wed, 26 Aug 2020 09:06:33 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 730763857013
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=corinna-cygwin@cygwin.com
Received: from calimero.vinschen.de ([217.91.18.234]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1Mgek8-1kpiVr156S-00h4bp; Wed, 26 Aug 2020 11:06:27 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 86B69A83A75; Wed, 26 Aug 2020 11:06:25 +0200 (CEST)
Date: Wed, 26 Aug 2020 11:06:25 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: Dahan Gong <gdh1995@qq.com>
Cc: cygwin-patches@cygwin.com
Subject: Re: [Patch] Fix incorrect code page when setting console title on
 Win10
Message-ID: <20200826090625.GN3272@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: Dahan Gong <gdh1995@qq.com>, cygwin-patches@cygwin.com
References: <tencent_DEAF96B572731C3B3E524F22CCAC86D3AD07@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <tencent_DEAF96B572731C3B3E524F22CCAC86D3AD07@qq.com>
X-Provags-ID: V03:K1:xazor4Pzz1UJOxWhBcXbk7veNydslk2tNMshUbo5THoJI0ZvIW5
 6y308B57shqx96OSKjblkblLFHubsuIkazpLPwRpjhl+zFoN4dYb4CTwXL1EGGB41pOX4Dq
 ypk00jzP2ysc+BIa6lY+O2gFoaWyd0pvbqQZqbD+SssxL8j3CqkMfHeTYf/iCs36wGKZPyf
 I1O/7MDBqohsUmqiPPxQg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:pU/8k7cSf3A=:zzSc39IeS9Lk8h+4f6dG30
 koaOKrt99OJi2PAP1atWew4Aby8OJZSaSeiE2Hr3LWlQrLf2i2JSs3NX0NfXcGD0OUt/WPFRY
 9tXDO2pnf49c3eZPLeir4FowYkzgGskiINBq9QZ91Z92wNb9f2eCUiTGiOQr1DbSfGKYoZMQH
 0v39BrYFTeXStAB6sbEZbKnMCIVQoAst4jVS71dDPOdimItP2xGoM8AFI+3ae2hpzhgqT136P
 qRe7oRuOdCvvgbc9V296sc883A9fDel0oQR7mmdaRIrgzE+UiIdXH5+mjfGFHg4rx5Jh8Wv9X
 r64zvXsZrmrchErUkdMjCkptvYcvh0iN/F1CbxedsSvTXHC17QHaiXPVr1UxqujxkBmDyRXb+
 J2wt2j8ox38KEuTtR8i3THNl0qauvBLIB6X1BsuDlZioNIKYOrw3dkUc0auVJ2ETLRlO2/Tfl
 VXshvkfPaZUeDEPgLY91+XVRwXLH66L8ZeUaEbUl9yJmW4jdux707j4DNasQX0FJGQKjwHTJT
 4ssYdgMajH8JudbOnYUf4yBLxgBUb5GjGxm9IIBlVfbU3u1IbpDOxlwmjyap5SlHKWngC8Cdj
 2LxMvHsZRdXi79QYmoX429bmRaSIfADwfo91lAYjt9OIl8JhBONGukJG4BUGC4lAzRLAFHmhB
 WBAoWPE22UF4h2miiZDW9UqIyLp2kQJyXIqBtKrERkQajL2ses7H8OSzgr4YCheXGvdZ0j2EJ
 3Gk+fWRmyKKXhHUmZNzxO8BgYMNuVJAdAuWce/KgWxkonJI7wDur4JfH+X8kO7+eU3mDWlkPD
 /EzQE+cJI8hq3Zsl8p1nZJJn4rcqp3LMd4SJJFj6n/IXmGPQ1K118r/v0Djc8T7kzjZifQ3lk
 9qsxF3+wSkFUqanA0bByXmGaGpM07A4TNmj8SDjbxcXgm14pdi8A9em8n/+GFI
X-Spam-Status: No, score=-103.0 required=5.0 tests=BAYES_00, BODY_8BITS,
 GIT_PATCH_0, GOOD_FROM_CORINNA_CYGWIN, JMQ_SPF_NEUTRAL, KAM_DMARC_STATUS,
 KAM_NUMSUBJECT, RCVD_IN_DNSWL_NONE, RCVD_IN_MSPIKE_H2, SPF_HELO_NONE,
 SPF_NEUTRAL, TXREP autolearn=ham autolearn_force=no version=3.4.2
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
X-List-Received-Date: Wed, 26 Aug 2020 09:06:37 -0000

Hi,

On Aug 26 16:43, 宫大汉 via Cygwin-patches wrote:
> When Cygwin sets console titles on Win10 (has_con_24bit_colors &amp;&amp; !con_is_legacy),
> `WriteConsoleA` is used and causes an error if:
> 1. the environment variable of `LANG` is `***.UTF-8`
> 2. and the code page of console.exe is not UTF-8
> &nbsp; 1. e.g. on my Computer, it's GB2312, for Chinese text
> 
> 
> I've done some tests on msys2 and details are on https://github.com/git-for-windows/git/issues/2738,
> and I filed a PR of https://github.com/git-for-windows/msys2-runtime/pull/25.
> Then what should I do, in order to fix this on Cygwin?

Sending patches to the cygwin-patches mailing list is the right way to
go, so that's fine.  However, there are two small problems with your
patch:

- For non-trivial patches we need a 2-clause BSD waiver from you, as per
  https://cygwin.com/contrib.html, chapter "Before you get started".

- Your MUA apparently broke the patch.  No way to apply it in this form.
  Would you mind to resend it together with your BSD waiver, but as
  attachment?


Thanks,
Corinna



> 
> 
> The below is the commit's .patch file:
> 
> 
> From 334f52a53a2e6b7f560b0e8810b9f672ebb3ad24 Mon Sep 17 00:00:00 2001
> From: Dahan Gong <gdh1995@qq.com&gt;
> Date: Fri, 31 Jul 2020 22:06:54 +0800
> Subject: [PATCH] Fix incorrect code page in console title
> 
> 
> `WriteConsoleA` always follows the current code page of a console window, so it's not suitable to pass a multi-byte string in `get_ttyp ()-&gt;term_code_page` to it directly.
> 
> 
> This PR turns to `WriteConsoleW` so that most characters will be translated "as is", and I've tested it on Win 10 v2004 (CMD: ver 10.0.19041.388).
> 
> 
> Signed-off-by: gdh1995 <gdh1995@qq.com&gt;



> ---
> &nbsp;winsup/cygwin/fhandler_console.cc | 18 +++++++++++++++++-
> &nbsp;1 file changed, 17 insertions(+), 1 deletion(-)
> 
> 
> diff --git a/winsup/cygwin/fhandler_console.cc b/winsup/cygwin/fhandler_console.cc
> index dd979fb8e2..7870eeda81 100644
> --- a/winsup/cygwin/fhandler_console.cc
> +++ b/winsup/cygwin/fhandler_console.cc
> @@ -80,6 +80,15 @@ static class write_pending_buffer
> &nbsp; &nbsp;{
> &nbsp; &nbsp; &nbsp;WriteConsoleA (handle, buf, ixput, wn, 0);
> &nbsp; &nbsp;}
> +&nbsp; inline char *c_str (size_t *psize = NULL)
> +&nbsp; {
> +&nbsp; &nbsp; size_t size = ixput < WPBUF_LEN ? ixput : WPBUF_LEN - 1;
> +&nbsp; &nbsp; buf[size] = '\0';
> +&nbsp; &nbsp; if (psize != NULL) {
> +&nbsp; &nbsp; &nbsp; *psize = size;
> +&nbsp; &nbsp; }
> +&nbsp; &nbsp; return (char *) buf;
> +&nbsp; }
> &nbsp;} wpbuf;
> &nbsp;
> &nbsp;static void
> @@ -3203,7 +3212,14 @@ fhandler_console::write (const void *vsrc, size_t len)
> &nbsp;	&nbsp; &nbsp; if (*src < ' ')
> &nbsp;	&nbsp; &nbsp; &nbsp; {
> &nbsp;		if (wincap.has_con_24bit_colors () &amp;&amp; !con_is_legacy)
> -		&nbsp; wpbuf.send (get_output_handle ());
> +		&nbsp; {
> +		&nbsp; &nbsp; size_t nms;
> +		&nbsp; &nbsp; char *ms = wpbuf.c_str(&amp;nms);
> +		&nbsp; &nbsp; wchar_t write_buf[TITLESIZE + 1];
> +		&nbsp; &nbsp; DWORD done;
> +		&nbsp; &nbsp; DWORD buf_len = sys_mbstowcs (write_buf, TITLESIZE, ms);
> +		&nbsp; &nbsp; write_console (write_buf, buf_len, done);
> +		&nbsp; }
> &nbsp;		else if (*src == '\007' &amp;&amp; con.state == gettitle)
> &nbsp;		&nbsp; set_console_title (con.my_title_buf);
> &nbsp;		con.state = normal;
