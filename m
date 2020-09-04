Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conssluserg-04.nifty.com (conssluserg-04.nifty.com
 [210.131.2.83])
 by sourceware.org (Postfix) with ESMTPS id 780F53857812
 for <cygwin-patches@cygwin.com>; Fri,  4 Sep 2020 10:03:58 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 780F53857812
Received: from Express5800-S70 (v038192.dynamic.ppp.asahi-net.or.jp
 [124.155.38.192]) (authenticated)
 by conssluserg-04.nifty.com with ESMTP id 084A3W8a016758
 for <cygwin-patches@cygwin.com>; Fri, 4 Sep 2020 19:03:32 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com 084A3W8a016758
X-Nifty-SrcIP: [124.155.38.192]
Date: Fri, 4 Sep 2020 19:03:37 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 3/3] fhandler_pty_slave::setup_locale: respect charset
 == "UTF-8"
Message-Id: <20200904190337.cde290e4b690793ef6a0f496@nifty.ne.jp>
In-Reply-To: <nycvar.QRO.7.76.6.2009011818560.56@tvgsbejvaqbjf.bet>
References: <nycvar.QRO.7.76.6.2009011818560.56@tvgsbejvaqbjf.bet>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart=_Fri__4_Sep_2020_19_03_37_+0900_/EawamU0ZpWW/5qo"
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, GIT_PATCH_0, NICE_REPLY_A,
 RCVD_IN_BARRACUDACENTRAL, RCVD_IN_DNSWL_NONE, RCVD_IN_MSPIKE_H4,
 RCVD_IN_MSPIKE_WL, SPF_HELO_NONE, SPF_PASS,
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
X-List-Received-Date: Fri, 04 Sep 2020 10:04:00 -0000

This is a multi-part message in MIME format.

--Multipart=_Fri__4_Sep_2020_19_03_37_+0900_/EawamU0ZpWW/5qo
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Johannes and Corinna,

On Tue, 1 Sep 2020 18:19:16 +0200 (CEST)
Johannes Schindelin wrote:

> When `LANG=en_US.UTF-8`, the detected `LCID` is 0x0409, which is
> correct, but after that (at least if Pseudo Console support is enabled),
> we try to find the default code page for that `LCID`, which is ASCII
> (437). Subsequently, we set the Console output code page to that value,
> completely ignoring that we wanted to use UTF-8.
> 
> Let's not ignore the specifically asked-for UTF-8 character set.
> 
> While at it, let's also set the Console output code page even if Pseudo
> Console support is disabled; contrary to the behavior of v3.0.7, the
> Console output code page is not ignored in that case.
> 
> The most common symptom would be that console applications which do not
> specifically call `SetConsoleOutputCP()` but output UTF-8-encoded text
> seem to be broken with v3.1.x when they worked plenty fine with v3.0.x.
> 
> This fixes https://github.com/msys2/MSYS2-packages/issues/1974,
> https://github.com/msys2/MSYS2-packages/issues/2012,
> https://github.com/rust-lang/cargo/issues/8369,
> https://github.com/git-for-windows/git/issues/2734,
> https://github.com/git-for-windows/git/issues/2793,
> https://github.com/git-for-windows/git/issues/2792, and possibly quite a
> few others.
> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  winsup/cygwin/fhandler_tty.cc | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
> index 06789a500..414c26992 100644
> --- a/winsup/cygwin/fhandler_tty.cc
> +++ b/winsup/cygwin/fhandler_tty.cc
> @@ -2859,6 +2859,15 @@ fhandler_pty_slave::setup_locale (void)
>    char charset[ENCODING_LEN + 1] = "ASCII";
>    LCID lcid = get_langinfo (locale, charset);
> 
> +  /* Special-case the UTF-8 character set */
> +  if (strcasecmp (charset, "UTF-8") == 0)
> +    {
> +      get_ttyp ()->term_code_page = CP_UTF8;
> +      SetConsoleCP (CP_UTF8);
> +      SetConsoleOutputCP (CP_UTF8);
> +      return;
> +    }
> +
>    /* Set console code page from locale */
>    if (get_pseudo_console ())
>      {
> --
> 2.27.0

I would like to propose a counter patch attached.
What do you think of this patch?

This patch does not treat UTF-8 as special.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>

--Multipart=_Fri__4_Sep_2020_19_03_37_+0900_/EawamU0ZpWW/5qo
Content-Type: application/octet-stream;
 name="0001-Cygwin-pty-Prevent-garbled-output-when-pseudo-consol.patch"
Content-Disposition: attachment;
 filename="0001-Cygwin-pty-Prevent-garbled-output-when-pseudo-consol.patch"
Content-Transfer-Encoding: base64

RnJvbSAwNTAxM2ZlN2NjNWJiYzNmMjBhODQwYmM0NGE0OWMxZTA3NzAyYmY0IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBUYWthc2hpIFlhbm8gPHRha2FzaGkueWFub0BuaWZ0eS5uZS5q
cD4KRGF0ZTogRnJpLCA0IFNlcCAyMDIwIDE4OjMxOjM1ICswOTAwClN1YmplY3Q6IFtQQVRDSF0g
Q3lnd2luOiBwdHk6IFByZXZlbnQgZ2FyYmxlZCBvdXRwdXQgd2hlbiBwc2V1ZG8gY29uc29sZSBp
cwogZGlzYWJsZWQuCgotIElmIHBzZXVkbyBjb25zb2xlIGlzIGRpc2FibGVkLCBub24tY3lnd2lu
IGFwcHMgZG8gbm90IGRldGVjdAogIGNvbnNvbGUgZGV2aWNlLiBJbiB0aGlzIGNhc2UsIHRoZSBz
b21lIGFwcHMgbWF5IG91dHB1dCBtZXNzYWdlcwogIGJhc2VkIG9uIHRoZSBsb2NhbGUuIEluIGFk
ZGl0aW9uLCBzb21lIGFwcHMgb3V0cHV0IFVURi04IHN0cmluZwogIHJlZ2FyZGxlc3Mgb2YgdGhl
IGxvY2FsZSBzZXR0aW5nLiBBdCBsZWFzdCBnaXQtZm9yLXdpbmRvd3MgYW5kCiAgbm9kZS5qcyBk
byB0aGF0LiBFdmVuIGluIHRoaXMgY2FzZSwgZ2FyYmxlZCBvdXRwdXQgaXMgcHJldmVudGVkCiAg
d2l0aCB0aGlzIHBhdGNoIGluIG1vc3QgY2FzZXMgYmVjYXVzZSBtaW50dHkgdXNlcyBVVEYtOCBi
eSBkZWZhdWx0LgotLS0KIHdpbnN1cC9jeWd3aW4vZmhhbmRsZXJfdHR5LmNjIHwgMiArKwogMSBm
aWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL3dpbnN1cC9jeWd3aW4v
ZmhhbmRsZXJfdHR5LmNjIGIvd2luc3VwL2N5Z3dpbi9maGFuZGxlcl90dHkuY2MKaW5kZXggZmQ3
NGE5ZjNkLi4zYjMzZTgyZjcgMTAwNjQ0Ci0tLSBhL3dpbnN1cC9jeWd3aW4vZmhhbmRsZXJfdHR5
LmNjCisrKyBiL3dpbnN1cC9jeWd3aW4vZmhhbmRsZXJfdHR5LmNjCkBAIC0xODQ4LDYgKzE4NDgs
OCBAQCBmaGFuZGxlcl9wdHlfc2xhdmU6OnNldHVwX2xvY2FsZSAodm9pZCkKIAkgIGdldF90dHlw
ICgpLT50ZXJtX2NvZGVfcGFnZSA9IGNzX25hbWVzW2ldLmNwOwogCSAgYnJlYWs7CiAJfQorICBT
ZXRDb25zb2xlQ1AgKGdldF90dHlwICgpLT50ZXJtX2NvZGVfcGFnZSk7CisgIFNldENvbnNvbGVP
dXRwdXRDUCAoZ2V0X3R0eXAgKCktPnRlcm1fY29kZV9wYWdlKTsKIH0KIAogdm9pZAotLSAKMi4y
OC4wCgo=

--Multipart=_Fri__4_Sep_2020_19_03_37_+0900_/EawamU0ZpWW/5qo--
