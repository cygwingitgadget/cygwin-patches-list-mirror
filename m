Return-Path: <cygwin-patches-return-9818-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 49474 invoked by alias); 8 Nov 2019 13:42:26 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 49462 invoked by uid 89); 8 Nov 2019 13:42:25 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-4.0 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=forcibly, screen, H*c:HHHH
X-HELO: conssluserg-03.nifty.com
Received: from conssluserg-03.nifty.com (HELO conssluserg-03.nifty.com) (210.131.2.82) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 08 Nov 2019 13:42:23 +0000
Received: from Express5800-S70 (ntsitm355024.sitm.nt.ngn.ppp.infoweb.ne.jp [175.184.70.24]) (authenticated)	by conssluserg-03.nifty.com with ESMTP id xA8DgKp3007688	for <cygwin-patches@cygwin.com>; Fri, 8 Nov 2019 22:42:21 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com xA8DgKp3007688
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1573220541;	bh=sPgPey+3ZY5z6YwHJu+bZVU1c1shrf7CxmdAiRkRkfQ=;	h=Date:From:To:Subject:In-Reply-To:References:From;	b=NE9FiClZjt+BG68vrxHghy28x0/Hp+OAh1VO5KUoChkTHrXnV1rO0PZXM+FMe7qje	 OjC7lvXJNLxXyqKt9gargnJ9eGMJFI3eWPBHPxeMrTTQAIGZnyW2vKfelUKZFFDjps	 mXWIlvbnHQHI8+YoH6ezCu4BLu2YPgFZZXBRqjG4Hp/HELIQGaQsGJFGp1BIJkd5Hv	 XdMwKa5kauAHVOd1h6+iFbPmfyWz8sX6h5q229GIZd31zFKsOLzULcMyzwj8QSyXzO	 V2/i+YCRFG2721DY7slwT45N5PYJgggakYfyh1IvTLd+FdiFTSxambH2cjuWT5YM1h	 02Lg3EoipVwxA==
Date: Fri, 08 Nov 2019 13:42:00 -0000
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pty: Disable clear screen for ssh sessions with -t option.
Message-Id: <20191108224232.c58ba683250a438a44e15e56@nifty.ne.jp>
In-Reply-To: <20191108110955.GC3372@calimero.vinschen.de>
References: <20191022162316.54c3bc2ff19dbc7ae1bdedf2@nifty.ne.jp>	<20191022080242.GN16240@calimero.vinschen.de>	<20191022182405.0ce3d7c17b0e7d924430b89c@nifty.ne.jp>	<20191022134048.GP16240@calimero.vinschen.de>	<20191023122717.66d241bd0a7814b7216d78f5@nifty.ne.jp>	<20191023120542.GA16240@calimero.vinschen.de>	<20191024100130.4c7f6e4ac55c10143e3c86f6@nifty.ne.jp>	<20191024093817.GD16240@calimero.vinschen.de>	<20191024191724.f44a44745f16f78595ae1b43@nifty.ne.jp>	<20191024133305.GF16240@calimero.vinschen.de>	<20191108110955.GC3372@calimero.vinschen.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Multipart=_Fri__8_Nov_2019_22_42_32_+0900_vCWCMpiNHoDnR5O6"
X-IsSubscribed: yes
X-SW-Source: 2019-q4/txt/msg00089.txt.bz2

This is a multi-part message in MIME format.

--Multipart=_Fri__8_Nov_2019_22_42_32_+0900_vCWCMpiNHoDnR5O6
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-length: 1496

Hi Corinna,

On Fri, 8 Nov 2019 12:09:55 +0100
Corinna Vinschen wrote:
> On Oct 24 15:33, Corinna Vinschen wrote:
> > On Oct 24 19:17, Takashi Yano wrote:
> > > On Thu, 24 Oct 2019 11:38:17 +0200
> > > Corinna Vinschen wrote:
> > > > Well, what I see when starting cmd.exe with this patch is a short
> > > > flicker in the existing output in mintty, but the cursor position
> > > > stays the same. and cmd.exe output is where you'd expect it.
> > > 
> > > I mean:
> > > 1) start mintty
> > > 2) ps
> > > 3) script
> > > 4) cmd
> > > 
> > > In my environment, output of ps command disappears.
> > 
> > In mine, too.  This does not occur w/o running script.
> 
> Any news here?  Why does this only occur with script?  Is that something
> about reusing (or not reusing) the existing pseudo console?

This does not occur only with script. If you run
ssh localhost
instead of script in step 3), it also happens.

This is because the console screen buffer is empty when pty
(pseudo console) is started. By executing cmd.exe, screen
is redrawn based on the console screen buffer. As a result,
the screen contents which are not in the screen buffer is
lost.

I came up with another alternative. How about the attached
patch? This forcibly redraws screen when the first native
program is executed after creating new pty (pseudo console),
instead of clearing screen.

This does not solve missing screen contents, but can avoid
cursor position problem in netsh.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>

--Multipart=_Fri__8_Nov_2019_22_42_32_+0900_vCWCMpiNHoDnR5O6
Content-Type: application/octet-stream;
 name="pty-redraw.patch"
Content-Disposition: attachment;
 filename="pty-redraw.patch"
Content-Transfer-Encoding: base64
Content-length: 3762

ZGlmZiAtLWdpdCBhL3dpbnN1cC9jeWd3aW4vZmhhbmRsZXJfdHR5LmNjIGIv
d2luc3VwL2N5Z3dpbi9maGFuZGxlcl90dHkuY2MKaW5kZXggYzcxNjAzMDY4
Li4yMDhmNWIzZmQgMTAwNjQ0Ci0tLSBhL3dpbnN1cC9jeWd3aW4vZmhhbmRs
ZXJfdHR5LmNjCisrKyBiL3dpbnN1cC9jeWd3aW4vZmhhbmRsZXJfdHR5LmNj
CkBAIC0yNjY5LDcgKzI2NjksNyBAQCBmaGFuZGxlcl9wdHlfc2xhdmU6OmZp
eHVwX2FmdGVyX2F0dGFjaCAoYm9vbCBuYXRpdmVfbWF5YmUsIGludCBmZF9z
ZXQpCiAJICBpZiAoZ2V0X3R0eXAgKCktPm51bV9wY29uX2F0dGFjaGVkX3Ns
YXZlcyA9PSAwCiAJICAgICAgJiYgIUFMV0FZU19VU0VfUENPTikKIAkgICAg
LyogQXNzdW1lIHRoaXMgaXMgdGhlIGZpcnN0IHByb2Nlc3MgdXNpbmcgdGhp
cyBwdHkgc2xhdmUuICovCi0JICAgIGdldF90dHlwICgpLT5uZWVkX2NsZWFy
X3NjcmVlbiA9IHRydWU7CisJICAgIGdldF90dHlwICgpLT5uZWVkX3JlZHJh
d19zY3JlZW4gPSB0cnVlOwogCiAJICBnZXRfdHR5cCAoKS0+bnVtX3Bjb25f
YXR0YWNoZWRfc2xhdmVzICsrOwogCX0KQEAgLTI3MDAsNiArMjcwMCwyNCBA
QCBmaGFuZGxlcl9wdHlfc2xhdmU6OmZpeHVwX2FmdGVyX2F0dGFjaCAoYm9v
bCBuYXRpdmVfbWF5YmUsIGludCBmZF9zZXQpCiAJCSAga2lsbCAoZ2V0X3R0
eXAgKCktPnBjb25fcGlkLCAwKSAhPSAwKQogCQlnZXRfdHR5cCAoKS0+cGNv
bl9waWQgPSBteXNlbGYtPnBpZDsKIAkgICAgICBnZXRfdHR5cCAoKS0+c3dp
dGNoX3RvX3Bjb25fb3V0ID0gdHJ1ZTsKKworCSAgICAgIGlmIChnZXRfdHR5
cCAoKS0+bmVlZF9yZWRyYXdfc2NyZWVuKQorCQl7CisJCSAgLyogRm9yY2li
bHkgcmVkcmF3IHNjcmVlbiBiYXNlZCBvbiBjb25zb2xlIHNjcmVlbiBidWZm
ZXIuICovCisJCSAgLyogVGhlIGZvbGxvd2luZyBjb2RlIHRyaWdnZXJzIHJl
ZHJhd2luZyB0aGUgc2NyZWVuLiAqLworCQkgIENPTlNPTEVfU0NSRUVOX0JV
RkZFUl9JTkZPIHNiaTsKKwkJICBHZXRDb25zb2xlU2NyZWVuQnVmZmVySW5m
byAoZ2V0X291dHB1dF9oYW5kbGUgKCksICZzYmkpOworCQkgIFNNQUxMX1JF
Q1QgcmVjdDsKKwkJICBDT09SRCBkZXN0ID0gezAsIDB9OworCQkgIENIQVJf
SU5GTyBmaWxsID0geycgJywgMH07CisJCSAgcmVjdC5Ub3AgPSAwOworCQkg
IHJlY3QuQm90dG9tID0gc2JpLmR3U2l6ZS5ZIC0gMTsKKwkJICByZWN0Lkxl
ZnQgPSAwOworCQkgIHJlY3QuUmlnaHQgPSBzYmkuZHdTaXplLlggLSAxOwor
CQkgIFNjcm9sbENvbnNvbGVTY3JlZW5CdWZmZXIgKGdldF9vdXRwdXRfaGFu
ZGxlICgpLAorCQkJCQkgICAgICZyZWN0LCBOVUxMLCBkZXN0LCAmZmlsbCk7
CisJCSAgZ2V0X3R0eXAgKCktPm5lZWRfcmVkcmF3X3NjcmVlbiA9IGZhbHNl
OworCQl9CiAJICAgIH0KIAkgIGluaXRfY29uc29sZV9oYW5kbGVyIChmYWxz
ZSk7CiAJfQpAQCAtMjcxNywxOSArMjczNSw2IEBAIGZoYW5kbGVyX3B0eV9z
bGF2ZTo6Zml4dXBfYWZ0ZXJfZm9yayAoSEFORExFIHBhcmVudCkKICAgLy8g
Zm9ya19maXh1cCAocGFyZW50LCBpbnVzZSwgImludXNlIik7CiAgIC8vIGZo
YW5kbGVyX3B0eV9jb21tb246OmZpeHVwX2FmdGVyX2ZvcmsgKHBhcmVudCk7
CiAgIHJlcG9ydF90dHlfY291bnRzICh0aGlzLCAiaW5oZXJpdGVkIiwgIiIp
OwotCi0gIGlmIChnZXRfdHR5cCAoKS0+bmVlZF9jbGVhcl9zY3JlZW4pCi0g
ICAgewotICAgICAgY29uc3QgY2hhciAqdGVybSA9IGdldGVudiAoIlRFUk0i
KTsKLSAgICAgIGlmICh0ZXJtICYmIHN0cmNtcCAodGVybSwgImR1bWIiKSAm
JiAhc3Ryc3RyICh0ZXJtLCAiZW1hY3MiKSkKLQl7Ci0JICAvKiBGSVhNRTog
Q2xlYXJpbmcgc2VxdWVuY2UgbWF5IG5vdCBiZSAiXltbSF5bW0oiCi0JICAg
ICBkZXBlbmRpbmcgb24gdGhlIHRlcm1pbmFsIHR5cGUuICovCi0JICBEV09S
RCBuOwotCSAgV3JpdGVGaWxlIChnZXRfb3V0cHV0X2hhbmRsZV9jeWcgKCks
ICJcMDMzW0hcMDMzW0oiLCA2LCAmbiwgTlVMTCk7Ci0JfQotICAgICAgZ2V0
X3R0eXAgKCktPm5lZWRfY2xlYXJfc2NyZWVuID0gZmFsc2U7Ci0gICAgfQog
fQogCiB2b2lkCmRpZmYgLS1naXQgYS93aW5zdXAvY3lnd2luL3R0eS5jYyBi
L3dpbnN1cC9jeWd3aW4vdHR5LmNjCmluZGV4IDQ2MDE1M2NkYi4uOWM2NmI4
OWQ4IDEwMDY0NAotLS0gYS93aW5zdXAvY3lnd2luL3R0eS5jYworKysgYi93
aW5zdXAvY3lnd2luL3R0eS5jYwpAQCAtMjQ0LDcgKzI0NCw3IEBAIHR0eTo6
aW5pdCAoKQogICBwY29uX3BpZCA9IDA7CiAgIG51bV9wY29uX2F0dGFjaGVk
X3NsYXZlcyA9IDA7CiAgIHRlcm1fY29kZV9wYWdlID0gMDsKLSAgbmVlZF9j
bGVhcl9zY3JlZW4gPSBmYWxzZTsKKyAgbmVlZF9yZWRyYXdfc2NyZWVuID0g
ZmFsc2U7CiB9CiAKIEhBTkRMRQpkaWZmIC0tZ2l0IGEvd2luc3VwL2N5Z3dp
bi90dHkuaCBiL3dpbnN1cC9jeWd3aW4vdHR5LmgKaW5kZXggOTI3ZDdhZmQ5
Li5hNjczMmFlY2MgMTAwNjQ0Ci0tLSBhL3dpbnN1cC9jeWd3aW4vdHR5LmgK
KysrIGIvd2luc3VwL2N5Z3dpbi90dHkuaApAQCAtMTA1LDcgKzEwNSw3IEBA
IHByaXZhdGU6CiAgIHBpZF90IHBjb25fcGlkOwogICBpbnQgbnVtX3Bjb25f
YXR0YWNoZWRfc2xhdmVzOwogICBVSU5UIHRlcm1fY29kZV9wYWdlOwotICBi
b29sIG5lZWRfY2xlYXJfc2NyZWVuOworICBib29sIG5lZWRfcmVkcmF3X3Nj
cmVlbjsKIAogcHVibGljOgogICBIQU5ETEUgZnJvbV9tYXN0ZXIgKCkgY29u
c3QgeyByZXR1cm4gX2Zyb21fbWFzdGVyOyB9Cg==

--Multipart=_Fri__8_Nov_2019_22_42_32_+0900_vCWCMpiNHoDnR5O6--
