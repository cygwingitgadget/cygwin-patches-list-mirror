Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conssluserg-06.nifty.com (conssluserg-06.nifty.com
 [210.131.2.91])
 by sourceware.org (Postfix) with ESMTPS id 8AF213857818
 for <cygwin-patches@cygwin.com>; Fri,  4 Sep 2020 09:22:00 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 8AF213857818
Received: from Express5800-S70 (v038192.dynamic.ppp.asahi-net.or.jp
 [124.155.38.192]) (authenticated)
 by conssluserg-06.nifty.com with ESMTP id 0849LjXg029140
 for <cygwin-patches@cygwin.com>; Fri, 4 Sep 2020 18:21:46 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com 0849LjXg029140
X-Nifty-SrcIP: [124.155.38.192]
Date: Fri, 4 Sep 2020 18:21:49 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 3/3] fhandler_pty_slave::setup_locale: respect charset
 == "UTF-8"
Message-Id: <20200904182149.18cd752eef58c67ee8d39135@nifty.ne.jp>
In-Reply-To: <20200903175912.GP4127@calimero.vinschen.de>
References: <nycvar.QRO.7.76.6.2009011818560.56@tvgsbejvaqbjf.bet>
 <20200902083014.GH4127@calimero.vinschen.de>
 <20200902083818.GI4127@calimero.vinschen.de>
 <20200902195412.aa7f233231d893a7a065b691@nifty.ne.jp>
 <20200902152450.GJ4127@calimero.vinschen.de>
 <20200903012500.640e36573c67328fc3e1bc70@nifty.ne.jp>
 <20200902163836.GL4127@calimero.vinschen.de>
 <20200903175912.GP4127@calimero.vinschen.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart=_Fri__4_Sep_2020_18_21_49_+0900_G/wyi0C0BJz.KFTw"
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, NICE_REPLY_A,
 RCVD_IN_BARRACUDACENTRAL, RCVD_IN_DNSWL_NONE, RCVD_IN_MSPIKE_H4,
 RCVD_IN_MSPIKE_WL, SPF_HELO_NONE, SPF_PASS,
 TXREP autolearn=no autolearn_force=no version=3.4.2
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
X-List-Received-Date: Fri, 04 Sep 2020 09:22:04 -0000

This is a multi-part message in MIME format.

--Multipart=_Fri__4_Sep_2020_18_21_49_+0900_G/wyi0C0BJz.KFTw
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Corinna,

On Thu, 3 Sep 2020 19:59:12 +0200
Corinna Vinschen wrote:
> On Sep  2 18:38, Corinna Vinschen wrote:
> > Hi Takashi,
> > 
> > On Sep  3 01:25, Takashi Yano via Cygwin-patches wrote:
> > > Hi Corinna,
> > > 
> > > On Wed, 2 Sep 2020 17:24:50 +0200
> > > Corinna Vinschen  wrote:
> > > > > > get_locale_from_env() and get_langinfo() should go away.  If we just
> > > > > > need a codepage for get_ttyp ()->term_code_page, we should really find a
> > > > > > way to do this from within internal_setlocale().
> > > > > 
> > > > > I looked into internal_setlocale() code, but I could not found
> > > > > the code which handles thecode page. I found the code handling
> > > > > the code page in __set_charset_from_locale() function in nlsfuncs.cc,
> > > > > but it does not return code page itself. Could you please explain
> > > > > more detail of your idea?
> > > > 
> > > > I had none yet :)  I was just musing, without actually thinking about a
> > > > solution.  But I think this isn't very complicated.  Given this is
> > > > inside Cygwin, nothing keeps the function to have a well-defined
> > > > side-effect, as in setting a (not yet existing) member "term_code_page"
> > > > of cygheap->locale.
> > > > 
> > > > Kind of like this:
> > > > [...]
> > > I have tried your code, however, it does not work as expected.
> > > It seems that __set_charset_from_locale() is not called.
> > > cygheap->locale.term_code_page is always 0.
> > 
> > Ah, right!  Take a look into newlib/libc/locale/locale.c, function
> > __loadlocale().  This function is called from _setlocale_r().  However,
> > it calls __set_charset_from_locale() *only* if the charset isn't already
> > given explicitely in the LC_* or LANG string, because otherwise we
> > already know the charset, after all.
> > 
> > Darn!  That foils my plans for world domination...
> > 
> > > Let me consider a while.
> > 
> > Thanks, I'll do the same.  I'd really like to simplify this stuff
> > and doing the locale shuffle in two entirely different locations
> > at different times is prone to getting out of sync.
> 
> The only idea I had so far was, changing the way __set_charset_from_locale
> works from within _setlocale_r:
> 
> We could add a Cygwin-specific function only fetching the codepage and
> call it unconditionally from _setlocale_r.  __set_charset_from_locale is
> called with a new parameter "codepage", so it doesn't have to fetch the
> CP by itself, but it's still only called from _setlocale_r if necessary.
> 
> Would that be sufficient?  The CP conversion from 20127/ASCII to 65001/UTF8
> could be done at the point the codepage is actually required.

I think I have found the answer to your request.
Patch attached. What do you think of this patch?

Calling initial_setlocale() is necessary because
nl_langinfo() always returns "ANSI_X3.4-1968"
regardless locale setting if this is not called.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>

--Multipart=_Fri__4_Sep_2020_18_21_49_+0900_G/wyi0C0BJz.KFTw
Content-Type: application/octet-stream;
 name="0001-Cygwin-pty-Replace-pty-specific-locale-functions-wit.patch"
Content-Disposition: attachment;
 filename="0001-Cygwin-pty-Replace-pty-specific-locale-functions-wit.patch"
Content-Transfer-Encoding: base64

RnJvbSBkZTU2MjMwODc2ZDRlMDZmYTc4YTQxYTNhZjZhMWM0MzlkZmU4ZjQxIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBUYWthc2hpIFlhbm8gPHRha2FzaGkueWFub0BuaWZ0eS5uZS5q
cD4KRGF0ZTogRnJpLCA0IFNlcCAyMDIwIDE4OjExOjAxICswOTAwClN1YmplY3Q6IFtQQVRDSF0g
Q3lnd2luOiBwdHk6IFJlcGxhY2UgcHR5IHNwZWNpZmljIGxvY2FsZSBmdW5jdGlvbnMgd2l0aAog
bmxfbGFuZ2luZm8oKS4KCi0gUmVtb3ZlIHB0eSBzcGVjaWZpYyBmdW5jdGlvbnMgZ2V0X2xvY2Fs
ZV9mcm9tX2VudigpIGFuZCBnZXRfbGFuZ2luZm8oKSwKICB3aGljaCBhcmUgY2FsbGVkIGZyb20g
c2V0dXBfbG9jYWxlKCksIGFuZCB1c2UgbmxfbGFuZ2luZm8oKSBpbnN0ZWFkLgotLS0KIHdpbnN1
cC9jeWd3aW4vZmhhbmRsZXJfdHR5LmNjIHwgMTE5ICsrLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDExNSBkZWxldGlvbnMo
LSkKCmRpZmYgLS1naXQgYS93aW5zdXAvY3lnd2luL2ZoYW5kbGVyX3R0eS5jYyBiL3dpbnN1cC9j
eWd3aW4vZmhhbmRsZXJfdHR5LmNjCmluZGV4IDhiZjM5YzNlNi4uZmQ3NGE5ZjNkIDEwMDY0NAot
LS0gYS93aW5zdXAvY3lnd2luL2ZoYW5kbGVyX3R0eS5jYworKysgYi93aW5zdXAvY3lnd2luL2Zo
YW5kbGVyX3R0eS5jYwpAQCAtMjYsNiArMjYsNyBAQCBkZXRhaWxzLiAqLwogI2luY2x1ZGUgPGFz
bS9zb2NrZXQuaD4KICNpbmNsdWRlICJjeWd3YWl0LmgiCiAjaW5jbHVkZSAicmVnaXN0cnkuaCIK
KyNpbmNsdWRlIDxsYW5naW5mby5oPgogCiAjaWZuZGVmIFBST0NfVEhSRUFEX0FUVFJJQlVURV9Q
U0VVRE9DT05TT0xFCiAjZGVmaW5lIFBST0NfVEhSRUFEX0FUVFJJQlVURV9QU0VVRE9DT05TT0xF
IDB4MDAwMjAwMTYKQEAgLTE4MTMsMTI3ICsxODE0LDE1IEBAIGNzX25hbWVzW10gPSB7CiAgIHsg
ICAgICAgMCwgIk5VTEwifQogfTsKIAotc3RhdGljIHZvaWQKLWdldF9sb2NhbGVfZnJvbV9lbnYg
KGNoYXIgKmxvY2FsZSkKLXsKLSAgY29uc3QgY2hhciAqZW52ID0gTlVMTDsKLSAgY2hhciBsYW5n
W0VOQ09ESU5HX0xFTiArIDFdID0gezAsIH0sIGNvdW50cnlbRU5DT0RJTkdfTEVOICsgMV0gPSB7
MCwgfTsKLSAgZW52ID0gZ2V0ZW52ICgiTENfQUxMIik7Ci0gIGlmIChlbnYgPT0gTlVMTCB8fCAh
KmVudikKLSAgICBlbnYgPSBnZXRlbnYgKCJMQ19DVFlQRSIpOwotICBpZiAoZW52ID09IE5VTEwg
fHwgISplbnYpCi0gICAgZW52ID0gZ2V0ZW52ICgiTEFORyIpOwotICBpZiAoZW52ID09IE5VTEwg
fHwgISplbnYpCi0gICAgewotICAgICAgaWYgKEdldExvY2FsZUluZm8gKExPQ0FMRV9DVVNUT01f
VUlfREVGQVVMVCwKLQkJCSAgTE9DQUxFX1NJU082MzlMQU5HTkFNRSwKLQkJCSAgbGFuZywgc2l6
ZW9mIChsYW5nKSkpCi0JR2V0TG9jYWxlSW5mbyAoTE9DQUxFX0NVU1RPTV9VSV9ERUZBVUxULAot
CQkgICAgICAgTE9DQUxFX1NJU08zMTY2Q1RSWU5BTUUsCi0JCSAgICAgICBjb3VudHJ5LCBzaXpl
b2YgKGNvdW50cnkpKTsKLSAgICAgIGVsc2UgaWYgKEdldExvY2FsZUluZm8gKExPQ0FMRV9DVVNU
T01fREVGQVVMVCwKLQkJCSAgICAgIExPQ0FMRV9TSVNPNjM5TEFOR05BTUUsCi0JCQkgICAgICBs
YW5nLCBzaXplb2YgKGxhbmcpKSkKLQkgIEdldExvY2FsZUluZm8gKExPQ0FMRV9DVVNUT01fREVG
QVVMVCwKLQkJCSBMT0NBTEVfU0lTTzMxNjZDVFJZTkFNRSwKLQkJCSBjb3VudHJ5LCBzaXplb2Yg
KGNvdW50cnkpKTsKLSAgICAgIGVsc2UgaWYgKEdldExvY2FsZUluZm8gKExPQ0FMRV9VU0VSX0RF
RkFVTFQsCi0JCQkgICAgICBMT0NBTEVfU0lTTzYzOUxBTkdOQU1FLAotCQkJICAgICAgbGFuZywg
c2l6ZW9mIChsYW5nKSkpCi0JICBHZXRMb2NhbGVJbmZvIChMT0NBTEVfVVNFUl9ERUZBVUxULAot
CQkJIExPQ0FMRV9TSVNPMzE2NkNUUllOQU1FLAotCQkJIGNvdW50cnksIHNpemVvZiAoY291bnRy
eSkpOwotICAgICAgZWxzZSBpZiAoR2V0TG9jYWxlSW5mbyAoTE9DQUxFX1NZU1RFTV9ERUZBVUxU
LAotCQkJICAgICAgTE9DQUxFX1NJU082MzlMQU5HTkFNRSwKLQkJCSAgICAgIGxhbmcsIHNpemVv
ZiAobGFuZykpKQotCSAgR2V0TG9jYWxlSW5mbyAoTE9DQUxFX1NZU1RFTV9ERUZBVUxULAotCQkJ
IExPQ0FMRV9TSVNPMzE2NkNUUllOQU1FLAotCQkJIGNvdW50cnksIHNpemVvZiAoY291bnRyeSkp
OwotICAgICAgaWYgKHN0cmxlbiAobGFuZykgJiYgc3RybGVuIChjb3VudHJ5KSkKLQlfX3NtYWxs
X3NwcmludGYgKGxhbmcgKyBzdHJsZW4gKGxhbmcpLCAiXyVzLlVURi04IiwgY291bnRyeSk7Ci0g
ICAgICBlbHNlCi0Jc3RyY3B5IChsYW5nICwgIkMuVVRGLTgiKTsKLSAgICAgIGVudiA9IGxhbmc7
Ci0gICAgfQotICBzdHJjcHkgKGxvY2FsZSwgZW52KTsKLX0KLQotc3RhdGljIHZvaWQKLWdldF9s
YW5naW5mbyAoY2hhciAqbG9jYWxlX291dCwgY2hhciAqY2hhcnNldF9vdXQpCi17Ci0gIC8qIEdl
dCBsb2NhbGUgZnJvbSBlbnZpcm9ubWVudCAqLwotICBjaGFyIG5ld19sb2NhbGVbRU5DT0RJTkdf
TEVOICsgMV07Ci0gIGdldF9sb2NhbGVfZnJvbV9lbnYgKG5ld19sb2NhbGUpOwotCi0gIF9fbG9j
YWxlX3QgbG9jOwotICBtZW1zZXQgKCZsb2MsIDAsIHNpemVvZiAobG9jKSk7Ci0gIGNvbnN0IGNo
YXIgKmxvY2FsZSA9IF9fbG9hZGxvY2FsZSAoJmxvYywgTENfQ1RZUEUsIG5ld19sb2NhbGUpOwot
ICBpZiAoIWxvY2FsZSkKLSAgICBsb2NhbGUgPSAiQyI7Ci0KLSAgY29uc3QgY2hhciAqY2hhcnNl
dDsKLSAgc3RydWN0IGxjX2N0eXBlX1QgKmxjX2N0eXBlID0gKHN0cnVjdCBsY19jdHlwZV9UICop
IGxvYy5sY19jYXRbTENfQ1RZUEVdLnB0cjsKLSAgaWYgKCFsY19jdHlwZSkKLSAgICBjaGFyc2V0
ID0gIkFTQ0lJIjsKLSAgZWxzZQotICAgIGNoYXJzZXQgPSBsY19jdHlwZS0+Y29kZXNldDsKLQot
ICAvKiBUaGUgZm9sbG93aW5nIGNvZGUgaXMgYm9ycm93ZWQgZnJvbSBubF9sYW5naW5mbygpCi0g
ICAgIGluIG5ld2xpYi9saWJjL2xvY2FsZS9ubF9sYW5naW5mby5jICovCi0gIC8qIENvbnZlcnQg
Y2hhcnNldCB0byBMaW51eCBjb21wYXRpYmxlIGNvZGVzZXQgc3RyaW5nLiAqLwotICBpZiAoY2hh
cnNldFswXSA9PSAnQScvKlNDSUkqLykKLSAgICBjaGFyc2V0ID0gIkFOU0lfWDMuNC0xOTY4IjsK
LSAgZWxzZSBpZiAoY2hhcnNldFswXSA9PSAnRScpCi0gICAgewotICAgICAgaWYgKHN0cmNtcCAo
Y2hhcnNldCwgIkVVQ0pQIikgPT0gMCkKLQljaGFyc2V0ID0gIkVVQy1KUCI7Ci0gICAgICBlbHNl
IGlmIChzdHJjbXAgKGNoYXJzZXQsICJFVUNLUiIpID09IDApCi0JY2hhcnNldCA9ICJFVUMtS1Ii
OwotICAgICAgZWxzZSBpZiAoc3RyY21wIChjaGFyc2V0LCAiRVVDQ04iKSA9PSAwKQotCWNoYXJz
ZXQgPSAiR0IyMzEyIjsKLSAgICB9Ci0gIGVsc2UgaWYgKGNoYXJzZXRbMF0gPT0gJ0MnLypQeHh4
eCovKQotICAgIHsKLSAgICAgIGlmIChzdHJjbXAgKGNoYXJzZXQgKyAyLCAiODc0IikgPT0gMCkK
LQljaGFyc2V0ID0gIlRJUy02MjAiOwotICAgICAgZWxzZSBpZiAoc3RyY21wIChjaGFyc2V0ICsg
MiwgIjIwODY2IikgPT0gMCkKLQljaGFyc2V0ID0gIktPSTgtUiI7Ci0gICAgICBlbHNlIGlmIChz
dHJjbXAgKGNoYXJzZXQgKyAyLCAiMjE4NjYiKSA9PSAwKQotCWNoYXJzZXQgPSAiS09JOC1VIjsK
LSAgICAgIGVsc2UgaWYgKHN0cmNtcCAoY2hhcnNldCArIDIsICIxMDEiKSA9PSAwKQotCWNoYXJz
ZXQgPSAiR0VPUkdJQU4tUFMiOwotICAgICAgZWxzZSBpZiAoc3RyY21wIChjaGFyc2V0ICsgMiwg
IjEwMiIpID09IDApCi0JY2hhcnNldCA9ICJQVDE1NCI7Ci0gICAgfQotICBlbHNlIGlmIChjaGFy
c2V0WzBdID09ICdTJy8qSklTKi8pCi0gICAgewotICAgICAgLyogQ3lnd2luIHVzZXMgTVNGVCdz
IGltcGxlbWVudGF0aW9uIG9mIFNKSVMsIHdoaWNoIGRpZmZlcnMKLQkgaW4gc29tZSBjb2RlcG9p
bnRzIGZyb20gdGhlIHJlYWwgdGhpbmcsIGVzcGVjaWFsbHkKLQkgMHg1YzogeWVuIHNpZ24gaW5z
dGVhZCBvZiBiYWNrc2xhc2gsCi0JIDB4N2U6IG92ZXJsaW5lIGluc3RlYWQgb2YgdGlsZGUuCi0J
IFdlIGNhbid0IHVzZSB0aGUgcmVhbCBTSklTIHNpbmNlIG90aGVyd2lzZSBXaW4zMgotCSBwYXRo
bmFtZXMgd291bGQgYmVjb21lIGludmFsaWQuICBPVE9ILCBpZiB3ZSByZXR1cm4KLQkgIlNKSVMi
IGhlcmUsIHRoZW4gbGliaWNvbnYgd2lsbCBkbyBtYjwtPndjIGNvbnZlcnNpb24KLQkgZGlmZmVy
ZW50bHkgdG8gb3VyIGludGVybmFsIGZ1bmN0aW9ucy4gIFRoZXJlZm9yZSB3ZQotCSByZXR1cm4g
d2hhdCB3ZSByZWFsbHkgaW1wbGVtZW50LCBDUDkzMi4gIFRoaXMgaXMgaGFuZGxlZAotCSBmaW5l
IGJ5IGxpYmljb252LiAqLwotICAgICAgY2hhcnNldCA9ICJDUDkzMiI7Ci0gICAgfQotCi0gIC8q
IFNldCByZXN1bHRzICovCi0gIHN0cmNweSAobG9jYWxlX291dCwgbmV3X2xvY2FsZSk7Ci0gIHN0
cmNweSAoY2hhcnNldF9vdXQsIGNoYXJzZXQpOwotfQotCiB2b2lkCiBmaGFuZGxlcl9wdHlfc2xh
dmU6OnNldHVwX2xvY2FsZSAodm9pZCkKIHsKICAgaWYgKGdldF90dHlwICgpLT50ZXJtX2NvZGVf
cGFnZSAhPSAwKQogICAgIHJldHVybjsKIAotICBjaGFyIGxvY2FsZVtFTkNPRElOR19MRU4gKyAx
XSA9ICJDIjsKLSAgY2hhciBjaGFyc2V0W0VOQ09ESU5HX0xFTiArIDFdID0gIkFTQ0lJIjsKLSAg
Z2V0X2xhbmdpbmZvIChsb2NhbGUsIGNoYXJzZXQpOworICBleHRlcm4gdm9pZCBpbml0aWFsX3Nl
dGxvY2FsZSAoKTsKKyAgaW5pdGlhbF9zZXRsb2NhbGUgKCk7CisgIGNvbnN0IGNoYXIgKmNoYXJz
ZXQgPSBubF9sYW5naW5mbyAoX05MX0NUWVBFX0NPREVTRVRfTkFNRSk7CiAKICAgLyogU2V0IHRl
cm1pbmFsIGNvZGUgcGFnZSBmcm9tIGxvY2FsZSAqLwogICAvKiBUaGlzIGNvZGUgaXMgYm9ycm93
ZWQgZnJvbSBtaW50dHk6IGNoYXJzZXQuYyAqLwotLSAKMi4yOC4wCgo=

--Multipart=_Fri__4_Sep_2020_18_21_49_+0900_G/wyi0C0BJz.KFTw--
