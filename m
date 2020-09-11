Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conssluserg-01.nifty.com (conssluserg-01.nifty.com
 [210.131.2.80])
 by sourceware.org (Postfix) with ESMTPS id 7785B395CC13
 for <cygwin-patches@cygwin.com>; Fri, 11 Sep 2020 17:39:15 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 7785B395CC13
Received: from Express5800-S70 (v038192.dynamic.ppp.asahi-net.or.jp
 [124.155.38.192]) (authenticated)
 by conssluserg-01.nifty.com with ESMTP id 08BHcg5d005539
 for <cygwin-patches@cygwin.com>; Sat, 12 Sep 2020 02:38:42 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com 08BHcg5d005539
X-Nifty-SrcIP: [124.155.38.192]
Date: Sat, 12 Sep 2020 02:38:43 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pty: Add workaround for ISO-2022 and ISCII in
 convert_mb_str().
Message-Id: <20200912023843.58ef0f3134d6aea5359c27c0@nifty.ne.jp>
In-Reply-To: <20200912010504.586a156f1712f61c3c696d40@nifty.ne.jp>
References: <20200911105401.153-1-takashi.yano@nifty.ne.jp>
 <20200911120840.GH4127@calimero.vinschen.de>
 <20200911213515.98a88ca7f186ede9bf8fc106@nifty.ne.jp>
 <20200911140601.GK4127@calimero.vinschen.de>
 <20200912010504.586a156f1712f61c3c696d40@nifty.ne.jp>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart=_Sat__12_Sep_2020_02_38_43_+0900_v3BitRG55EI8AXO3"
X-Spam-Status: No, score=-8.4 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, GIT_PATCH_0, NICE_REPLY_A,
 RCVD_IN_BARRACUDACENTRAL, RCVD_IN_DNSWL_NONE, SPF_HELO_NONE, SPF_PASS,
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
X-List-Received-Date: Fri, 11 Sep 2020 17:39:19 -0000

This is a multi-part message in MIME format.

--Multipart=_Sat__12_Sep_2020_02_38_43_+0900_v3BitRG55EI8AXO3
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 12 Sep 2020 01:05:04 +0900
Takashi Yano via Cygwin-patches <cygwin-patches@cygwin.com> wrote:
> On Fri, 11 Sep 2020 16:06:01 +0200
> Corinna Vinschen wrote:
> > On Sep 11 21:35, Takashi Yano via Cygwin-patches wrote:
> > > Hi Corinna,
> > > 
> > > On Fri, 11 Sep 2020 14:08:40 +0200
> > > Corinna Vinschen wrote:
> > > > On Sep 11 19:54, Takashi Yano via Cygwin-patches wrote:
> > > > > - In convert_mb_str(), exclude ISO-2022 and ISCII from the processing
> > > > >   for the case that the multibyte char is splitted in the middle.
> > > > >   The reason is as follows.
> > > > >   * ISO-2022 is too complicated to handle correctly.
> > > > >   * Not sure what to do with ISCII.
> > > > > ---
> > > > >  winsup/cygwin/fhandler_tty.cc | 9 +++++++--
> > > > >  1 file changed, 7 insertions(+), 2 deletions(-)
> > > > > 
> > > > > diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
> > > > > index 37d033bbe..ee5c6a90a 100644
> > > > > --- a/winsup/cygwin/fhandler_tty.cc
> > > > > +++ b/winsup/cygwin/fhandler_tty.cc
> > > > > @@ -117,6 +117,9 @@ CreateProcessW_Hooked
> > > > >    return CreateProcessW_Orig (n, c, pa, ta, inh, f, e, d, si, pi);
> > > > >  }
> > > > >  
> > > > > +#define IS_ISO_2022(x) ( (x) >= 50220 && (x) <= 50229 )
> > > > > +#define IS_ISCII(x) ( (x) >= 57002 && (x) <= 57011 )
> > > > > +
> > > > >  static void
> > > > >  convert_mb_str (UINT cp_to, char *ptr_to, size_t *len_to,
> > > > >  		UINT cp_from, const char *ptr_from, size_t len_from,
> > > > > @@ -126,8 +129,10 @@ convert_mb_str (UINT cp_to, char *ptr_to, size_t *len_to,
> > > > >    tmp_pathbuf tp;
> > > > >    wchar_t *wbuf = tp.w_get ();
> > > > >    int wlen = 0;
> > > > > -  if (cp_from == CP_UTF7)
> > > > > -    /* MB_ERR_INVALID_CHARS does not work properly for UTF-7.
> > > > > +  if (cp_from == CP_UTF7 || IS_ISO_2022 (cp_from) || IS_ISCII (cp_from))
> > > > > +    /* - MB_ERR_INVALID_CHARS does not work properly for UTF-7.
> > > > > +       - ISO-2022 is too complicated to handle correctly.
> > > > > +       - FIXME: Not sure what to do for ISCII.
> > > > >         Therefore, just convert string without checking */
> > > > >      wlen = MultiByteToWideChar (cp_from, 0, ptr_from, len_from,
> > > > >  				wbuf, NT_MAX_PATH);
> > > > > -- 
> > > > > 2.28.0
> > > > 
> > > > I'd prefer to not handle them at all.  We just don't support these
> > > > charsets, same as JIS, EBCDIC, you name it, which are not ASCII
> > > > compatible.  Let's please just drop any handling for these weird
> > > > or outdated codepages.
> > > 
> > > What do you mean by "just drop any handling"? 
> > > 
> > > Do you mean remove following if block?
> > > > > +  if (cp_from == CP_UTF7 || IS_ISO_2022 (cp_from) || IS_ISCII (cp_from))
> > > > > +    /* - MB_ERR_INVALID_CHARS does not work properly for UTF-7.
> > > > > +       - ISO-2022 is too complicated to handle correctly.
> > > > > +       - FIXME: Not sure what to do for ISCII.
> > > > >         Therefore, just convert string without checking */
> > > > >      wlen = MultiByteToWideChar (cp_from, 0, ptr_from, len_from,
> > > > >  				wbuf, NT_MAX_PATH);
> > > In this case, the conversion for ISO-2022, ISCII and UTF-7 will
> > > not be done correctly.
> > > 
> > > Or skip charset conversion if the codepage is EBCDIC, ISO-2022
> > > or ISCII? What should we do for UTF-7?
> > 
> > Nothing, just like for any other of these weird charsets.  Cygwin never
> > supported any charset which wasn't at least ASCII compatible in the
> > 0 <= x <= 127 range.  Just ignore them and the possibility that a
> > user chooses them for fun.
> > 
> > > What should happen if user or apps chage codepage to one of them?
> > 
> > Garbage output, I guess.  We shouldn't really care.
> 
> Do you mean a patch attached?
> 
> Please try:
> (1) Open mintty with "env CYGWIN=disable_pcon mintty".
> (2) Start cmd.exe in that mintty.
> (3) Try chcp such as
>     37 (EBCDIC),
>     65000 (UTF-7),
>     50220 (ISO-2022),
>     and 57002 (ISCII).
> (4) Execute dir or some other commands in cmd.exe.
> 
> For 65000, 50220 adn 57002, even the prompt will be broken.
> Are the results as you expected?
> 
> If pseudo console is enabled, all the above are work without
> problem. With the previous patch, the results was sane even
> if pseudo console is disabled.

How about the patch attached?
I think this is safer than previous patch.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>

--Multipart=_Sat__12_Sep_2020_02_38_43_+0900_v3BitRG55EI8AXO3
Content-Type: application/octet-stream;
 name="0001-Cygwin-pty-Skip-multibyte-char-boundary-check-condit.patch"
Content-Disposition: attachment;
 filename="0001-Cygwin-pty-Skip-multibyte-char-boundary-check-condit.patch"
Content-Transfer-Encoding: base64

RnJvbSBiZTZkMjBhYmYzMDI3Y2NmMjRjNTQ5YzU4YTdlMWQwNWMxZWE0ZGJkIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBUYWthc2hpIFlhbm8gPHRha2FzaGkueWFub0BuaWZ0eS5uZS5q
cD4KRGF0ZTogU2F0LCAxMiBTZXAgMjAyMCAwMjoyOToyMSArMDkwMApTdWJqZWN0OiBbUEFUQ0hd
IEN5Z3dpbjogcHR5OiBTa2lwIG11bHRpYnl0ZSBjaGFyIGJvdW5kYXJ5IGNoZWNrCiBjb25kaXRp
b25hbGx5LgoKLSBGb3IgY2hhcnNldCBpbiB3aGljaCBNQl9FUlJfSU5WQUxJRF9DSEFSUyBkb2Vz
IG5vdCB3b3JrIHByb3Blcmx5LAogIHNraXAgbXVsdGlieXRlIGNoYXIgYm91bmRhcnkgY2hlY2sg
aW4gY29udmVydF9tYl9zdHIoKS4KLS0tCiB3aW5zdXAvY3lnd2luL2ZoYW5kbGVyX3R0eS5jYyB8
IDE1ICsrKysrKysrLS0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKSwgNyBk
ZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS93aW5zdXAvY3lnd2luL2ZoYW5kbGVyX3R0eS5jYyBi
L3dpbnN1cC9jeWd3aW4vZmhhbmRsZXJfdHR5LmNjCmluZGV4IDk1YjI4YzNkYS4uNTBjMzZmNjQ1
IDEwMDY0NAotLS0gYS93aW5zdXAvY3lnd2luL2ZoYW5kbGVyX3R0eS5jYworKysgYi93aW5zdXAv
Y3lnd2luL2ZoYW5kbGVyX3R0eS5jYwpAQCAtMTIyLDEzICsxMjIsMTUgQEAgY29udmVydF9tYl9z
dHIgKFVJTlQgY3BfdG8sIGNoYXIgKnB0cl90bywgc2l6ZV90ICpsZW5fdG8sCiAJCVVJTlQgY3Bf
ZnJvbSwgY29uc3QgY2hhciAqcHRyX2Zyb20sIHNpemVfdCBsZW5fZnJvbSwKIAkJbWJzdGF0ZV90
ICptYnApCiB7Ci0gIHNpemVfdCBubGVuOworICBib29sIGNoZWNrX3ZhbGlkID0gZmFsc2U7Cisg
IGlmIChNdWx0aUJ5dGVUb1dpZGVDaGFyIChjcF9mcm9tLCBNQl9FUlJfSU5WQUxJRF9DSEFSUywg
IkEiLCAxLCBOVUxMLCAwKSkKKyAgICBjaGVja192YWxpZCA9IHRydWU7CiAgIHRtcF9wYXRoYnVm
IHRwOwogICB3Y2hhcl90ICp3YnVmID0gdHAud19nZXQgKCk7CiAgIGludCB3bGVuID0gMDsKLSAg
aWYgKGNwX2Zyb20gPT0gQ1BfVVRGNykKLSAgICAvKiBNQl9FUlJfSU5WQUxJRF9DSEFSUyBkb2Vz
IG5vdCB3b3JrIHByb3Blcmx5IGZvciBVVEYtNy4KLSAgICAgICBUaGVyZWZvcmUsIGp1c3QgY29u
dmVydCBzdHJpbmcgd2l0aG91dCBjaGVja2luZyAqLworICBpZiAoIWNoZWNrX3ZhbGlkKQorICAg
IC8qIElmIE1CX0VSUl9JTlZBTElEX0NIQVJTIGRvZXMgbm90IHdvcmsgcHJvcGVybHksCisgICAg
ICAganVzdCBjb252ZXJ0IHN0cmluZyB3aXRob3V0IGNoZWNraW5nICovCiAgICAgd2xlbiA9IE11
bHRpQnl0ZVRvV2lkZUNoYXIgKGNwX2Zyb20sIDAsIHB0cl9mcm9tLCBsZW5fZnJvbSwKIAkJCQl3
YnVmLCBOVF9NQVhfUEFUSCk7CiAgIGVsc2UKQEAgLTE3MSw5ICsxNzMsOCBAQCBjb252ZXJ0X21i
X3N0ciAoVUlOVCBjcF90bywgY2hhciAqcHRyX3RvLCBzaXplX3QgKmxlbl90bywKIAkgICAgLyog
UmV0cnkgY29udmVyc2lvbiB3aXRoIGV4dGVuZGVkIGxlbmd0aCAqLwogCSAgfQogICAgIH0KLSAg
bmxlbiA9IFdpZGVDaGFyVG9NdWx0aUJ5dGUgKGNwX3RvLCAwLCB3YnVmLCB3bGVuLAotCQkJICAg
ICAgcHRyX3RvLCAqbGVuX3RvLCBOVUxMLCBOVUxMKTsKLSAgKmxlbl90byA9IG5sZW47CisgICps
ZW5fdG8gPSBXaWRlQ2hhclRvTXVsdGlCeXRlIChjcF90bywgMCwgd2J1Ziwgd2xlbiwKKwkJCQkg
cHRyX3RvLCAqbGVuX3RvLCBOVUxMLCBOVUxMKTsKIH0KIAogc3RhdGljIGJvb2wKLS0gCjIuMjgu
MAoK

--Multipart=_Sat__12_Sep_2020_02_38_43_+0900_v3BitRG55EI8AXO3--
