Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conssluserg-03.nifty.com (conssluserg-03.nifty.com
 [210.131.2.82])
 by sourceware.org (Postfix) with ESMTPS id BC3D93857C60
 for <cygwin-patches@cygwin.com>; Sun, 30 Aug 2020 07:58:09 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org BC3D93857C60
Received: from Express5800-S70 (v038192.dynamic.ppp.asahi-net.or.jp
 [124.155.38.192]) (authenticated)
 by conssluserg-03.nifty.com with ESMTP id 07U7vses018740
 for <cygwin-patches@cygwin.com>; Sun, 30 Aug 2020 16:57:54 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com 07U7vses018740
X-Nifty-SrcIP: [124.155.38.192]
Date: Sun, 30 Aug 2020 16:58:02 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pty: Disable pseudo console if TERM is dumb or
 not set.
Message-Id: <20200830165802.f1a115eb50a21fe948635161@nifty.ne.jp>
In-Reply-To: <20200830164217.1d1d7a740de94649f5f395d4@nifty.ne.jp>
References: <20200826120015.1188-1-takashi.yano@nifty.ne.jp>
 <20200828134503.GL3272@calimero.vinschen.de>
 <20200829042554.e18de504a93bb80da347e858@nifty.ne.jp>
 <20200829201228.b327d38eab10a64d941f99c0@nifty.ne.jp>
 <20200829221420.65bf54f2848c30c5415fbf29@nifty.ne.jp>
 <20200830052506.cc15ac67c0820274a09228e5@nifty.ne.jp>
 <20200830061317.2832cfd36382520b50ab9577@nifty.ne.jp>
 <20200830164217.1d1d7a740de94649f5f395d4@nifty.ne.jp>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart=_Sun__30_Aug_2020_16_58_02_+0900_rvi.E8OC.Br2+N05"
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, NICE_REPLY_A,
 RCVD_IN_BARRACUDACENTRAL, RCVD_IN_DNSWL_NONE, RCVD_IN_MSPIKE_H3,
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
X-List-Received-Date: Sun, 30 Aug 2020 07:58:12 -0000

This is a multi-part message in MIME format.

--Multipart=_Sun__30_Aug_2020_16_58_02_+0900_rvi.E8OC.Br2+N05
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 30 Aug 2020 16:42:17 +0900
Takashi Yano via Cygwin-patches <cygwin-patches@cygwin.com> wrote:
> On Sun, 30 Aug 2020 06:13:17 +0900
> Takashi Yano via Cygwin-patches <cygwin-patches@cygwin.com> wrote:
> > On Sun, 30 Aug 2020 05:25:06 +0900
> > Takashi Yano via Cygwin-patches <cygwin-patches@cygwin.com> wrote:
> > > On Sat, 29 Aug 2020 22:14:20 +0900
> > > Takashi Yano via Cygwin-patches <cygwin-patches@cygwin.com> wrote:
> > > > On Sat, 29 Aug 2020 20:12:28 +0900
> > > > Takashi Yano via Cygwin-patches <cygwin-patches@cygwin.com> wrote:
> > > > > Hi Corinna,
> > > > > 
> > > > > On Sat, 29 Aug 2020 04:25:54 +0900
> > > > > Takashi Yano via Cygwin-patches <cygwin-patches@cygwin.com> wrote:
> > > > > > Hi Corinna,
> > > > > >
> > > > > > On Fri, 28 Aug 2020 15:45:03 +0200
> > > > > > Corinna Vinschen wrote:
> > > > > > > Hi Takashi,
> > > > > > > 
> > > > > > > On Aug 26 21:00, Takashi Yano via Cygwin-patches wrote:
> > > > > > > > Pseudo console generates escape sequences on execution of non-cygwin
> > > > > > > > apps.  If the terminal does not support escape sequence, output will
> > > > > > > > be garbled. This patch prevents garbled output in dumb terminal by
> > > > > > > > disabling pseudo console.
> > > > > [...]
> > > > > > > 
> > > > > > > Would you mind to encapsulate the TERM checks into a fhandler_pty_slave
> > > > > > > method so the TERM specific stuff is done in the fhandler code, not
> > > > > > > in spawn.cc?
> > > > > > 
> > > > > > Thansk for the suggestion. I will submit v2 patch.
> > > > > 
> > > > > What do you think of v3 patch attached? With this patch,
> > > > > terminal capability is checked by looking into terminfo
> > > > > database rather than just checking terminal name. This
> > > > > solution is more essential for the issue to be solved,
> > > > > I think.
> > > > > 
> > > > > One downside of this solution, I noticed, is that tmux
> > > > > sets TERM to "screen", which does not have CSI6n, by
> > > > > default. As a result, pseudo console is disbled in tmux
> > > > > by default. Setting TERM, such as screen.xterm-256color,
> > > > > will solve the issue.
> > > > 
> > > > Attached is the v4 patch. Small bug was fixed.
> > > 
> > > Bug fixed again. v5 patch attached.
> > 
> > v6: Refactor the code a little.
> 
> v7: Fix another bug again.

v8: Yet another bug fix.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>

--Multipart=_Sun__30_Aug_2020_16_58_02_+0900_rvi.E8OC.Br2+N05
Content-Type: application/octet-stream;
 name="v8-0001-Cygwin-pty-Disable-pseudo-console-if-TERM-does-no.patch"
Content-Disposition: attachment;
 filename="v8-0001-Cygwin-pty-Disable-pseudo-console-if-TERM-does-no.patch"
Content-Transfer-Encoding: base64

RnJvbSBmNzE3OGNjMGI1NzA5YTEzNGNhNWU0ZTFkODVkZmI1M2RiZTgyZjgxIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBUYWthc2hpIFlhbm8gPHRha2FzaGkueWFub0BuaWZ0eS5uZS5q
cD4KRGF0ZTogU3VuLCAzMCBBdWcgMjAyMCAxNjo1NToxMCArMDkwMApTdWJqZWN0OiBbUEFUQ0gg
djhdIEN5Z3dpbjogcHR5OiBEaXNhYmxlIHBzZXVkbyBjb25zb2xlIGlmIFRFUk0gZG9lcyBub3Qg
aGF2ZQogQ1NJNm4uCgotIFBzZXVkbyBjb25zb2xlIGludGVybmFsbHkgc2VuZHMgZXNjYXBlIHNl
cXVlbmNlIENTSTZuIChxdWVyeSBjdXJzb3IKICBwb3NpdGlvbikgb24gc3RhcnR1cCBvZiBub24t
Y3lnd2luIGFwcHMuIElmIHRoZSB0ZXJtaW5hbCBkb2VzIG5vdAogIHN1cHBvcnQgQ1NJNm4sIENy
ZWF0ZVByb2Nlc3MoKSBoYW5ncyB3YWl0aW5nIGZvciByZXNwb25zZS4gVG8gcHJldmVudAogIGhh
bmcsIHRoaXMgcGF0Y2ggZGlzYWJsZXMgcHNldWRvIGNvbnNvbGUgaWYgdGhlIHRlcm1pbmFsIGRv
ZXMgbm90CiAgaGF2ZSBDU0k2biBpbiB0ZXJtaW5mbyBkYXRhYmFzZS4gQWxzbywgcmVtb3ZlcyBl
c2NhcGUgc2VxdWVuY2UgZm9yCiAgc2V0dGluZyB3aW5kb3cgdGl0bGUgaWYgdGhlIHRlcm1pbmFs
IGRvZXMgbm90IGhhdmUgdGhlIHNldC10aXRsZQogIGNhcGFiaWxpdHkuCi0tLQogd2luc3VwL2N5
Z3dpbi9maGFuZGxlci5oICAgICAgfCAgIDEgKwogd2luc3VwL2N5Z3dpbi9maGFuZGxlcl90dHku
Y2MgfCAxMzMgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKwogd2luc3VwL2N5Z3dp
bi9zcGF3bi5jYyAgICAgICAgfCAgMTkgKysrLS0KIHdpbnN1cC9jeWd3aW4vdHR5LmNjICAgICAg
ICAgIHwgICAxICsKIHdpbnN1cC9jeWd3aW4vdHR5LmggICAgICAgICAgIHwgICAxICsKIDUgZmls
ZXMgY2hhbmdlZCwgMTQ4IGluc2VydGlvbnMoKyksIDcgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0
IGEvd2luc3VwL2N5Z3dpbi9maGFuZGxlci5oIGIvd2luc3VwL2N5Z3dpbi9maGFuZGxlci5oCmlu
ZGV4IDlmZDk1YzA5OC4uZjU1YmNmOWQxIDEwMDY0NAotLS0gYS93aW5zdXAvY3lnd2luL2ZoYW5k
bGVyLmgKKysrIGIvd2luc3VwL2N5Z3dpbi9maGFuZGxlci5oCkBAIC0yMzMyLDYgKzIzMzIsNyBA
QCBjbGFzcyBmaGFuZGxlcl9wdHlfc2xhdmU6IHB1YmxpYyBmaGFuZGxlcl9wdHlfY29tbW9uCiAg
IH0KICAgYm9vbCBzZXR1cF9wc2V1ZG9jb25zb2xlIChTVEFSVFVQSU5GT0VYVyAqc2ksIGJvb2wg
bm9wY29uKTsKICAgdm9pZCBjbG9zZV9wc2V1ZG9jb25zb2xlICh2b2lkKTsKKyAgYm9vbCB0ZXJt
X2hhc19wY29uX2NhcCAoY29uc3QgV0NIQVIgKmVudiwgYm9vbCBiZyk7CiAgIHZvaWQgc2V0X3N3
aXRjaF90b19wY29uICh2b2lkKTsKICAgdm9pZCByZXNldF9zd2l0Y2hfdG9fcGNvbiAodm9pZCk7
CiAgIHZvaWQgbWFza19zd2l0Y2hfdG9fcGNvbl9pbiAoYm9vbCBtYXNrKTsKZGlmZiAtLWdpdCBh
L3dpbnN1cC9jeWd3aW4vZmhhbmRsZXJfdHR5LmNjIGIvd2luc3VwL2N5Z3dpbi9maGFuZGxlcl90
dHkuY2MKaW5kZXggMDg2NWMxZmFjLi4yYTdlNjZhZmQgMTAwNjQ0Ci0tLSBhL3dpbnN1cC9jeWd3
aW4vZmhhbmRsZXJfdHR5LmNjCisrKyBiL3dpbnN1cC9jeWd3aW4vZmhhbmRsZXJfdHR5LmNjCkBA
IC0yMTY5LDYgKzIxNjksMjIgQEAgZmhhbmRsZXJfcHR5X21hc3Rlcjo6cHR5X21hc3Rlcl9md2Rf
dGhyZWFkICgpCiAgICAgICBjaGFyICpwdHIgPSBvdXRidWY7CiAgICAgICBpZiAoZ2V0X3R0eXAg
KCktPmhfcHNldWRvX2NvbnNvbGUpCiAJeworCSAgaWYgKCFnZXRfdHR5cCAoKS0+aGFzX3NldF90
aXRsZSkKKwkgICAgeworCSAgICAgIC8qIFJlbW92ZSBTZXQgdGl0bGUgc2VxdWVuY2UgKi8KKwkg
ICAgICBjaGFyICpwMCwgKnAxOworCSAgICAgIHAwID0gb3V0YnVmOworCSAgICAgIHdoaWxlICgo
cDAgPSAoY2hhciAqKSBtZW1tZW0gKHAwLCBybGVuLCAiXDAzM10wOyIsIDQpKSkKKwkJeworCQkg
IHAxID0gKGNoYXIgKikgbWVtY2hyIChwMCwgJ1wwMDcnLCBybGVuIC0gKHAwIC0gb3V0YnVmKSk7
CisJCSAgaWYgKHAxKQorCQkgICAgeworCQkgICAgICBtZW1tb3ZlIChwMCwgcDEgKyAxLCBybGVu
IC0gKHAxICsgMSAtIG91dGJ1ZikpOworCQkgICAgICBybGVuIC09IHAxICsgMSAtIHAwOworCQkg
ICAgICB3bGVuID0gcmxlbjsKKwkJICAgIH0KKwkJfQorCSAgICB9CiAJICAvKiBSZW1vdmUgQ1NJ
ID4gUG0gbSAqLwogCSAgaW50IHN0YXRlID0gMDsKIAkgIGludCBzdGFydF9hdCA9IDA7CkBAIC0y
NjU5LDMgKzI2NzUsMTIwIEBAIGZoYW5kbGVyX3B0eV9zbGF2ZTo6Y2xvc2VfcHNldWRvY29uc29s
ZSAodm9pZCkKICAgICAgIGdldF90dHlwICgpLT5wY29uX3N0YXJ0ID0gZmFsc2U7CiAgICAgfQog
fQorCitib29sCitmaGFuZGxlcl9wdHlfc2xhdmU6OnRlcm1faGFzX3Bjb25fY2FwIChjb25zdCBX
Q0hBUiAqZW52LCBib29sIGJhY2tncm91bmQpCit7CisgIGNvbnN0IGNoYXIgKnRlcm0gPSBOVUxM
OworICBjaGFyIHRlcm1fc3RyWzI2MF07CisgIGlmIChlbnYpCisgICAgeworICAgIGZvciAoY29u
c3QgV0NIQVIgKnAgPSBlbnY7ICpwICE9IEwnXDAnOyBwICs9IHdjc2xlbiAocCkgKyAxKQorICAg
ICAgaWYgKHN3c2NhbmYgKHAsIEwiVEVSTT0lMjM2cyIsIHRlcm1fc3RyKSA9PSAxKQorCXsKKwkg
IHRlcm0gPSB0ZXJtX3N0cjsKKwkgIGJyZWFrOworCX0KKyAgICB9CisgIGVsc2UKKyAgICB0ZXJt
ID0gZ2V0ZW52ICgiVEVSTSIpOworCisgIGlmICghdGVybSkKKyAgICByZXR1cm4gZmFsc2U7CisK
KyAgLyogQ2hlY2sgaWYgdGVybWluYWwgaGFzIGNhcGFiaWxpdHkgd2hpY2ggcHVzZWRvIGNvbnNv
bGUgbmVlZHMgKi8KKyAgY2hhciB0aW5mb1syNjBdOworICBfX3NtYWxsX3NwcmludGYgKHRpbmZv
LCAiL3Vzci9zaGFyZS90ZXJtaW5mby8lMDJ4LyVzIiwgdGVybVswXSwgdGVybSk7CisgIHBhdGhf
Y29udiBwYXRoICh0aW5mbyk7CisgIFdDSEFSIHd0aW5mb1syNjBdOworICBwYXRoLmdldF93aWRl
X3dpbjMyX3BhdGggKHd0aW5mbyk7CisgIEhBTkRMRSBoOworICBoID0gQ3JlYXRlRmlsZVcgKHd0
aW5mbywgR0VORVJJQ19SRUFELCBGSUxFX1NIQVJFX1JFQUQsCisJCSAgIE5VTEwsIE9QRU5fRVhJ
U1RJTkcsIDAsIE5VTEwpOworICBpZiAoaCA9PSBOVUxMKQorICAgIHJldHVybiBmYWxzZTsKKyAg
Y2hhciB0ZXJtaW5mb1s0MDk2XTsKKyAgRFdPUkQgbjsKKyAgUmVhZEZpbGUgKGgsIHRlcm1pbmZv
LCBzaXplb2YgKHRlcm1pbmZvKSwgJm4sIDApOworICBDbG9zZUhhbmRsZSAoaCk7CisKKyAgaW50
IG51bV9zaXplID0gMjsKKyAgaWYgKCooaW50MTZfdCAqKXRlcm1pbmZvID09IDAxMDM2IC8qIE1B
R0lDMiAqLykKKyAgICBudW1fc2l6ZSA9IDQ7CisgIGNvbnN0IGludCBuYW1lX3BvcyA9IDEyOyAv
KiBQb3NpdGlvbiBvZiB0ZXJtaW5hbCBuYW1lICovCisgIGNvbnN0IGludCBuYW1lX3NpemUgPSAq
KGludDE2X3QgKikgKHRlcm1pbmZvICsgMik7CisgIGNvbnN0IGludCBib29sX2NvdW50ID0gKihp
bnQxNl90ICopICh0ZXJtaW5mbyArIDQpOworICBjb25zdCBpbnQgbnVtX2NvdW50ID0gKihpbnQx
Nl90ICopICh0ZXJtaW5mbyArIDYpOworICBjb25zdCBpbnQgc3RyX2NvdW50ID0gKihpbnQxNl90
ICopICh0ZXJtaW5mbyArIDgpOworICBjb25zdCBpbnQgc3RyX3NpemUgPSAqKGludDE2X3QgKikg
KHRlcm1pbmZvICsgMTApOworICBjb25zdCBpbnQgdXNlcjcgPSAyOTQ7IC8qIHU3IChxdWVyeSBj
dXJzb3IgcG9zaXRpb24pIGVudHJ5IGluZGV4ICovCisgIGlmICh1c2VyNyA+PSBzdHJfY291bnQp
CisgICAgcmV0dXJuIGZhbHNlOworICBpbnQgc3RyX2lkeF9wb3MgPSBuYW1lX3BvcyArIG5hbWVf
c2l6ZSArIGJvb2xfY291bnQgKyBudW1fc2l6ZSAqIG51bV9jb3VudDsKKyAgaWYgKHN0cl9pZHhf
cG9zICYgMSkKKyAgICBzdHJfaWR4X3BvcyArKzsKKyAgY29uc3QgaW50MTZfdCAqc3RyX2lkeCA9
IChpbnQxNl90ICopICh0ZXJtaW5mbyArIHN0cl9pZHhfcG9zKTsKKyAgY29uc3QgY2hhciAqc3Ry
X3RhYmxlID0gKGNvbnN0IGNoYXIgKikgKHN0cl9pZHggKyBzdHJfY291bnQpOworICBpZiAoc3Ry
X2lkeCArIHVzZXI3ID49IChpbnQxNl90ICopICh0ZXJtaW5mbyArIG4pKQorICAgIHJldHVybiBm
YWxzZTsKKyAgaWYgKHN0cl9pZHhbdXNlcjddID09IC0xKQorICAgIHJldHVybiBmYWxzZTsKKyAg
Y29uc3QgY2hhciAqdXNlcjdfc3RyID0gc3RyX3RhYmxlICsgc3RyX2lkeFt1c2VyN107CisgIGlm
ICh1c2VyN19zdHIgPj0gc3RyX3RhYmxlICsgc3RyX3NpemUpCisgICAgcmV0dXJuIGZhbHNlOwor
ICBpZiAodXNlcjdfc3RyID49IHRlcm1pbmZvICsgbikKKyAgICByZXR1cm4gZmFsc2U7CisgIGlm
IChzdHJjbXAgKHVzZXI3X3N0ciwgIlwwMzNbNm4iKSAhPSAwKQorICAgIHJldHVybiBmYWxzZTsK
KworICAvKiBJZiB0aGUgcHJvY2VzcyBpcyBiYWNrZ3JvdW5kLCBvciBhbm90aGVyIHByb2Nlc3Mg
aXMgYWxyZWFkeQorICAgICBzdGFydGVkIHVuZGVyIHBzZXVkbyBjb25zb2xlLCByZXNwb25jZSB0
byBDU0k2biBtYXkgYmUgZWF0ZW4KKyAgICAgYnkgdGhlIG90aGVyIHByb2Nlc3MuIFRoZXJlZm9y
ZSwgY2hlY2tpbmcgc2V0LXRpdGxlIGNhcGFiaWxpdHkKKyAgICAgc2hvdWxkIGJlIHNraXBwZWQu
ICovCisgIGlmIChnZXRfdHR5cCAoKS0+cGNvbl9waWQgJiYgZ2V0X3R0eXAgKCktPnBjb25fcGlk
ICE9IG15c2VsZi0+cGlkCisgICAgICAmJiAhIXBpbmZvIChnZXRfdHR5cCAoKS0+cGNvbl9waWQp
KQorICAgIHJldHVybiB0cnVlOworICBpZiAoYmFja2dyb3VuZCkKKyAgICByZXR1cm4gdHJ1ZTsK
KworICAvKiBDaGVjayBpZiB0ZXJtaW5hbCBoYXMgc2V0LXRpdGxlIGNhcGFiaWxpdHkgKi8KKyAg
dGNmbGFnX3QgY19sZmxhZyA9IGdldF90dHlwICgpLT50aS5jX2xmbGFnOworICBnZXRfdHR5cCAo
KS0+dGkuY19sZmxhZyAmPSB+SUNBTk9OOworICB3cml0ZSAoIlwwMzNbNm5cMDMzXTA7XDAzM1xc
XDAzM1s2biIsIDE0KTsKKyAgY2hhciBidWZbMTAyNF07CisgIGNoYXIgKnAgPSBidWY7CisgIGlu
dCBsZW4gPSBzaXplb2YgKGJ1ZikgLSAxOworICBpbnQgeDEsIHkxLCB4MiwgeTI7CisgIGRvCisg
ICAgeworICAgICAgc2l6ZV90IG4gPSBsZW47CisgICAgICByZWFkIChwLCBuKTsKKyAgICAgIHAg
Kz0gbjsKKyAgICAgIGxlbiAtPSBuOworICAgICAgKnAgPSAnXDAnOworICAgICAgY2hhciAqcDIg
PSBzdHJyY2hyIChidWYsICdcMDMzJyk7CisgICAgICBpZiAocDIgPT0gTlVMTCB8fCBzc2NhbmYg
KHAyLCAiXDAzM1slZDslZFIiLCAmeTIsICZ4MikgIT0gMikKKwljb250aW51ZTsKKyAgICAgICpw
MiA9ICdcMCc7CisgICAgICBjaGFyICpwMSA9IHN0cnJjaHIgKGJ1ZiwgJ1wwMzMnKTsKKyAgICAg
ICpwMiA9ICdcMDMzJzsKKyAgICAgIGlmIChwMSA9PSBOVUxMIHx8IHNzY2FuZiAocDEsICJcMDMz
WyVkOyVkUiIsICZ5MSwgJngxKSAhPSAyKQorCWNvbnRpbnVlOworICAgICAgYnJlYWs7CisgICAg
fQorICB3aGlsZSAobGVuKTsKKyAgZ2V0X3R0eXAgKCktPnRpLmNfbGZsYWcgPSBjX2xmbGFnOwor
ICBpZiAobGVuID09IDApCisgICAgcmV0dXJuIHRydWU7CisgIGlmICh4MiA9PSB4MSAmJiB5MiA9
PSB5MSkKKyAgICAvKiBJZiAiXDAzM10wO1wwMzNcXCIgZG9lcyBub3QgbW92ZSBjdXJzb3IgcG9z
aXRpb24sCisgICAgICAgc2V0LXRpdGxlIGlzIHN1cHBvc2VkIHRvIGJlIHN1cHBvcnRlZC4gKi8K
KyAgICBnZXRfdHR5cCAoKS0+aGFzX3NldF90aXRsZSA9IHRydWU7CisgIGVsc2UKKyAgICB7Cisg
ICAgICBmb3IgKGludCBpPTA7IGk8eDIteDE7IGkrKykKKwl3cml0ZSAoIlxiIFxiIiwgMyk7Cisg
ICAgICBnZXRfdHR5cCAoKS0+aGFzX3NldF90aXRsZSA9IGZhbHNlOworICAgIH0KKyAgcmV0dXJu
IHRydWU7Cit9CmRpZmYgLS1naXQgYS93aW5zdXAvY3lnd2luL3NwYXduLmNjIGIvd2luc3VwL2N5
Z3dpbi9zcGF3bi5jYwppbmRleCBhMmY3Njk3ZDcuLjlhNWUzZjZlZiAxMDA2NDQKLS0tIGEvd2lu
c3VwL2N5Z3dpbi9zcGF3bi5jYworKysgYi93aW5zdXAvY3lnd2luL3NwYXduLmNjCkBAIC02NDcs
MTMgKzY0NywxOCBAQCBjaGlsZF9pbmZvX3NwYXduOjp3b3JrZXIgKGNvbnN0IGNoYXIgKnByb2df
YXJnLCBjb25zdCBjaGFyICpjb25zdCAqYXJndiwKICAgICAgIFplcm9NZW1vcnkgKCZzaV9wY29u
LCBzaXplb2YgKHNpX3Bjb24pKTsKICAgICAgIFNUQVJUVVBJTkZPVyAqc2lfdG1wID0gJnNpOwog
ICAgICAgaWYgKCFpc2N5Z3dpbiAoKSAmJiBwdHlzX3ByaW1hcnkgJiYgaXNfY29uc29sZV9hcHAg
KHJ1bnBhdGgpKQotCWlmIChwdHlzX3ByaW1hcnktPnNldHVwX3BzZXVkb2NvbnNvbGUgKCZzaV9w
Y29uLAotCQkJICAgICBtb2RlICE9IF9QX09WRVJMQVkgJiYgbW9kZSAhPSBfUF9XQUlUKSkKLQkg
IHsKLQkgICAgY19mbGFncyB8PSBFWFRFTkRFRF9TVEFSVFVQSU5GT19QUkVTRU5UOwotCSAgICBz
aV90bXAgPSAmc2lfcGNvbi5TdGFydHVwSW5mbzsKLQkgICAgZW5hYmxlX3Bjb24gPSB0cnVlOwot
CSAgfQorCXsKKwkgIGJvb2wgbm9wY29uID0gbW9kZSAhPSBfUF9PVkVSTEFZICYmIG1vZGUgIT0g
X1BfV0FJVDsKKwkgIGJvb2wgYmFja2dyb3VuZCA9IGN0dHlfcGdpZCAmJiBjdHR5X3BnaWQgIT0g
bXlzZWxmLT5wZ2lkOworCSAgaWYgKCFwdHlzX3ByaW1hcnktPnRlcm1faGFzX3Bjb25fY2FwIChl
bnZibG9jaywgYmFja2dyb3VuZCkpCisJICAgIG5vcGNvbiA9IHRydWU7CisJICBpZiAocHR5c19w
cmltYXJ5LT5zZXR1cF9wc2V1ZG9jb25zb2xlICgmc2lfcGNvbiwgbm9wY29uKSkKKwkgICAgewor
CSAgICAgIGNfZmxhZ3MgfD0gRVhURU5ERURfU1RBUlRVUElORk9fUFJFU0VOVDsKKwkgICAgICBz
aV90bXAgPSAmc2lfcGNvbi5TdGFydHVwSW5mbzsKKwkgICAgICBlbmFibGVfcGNvbiA9IHRydWU7
CisJICAgIH0KKwl9CiAKICAgICBsb29wOgogICAgICAgLyogV2hlbiBydWlkICE9IGV1aWQgd2Ug
Y3JlYXRlIHRoZSBuZXcgcHJvY2VzcyB1bmRlciB0aGUgY3VycmVudCBvcmlnaW5hbApkaWZmIC0t
Z2l0IGEvd2luc3VwL2N5Z3dpbi90dHkuY2MgYi93aW5zdXAvY3lnd2luL3R0eS5jYwppbmRleCBk
NjBmMjc1NDUuLmU2ZDU3ZmY2ZSAxMDA2NDQKLS0tIGEvd2luc3VwL2N5Z3dpbi90dHkuY2MKKysr
IGIvd2luc3VwL2N5Z3dpbi90dHkuY2MKQEAgLTI0Miw2ICsyNDIsNyBAQCB0dHk6OmluaXQgKCkK
ICAgdGVybV9jb2RlX3BhZ2UgPSAwOwogICBwY29uX2xhc3RfdGltZSA9IDA7CiAgIHBjb25fc3Rh
cnQgPSBmYWxzZTsKKyAgaGFzX3NldF90aXRsZSA9IGZhbHNlOwogfQogCiBIQU5ETEUKZGlmZiAt
LWdpdCBhL3dpbnN1cC9jeWd3aW4vdHR5LmggYi93aW5zdXAvY3lnd2luL3R0eS5oCmluZGV4IGM0
OTFkMzg5MS4uMTNhZjk1Njg3IDEwMDY0NAotLS0gYS93aW5zdXAvY3lnd2luL3R0eS5oCisrKyBi
L3dpbnN1cC9jeWd3aW4vdHR5LmgKQEAgLTEwMSw2ICsxMDEsNyBAQCBwcml2YXRlOgogICBVSU5U
IHRlcm1fY29kZV9wYWdlOwogICBEV09SRCBwY29uX2xhc3RfdGltZTsKICAgSEFORExFIGhfcGNv
bl93cml0ZV9waXBlOworICBib29sIGhhc19zZXRfdGl0bGU7CiAKIHB1YmxpYzoKICAgSEFORExF
IGZyb21fbWFzdGVyICgpIGNvbnN0IHsgcmV0dXJuIF9mcm9tX21hc3RlcjsgfQotLSAKMi4yOC4w
Cgo=

--Multipart=_Sun__30_Aug_2020_16_58_02_+0900_rvi.E8OC.Br2+N05--
