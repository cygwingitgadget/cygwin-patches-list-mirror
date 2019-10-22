Return-Path: <cygwin-patches-return-9782-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 123587 invoked by alias); 22 Oct 2019 09:24:41 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 123518 invoked by uid 89); 22 Oct 2019 09:24:30 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=screen, H*c:HHHH
X-HELO: conssluserg-05.nifty.com
Received: from conssluserg-05.nifty.com (HELO conssluserg-05.nifty.com) (210.131.2.90) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 22 Oct 2019 09:24:28 +0000
Received: from Express5800-S70 (ntsitm355024.sitm.nt.ngn.ppp.infoweb.ne.jp [175.184.70.24]) (authenticated)	by conssluserg-05.nifty.com with ESMTP id x9M9NxIL027182	for <cygwin-patches@cygwin.com>; Tue, 22 Oct 2019 18:23:59 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com x9M9NxIL027182
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1571736239;	bh=0k7qBxJw542/utcEuyRVU4jNtp8ydSuvcQwDMtVWAw8=;	h=Date:From:To:Subject:In-Reply-To:References:From;	b=MZey/WFZWQRZJBr2DftFelXy+AJa1qUyE6soZnv9RdpXXzWLUENO4jppYvKPyZSZz	 oEc2vCzHzFl/7wO1XQT5P4UFpx7HoZVWqTcHD9EukMt59u7aWR67YfIznCUk0aASAq	 OF7Fugfvw3lgNuO/TQMA8GllQWpGmo/A+Bap9HoCXRo5AlebfPazPBigzEoalK3f1u	 jeFJvdjmAQsDmgMVLLmy0+ZhGO/FE2hJlGx2IGVDHZLbed3QNNXipJ+G42G7Reqqz4	 FC5udeN8yIuuw5U6zPWX6RJ4TINy+oNJFJleNqXfkd1WbSAvCzrmtswOonetnIeNY4	 +1WCvMjWk0MAQ==
Date: Tue, 22 Oct 2019 09:24:00 -0000
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pty: Disable clear screen for ssh sessions with -t option.
Message-Id: <20191022182405.0ce3d7c17b0e7d924430b89c@nifty.ne.jp>
In-Reply-To: <20191022080242.GN16240@calimero.vinschen.de>
References: <20191018113721.2486-1-takashi.yano@nifty.ne.jp>	<20191018143306.GG16240@calimero.vinschen.de>	<20191019085051.4d2cc80811854d21b193fed6@nifty.ne.jp>	<20191021094356.GI16240@calimero.vinschen.de>	<20191022090930.b312514dcf8495c1db4bb461@nifty.ne.jp>	<20191022065506.GL16240@calimero.vinschen.de>	<20191022162316.54c3bc2ff19dbc7ae1bdedf2@nifty.ne.jp>	<20191022080242.GN16240@calimero.vinschen.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Multipart=_Tue__22_Oct_2019_18_24_05_+0900_SYD/9kiCave4K7rw"
X-IsSubscribed: yes
X-SW-Source: 2019-q4/txt/msg00053.txt.bz2

This is a multi-part message in MIME format.

--Multipart=_Tue__22_Oct_2019_18_24_05_+0900_SYD/9kiCave4K7rw
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-length: 1124

On Tue, 22 Oct 2019 10:02:42 +0200
Corinna Vinschen wrote:
> On Oct 22 16:23, Takashi Yano wrote:
> > On Tue, 22 Oct 2019 08:55:06 +0200
> > Corinna Vinschen wrote:
> > > On Oct 22 09:09, Takashi Yano wrote:
> > > > I confirmed the dwSize has right screen size and dwCursorPosition
> > > > is (0,0) just after creating pty even though the cursor position
> > > > in real screen is not at top left.
> > > > 
> > > > Clearing screen fixes this mismatch.
> > > 
> > > And calling SetConsoleCursorPosition instead does not?
> > 
> > For SetConsoleCursorPosition, it is necessary to know the cursor
> > position of course. I cannot come up with any other way than
> > using ANSI escape sequence "ESC[6n". Do you think this is
> > feasible?
> 
> Hmm, interesting point.  I think that should be ok for a start.
> assuming it works.

Unfortunately, this does not work as expected. Please try
attached patch. Cursor position is kept as expected, but the
screen contents before opening pty are lost when cmd.exe is
executed.

However, this fixes cursor position problem of netsh and WMIC.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>

--Multipart=_Tue__22_Oct_2019_18_24_05_+0900_SYD/9kiCave4K7rw
Content-Type: application/octet-stream;
 name="cursor-position.patch"
Content-Disposition: attachment;
 filename="cursor-position.patch"
Content-Transfer-Encoding: base64
Content-length: 1566

ZGlmZiAtLWdpdCBhL3dpbnN1cC9jeWd3aW4vZmhhbmRsZXJfdHR5LmNjIGIv
d2luc3VwL2N5Z3dpbi9maGFuZGxlcl90dHkuY2MKaW5kZXggZGE2MTE5ZGZi
Li43YjdiZTc3ODMgMTAwNjQ0Ci0tLSBhL3dpbnN1cC9jeWd3aW4vZmhhbmRs
ZXJfdHR5LmNjCisrKyBiL3dpbnN1cC9jeWd3aW4vZmhhbmRsZXJfdHR5LmNj
CkBAIC0yNzIyLDEwICsyNzIyLDIxIEBAIGZoYW5kbGVyX3B0eV9zbGF2ZTo6
Zml4dXBfYWZ0ZXJfZm9yayAoSEFORExFIHBhcmVudCkKICAgICAgIGNvbnN0
IGNoYXIgKnRlcm0gPSBnZXRlbnYgKCJURVJNIik7CiAgICAgICBpZiAodGVy
bSAmJiBzdHJjbXAgKHRlcm0sICJkdW1iIikgJiYgIXN0cnN0ciAodGVybSwg
ImVtYWNzIikpCiAJewotCSAgLyogRklYTUU6IENsZWFyaW5nIHNlcXVlbmNl
IG1heSBub3QgYmUgIl5bW0heW1tKIgotCSAgICAgZGVwZW5kaW5nIG9uIHRo
ZSB0ZXJtaW5hbCB0eXBlLiAqLwogCSAgRFdPUkQgbjsKLQkgIFdyaXRlRmls
ZSAoZ2V0X291dHB1dF9oYW5kbGVfY3lnICgpLCAiXDAzM1tIXDAzM1tKIiwg
NiwgJm4sIE5VTEwpOworCSAgV3JpdGVGaWxlIChnZXRfb3V0cHV0X2hhbmRs
ZV9jeWcgKCksICJcMDMzWzZuIiwgNCwgJm4sIE5VTEwpOworCSAgc3RydWN0
IHRlcm1pb3MgdGksIHRpX25ldzsKKwkgIHRjZ2V0YXR0ciAoJnRpKTsKKwkg
IHRpX25ldyA9IHRpOworCSAgdGlfbmV3LmNfbGZsYWcgJj0gKH5JQ0FOT04g
fCBFQ0hPKTsKKwkgIHRjc2V0YXR0ciAoVENTQU5PVywgJnRpX25ldyk7CisJ
ICBjaGFyIGJ1ZlszMl07CisJICBSZWFkRmlsZSAoZ2V0X2hhbmRsZV9jeWcg
KCksIGJ1Ziwgc2l6ZW9mKGJ1ZiksICZuLCBOVUxMKTsKKwkgIHRjc2V0YXR0
ciAoVENTQU5PVywgJnRpKTsKKwkgIGJ1ZltuXSA9ICdcMCc7CisJICBpbnQg
cm93cywgY29sczsKKwkgIHNzY2FuZiAoYnVmLCAiXDAzM1slZDslZFIiLCAm
cm93cywgJmNvbHMpOworCSAgQ09PUkQgZHdDdXJzb3JQb3NpdGlvbiA9IHso
U0hPUlQpKGNvbHMtMSksIChTSE9SVCkocm93cy0xKX07CisJICBTZXRDb25z
b2xlQ3Vyc29yUG9zaXRpb24gKGdldF9vdXRwdXRfaGFuZGxlICgpLCBkd0N1
cnNvclBvc2l0aW9uKTsKIAl9CiAgICAgICBnZXRfdHR5cCAoKS0+bmVlZF9j
bGVhcl9zY3JlZW4gPSBmYWxzZTsKICAgICB9Cg==

--Multipart=_Tue__22_Oct_2019_18_24_05_+0900_SYD/9kiCave4K7rw--
