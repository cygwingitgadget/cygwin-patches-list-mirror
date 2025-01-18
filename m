Return-Path: <SRS0=STgq=UK=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w03.mail.nifty.com (mta-snd-w03.mail.nifty.com [106.153.227.35])
	by sourceware.org (Postfix) with ESMTPS id 0A7F03858C98
	for <cygwin-patches@cygwin.com>; Sat, 18 Jan 2025 22:48:28 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 0A7F03858C98
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 0A7F03858C98
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.35
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1737240510; cv=none;
	b=E7SHCt8336bidVPzf1u3rQgLiXqp3awezbmWeT2xcD8FQHjUU3pmTnxXuuqxfZrQ3qWilOPLGAqp3EtYfn6HuwkQSXslGsL2Vwb/wYMCF7Syp/wxpuHoQeW/066xzaRWpC8Vl3BtX5GkBt44BVk9kHWxpSXgNywPeufluJ4lG1w=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1737240510; c=relaxed/simple;
	bh=XV2v3tE9RsBcgo55DrtnnYrXw9Wt26vMS+Nx4Riwfq8=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=iRc9cZBaH/cAVPC82JbG9qv3Sc6qsq6qUibsXl6ax3GoX4rvJgSYsByrjqAgq6m/qQA/w21HSCW/ovCJe9vU+3RnzoYWcXOvLa+j6/aagNnFhvLKa28GFxMgnlr9nmVlr+ifqrHmyoBXGvRDGgRfsX52Nu940APddkitPHjysKA=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 0A7F03858C98
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=JuTXGZJD
Received: from HP-Z230 by mta-snd-w03.mail.nifty.com with ESMTP
          id <20250118224827093.ONJS.115271.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Sun, 19 Jan 2025 07:48:27 +0900
Date: Sun, 19 Jan 2025 07:48:25 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] Cygwin: signal: Do not handle signal when
 __SIGFLUSHFAST is sent
Message-Id: <20250119074825.06b5e9c40ac40272e38c5064@nifty.ne.jp>
In-Reply-To: <20250118204137.e719acb59d777ac3303a359f@nifty.ne.jp>
References: <20241223013332.1269-1-takashi.yano@nifty.ne.jp>
	<Z36eWXU8Q__9fUhr@calimero.vinschen.de>
	<20250109105827.5cef1a8c1b27b13ab73746eb@nifty.ne.jp>
	<7aac0c64-e504-f26e-165e-cd1c0ed24d6c@jdrake.com>
	<20250117185241.34202389178435578f251727@nifty.ne.jp>
	<20250118204137.e719acb59d777ac3303a359f@nifty.ne.jp>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart=_Sun__19_Jan_2025_07_48_25_+0900_cmikkm5LCqsm084a"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1737240507;
 bh=GDNF32yIOIYxhZv7rIVJ1jlUWOPzX8ZwgDZVZEl3o4w=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=JuTXGZJDk63iEqxfrhXv1PqoDYo5kbv5lTOQ43SYfP8cXw/GQ/oKMJhU5xNHuhlY5APHBt1Y
 SQQWQFV9llP8TM7kn5Kr9APLCastoell5tWeGKFHgCQYfBown4UwH9og8TWRokzkJlT4+jX4BC
 ctUEALHVtAjSBeMT1l11y3TeVbQLH4Un/x7Dt4HaJVI3iUPdH5fOD4noUPN6+cCuHZbjjdQRdu
 DbmLnfpalqTCJbHiFYbb2YlFQhbjcozLQwe9UDCIabHWMs2iEMmstC3cRg0cHiP2XqmDw2XZOD
 I56yFLNvQeWqGiVCxECyZjUdSLNNRBnmeqwtLvxQMq0OvtYQ==
X-Spam-Status: No, score=-11.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

This is a multi-part message in MIME format.

--Multipart=_Sun__19_Jan_2025_07_48_25_+0900_cmikkm5LCqsm084a
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 18 Jan 2025 20:41:37 +0900
Takashi Yano wrote:
> On Fri, 17 Jan 2025 18:52:41 +0900
> Takashi Yano wrote:
> > On Wed, 8 Jan 2025 18:05:53 -0800 (PST)
> > Jeremy Drake wrote:
> > > On Thu, 9 Jan 2025, Takashi Yano wrote:
> > > 
> > > > On Wed, 8 Jan 2025 16:48:41 +0100
> > > > Corinna Vinschen wrote:
> > > > > Does this patch fix Bruno's bash issue as well?
> > > >
> > > > I'm not sure because it is not reproducible as he said.
> > > > I also could not reproduce that.
> > > >
> > > > However, at least this fixes the issue that Jeremy encountered:
> > > > https://cygwin.com/pipermail/cygwin/2024-December/256977.html
> > > >
> > > > But, even with this patch, Jeremy reported another hang issue
> > > > that also is not reproducible:
> > > > https://cygwin.com/pipermail/cygwin/2024-December/256987.html
> > > 
> > > Yes, this patch helped the hangs I was seeing on Windows on ARM64.
> > > However, there is still some hang issue in 3.5.5 (which occurs on
> > > native x86_64) that is not there in 3.5.4.  Git for Windows' test suite
> > > seems to be somewhat reliable at triggering this, but it's hardly a
> > > minimal test case ;).
> > > 
> > > Because of this issue, MSYS2 has been keeping 3.5.5 in its 'staging' state
> > > (rather than deploying it to normal users), and Git for Windows rolled
> > > back to 3.5.4 before the release of the latest Git RC.
> > 
> > I might have successfully reproduced this issue. I tried building
> > cygwin1.dll repeatedly for some of my machines, and one of them
> > hung in fhandler_pipe::raw_read() as lazka's case:
> > https://github.com/msys2/msys2-runtime/pull/251#issuecomment-2571338429
> > 
> > The call:
> > L358:         waitret = cygwait (select_sem, select_sem_timeout);
> > never returned even with select_sem_timeout == 1 until a signal
> > (such as SIGTERM, SIGKILL) arrives. In this situation, attaching
> > gdb to the process hanging and issuing 'si' command do not return.
> > Something (stack?) seems to be completely broken.
> > 
> > I'll try to bisect which commit causes this issue. Please wait
> > a while.
> 
> Done.
> 
> This issue also seems to be related to the commit:
> 
> commit d243e51ef1d30312ba1e21b4d25a1ca9a8dc1f63
> Author: Takashi Yano <takashi.yano@nifty.ne.jp>
> Date:   Mon Nov 25 19:51:53 2024 +0900
> 
>     Cygwin: signal: Fix deadlock between main thread and sig thread
> 
>     Previously, a deadlock happened if many SIGSTOP/SIGCONT signals were
>     received rapidly. If the main thread sends __SIGFLUSH at the timing
>     when SIGSTOP is handled by the sig thread, but not is handled by the
>     main thread yet (sig_handle_tty_stop() not called yet), and if SIGCONT
>     is received, the sig thread waits for cygtls::current_sig (is SIGSTOP
>     now) cleared. However, the main thread waits for the pack.wakeup using
>     WaitForSingleObject(), so the main thread cannot handle SIGSTOP. This
>     is the mechanism of the deadlock. This patch uses cygwait() instead of
>     WaitForSingleObject() to be able to handle the pending SIGSTOP.
> 
>     Addresses: https://cygwin.com/pipermail/cygwin/2024-November/256744.html
>     Fixes: 7759daa979c4 ("(sig_send): Fill out sigpacket structure to send to signal thread rather than racily sending separate packets.")
>     Reported-by: Christian Franke <Christian.Franke@t-online.de>
>     Reviewed-by: Corinna Vinschen <corinna@vinschen.de>
>     Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> 
> Even though the reason why this issue happens is not clear at all,
> I perhaps found the solution for that.
> 
> Applying the attached patch:
> 0003-Cygwin-signal-Do-not-handle-signal-when-__SIGFLUSHFA.patch
> instead of previous v2 __SIGFLUSHFAST patch solves the both issues.
> 
> However, strangely enough, the similar patch:
> ng-0003-Cygwin-signal-Do-not-handle-signal-when-__SIGFLUSHFA.patch
> which uses cygwait() instead of WF[SM]O does not solve the issue
> Jeremy reported.
> 
> The reason is also unclear. What is the difference between cygwait()
> and WF[SM]O? I expected both patches work almost the same. The v2
> __SIGFLUSHFAST patch also uses cygwait(), so the reason might be
> the same (the reason why we should use WF[SM]O rather than cygwait()).
> 
> Corinna, any idea? I need some clue.
> 
> 
> While debugging this problem, I encountered another hang issue,
> which is fixed by:
> 0001-Cygwin-signal-Avoid-frequent-tls-lock-unlock-for-SIG.patch
> 
> If we are confident in the patch 0003, I think we should apply
> 0001-Cygwin-signal-Avoid-frequent-tls-lock-unlock-for-SIG.patch
> 0002-Revert-Cygwin-signal-Do-not-handle-signal-when-__SIG.patch
> 0003-Cygwin-signal-Do-not-handle-signal-when-__SIGFLUSHFA.patch
> 0004-Revert-Cygwin-signal-Fix-high-load-when-retrying-to-.patch
> for main branch and
> 0001-Cygwin-signal-Avoid-frequent-tls-lock-unlock-for-SIG.patch
> 0003-Cygwin-signal-Do-not-handle-signal-when-__SIGFLUSHFA.patch
> for cygwin-3_5-branch.
> 
> Corinna, what do you think?
> 
> Jeremy,
> could you please apply the attached patches:
> 0001-Cygwin-signal-Avoid-frequent-tls-lock-unlock-for-SIG.patch
> 0003-Cygwin-signal-Do-not-handle-signal-when-__SIGFLUSHFA.patch
> against cygwin-3_5-branch and test if these fix the issue?

The patch 0001 still seems to have hang problem. I revised it
as attached.

Jeremy, could you please replace 0001 patch with attached v2 patch?

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>

--Multipart=_Sun__19_Jan_2025_07_48_25_+0900_cmikkm5LCqsm084a
Content-Type: text/plain;
 name="v2-0001-Cygwin-signal-Avoid-frequent-tls-lock-unlock-for-.patch"
Content-Disposition: attachment;
 filename="v2-0001-Cygwin-signal-Avoid-frequent-tls-lock-unlock-for-.patch"
Content-Transfer-Encoding: base64

RnJvbSAzOTBjNmYxYTAxNjUxNzEwNjZlMDQ1MDQ1NDA4MzFmZDkwMmY1OTBhIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQ0KRnJvbTogVGFrYXNoaSBZYW5vIDx0YWthc2hpLnlhbm9AbmlmdHkubmUu
anA+DQpEYXRlOiBTYXQsIDE4IEphbiAyMDI1IDE5OjAzOjIzICswOTAwDQpTdWJqZWN0OiBbUEFU
Q0ggdjJdIEN5Z3dpbjogc2lnbmFsOiBBdm9pZCBmcmVxdWVudCB0bHMgbG9jay91bmxvY2sgZm9y
IFNJR0NPTlQNCiBwcm9jZXNzaW5nDQoNCkl0IHNlZW1zIHRoYXQgY3VycmVudCBfY3lndGxzOjpo
YW5kbGVfU0lHQ09OVCgpIGNvZGUgc29tZXRpbWVzIGZhbGxzDQppbnRvIGEgZGVhZGxvY2sgZHVl
IHRvIGZyZXF1ZW50IFRMUyBsb2NrL3VubG9jayBvcGVyYXRpb24gaW4gdGhlDQp5aWVsZCgpIGxv
b3AuIFdpdGggdGhpcyBwYXRjaCwgdGhlIHlpZWxkKCkgaW4gdGhlIHdhaXQgbG9vcCBpcyBwbGFj
ZWQNCnBsYWNlZCBvdXRzaWRlIHRoZSBUTFMgbG9jayB0byBhdm9pZCBmcmVxdWVudCBUTFMgbG9j
ay91bmxvY2suDQoNCkZpeGVzOiA5YWU1MWJjYzUxYTcgKCJDeWd3aW46IHNpZ25hbDogRml4IGFu
b3RoZXIgZGVhZGxvY2sgYmV0d2VlbiBtYWluIGFuZCBzaWcgdGhyZWFkIikNClJldmlld2VkLWJ5
Og0KU2lnbmVkLW9mZi1ieTogVGFrYXNoaSBZYW5vIDx0YWthc2hpLnlhbm9AbmlmdHkubmUuanA+
DQotLS0NCiB3aW5zdXAvY3lnd2luL2V4Y2VwdGlvbnMuY2MgICAgICAgICAgIHwgMzYgKysrKysr
KysrKy0tLS0tLS0tLS0tLS0tLS0tDQogd2luc3VwL2N5Z3dpbi9sb2NhbF9pbmNsdWRlcy9jeWd0
bHMuaCB8ICAyICstDQogMiBmaWxlcyBjaGFuZ2VkLCAxNCBpbnNlcnRpb25zKCspLCAyNCBkZWxl
dGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL3dpbnN1cC9jeWd3aW4vZXhjZXB0aW9ucy5jYyBiL3dp
bnN1cC9jeWd3aW4vZXhjZXB0aW9ucy5jYw0KaW5kZXggNGRjNGJlMjc4Li4wOTUyOTA2MWYgMTAw
NjQ0DQotLS0gYS93aW5zdXAvY3lnd2luL2V4Y2VwdGlvbnMuY2MNCisrKyBiL3dpbnN1cC9jeWd3
aW4vZXhjZXB0aW9ucy5jYw0KQEAgLTE0MjAsNyArMTQyMCw3IEBAIGFwaV9mYXRhbF9kZWJ1ZyAo
KQ0KIA0KIC8qIEF0dGVtcHQgdG8gY2FyZWZ1bGx5IGhhbmRsZSBTSUdDT05UIHdoZW4gd2UgYXJl
IHN0b3BwZWQuICovDQogdm9pZA0KLV9jeWd0bHM6OmhhbmRsZV9TSUdDT05UICh0aHJlYWRsaXN0
X3QgKiAmdGxfZW50cnkpDQorX2N5Z3Rsczo6aGFuZGxlX1NJR0NPTlQgKCkNCiB7DQogICBpZiAo
Tk9UU1RBVEUgKG15c2VsZiwgUElEX1NUT1BQRUQpKQ0KICAgICByZXR1cm47DQpAQCAtMTQzMSwy
MyArMTQzMSwxNyBAQCBfY3lndGxzOjpoYW5kbGVfU0lHQ09OVCAodGhyZWFkbGlzdF90ICogJnRs
X2VudHJ5KQ0KICAgICAgTWFrZSBzdXJlIHRoYXQgYW55IHBlbmRpbmcgc2lnbmFsIGlzIGhhbmRs
ZWQgYmVmb3JlIHRyeWluZyB0bw0KICAgICAgc2VuZCBhIG5ldyBvbmUuICBUaGVuIG1ha2Ugc3Vy
ZSB0aGF0IFNJR0NPTlQgaGFzIGJlZW4gcmVjb2duaXplZA0KICAgICAgYmVmb3JlIGV4aXRpbmcg
dGhlIGxvb3AuICAqLw0KLSAgYm9vbCBzaWdzZW50ID0gZmFsc2U7DQotICB3aGlsZSAoMSkNCi0g
ICAgaWYgKGN1cnJlbnRfc2lnKQkvKiBBc3N1bWUgdGhhdCBpdCdzIG9rIHRvIGp1c3QgdGVzdCBz
aWcgb3V0c2lkZSBvZiBhDQotCQkJICAgbG9jayBzaW5jZSBzZXR1cF9oYW5kbGVyIGRvZXMgaXQg
dGhpcyB3YXkuICAqLw0KLSAgICAgIHsNCi0JY3lnaGVhcC0+dW5sb2NrX3RscyAodGxfZW50cnkp
Ow0KLQl5aWVsZCAoKTsJLyogQXR0ZW1wdCB0byBzY2hlZHVsZSBhbm90aGVyIHRocmVhZC4gICov
DQotCXRsX2VudHJ5ID0gY3lnaGVhcC0+ZmluZF90bHMgKF9tYWluX3Rscyk7DQotICAgICAgfQ0K
LSAgICBlbHNlIGlmIChzaWdzZW50KQ0KLSAgICAgIGJyZWFrOwkJLyogU0lHQ09OVCBoYXMgYmVl
biByZWNvZ25pemVkIGJ5IG90aGVyIHRocmVhZCAqLw0KLSAgICBlbHNlDQotICAgICAgew0KLQlj
dXJyZW50X3NpZyA9IFNJR0NPTlQ7DQotCXNldF9zaWduYWxfYXJyaXZlZCAoKTsgLyogYWxlcnQg
c2lnX2hhbmRsZV90dHlfc3RvcCAqLw0KLQlzaWdzZW50ID0gdHJ1ZTsNCi0gICAgICB9DQorICB3
aGlsZSAoY3VycmVudF9zaWcpDQorICAgIHlpZWxkICgpOw0KKw0KKyAgdGhyZWFkbGlzdF90ICp0
bF9lbnRyeSA9IGN5Z2hlYXAtPmZpbmRfdGxzICh0aGlzKTsNCisgIGN1cnJlbnRfc2lnID0gU0lH
Q09OVDsNCisgIHNldF9zaWduYWxfYXJyaXZlZCAoKTsgLyogYWxlcnQgc2lnX2hhbmRsZV90dHlf
c3RvcCAqLw0KKyAgY3lnaGVhcC0+dW5sb2NrX3RscyAodGxfZW50cnkpOw0KKw0KKyAgd2hpbGUg
KGN1cnJlbnRfc2lnID09IFNJR0NPTlQpDQorICAgIHlpZWxkICgpOw0KKw0KICAgLyogQ2xlYXIg
cGVuZGluZyBzdG9wIHNpZ25hbHMgKi8NCiAgIHNpZ19jbGVhciAoU0lHU1RPUCwgZmFsc2UpOw0K
ICAgc2lnX2NsZWFyIChTSUdUU1RQLCBmYWxzZSk7DQpAQCAtMTQ3OSwxMSArMTQ3Myw3IEBAIHNp
Z3BhY2tldDo6cHJvY2VzcyAoKQ0KICAgbXlzZWxmLT5ydXNhZ2Vfc2VsZi5ydV9uc2lnbmFscysr
Ow0KIA0KICAgaWYgKHNpLnNpX3NpZ25vID09IFNJR0NPTlQpDQotICAgIHsNCi0gICAgICB0bF9l
bnRyeSA9IGN5Z2hlYXAtPmZpbmRfdGxzIChfbWFpbl90bHMpOw0KLSAgICAgIF9tYWluX3Rscy0+
aGFuZGxlX1NJR0NPTlQgKHRsX2VudHJ5KTsNCi0gICAgICBjeWdoZWFwLT51bmxvY2tfdGxzICh0
bF9lbnRyeSk7DQotICAgIH0NCisgICAgX21haW5fdGxzLT5oYW5kbGVfU0lHQ09OVCAoKTsNCiAN
CiAgIC8qIFNJR0tJTEwgaXMgc3BlY2lhbC4gIEl0IGFsd2F5cyBnb2VzIHRocm91Z2guICAqLw0K
ICAgaWYgKHNpLnNpX3NpZ25vID09IFNJR0tJTEwpDQpkaWZmIC0tZ2l0IGEvd2luc3VwL2N5Z3dp
bi9sb2NhbF9pbmNsdWRlcy9jeWd0bHMuaCBiL3dpbnN1cC9jeWd3aW4vbG9jYWxfaW5jbHVkZXMv
Y3lndGxzLmgNCmluZGV4IDJkNDkwNjQ2YS4uZGEyMmU1ZDE0IDEwMDY0NA0KLS0tIGEvd2luc3Vw
L2N5Z3dpbi9sb2NhbF9pbmNsdWRlcy9jeWd0bHMuaA0KKysrIGIvd2luc3VwL2N5Z3dpbi9sb2Nh
bF9pbmNsdWRlcy9jeWd0bHMuaA0KQEAgLTI3NCw3ICsyNzQsNyBAQCBwdWJsaWM6IC8qIERvIE5P
VCByZW1vdmUgdGhpcyBwdWJsaWM6IGxpbmUsIGl0J3MgYSBtYXJrZXIgZm9yIGdlbnRsc19vZmZz
ZXRzLiAqLw0KICAgew0KICAgICB3aWxsX3dhaXRfZm9yX3NpZ25hbCA9IGZhbHNlOw0KICAgfQ0K
LSAgdm9pZCBoYW5kbGVfU0lHQ09OVCAodGhyZWFkbGlzdF90ICogJik7DQorICB2b2lkIGhhbmRs
ZV9TSUdDT05UICgpOw0KICAgc3RhdGljIHZvaWQgY2xlYW51cF9lYXJseShzdHJ1Y3QgX3JlZW50
ICopOw0KIHByaXZhdGU6DQogICB2b2lkIGNhbGwyIChEV09SRCAoKikgKHZvaWQgKiwgdm9pZCAq
KSwgdm9pZCAqLCB2b2lkICopOw0KLS0gDQoyLjQ1LjENCg0K

--Multipart=_Sun__19_Jan_2025_07_48_25_+0900_cmikkm5LCqsm084a--
