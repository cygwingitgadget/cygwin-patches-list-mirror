Return-Path: <cygwin-patches-return-9606-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 100506 invoked by alias); 4 Sep 2019 03:34:50 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 100474 invoked by uid 89); 4 Sep 2019 03:34:47 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-9.3 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_2,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=H*f:sk:e8c3b43, H*i:sk:e8c3b43, screen
X-HELO: conssluserg-02.nifty.com
Received: from conssluserg-02.nifty.com (HELO conssluserg-02.nifty.com) (210.131.2.81) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 04 Sep 2019 03:34:44 +0000
Received: from Express5800-S70 (ntsitm268057.sitm.nt.ngn.ppp.infoweb.ne.jp [125.1.110.57]) (authenticated)	by conssluserg-02.nifty.com with ESMTP id x843YRaR022137;	Wed, 4 Sep 2019 12:34:27 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com x843YRaR022137
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1567568067;	bh=DvmbtLkyA82jwZ8znaArWwz+L1AqXDEQrLBHhovCTIw=;	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;	b=zbMrJgBxAbkpkIzVsxYF2736opDGOjXBUf5EYP0ey6wDh/2wfJWDWbZFZHAWlIKIH	 jmPQ+orTqAwCaNDxuLwI5kaXmUF2BGDw4F1Dkg35qN5oURgHSkOQfBXpvJBk1VEeAr	 g7NoCm2dxx5WLcJqMmbDDM1XBz1hiuOP0Ib9nZ5rkmBrShzJD/XEKVvxoznmgcG+yq	 ZRpVzuT/kgRZOLVpKWxvvDhB2CeD9yTwA43FPoRoNXgm8GQ/Mz7hp+Fs/jmUFsUW0s	 K44Jihp4tUWanJvwFDpYKRjL4C9jj0O7m5v98k+00pxkfn2CcwE+MduokRzWQ72UZd	 p8L9XrpR4bLRA==
Date: Wed, 04 Sep 2019 03:34:00 -0000
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Brian.Inglis@SystematicSw.ab.ca
Subject: Re: [PATCH 2/2] Cygwin: pty: Disable clear screen on new pty if TERM=dumb or emacs*.
Message-Id: <20190904123431.59ac7a667f91e3cb65f2a9a9@nifty.ne.jp>
In-Reply-To: <e8c3b43a-7988-bb2c-a52b-dc792677dd96@SystematicSw.ab.ca>
References: <20190904014618.1372-1-takashi.yano@nifty.ne.jp>	<20190904014618.1372-3-takashi.yano@nifty.ne.jp>	<e8c3b43a-7988-bb2c-a52b-dc792677dd96@SystematicSw.ab.ca>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Multipart=_Wed__4_Sep_2019_12_34_31_+0900_M03RgF=FIevbxPBW"
X-IsSubscribed: yes
X-SW-Source: 2019-q3/txt/msg00126.txt.bz2

This is a multi-part message in MIME format.

--Multipart=_Wed__4_Sep_2019_12_34_31_+0900_M03RgF=FIevbxPBW
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-length: 2452

Hi Brian,

On Tue, 3 Sep 2019 20:47:14 -0600
Brian Inglis wrote:
> On 2019-09-03 19:46, Takashi Yano wrote:
> > - Pseudo console support introduced by commit
> >   169d65a5774acc76ce3f3feeedcbae7405aa9b57 shows garbage ^[[H^[[J in
> >   some of emacs screens. These screens do not handle ANSI escape
> >   sequences. Therefore, clear screen is disabled on these screens.
> 
> Dealing with escape sequences is way out of the scope of any pty driver.
> It is up to the terminal emulator or applications running in the terminal to
> handle terminal characteristics appropriately.
> 
> The pty driver should not touch *ANY* escape sequences coming from the system,
> nor should it generate any to it, as TERM may not be set at the time, or
> appropriately or usefully in some shells e.g. cmd or powershell.
> 
> Most folks probably use mintty or cmd as their Cygwin terminal, but some use
> other terminals, like various flavours of xterm and rxvt, with ssh sessions in
> and out, so they could be on Linux consoles or proprietary AIX/HP-UX/Sun
> terminals, and operate properly as long as they have a good terminfo definition.
> 
> I see this issue as similar to the Windows text file handling changes required
> when coreutils/textutils went POSIX and removed '\r\n' crlf handling to give the
> same results as on Unix systems.
> To handle terminal characteristics properly would require terminfo support in
> the pty driver: I doubt anyone wants that, so the best approach is to do
> nothing, and let the terminal or application handle it: they are more likely to
> have the configuration options or hooks to do so easily.

You are definitely right. However, the essence of the problem is that
the pseudo console itself outputs a lot of ANSI escape sequences
even if client program output only ASCII characters.

Attached is the raw output from pseudo console when the screen shows
the simple text below.

---- from here ----
[yano@Express5800-S70 ~]$ cmd
Microsoft Windows [Version 10.0.18362.329]
(c) 2019 Microsoft Corporation. All rights reserved.

C:\cygwin\home\yano>exit
[yano@Express5800-S70 ~]$ exit
exit
---- to here ----

You will noticed that the screen is cleared if you execute
cat pcon-output.log
in a terminal which support ANSI escape sequences.

So clearing the screen when creating pseudo console is the result of
compromise to synchronize real screen and screen buffer of pseudo
console.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>

--Multipart=_Wed__4_Sep_2019_12_34_31_+0900_M03RgF=FIevbxPBW
Content-Type: application/octet-stream;
 name="pcon-output.log"
Content-Disposition: attachment;
 filename="pcon-output.log"
Content-Transfer-Encoding: base64
Content-length: 5373

G1s/MjVsG1s4MFgbWzgwQw0KG1s4MFgbWzgwQw0KG1s4MFgbWzgwQw0KG1s4
MFgbWzgwQw0KG1s4MFgbWzgwQw0KG1s4MFgbWzgwQw0KG1s4MFgbWzgwQw0K
G1s4MFgbWzgwQw0KG1s4MFgbWzgwQw0KG1s4MFgbWzgwQw0KG1s4MFgbWzgw
Qw0KG1s4MFgbWzgwQw0KG1s4MFgbWzgwQw0KG1s4MFgbWzgwQw0KG1s4MFgb
WzgwQw0KG1s4MFgbWzgwQw0KG1s4MFgbWzgwQw0KG1s4MFgbWzgwQw0KG1s4
MFgbWzgwQw0KG1s4MFgbWzgwQw0KG1s4MFgbWzgwQw0KG1s4MFgbWzgwQw0K
G1s4MFgbWzgwQw0KG1s4MFgbWzgwQxtbSBtbPzI1aBtbPzI1bFt5YW5vQEV4
cHJlc3M1ODAwLVM3MCB+XSQbWzU1WBtbNTVDDQobWzgwWBtbODBDDQobWzgw
WBtbODBDDQobWzgwWBtbODBDDQobWzgwWBtbODBDDQobWzgwWBtbODBDDQob
WzgwWBtbODBDDQobWzgwWBtbODBDDQobWzgwWBtbODBDDQobWzgwWBtbODBD
DQobWzgwWBtbODBDDQobWzgwWBtbODBDDQobWzgwWBtbODBDDQobWzgwWBtb
ODBDDQobWzgwWBtbODBDDQobWzgwWBtbODBDDQobWzgwWBtbODBDDQobWzgw
WBtbODBDDQobWzgwWBtbODBDDQobWzgwWBtbODBDDQobWzgwWBtbODBDDQob
WzgwWBtbODBDDQobWzgwWBtbODBDDQobWzgwWBtbODBDG1sxOzI3SBtbPzI1
aBtbPzI1bBtbSFt5YW5vQEV4cHJlc3M1ODAwLVM3MCB+XSQbWzU1WBtbNTVD
DQobWzgwWBtbODBDDQobWzgwWBtbODBDDQobWzgwWBtbODBDDQobWzgwWBtb
ODBDDQobWzgwWBtbODBDDQobWzgwWBtbODBDDQobWzgwWBtbODBDDQobWzgw
WBtbODBDDQobWzgwWBtbODBDDQobWzgwWBtbODBDDQobWzgwWBtbODBDDQob
WzgwWBtbODBDDQobWzgwWBtbODBDDQobWzgwWBtbODBDDQobWzgwWBtbODBD
DQobWzgwWBtbODBDDQobWzgwWBtbODBDDQobWzgwWBtbODBDDQobWzgwWBtb
ODBDDQobWzgwWBtbODBDDQobWzgwWBtbODBDDQobWzgwWBtbODBDDQobWzgw
WBtbODBDG1sxOzI3SBtbPzI1aBtbPzI1bBtbSFt5YW5vQEV4cHJlc3M1ODAw
LVM3MCB+XSQgYxtbNTNYG1s1M0MNChtbODBYG1s4MEMNChtbODBYG1s4MEMN
ChtbODBYG1s4MEMNChtbODBYG1s4MEMNChtbODBYG1s4MEMNChtbODBYG1s4
MEMNChtbODBYG1s4MEMNChtbODBYG1s4MEMNChtbODBYG1s4MEMNChtbODBY
G1s4MEMNChtbODBYG1s4MEMNChtbODBYG1s4MEMNChtbODBYG1s4MEMNChtb
ODBYG1s4MEMNChtbODBYG1s4MEMNChtbODBYG1s4MEMNChtbODBYG1s4MEMN
ChtbODBYG1s4MEMNChtbODBYG1s4MEMNChtbODBYG1s4MEMNChtbODBYG1s4
MEMNChtbODBYG1s4MEMNChtbODBYG1s4MEMbWzE7MjhIG1s/MjVoG1s/MjVs
G1tIW3lhbm9ARXhwcmVzczU4MDAtUzcwIH5dJCBjG1s1M1gbWzUzQw0KG1s4
MFgbWzgwQw0KG1s4MFgbWzgwQw0KG1s4MFgbWzgwQw0KG1s4MFgbWzgwQw0K
G1s4MFgbWzgwQw0KG1s4MFgbWzgwQw0KG1s4MFgbWzgwQw0KG1s4MFgbWzgw
Qw0KG1s4MFgbWzgwQw0KG1s4MFgbWzgwQw0KG1s4MFgbWzgwQw0KG1s4MFgb
WzgwQw0KG1s4MFgbWzgwQw0KG1s4MFgbWzgwQw0KG1s4MFgbWzgwQw0KG1s4
MFgbWzgwQw0KG1s4MFgbWzgwQw0KG1s4MFgbWzgwQw0KG1s4MFgbWzgwQw0K
G1s4MFgbWzgwQw0KG1s4MFgbWzgwQw0KG1s4MFgbWzgwQw0KG1s4MFgbWzgw
QxtbMTsyOEgbWz8yNWgbWz8yNWwbW0hbeWFub0BFeHByZXNzNTgwMC1TNzAg
fl0kIGNtG1s1MlgbWzUyQw0KG1s4MFgbWzgwQw0KG1s4MFgbWzgwQw0KG1s4
MFgbWzgwQw0KG1s4MFgbWzgwQw0KG1s4MFgbWzgwQw0KG1s4MFgbWzgwQw0K
G1s4MFgbWzgwQw0KG1s4MFgbWzgwQw0KG1s4MFgbWzgwQw0KG1s4MFgbWzgw
Qw0KG1s4MFgbWzgwQw0KG1s4MFgbWzgwQw0KG1s4MFgbWzgwQw0KG1s4MFgb
WzgwQw0KG1s4MFgbWzgwQw0KG1s4MFgbWzgwQw0KG1s4MFgbWzgwQw0KG1s4
MFgbWzgwQw0KG1s4MFgbWzgwQw0KG1s4MFgbWzgwQw0KG1s4MFgbWzgwQw0K
G1s4MFgbWzgwQw0KG1s4MFgbWzgwQxtbMTsyOUgbWz8yNWgbWz8yNWwbW0hb
eWFub0BFeHByZXNzNTgwMC1TNzAgfl0kIGNtG1s1MlgbWzUyQw0KG1s4MFgb
WzgwQw0KG1s4MFgbWzgwQw0KG1s4MFgbWzgwQw0KG1s4MFgbWzgwQw0KG1s4
MFgbWzgwQw0KG1s4MFgbWzgwQw0KG1s4MFgbWzgwQw0KG1s4MFgbWzgwQw0K
G1s4MFgbWzgwQw0KG1s4MFgbWzgwQw0KG1s4MFgbWzgwQw0KG1s4MFgbWzgw
Qw0KG1s4MFgbWzgwQw0KG1s4MFgbWzgwQw0KG1s4MFgbWzgwQw0KG1s4MFgb
WzgwQw0KG1s4MFgbWzgwQw0KG1s4MFgbWzgwQw0KG1s4MFgbWzgwQw0KG1s4
MFgbWzgwQw0KG1s4MFgbWzgwQw0KG1s4MFgbWzgwQw0KG1s4MFgbWzgwQxtb
MTsyOUgbWz8yNWgbWz8yNWwbW0hbeWFub0BFeHByZXNzNTgwMC1TNzAgfl0k
IGNtZBtbNTFYG1s1MUMNChtbODBYG1s4MEMNChtbODBYG1s4MEMNChtbODBY
G1s4MEMNChtbODBYG1s4MEMNChtbODBYG1s4MEMNChtbODBYG1s4MEMNChtb
ODBYG1s4MEMNChtbODBYG1s4MEMNChtbODBYG1s4MEMNChtbODBYG1s4MEMN
ChtbODBYG1s4MEMNChtbODBYG1s4MEMNChtbODBYG1s4MEMNChtbODBYG1s4
MEMNChtbODBYG1s4MEMNChtbODBYG1s4MEMNChtbODBYG1s4MEMNChtbODBY
G1s4MEMNChtbODBYG1s4MEMNChtbODBYG1s4MEMNChtbODBYG1s4MEMNChtb
ODBYG1s4MEMNChtbODBYG1s4MEMbWzE7MzBIG1s/MjVoG1s/MjVsG1tIW3lh
bm9ARXhwcmVzczU4MDAtUzcwIH5dJCBjbWQbWzUxWBtbNTFDDQobWzgwWBtb
ODBDDQobWzgwWBtbODBDDQobWzgwWBtbODBDDQobWzgwWBtbODBDDQobWzgw
WBtbODBDDQobWzgwWBtbODBDDQobWzgwWBtbODBDDQobWzgwWBtbODBDDQob
WzgwWBtbODBDDQobWzgwWBtbODBDDQobWzgwWBtbODBDDQobWzgwWBtbODBD
DQobWzgwWBtbODBDDQobWzgwWBtbODBDDQobWzgwWBtbODBDDQobWzgwWBtb
ODBDDQobWzgwWBtbODBDDQobWzgwWBtbODBDDQobWzgwWBtbODBDDQobWzgw
WBtbODBDDQobWzgwWBtbODBDDQobWzgwWBtbODBDDQobWzgwWBtbODBDG1sx
OzMwSBtbPzI1aBtbPzI1bBtbSFt5YW5vQEV4cHJlc3M1ODAwLVM3MCB+XSQg
Y21kG1s1MVgbWzUxQw0KG1s4MFgbWzgwQw0KG1s4MFgbWzgwQw0KG1s4MFgb
WzgwQw0KG1s4MFgbWzgwQw0KG1s4MFgbWzgwQw0KG1s4MFgbWzgwQw0KG1s4
MFgbWzgwQw0KG1s4MFgbWzgwQw0KG1s4MFgbWzgwQw0KG1s4MFgbWzgwQw0K
G1s4MFgbWzgwQw0KG1s4MFgbWzgwQw0KG1s4MFgbWzgwQw0KG1s4MFgbWzgw
Qw0KG1s4MFgbWzgwQw0KG1s4MFgbWzgwQw0KG1s4MFgbWzgwQw0KG1s4MFgb
WzgwQw0KG1s4MFgbWzgwQw0KG1s4MFgbWzgwQw0KG1s4MFgbWzgwQw0KG1s4
MFgbWzgwQw0KG1s4MFgbWzgwQxtbMjsxSBtbPzI1aBtbPzI1bBtbSFt5YW5v
QEV4cHJlc3M1ODAwLVM3MCB+XSQgY21kG1s1MVgbWzUxQw0KG1s4MFgbWzgw
Qw0KG1s4MFgbWzgwQw0KG1s4MFgbWzgwQw0KG1s4MFgbWzgwQw0KG1s4MFgb
WzgwQw0KG1s4MFgbWzgwQw0KG1s4MFgbWzgwQw0KG1s4MFgbWzgwQw0KG1s4
MFgbWzgwQw0KG1s4MFgbWzgwQw0KG1s4MFgbWzgwQw0KG1s4MFgbWzgwQw0K
G1s4MFgbWzgwQw0KG1s4MFgbWzgwQw0KG1s4MFgbWzgwQw0KG1s4MFgbWzgw
Qw0KG1s4MFgbWzgwQw0KG1s4MFgbWzgwQw0KG1s4MFgbWzgwQw0KG1s4MFgb
WzgwQw0KG1s4MFgbWzgwQw0KG1s4MFgbWzgwQw0KG1s4MFgbWzgwQxtbMjsx
SBtbPzI1aBtbPzI1bE1pY3Jvc29mdCBXaW5kb3dzIFtWZXJzaW9uIDEwLjAu
MTgzNjIuMzI5XRtbMTBYG1sxMEMNCihjKSAyMDE5IE1pY3Jvc29mdCBDb3Jw
b3JhdGlvbi4gQWxsIHJpZ2h0cyByZXNlcnZlZC4NChtbNTJYG1s1MkMNCkM6
XGN5Z3dpblxob21lXHlhbm8+G1szMlgbWzMyQxtbNTsyMUgbWz8yNWhleGl0
G1s/MjVsDQobWz8yNWgbWz8yNWxbeWFub0BFeHByZXNzNTgwMC1TNzAgfl0k
IBtbPzI1aGUbWz8yNWwbWz8yNWh4G1s/MjVsG1s/MjVoaRtbPzI1bBtbPzI1
aHQbWz8yNWwbWz8yNWgbWz8yNWwNChtbPzI1aBtbPzI1bGV4aXQNChtbPzI1
aAo=

--Multipart=_Wed__4_Sep_2019_12_34_31_+0900_M03RgF=FIevbxPBW--
