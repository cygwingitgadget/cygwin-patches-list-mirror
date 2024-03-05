Return-Path: <SRS0=ZRpm=KL=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from dmta1016.nifty.com (mta-snd01004.nifty.com [IPv6:2001:268:fa30:831:6a:99:e3:24])
	by sourceware.org (Postfix) with ESMTPS id 299043858C54
	for <cygwin-patches@cygwin.com>; Tue,  5 Mar 2024 14:47:55 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 299043858C54
Authentication-Results: sourceware.org; dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 299043858C54
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=2001:268:fa30:831:6a:99:e3:24
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1709650080; cv=none;
	b=jIkxoYnH/Jx5JSt+8AJxu4fx1xNODGVL5CxFwPj9fmBDCByMbr0Sz46BA5uOjOa9ftSI/TmCb163u4QKyQordxlZuaExez16zT0FBo68yPEIQHm1t5jjIJ7cmCHUhy4ncEPbi7Cgaf8y+xjeYKjtDwcQVUC/9tAt5amGZSDCVuI=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1709650080; c=relaxed/simple;
	bh=7v9kekpsvu0PQX+To9ooTRPEqN/C8WVOvUdZ+uTsqZE=;
	h=Date:From:To:Subject:Message-Id:Mime-Version; b=sG9cGS99Hnt8QUsMgB7kypalD1A9ktNDwbv6vGEQCzFGjQpMF02Om8sVoHhnOyBj8o0h1s16sqxj+bzgOvAil/xTJlsaj6H4nxohOyDOuUEJA2pucymF2vJQ98g4Vb9lknoHzv9Bw1BV+mmgfT3HcrlF+fTplzxHddTuQTQSQlQ=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: from HP-Z230 by dmta1016.nifty.com with ESMTP
          id <20240305144753947.FRPZ.67045.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Tue, 5 Mar 2024 23:47:53 +0900
Date: Tue, 5 Mar 2024 23:47:53 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pipe: Give up to use query_hdl for non-cygwin
 apps.
Message-Id: <20240305234753.b484e79322961aba9f8c9979@nifty.ne.jp>
In-Reply-To: <ZebwloVEzedGcBWj@calimero.vinschen.de>
References: <20240303050915.2024-1-takashi.yano@nifty.ne.jp>
	<b0bd6b96-5bd8-7f4e-71ff-4552e5ac1cb5@gmx.de>
	<20240303192109.9fb4a3a4968bb11ca5d9636a@nifty.ne.jp>
	<87a5nfbnv7.fsf@Gerda.invalid>
	<20240303203641.09321b0a0713e8bdb90980b5@nifty.ne.jp>
	<ZeWjmEikjIUushtk@calimero.vinschen.de>
	<87edcqgfwc.fsf@>
	<ZeYG_11UfRTLzit1@calimero.vinschen.de>
	<20240305090648.6342d8f9cb8fd4ca64b47d38@nifty.ne.jp>
	<ZebwloVEzedGcBWj@calimero.vinschen.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart=_Tue__5_Mar_2024_23_47_53_+0900_j+BrmeQuWG+OICAC"
X-Spam-Status: No, score=-11.1 required=5.0 tests=BAYES_00,GIT_PATCH_0,KAM_DMARC_STATUS,NICE_REPLY_A,SPF_HELO_PASS,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

This is a multi-part message in MIME format.

--Multipart=_Tue__5_Mar_2024_23_47_53_+0900_j+BrmeQuWG+OICAC
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 5 Mar 2024 11:14:46 +0100
Corinna Vinschen wrote:
> On Mar  5 09:06, Takashi Yano wrote:
> > On Mon, 4 Mar 2024 18:38:07 +0100
> > Corinna Vinschen wrote:
> > > On Mar  4 16:45, ASSI wrote:
> > > > Corinna Vinschen writes:
> > > > > Right you are.  We always said that independent Cygwin installations
> > > > > are supposed to *stay* independent.
> > > > >
> > > > > Keep in mind that they don't share the same shared objects in the native
> > > > > NT namespace and they don't know of each other.  It's not only the
> > > > > process table but also in-use FIFO stuff, pty info, etc.
> > > > 
> > > > What I was getting at is that a process not showing up in the process
> > > > list in one Cygwin installation doesn't automatically mean it's a native
> > > > Windows process, it could be a process started by an independent Cygwin
> > > > installation.  So this way of checking for "native" Windows processes
> > > > may or may not do what was originally intended.
> > > 
> > > But that was my point. A "foreign" Cygwin process from another
> > > installation is not a Cygwin process.  Lots of interoperability
> > > just won't work, so it's basically a native process.
> > 
> > Actually, I think query_hdl can be retrieved from the process
> > from another installation of cygwin using NtQueryInformationProcess()
> > with ProcessHandleInformation. However, I cannot imagne the case
> > that the pipe is made by one cygwin installation but the reader
> > process is from another installation of cygwin.
> > 
> > BTW, what about v2 patch itself?
> 
> It does the job with less code and less memory, which is good.
> I would change the comment
> 
>   stop to try to get query_hdl for non-cygwin apps
> 
> to something like
> 
>   don't try to fetch query_hdl from non-cygwin apps
> 
> "stop trying" is a bit of a back-reference to the old code, which
> is not necessary, I think.

I'll submit v3 patch. Please review.

> This doesn't affect your patch, but while looking into this, what
> strikes me as weird is that fhandler_pipe::temporary_query_hdl() calls
> NtQueryObject() and assembles the pipe name via swscanf() every time it
> is called.
> 
> Wouldn't it make sense to store the name in the fhandler's
> path_conv::wide_path/uni_path at creation time instead?
> The wide_path member is not used at all in pipes, ostensibly.

Is the patch attached as you intended?

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>

--Multipart=_Tue__5_Mar_2024_23_47_53_+0900_j+BrmeQuWG+OICAC
Content-Type: text/plain;
 name="0001-Cygwin-pipe-Simplify-chhecking-procedure-of-query_hd.patch"
Content-Disposition: attachment;
 filename="0001-Cygwin-pipe-Simplify-chhecking-procedure-of-query_hd.patch"
Content-Transfer-Encoding: base64

RnJvbSA5OTgwMjdmZTdhN2E1NmFmOTUwNzM0MTI2NmM5ZmNhZGVlNjZiZWI5IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQ0KRnJvbTogVGFrYXNoaSBZYW5vIDx0YWthc2hpLnlhbm9AbmlmdHkubmUu
anA+DQpEYXRlOiBUdWUsIDUgTWFyIDIwMjQgMjM6MzQ6MjEgKzA5MDANClN1YmplY3Q6IFtQQVRD
SF0gQ3lnd2luOiBwaXBlOiBTaW1wbGlmeSBjaGhlY2tpbmcgcHJvY2VkdXJlIG9mIHF1ZXJ5X2hk
bC4NCg0KVGhpcyBwYXRjaCBlbGltaW5hdGVzIHZlcmJvc2UgTnRRdWVyeU9iamVjdCgpIGNhbGxz
IGluIHRoZSBwcm9jZWR1cmUNCnRvIGdldCBxdWVyeV9oZGwgYnkgc3RvcmluZyBwaXBlIG5hbWUg
aW50byBmaGFuZGxlcl9iYXNlOjpwYyB3aGVuDQp0aGUgcGlwZSBpcyBjcmVhdGVkLiAgZmhhbmRs
ZXJfcGlwZTo6dGVtcG9yYXJ5X3F1ZXJ5X2hkbCgpIHVzZXMgdGhlDQpzdG9yZWRwaXBlIG5hbWUg
cmF0aGVyIHRoYW4gdGhlIG5hbWUgcmV0cmlldmVkIGJ5IE50UXVlcnlPYmplY3QoKS4NCg0KU3Vn
Z2VzdGVkLWJ5OiBDb3Jpbm5hIFZpbnNjaGVuIDxjb3Jpbm5hQHZpbnNjaGVuLmRlPg0KU2lnbmVk
LW9mZi1ieTogVGFrYXNoaSBZYW5vIDx0YWthc2hpLnlhbm9AbmlmdHkubmUuanA+DQotLS0NCiB3
aW5zdXAvY3lnd2luL2ZoYW5kbGVyL3BpcGUuY2MgICAgICAgICAgfCAzOSArKysrKysrKysrKyst
LS0tLS0tLS0tLS0tDQogd2luc3VwL2N5Z3dpbi9sb2NhbF9pbmNsdWRlcy9maGFuZGxlci5oIHwg
IDMgLS0NCiAyIGZpbGVzIGNoYW5nZWQsIDE5IGluc2VydGlvbnMoKyksIDIzIGRlbGV0aW9ucygt
KQ0KDQpkaWZmIC0tZ2l0IGEvd2luc3VwL2N5Z3dpbi9maGFuZGxlci9waXBlLmNjIGIvd2luc3Vw
L2N5Z3dpbi9maGFuZGxlci9waXBlLmNjDQppbmRleCBjODc3ZDg5ZDcuLjA2MTFkZDFjMyAxMDA2
NDQNCi0tLSBhL3dpbnN1cC9jeWd3aW4vZmhhbmRsZXIvcGlwZS5jYw0KKysrIGIvd2luc3VwL2N5
Z3dpbi9maGFuZGxlci9waXBlLmNjDQpAQCAtOTMsNiArOTMsMTkgQEAgZmhhbmRsZXJfcGlwZTo6
aW5pdCAoSEFORExFIGYsIERXT1JEIGEsIG1vZGVfdCBtb2RlLCBpbnQ2NF90IHVuaXFfaWQpDQog
ICAgICAgIGV2ZW4gd2l0aCBGSUxFX1NZTkNIUk9OT1VTX0lPX05PTkFMRVJULiAqLw0KICAgICBz
ZXRfcGlwZV9ub25fYmxvY2tpbmcgKGdldF9kZXZpY2UgKCkgPT0gRkhfUElQRVIgPw0KIAkJCSAg
IHRydWUgOiBpc19ub25ibG9ja2luZyAoKSk7DQorDQorICAvKiBTdG9yZSBwaXBlIG5hbWUgdG8g
cGF0aF9jb252IHBjIGZvciBxdWVyeV9oZGwgY2hlY2sgKi8NCisgIGlmIChnZXRfZGV2ICgpID09
IEZIX1BJUEVXKQ0KKyAgICB7DQorICAgICAgVUxPTkcgbGVuOw0KKyAgICAgIHRtcF9wYXRoYnVm
IHRwOw0KKyAgICAgIE9CSkVDVF9OQU1FX0lORk9STUFUSU9OICpudGZuID0gKE9CSkVDVF9OQU1F
X0lORk9STUFUSU9OICopIHRwLndfZ2V0ICgpOw0KKyAgICAgIE5UU1RBVFVTIHN0YXR1cyA9IE50
UXVlcnlPYmplY3QgKGYsIE9iamVjdE5hbWVJbmZvcm1hdGlvbiwgbnRmbiwNCisJCQkJICAgICAg
IDY1NTM2LCAmbGVuKTsNCisgICAgICBpZiAoTlRfU1VDQ0VTUyAoc3RhdHVzKSAmJiBudGZuLT5O
YW1lLkJ1ZmZlcikNCisJcGMuc2V0X250X25hdGl2ZV9wYXRoICgmbnRmbi0+TmFtZSk7DQorICAg
IH0NCisNCiAgIHJldHVybiAxOw0KIH0NCiANCkBAIC0xMTQ5LDYgKzExNjIsOSBAQCBmaGFuZGxl
cl9waXBlOjp0ZW1wb3JhcnlfcXVlcnlfaGRsICgpDQogICB0bXBfcGF0aGJ1ZiB0cDsNCiAgIE9C
SkVDVF9OQU1FX0lORk9STUFUSU9OICpudGZuID0gKE9CSkVDVF9OQU1FX0lORk9STUFUSU9OICop
IHRwLndfZ2V0ICgpOw0KIA0KKyAgVU5JQ09ERV9TVFJJTkcgKm5hbWUgPSBwYy5nZXRfbnRfbmF0
aXZlX3BhdGggKE5VTEwpOw0KKyAgbmFtZS0+QnVmZmVyW25hbWUtPkxlbmd0aCAvIHNpemVvZiAo
V0NIQVIpXSA9IEwnXDAnOw0KKw0KICAgLyogVHJ5IHByb2Nlc3MgaGFuZGxlIG9wZW5lZCBhbmQg
cGlwZSBoYW5kbGUgdmFsdWUgY2FjaGVkIGZpcnN0DQogICAgICBpbiBvcmRlciB0byByZWR1Y2Ug
b3ZlcmhlYWQuICovDQogICBpZiAocXVlcnlfaGRsX3Byb2MgJiYgcXVlcnlfaGRsX3ZhbHVlKQ0K
QEAgLTExNjEsMTQgKzExNzcsNyBAQCBmaGFuZGxlcl9waXBlOjp0ZW1wb3JhcnlfcXVlcnlfaGRs
ICgpDQogICAgICAgc3RhdHVzID0gTnRRdWVyeU9iamVjdCAoaCwgT2JqZWN0TmFtZUluZm9ybWF0
aW9uLCBudGZuLCA2NTUzNiwgJmxlbik7DQogICAgICAgaWYgKCFOVF9TVUNDRVNTIChzdGF0dXMp
IHx8ICFudGZuLT5OYW1lLkJ1ZmZlcikNCiAJZ290byBoZGxfZXJyOw0KLSAgICAgIG50Zm4tPk5h
bWUuQnVmZmVyW250Zm4tPk5hbWUuTGVuZ3RoIC8gc2l6ZW9mIChXQ0hBUildID0gTCdcMCc7DQot
ICAgICAgdWludDY0X3Qga2V5Ow0KLSAgICAgIERXT1JEIHBpZDsNCi0gICAgICBMT05HIGlkOw0K
LSAgICAgIGlmIChzd3NjYW5mIChudGZuLT5OYW1lLkJ1ZmZlciwNCi0JCSAgIEwiXFxEZXZpY2Vc
XE5hbWVkUGlwZVxcJWxseC0ldS1waXBlLW50LTB4JXgiLA0KLQkJICAgJmtleSwgJnBpZCwgJmlk
KSA9PSAzICYmDQotCSAga2V5ID09IHBpcGVuYW1lX2tleSAmJiBwaWQgPT0gcGlwZW5hbWVfcGlk
ICYmIGlkID09IHBpcGVuYW1lX2lkKQ0KKyAgICAgIGlmIChSdGxFcXVhbFVuaWNvZGVTdHJpbmcg
KG5hbWUsICZudGZuLT5OYW1lLCBGQUxTRSkpDQogCXJldHVybiBoOw0KIGhkbF9lcnI6DQogICAg
ICAgQ2xvc2VIYW5kbGUgKGgpOw0KQEAgLTExNzgsMTkgKzExODcsOSBAQCBjYWNoZV9lcnI6DQog
ICAgICAgcXVlcnlfaGRsX3ZhbHVlID0gTlVMTDsNCiAgICAgfQ0KIA0KLSAgc3RhdHVzID0gTnRR
dWVyeU9iamVjdCAoZ2V0X2hhbmRsZSAoKSwgT2JqZWN0TmFtZUluZm9ybWF0aW9uLCBudGZuLA0K
LQkJCSAgNjU1MzYsICZsZW4pOw0KLSAgaWYgKCFOVF9TVUNDRVNTIChzdGF0dXMpIHx8ICFudGZu
LT5OYW1lLkJ1ZmZlcikNCisgIGlmIChuYW1lLT5MZW5ndGggPT0gMCB8fCBuYW1lLT5CdWZmZXIg
PT0gTlVMTCkNCiAgICAgcmV0dXJuIE5VTEw7IC8qIE5vbiBjeWd3aW4gcGlwZT8gKi8NCi0gIFdD
SEFSIG5hbWVbTUFYX1BBVEhdOw0KLSAgaW50IG5hbWVsZW4gPSBtaW4gKG50Zm4tPk5hbWUuTGVu
Z3RoIC8gc2l6ZW9mIChXQ0hBUiksIE1BWF9QQVRILTEpOw0KLSAgbWVtY3B5IChuYW1lLCBudGZu
LT5OYW1lLkJ1ZmZlciwgbmFtZWxlbiAqIHNpemVvZiAoV0NIQVIpKTsNCi0gIG5hbWVbbmFtZWxl
bl0gPSBMJ1wwJzsNCi0gIGlmIChzd3NjYW5mIChuYW1lLCBMIlxcRGV2aWNlXFxOYW1lZFBpcGVc
XCVsbHgtJXUtcGlwZS1udC0weCV4IiwNCi0JICAgICAgICZwaXBlbmFtZV9rZXksICZwaXBlbmFt
ZV9waWQsICZwaXBlbmFtZV9pZCkgIT0gMykNCi0gICAgcmV0dXJuIE5VTEw7IC8qIE5vbiBjeWd3
aW4gcGlwZT8gKi8NCi0NCi0gIHJldHVybiBnZXRfcXVlcnlfaGRsX3Blcl9wcm9jZXNzIChuYW1l
LCBudGZuKTsgLyogU2luY2UgV2luOCAqLw0KKyAgcmV0dXJuIGdldF9xdWVyeV9oZGxfcGVyX3By
b2Nlc3MgKG5hbWUtPkJ1ZmZlciwgbnRmbik7IC8qIFNpbmNlIFdpbjggKi8NCiB9DQogDQogSEFO
RExFDQpkaWZmIC0tZ2l0IGEvd2luc3VwL2N5Z3dpbi9sb2NhbF9pbmNsdWRlcy9maGFuZGxlci5o
IGIvd2luc3VwL2N5Z3dpbi9sb2NhbF9pbmNsdWRlcy9maGFuZGxlci5oDQppbmRleCA2ZGRmMzcz
NzAuLjAyOGViNDlkMCAxMDA2NDQNCi0tLSBhL3dpbnN1cC9jeWd3aW4vbG9jYWxfaW5jbHVkZXMv
ZmhhbmRsZXIuaA0KKysrIGIvd2luc3VwL2N5Z3dpbi9sb2NhbF9pbmNsdWRlcy9maGFuZGxlci5o
DQpAQCAtMTIxNiw5ICsxMjE2LDYgQEAgcHJpdmF0ZToNCiAgIEhBTkRMRSBxdWVyeV9oZGxfcHJv
YzsNCiAgIEhBTkRMRSBxdWVyeV9oZGxfdmFsdWU7DQogICBIQU5ETEUgcXVlcnlfaGRsX2Nsb3Nl
X3JlcV9ldnQ7DQotICB1aW50NjRfdCBwaXBlbmFtZV9rZXk7DQotICBEV09SRCBwaXBlbmFtZV9w
aWQ7DQotICBMT05HIHBpcGVuYW1lX2lkOw0KICAgdm9pZCByZWxlYXNlX3NlbGVjdF9zZW0gKGNv
bnN0IGNoYXIgKik7DQogICBIQU5ETEUgZ2V0X3F1ZXJ5X2hkbF9wZXJfcHJvY2VzcyAoV0NIQVIg
KiwgT0JKRUNUX05BTUVfSU5GT1JNQVRJT04gKik7DQogcHVibGljOg0KLS0gDQoyLjQzLjANCg0K

--Multipart=_Tue__5_Mar_2024_23_47_53_+0900_j+BrmeQuWG+OICAC--
