Return-Path: <SRS0=XFaT=S6=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w06.mail.nifty.com (mta-snd-w06.mail.nifty.com [106.153.227.38])
	by sourceware.org (Postfix) with ESMTPS id 4A2933858D21
	for <cygwin-patches@cygwin.com>; Thu,  5 Dec 2024 01:14:26 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 4A2933858D21
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 4A2933858D21
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.38
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1733361267; cv=none;
	b=I9cN2DHqqhWDWyWeVAvmTYTyoT7IdDjpaDi5sUIysPgyFswNSBf+KyG2d6PugatHIpd15xG0Oek6rK3gZMv9B3FrQwOCcC0Yodj6/PO90t26PetaBukCgppX+vZ+GlxTL+Zi8bstJfOzBUO+NRqVpeFlBBZ65ZzlaKtlBUjH8ZA=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1733361267; c=relaxed/simple;
	bh=8eLX6im0UtTQg6rUP9uMIDPGE2nG8COim0gG0g3jgE0=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=Yx7Yk2dOJA6CfygZoZzJoH0oBteYMVoyUWUAvzxlP+Bff3MBRlNOJ77KIMAAMUH7u4J6dcAgB29bL4gin62u3BC0oI1MT2CY5usN2L7Vzn5aVW8FGc4aBxri1iGKVZtdXowTOTMPVCqKiNKcYl+NV6vpS7XqFx5tKagFBBsX88k=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 4A2933858D21
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=leSHcC5I
Received: from HP-Z230 by mta-snd-w06.mail.nifty.com with ESMTP
          id <20241205011424060.SORU.90861.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Thu, 5 Dec 2024 10:14:24 +0900
Date: Thu, 5 Dec 2024 10:14:22 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: setjmp/longjmp: decrement incyg after signal
 handling
Message-Id: <20241205101422.ef6a17a0e3b8f313c1f76638@nifty.ne.jp>
In-Reply-To: <20241204125447.316279-1-corinna-cygwin@cygwin.com>
References: <20241204125447.316279-1-corinna-cygwin@cygwin.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart=_Thu__5_Dec_2024_10_14_22_+0900_AFjBrY2S7KL+tgDQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1733361264;
 bh=FoSV66R+AwMGk3SCU+vLCaPNo3wBzUiV+4/6CxwlbbA=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=leSHcC5IZACRTJIe0lZQNZXTKxgEnmhbybmY16OEOVB4dvK0WJJyjPU9YIZjeilKcDjaoxsD
 +DPOE74Bl6vltwuvFAde0YokSUWxBqhGryLFshT58+KZk0nitjWsyrwK55pYlykK/L3p5lht5M
 baaQ9AkDpj6Bs9k5nfk1gwZeLAtRvEhiv9yVVsnZrMFMXLiozy+z5A2oR+n5C1gpdfcHAFd+j7
 KooWE5cLOjym+tMGB6oVYkIOj9PVDtlTccK5ZLfgJSU86UQdiRbMPSNb3P5uISuzLhALvtzboa
 NGsJRatCtkBPzieLHsUO5fvhSSwVVpag+VUXRTPjZzCO7QIw==
X-Spam-Status: No, score=-10.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

This is a multi-part message in MIME format.

--Multipart=_Thu__5_Dec_2024_10_14_22_+0900_AFjBrY2S7KL+tgDQ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Corinna,

On Wed,  4 Dec 2024 13:54:47 +0100
Corinna Vinschen wrote:
> From: Corinna Vinschen <corinna@vinschen.de>
> 
> Commit 0b6fbd396ca2f ("* exceptions.cc (_cygtls::interrupt_now): Revert
> to checking for "spinning" when choosing to defer signal.") introduced
> a bug in the loop inside the stabilize_sig_stack subroutine:
> 
> First, stabilize_sig_stack grabs the stacklock. The _cygtls::incyg
> flag is then incremented before checking if a signal has to be handled
> for the current thread.
> 
> If no signal waits, the code simply jumps out, decrements _cygtls::incyg
> and returns to the caller, which eventually releases the stacklock.
> 
> However, if a signal is waiting, stabilize_sig_stack releases the
> stacklock, calls _cygtls::call_signal_handler(), and returns to
> the start of the subroutine, trying to grab the lock.
> 
> After grabbing the lock, it increments _cygtls::incyg... wait...
> again?
> 
> The loop does not decrement _cygtls::incyg after
> _cygtls::call_signal_handler(), which returns with _cygtls::incyg
> set to 1.  So it increments incyg to 2.  If no other signal is
> waiting, stabilize_sig_stack jumps out and decrements _cygtls::incyg
> to 1.  Eventually, setjmp or longjmp both will return to user
> code with _cygtls::incyg set to 1.  This *may* be fixed at some later
> point when signals arrive, but there will be a time when the application
> runs in user code with broken signal handling.
> 
> Fixes: 0b6fbd396ca2f ("* exceptions.cc (_cygtls::interrupt_now): Revert to checking for "spinning" when choosing to defer signal.")
> Signed-off-by: Corinna Vinschen <corinna@vinschen.de>
> ---
>  winsup/cygwin/scripts/gendef | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/winsup/cygwin/scripts/gendef b/winsup/cygwin/scripts/gendef
> index 7e14f69cf71c..377ceb59b2c8 100755
> --- a/winsup/cygwin/scripts/gendef
> +++ b/winsup/cygwin/scripts/gendef
> @@ -344,6 +344,7 @@ stabilize_sig_stack:
>  	movq	\$_cygtls.start_offset,%rcx	# point to beginning
>  	addq	%r12,%rcx			#  of tls block
>  	call	_ZN7_cygtls19call_signal_handlerEv
> +	decl	_cygtls.incyg(%r12)
>  	jmp	1b
>  3:	decl	_cygtls.incyg(%r12)
>  	addq	\$0x20,%rsp
> -- 
> 2.47.0
> 

I tested this patch with Christian's longjmp test case, but
the problem does not seem to be fixed.

However, if additional patch attached as well as this patch are
applied, the problem does not happen anymore. The additional
patch removes the spinning flag completely.

What do you think?

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>

--Multipart=_Thu__5_Dec_2024_10_14_22_+0900_AFjBrY2S7KL+tgDQ
Content-Type: text/plain;
 name="no-spinning.patch"
Content-Disposition: attachment;
 filename="no-spinning.patch"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL3dpbnN1cC9jeWd3aW4vY3lndGxzLmNjIGIvd2luc3VwL2N5Z3dpbi9jeWd0
bHMuY2MNCmluZGV4IDI4NDJjMjczMy4uYmZhYTE5ODY3IDEwMDY0NA0KLS0tIGEvd2luc3VwL2N5
Z3dpbi9jeWd0bHMuY2MNCisrKyBiL3dpbnN1cC9jeWd3aW4vY3lndGxzLmNjDQpAQCAtODEsNyAr
ODEsNyBAQCBfY3lndGxzOjpmaXh1cF9hZnRlcl9mb3JrICgpDQogICAgICAgcG9wICgpOw0KICAg
ICAgIGN1cnJlbnRfc2lnID0gMDsNCiAgICAgfQ0KLSAgc3RhY2tsb2NrID0gc3Bpbm5pbmcgPSAw
Ow0KKyAgc3RhY2tsb2NrID0gMDsNCiAgIHNpZ25hbF9hcnJpdmVkID0gTlVMTDsNCiAgIGxvY2Fs
cy5zZWxlY3Quc29ja2V2dCA9IE5VTEw7DQogICBsb2NhbHMuY3dfdGltZXIgPSBOVUxMOw0KZGlm
ZiAtLWdpdCBhL3dpbnN1cC9jeWd3aW4vZXhjZXB0aW9ucy5jYyBiL3dpbnN1cC9jeWd3aW4vZXhj
ZXB0aW9ucy5jYw0KaW5kZXggMzVhNGEwYjQ3Li40ZGM0YmUyNzggMTAwNjQ0DQotLS0gYS93aW5z
dXAvY3lnd2luL2V4Y2VwdGlvbnMuY2MNCisrKyBiL3dpbnN1cC9jeWd3aW4vZXhjZXB0aW9ucy5j
Yw0KQEAgLTkyMCw5ICs5MjAsOCBAQCBfY3lndGxzOjppbnRlcnJ1cHRfbm93IChDT05URVhUICpj
eCwgc2lnaW5mb190JiBzaSwgdm9pZCAqaGFuZGxlciwNCiANCiAgIC8qIERlbGF5IHRoZSBpbnRl
cnJ1cHQgaWYgd2UgYXJlDQogICAgICAxKSBzb21laG93IGluc2lkZSB0aGUgRExMDQotICAgICAy
KSBpbiBfc2lnZmUgKHNwaW5uaW5nIGlzIHRydWUpIGFuZCBhYm91dCB0byBlbnRlciBjeWd3aW4g
RExMDQotICAgICAzKSBpbiBhIFdpbmRvd3MgRExMLiAgKi8NCi0gIGlmIChpbmN5ZyB8fCBzcGlu
bmluZyB8fCBpbnNpZGVfa2VybmVsIChjeCkpDQorICAgICAyKSBpbiBhIFdpbmRvd3MgRExMLiAg
Ki8NCisgIGlmIChpbmN5ZyB8fCBpbnNpZGVfa2VybmVsIChjeCkpDQogICAgIGludGVycnVwdGVk
ID0gZmFsc2U7DQogICBlbHNlDQogICAgIHsNCmRpZmYgLS1naXQgYS93aW5zdXAvY3lnd2luL2xv
Y2FsX2luY2x1ZGVzL2N5Z3Rscy5oIGIvd2luc3VwL2N5Z3dpbi9sb2NhbF9pbmNsdWRlcy9jeWd0
bHMuaA0KaW5kZXggZWZiZDU1N2IxLi4yZDQ5MDY0NmEgMTAwNjQ0DQotLS0gYS93aW5zdXAvY3ln
d2luL2xvY2FsX2luY2x1ZGVzL2N5Z3Rscy5oDQorKysgYi93aW5zdXAvY3lnd2luL2xvY2FsX2lu
Y2x1ZGVzL2N5Z3Rscy5oDQpAQCAtMTk2LDcgKzE5Niw2IEBAIHB1YmxpYzogLyogRG8gTk9UIHJl
bW92ZSB0aGlzIHB1YmxpYzogbGluZSwgaXQncyBhIG1hcmtlciBmb3IgZ2VudGxzX29mZnNldHMu
ICovDQogICB3YWl0cSB3cTsNCiAgIGludCBjdXJyZW50X3NpZzsNCiAgIHVuc2lnbmVkIGluY3ln
Ow0KLSAgdW5zaWduZWQgc3Bpbm5pbmc7DQogICB2b2xhdGlsZSB1bnNpZ25lZCBzdGFja2xvY2s7
DQogICBfX3Rsc3N0YWNrX3QgKnN0YWNrcHRyOw0KICAgX190bHNzdGFja190IHN0YWNrW1RMU19T
VEFDS19TSVpFXTsNCmRpZmYgLS1naXQgYS93aW5zdXAvY3lnd2luL3NjcmlwdHMvZ2VuZGVmIGIv
d2luc3VwL2N5Z3dpbi9zY3JpcHRzL2dlbmRlZg0KaW5kZXggMzc3Y2ViNTliLi41MjE1NTAxNzUg
MTAwNzU1DQotLS0gYS93aW5zdXAvY3lnd2luL3NjcmlwdHMvZ2VuZGVmDQorKysgYi93aW5zdXAv
Y3lnd2luL3NjcmlwdHMvZ2VuZGVmDQpAQCAtMTM0LDcgKzEzNCw2IEBAIF9zaWdmZToJCQkJCQkj
IHN0YWNrIGlzIGFsaWduZWQgb24gZW50cnkhDQogCW1vdnEJJWdzOjgsJXIxMAkJCSMgbG9jYXRp
b24gb2YgYm90dG9tIG9mIHN0YWNrDQogMToJbW92bAlcJDEsJXIxMWQNCiAJeGNoZ2wJJXIxMWQs
X2N5Z3Rscy5zdGFja2xvY2soJXIxMCkJIyB0cnkgdG8gYWNxdWlyZSBsb2NrDQotCW1vdmwJJXIx
MWQsX2N5Z3Rscy5zcGlubmluZyglcjEwKQkjIGZsYWcgaWYgd2UgYXJlIHdhaXRpbmcgZm9yIGxv
Y2sNCiAJdGVzdGwJJXIxMWQsJXIxMWQJCQkjIGl0IHdpbGwgYmUgemVybw0KIAlqegkyZgkJCQkj
ICBpZiBzbw0KIAlwYXVzZQ0KQEAgLTE1OCw3ICsxNTcsNiBAQCBfc2lnYmU6CQkJCQkJIyByZXR1
cm4gaGVyZSBhZnRlciBjeWd3aW4gc3lzY2FsbA0KIAltb3ZxCSVnczo4LCVyMTAJCQkjIGFkZHJl
c3Mgb2YgYm90dG9tIG9mIHRscw0KIDE6CW1vdmwJXCQxLCVyMTFkDQogCXhjaGdsCSVyMTFkLF9j
eWd0bHMuc3RhY2tsb2NrKCVyMTApCSMgdHJ5IHRvIGFjcXVpcmUgbG9jaw0KLQltb3ZsCSVyMTFk
LF9jeWd0bHMuc3Bpbm5pbmcoJXIxMCkJIyBmbGFnIGlmIHdlIGFyZSB3YWl0aW5nIGZvciBsb2Nr
DQogCXRlc3RsCSVyMTFkLCVyMTFkCQkJIyBpdCB3aWxsIGJlIHplcm8NCiAJanoJMmYJCQkJIyAg
aWYgc28NCiAJcGF1c2UNCkBAIC0yNTgsNyArMjU2LDYgQEAgc2lnZGVsYXllZDoNCiANCiAxOglt
b3ZsCVwkMSwlcjExZA0KIAl4Y2hnbAklcjExZCxfY3lndGxzLnN0YWNrbG9jayglcjEyKQkjIHRy
eSB0byBhY3F1aXJlIGxvY2sNCi0JbW92bAklcjExZCxfY3lndGxzLnNwaW5uaW5nKCVyMTIpCSMg
ZmxhZyBpZiB3ZSBhcmUgd2FpdGluZyBmb3IgbG9jaw0KIAl0ZXN0bAklcjExZCwlcjExZAkJCSMg
aXQgd2lsbCBiZSB6ZXJvDQogCWp6CTJmCQkJCSMgIGlmIHNvDQogCXBhdXNlDQpAQCAtMzMyLDcg
KzMyOSw2IEBAIHN0YWJpbGl6ZV9zaWdfc3RhY2s6DQogCW1vdnEJJWdzOjgsJXIxMg0KIDE6CW1v
dmwJXCQxLCVyMTBkDQogCXhjaGdsCSVyMTBkLF9jeWd0bHMuc3RhY2tsb2NrKCVyMTIpCSMgdHJ5
IHRvIGFjcXVpcmUgbG9jaw0KLQltb3ZsCSVyMTBkLF9jeWd0bHMuc3Bpbm5pbmcoJXIxMikJIyBm
bGFnIGlmIHdlIGFyZSB3YWl0aW5nIGZvciBsb2NrDQogCXRlc3RsCSVyMTBkLCVyMTBkDQogCWp6
CTJmDQogCXBhdXNlDQo=

--Multipart=_Thu__5_Dec_2024_10_14_22_+0900_AFjBrY2S7KL+tgDQ--
