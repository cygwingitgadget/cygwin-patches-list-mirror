Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conssluserg-05.nifty.com (conssluserg-05.nifty.com
 [210.131.2.90])
 by sourceware.org (Postfix) with ESMTPS id A96D2384BC11
 for <cygwin-patches@cygwin.com>; Fri, 11 Sep 2020 16:05:21 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org A96D2384BC11
Received: from Express5800-S70 (v038192.dynamic.ppp.asahi-net.or.jp
 [124.155.38.192]) (authenticated)
 by conssluserg-05.nifty.com with ESMTP id 08BG54hG023396
 for <cygwin-patches@cygwin.com>; Sat, 12 Sep 2020 01:05:04 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com 08BG54hG023396
X-Nifty-SrcIP: [124.155.38.192]
Date: Sat, 12 Sep 2020 01:05:04 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pty: Add workaround for ISO-2022 and ISCII in
 convert_mb_str().
Message-Id: <20200912010504.586a156f1712f61c3c696d40@nifty.ne.jp>
In-Reply-To: <20200911140601.GK4127@calimero.vinschen.de>
References: <20200911105401.153-1-takashi.yano@nifty.ne.jp>
 <20200911120840.GH4127@calimero.vinschen.de>
 <20200911213515.98a88ca7f186ede9bf8fc106@nifty.ne.jp>
 <20200911140601.GK4127@calimero.vinschen.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart=_Sat__12_Sep_2020_01_05_04_+0900_0EJiX08jsLZ_XBw1"
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
X-List-Received-Date: Fri, 11 Sep 2020 16:05:25 -0000

This is a multi-part message in MIME format.

--Multipart=_Sat__12_Sep_2020_01_05_04_+0900_0EJiX08jsLZ_XBw1
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 11 Sep 2020 16:06:01 +0200
Corinna Vinschen wrote:
> On Sep 11 21:35, Takashi Yano via Cygwin-patches wrote:
> > Hi Corinna,
> > 
> > On Fri, 11 Sep 2020 14:08:40 +0200
> > Corinna Vinschen wrote:
> > > On Sep 11 19:54, Takashi Yano via Cygwin-patches wrote:
> > > > - In convert_mb_str(), exclude ISO-2022 and ISCII from the processing
> > > >   for the case that the multibyte char is splitted in the middle.
> > > >   The reason is as follows.
> > > >   * ISO-2022 is too complicated to handle correctly.
> > > >   * Not sure what to do with ISCII.
> > > > ---
> > > >  winsup/cygwin/fhandler_tty.cc | 9 +++++++--
> > > >  1 file changed, 7 insertions(+), 2 deletions(-)
> > > > 
> > > > diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
> > > > index 37d033bbe..ee5c6a90a 100644
> > > > --- a/winsup/cygwin/fhandler_tty.cc
> > > > +++ b/winsup/cygwin/fhandler_tty.cc
> > > > @@ -117,6 +117,9 @@ CreateProcessW_Hooked
> > > >    return CreateProcessW_Orig (n, c, pa, ta, inh, f, e, d, si, pi);
> > > >  }
> > > >  
> > > > +#define IS_ISO_2022(x) ( (x) >= 50220 && (x) <= 50229 )
> > > > +#define IS_ISCII(x) ( (x) >= 57002 && (x) <= 57011 )
> > > > +
> > > >  static void
> > > >  convert_mb_str (UINT cp_to, char *ptr_to, size_t *len_to,
> > > >  		UINT cp_from, const char *ptr_from, size_t len_from,
> > > > @@ -126,8 +129,10 @@ convert_mb_str (UINT cp_to, char *ptr_to, size_t *len_to,
> > > >    tmp_pathbuf tp;
> > > >    wchar_t *wbuf = tp.w_get ();
> > > >    int wlen = 0;
> > > > -  if (cp_from == CP_UTF7)
> > > > -    /* MB_ERR_INVALID_CHARS does not work properly for UTF-7.
> > > > +  if (cp_from == CP_UTF7 || IS_ISO_2022 (cp_from) || IS_ISCII (cp_from))
> > > > +    /* - MB_ERR_INVALID_CHARS does not work properly for UTF-7.
> > > > +       - ISO-2022 is too complicated to handle correctly.
> > > > +       - FIXME: Not sure what to do for ISCII.
> > > >         Therefore, just convert string without checking */
> > > >      wlen = MultiByteToWideChar (cp_from, 0, ptr_from, len_from,
> > > >  				wbuf, NT_MAX_PATH);
> > > > -- 
> > > > 2.28.0
> > > 
> > > I'd prefer to not handle them at all.  We just don't support these
> > > charsets, same as JIS, EBCDIC, you name it, which are not ASCII
> > > compatible.  Let's please just drop any handling for these weird
> > > or outdated codepages.
> > 
> > What do you mean by "just drop any handling"? 
> > 
> > Do you mean remove following if block?
> > > > +  if (cp_from == CP_UTF7 || IS_ISO_2022 (cp_from) || IS_ISCII (cp_from))
> > > > +    /* - MB_ERR_INVALID_CHARS does not work properly for UTF-7.
> > > > +       - ISO-2022 is too complicated to handle correctly.
> > > > +       - FIXME: Not sure what to do for ISCII.
> > > >         Therefore, just convert string without checking */
> > > >      wlen = MultiByteToWideChar (cp_from, 0, ptr_from, len_from,
> > > >  				wbuf, NT_MAX_PATH);
> > In this case, the conversion for ISO-2022, ISCII and UTF-7 will
> > not be done correctly.
> > 
> > Or skip charset conversion if the codepage is EBCDIC, ISO-2022
> > or ISCII? What should we do for UTF-7?
> 
> Nothing, just like for any other of these weird charsets.  Cygwin never
> supported any charset which wasn't at least ASCII compatible in the
> 0 <= x <= 127 range.  Just ignore them and the possibility that a
> user chooses them for fun.
> 
> > What should happen if user or apps chage codepage to one of them?
> 
> Garbage output, I guess.  We shouldn't really care.

Do you mean a patch attached?

Please try:
(1) Open mintty with "env CYGWIN=disable_pcon mintty".
(2) Start cmd.exe in that mintty.
(3) Try chcp such as
    37 (EBCDIC),
    65000 (UTF-7),
    50220 (ISO-2022),
    and 57002 (ISCII).
(4) Execute dir or some other commands in cmd.exe.

For 65000, 50220 adn 57002, even the prompt will be broken.
Are the results as you expected?

If pseudo console is enabled, all the above are work without
problem. With the previous patch, the results was sane even
if pseudo console is disabled.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>

--Multipart=_Sat__12_Sep_2020_01_05_04_+0900_0EJiX08jsLZ_XBw1
Content-Type: application/octet-stream;
 name="0001-Cygwin-pty-Drop-handling-for-UTF-7-in-convert_mb_str.patch"
Content-Disposition: attachment;
 filename="0001-Cygwin-pty-Drop-handling-for-UTF-7-in-convert_mb_str.patch"
Content-Transfer-Encoding: base64

RnJvbSA3ZDI2ZjRkYTI5Njk0MjVmN2MzY2M4ZTk2OGEyNTZkMzg4YjdlNThhIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBUYWthc2hpIFlhbm8gPHRha2FzaGkueWFub0BuaWZ0eS5uZS5q
cD4KRGF0ZTogU2F0LCAxMiBTZXAgMjAyMCAwMDozNzoyNiArMDkwMApTdWJqZWN0OiBbUEFUQ0hd
IEN5Z3dpbjogcHR5OiBEcm9wIGhhbmRsaW5nIGZvciBVVEYtNyBpbiBjb252ZXJ0X21iX3N0cigp
LgoKLSBDaGFyc2V0IGNvbnZlcnNpb24gZm9yIFVURi03LCBJU08tMjAyMiBhbmQgSVNDSUksIHdo
aWNoIGFyZSBub3QKICBzdXBwb3J0ZWQgaW4gY3lnd2luLCBkb2VzIG5vdCB3b3JrIHByb3Blcmx5
IGFzIGEgcmVzdWx0LiBBdCB0aGUKICBleHBlbnNlIG9mIHRoZSBhYm92ZSwgdGhlIGNvZGUgaGFz
IGJlZW4gc2ltcGxpZmllZCBhIGJpdC4KLS0tCiB3aW5zdXAvY3lnd2luL2ZoYW5kbGVyX3R0eS5j
YyB8IDg2ICsrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0tLS0tCiAxIGZpbGUgY2hhbmdl
ZCwgMzggaW5zZXJ0aW9ucygrKSwgNDggZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvd2luc3Vw
L2N5Z3dpbi9maGFuZGxlcl90dHkuY2MgYi93aW5zdXAvY3lnd2luL2ZoYW5kbGVyX3R0eS5jYwpp
bmRleCA5NWIyOGMzZGEuLjg5MTBhZjFlNyAxMDA2NDQKLS0tIGEvd2luc3VwL2N5Z3dpbi9maGFu
ZGxlcl90dHkuY2MKKysrIGIvd2luc3VwL2N5Z3dpbi9maGFuZGxlcl90dHkuY2MKQEAgLTEyMiw1
OCArMTIyLDQ4IEBAIGNvbnZlcnRfbWJfc3RyIChVSU5UIGNwX3RvLCBjaGFyICpwdHJfdG8sIHNp
emVfdCAqbGVuX3RvLAogCQlVSU5UIGNwX2Zyb20sIGNvbnN0IGNoYXIgKnB0cl9mcm9tLCBzaXpl
X3QgbGVuX2Zyb20sCiAJCW1ic3RhdGVfdCAqbWJwKQogewotICBzaXplX3QgbmxlbjsKICAgdG1w
X3BhdGhidWYgdHA7CiAgIHdjaGFyX3QgKndidWYgPSB0cC53X2dldCAoKTsKICAgaW50IHdsZW4g
PSAwOwotICBpZiAoY3BfZnJvbSA9PSBDUF9VVEY3KQotICAgIC8qIE1CX0VSUl9JTlZBTElEX0NI
QVJTIGRvZXMgbm90IHdvcmsgcHJvcGVybHkgZm9yIFVURi03LgotICAgICAgIFRoZXJlZm9yZSwg
anVzdCBjb252ZXJ0IHN0cmluZyB3aXRob3V0IGNoZWNraW5nICovCi0gICAgd2xlbiA9IE11bHRp
Qnl0ZVRvV2lkZUNoYXIgKGNwX2Zyb20sIDAsIHB0cl9mcm9tLCBsZW5fZnJvbSwKLQkJCQl3YnVm
LCBOVF9NQVhfUEFUSCk7Ci0gIGVsc2UKLSAgICB7Ci0gICAgICBjaGFyICp0bXBidWYgPSB0cC5j
X2dldCAoKTsKLSAgICAgIG1lbWNweSAodG1wYnVmLCBtYnAtPl9fdmFsdWUuX193Y2hiLCBtYnAt
Pl9fY291bnQpOwotICAgICAgaWYgKG1icC0+X19jb3VudCArIGxlbl9mcm9tID4gTlRfTUFYX1BB
VEgpCi0JbGVuX2Zyb20gPSBOVF9NQVhfUEFUSCAtIG1icC0+X19jb3VudDsKLSAgICAgIG1lbWNw
eSAodG1wYnVmICsgbWJwLT5fX2NvdW50LCBwdHJfZnJvbSwgbGVuX2Zyb20pOwotICAgICAgaW50
IHRvdGFsX2xlbiA9IG1icC0+X19jb3VudCArIGxlbl9mcm9tOwotICAgICAgbWJwLT5fX2NvdW50
ID0gMDsKLSAgICAgIGludCBtYmxlbiA9IDA7Ci0gICAgICBmb3IgKGNvbnN0IGNoYXIgKnAgPSB0
bXBidWY7IHAgPCB0bXBidWYgKyB0b3RhbF9sZW47IHAgKz0gbWJsZW4pCi0JLyogTWF4IGJ5dGVz
IGluIG11bHRpYnl0ZSBjaGFyIGlzIDQuICovCi0JZm9yIChtYmxlbiA9IDE7IG1ibGVuIDw9IDQ7
IG1ibGVuICsrKQotCSAgewotCSAgICAvKiBUcnkgY29udmVyc2lvbiAqLwotCSAgICBpbnQgbCA9
IE11bHRpQnl0ZVRvV2lkZUNoYXIgKGNwX2Zyb20sIE1CX0VSUl9JTlZBTElEX0NIQVJTLAotCQkJ
CQkgcCwgbWJsZW4sCi0JCQkJCSB3YnVmICsgd2xlbiwgTlRfTUFYX1BBVEggLSB3bGVuKTsKLQkg
ICAgaWYgKGwpCi0JICAgICAgeyAvKiBDb252ZXJzaW9uIFN1Y2Nlc3MgKi8KLQkJd2xlbiArPSBs
OwotCQlicmVhazsKLQkgICAgICB9Ci0JICAgIGVsc2UgaWYgKG1ibGVuID09IDQpCi0JICAgICAg
eyAvKiBDb252ZXJzaW9uIEZhaWwgKi8KLQkJbCA9IE11bHRpQnl0ZVRvV2lkZUNoYXIgKGNwX2Zy
b20sIDAsIHAsIDEsCi0JCQkJCSB3YnVmICsgd2xlbiwgTlRfTUFYX1BBVEggLSB3bGVuKTsKLQkJ
d2xlbiArPSBsOwotCQltYmxlbiA9IDE7Ci0JCWJyZWFrOwotCSAgICAgIH0KLQkgICAgZWxzZSBp
ZiAocCArIG1ibGVuID09IHRtcGJ1ZiArIHRvdGFsX2xlbikKLQkgICAgICB7IC8qIE11bHRpYnl0
ZSBjaGFyIGluY29tcGxldGUgKi8KLQkJbWVtY3B5IChtYnAtPl9fdmFsdWUuX193Y2hiLCBwLCBt
Ymxlbik7Ci0JCW1icC0+X19jb3VudCA9IG1ibGVuOwotCQlicmVhazsKLQkgICAgICB9Ci0JICAg
IC8qIFJldHJ5IGNvbnZlcnNpb24gd2l0aCBleHRlbmRlZCBsZW5ndGggKi8KKyAgY2hhciAqdG1w
YnVmID0gdHAuY19nZXQgKCk7CisgIG1lbWNweSAodG1wYnVmLCBtYnAtPl9fdmFsdWUuX193Y2hi
LCBtYnAtPl9fY291bnQpOworICBpZiAobWJwLT5fX2NvdW50ICsgbGVuX2Zyb20gPiBOVF9NQVhf
UEFUSCkKKyAgICBsZW5fZnJvbSA9IE5UX01BWF9QQVRIIC0gbWJwLT5fX2NvdW50OworICBtZW1j
cHkgKHRtcGJ1ZiArIG1icC0+X19jb3VudCwgcHRyX2Zyb20sIGxlbl9mcm9tKTsKKyAgaW50IHRv
dGFsX2xlbiA9IG1icC0+X19jb3VudCArIGxlbl9mcm9tOworICBtYnAtPl9fY291bnQgPSAwOwor
ICBpbnQgbWJsZW4gPSAwOworICBmb3IgKGNvbnN0IGNoYXIgKnAgPSB0bXBidWY7IHAgPCB0bXBi
dWYgKyB0b3RhbF9sZW47IHAgKz0gbWJsZW4pCisgICAgLyogTWF4IGJ5dGVzIGluIG11bHRpYnl0
ZSBjaGFyIHN1cHBvcnRlZCBpcyA0LiAqLworICAgIGZvciAobWJsZW4gPSAxOyBtYmxlbiA8PSA0
OyBtYmxlbiArKykKKyAgICAgIHsKKwkvKiBUcnkgY29udmVyc2lvbiAqLworCWludCBsID0gTXVs
dGlCeXRlVG9XaWRlQ2hhciAoY3BfZnJvbSwgTUJfRVJSX0lOVkFMSURfQ0hBUlMsCisJCQkJICAg
ICBwLCBtYmxlbiwKKwkJCQkgICAgIHdidWYgKyB3bGVuLCBOVF9NQVhfUEFUSCAtIHdsZW4pOwor
CWlmIChsKQorCSAgeyAvKiBDb252ZXJzaW9uIFN1Y2Nlc3MgKi8KKwkgICAgd2xlbiArPSBsOwor
CSAgICBicmVhazsKIAkgIH0KLSAgICB9Ci0gIG5sZW4gPSBXaWRlQ2hhclRvTXVsdGlCeXRlIChj
cF90bywgMCwgd2J1Ziwgd2xlbiwKLQkJCSAgICAgIHB0cl90bywgKmxlbl90bywgTlVMTCwgTlVM
TCk7Ci0gICpsZW5fdG8gPSBubGVuOworCWVsc2UgaWYgKG1ibGVuID09IDQpCisJICB7IC8qIENv
bnZlcnNpb24gRmFpbCAqLworCSAgICBsID0gTXVsdGlCeXRlVG9XaWRlQ2hhciAoY3BfZnJvbSwg
MCwgcCwgMSwKKwkJCQkgICAgIHdidWYgKyB3bGVuLCBOVF9NQVhfUEFUSCAtIHdsZW4pOworCSAg
ICB3bGVuICs9IGw7CisJICAgIG1ibGVuID0gMTsKKwkgICAgYnJlYWs7CisJICB9CisJZWxzZSBp
ZiAocCArIG1ibGVuID09IHRtcGJ1ZiArIHRvdGFsX2xlbikKKwkgIHsgLyogTXVsdGlieXRlIGNo
YXIgaW5jb21wbGV0ZSAqLworCSAgICBtZW1jcHkgKG1icC0+X192YWx1ZS5fX3djaGIsIHAsIG1i
bGVuKTsKKwkgICAgbWJwLT5fX2NvdW50ID0gbWJsZW47CisJICAgIGJyZWFrOworCSAgfQorCS8q
IFJldHJ5IGNvbnZlcnNpb24gd2l0aCBleHRlbmRlZCBsZW5ndGggKi8KKyAgICAgIH0KKyAgKmxl
bl90byA9IFdpZGVDaGFyVG9NdWx0aUJ5dGUgKGNwX3RvLCAwLCB3YnVmLCB3bGVuLAorCQkJCSBw
dHJfdG8sICpsZW5fdG8sIE5VTEwsIE5VTEwpOwogfQogCiBzdGF0aWMgYm9vbAotLSAKMi4yOC4w
Cgo=

--Multipart=_Sat__12_Sep_2020_01_05_04_+0900_0EJiX08jsLZ_XBw1--
