Return-Path: <SRS0=4ELj=7I=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e06.mail.nifty.com (mta-snd-e06.mail.nifty.com [106.153.226.38])
	by sourceware.org (Postfix) with ESMTPS id 5B57F4BA2E05;
	Sat,  3 Jan 2026 14:05:15 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 5B57F4BA2E05
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 5B57F4BA2E05
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.226.38
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1767449116; cv=none;
	b=XJmLXLa/GUBiDzLeJ3TpXLpu2PxFsA6MUyk99ZKF+Vfi5oMNgKgC5azU1l7IUBFd7TdJc4KDcEALiCV5TJlrWevIXj6IDuD3qWzAyWLVLvK2OeOFYw2VsNRPfoAOytJn43XINEQURhYMrMuQ2U1/19eyeNCQVTmU2w+IVNDHNig=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1767449116; c=relaxed/simple;
	bh=oPLWsmJrJdfN+Q7u1EOwkHdII+xrriLquLeE/KUj20k=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=mOntx8MjdlvgY1JeYvPQmfQoYA2r2eN/06qy1SZ5rxWQpZ0g8eUVcLQf8DRJRg71PT/zUM7XzdgkmdlFyZ9K3ZQvHWgLVPxy86h1OYwN1NsCdjlKxvE5CMV1+zhxjCLBaE4WV0Q9lZ45Rh9BRBpy04p1/dtP86ACc7sXHdVfIO8=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 5B57F4BA2E05
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=tg0o8B06
Received: from HP-Z230 by mta-snd-e06.mail.nifty.com with ESMTP
          id <20260103140513394.BYJV.111119.HP-Z230@nifty.com>;
          Sat, 3 Jan 2026 23:05:13 +0900
Date: Sat, 3 Jan 2026 23:05:11 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin@cygwin.com, cygwin-patches@cygwin.com
Subject: Re: flock deadlock
Message-Id: <20260103230511.24a6f772323927a141bf595f@nifty.ne.jp>
In-Reply-To: <CA+1R0Vju3VQYaz-s00vCroEV3pH7vBeUhoMGqtUxi0x5k56vpQ@mail.gmail.com>
References: <CA+1R0Vg7b7YyvgDf1=or8oxskEX4BJwMJQxxTKYaUHWPQeD9iQ@mail.gmail.com>
	<CA+1R0Vju3VQYaz-s00vCroEV3pH7vBeUhoMGqtUxi0x5k56vpQ@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart=_Sat__3_Jan_2026_23_05_11_+0900_mt=kfKvTBxH72A=I"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1767449113;
 bh=nYnflcEI6TdlPqcy3YXjoJEGOmFE3a+ZqAUB2FdENJo=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=tg0o8B066V0DHNXkTmGVB3ZdEWlaqZxlRiEa66JivlMx4/qR+Nd2C00aVL+WCLdGFsMv+hoL
 NTPga/70e7W5QWM4ijGUkJJzwd0HfnQNGK2EIfKvjG8rPVcg4zp5cIw5kp30Co/+XSIsy6xrbj
 JmC/USLgWxx35+XcqGHrnWkEg5PpBF9c4XWZLWkdB809u6SilUsefsMixMRrh5vog5VCOUajUJ
 jHByn81sCcLpLLLJ0zu0Hk0IZv8xC/HDJ5114JY7TayM/LlAEtEWDL98Aw6V40176cPTRxc9Wy
 +pGjeTTI2J2MH9n9gCt0XqoIdjsLtCBNie0/bmKwbxlcUPPg==
X-Spam-Status: No, score=-11.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

This is a multi-part message in MIME format.

--Multipart=_Sat__3_Jan_2026_23_05_11_+0900_mt=kfKvTBxH72A=I
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 28 Dec 2025 11:52:36 -0800
Nahor <nahor.j+cygwin@gmail.com> wrote:
> Attached is a reproducible example.
> The example just calls `fork()` then open/flock/close a directory and
> repeats (fork/open/flock/close). The forks optionally sleep then
> open/flock/close the same directory and exit.
> 
> There is no issue if either the parent or the children don't call `flock()`.
> Without sleeping, the example deadlocks immediately on my system 100%
> of the time. Killing the child allow the parent to proceed, fork the
> next child, which triggers the next deadlock.
> When sleeping, _sometimes_ one child will deadlock with the parent.
> Killing that child allows the parent and remaining children to proceed
> (and potentially trigger another deadlock). Killing the parent also
> unblocks all the children.

Thanks for the report and the test case.
I looked into the issue and found the cause. I also confirmed that
the patch attached solves the issue.

Could anyone please review the patch?

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>

--Multipart=_Sat__3_Jan_2026_23_05_11_+0900_mt=kfKvTBxH72A=I
Content-Type: text/plain;
 name="0001-Cygwin-close-Do-not-lock-fdtab.patch"
Content-Disposition: attachment;
 filename="0001-Cygwin-close-Do-not-lock-fdtab.patch"
Content-Transfer-Encoding: base64

RnJvbSA1YjBhM2ZhYzhjNmY0ZjU2NjI2ZDEwOGEyZGZhOTczOGY3M2VjZjZiIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQ0KRnJvbTogVGFrYXNoaSBZYW5vIDx0YWthc2hpLnlhbm9AbmlmdHkubmUu
anA+DQpEYXRlOiBTYXQsIDMgSmFuIDIwMjYgMjE6NTM6MzYgKzA5MDANClN1YmplY3Q6IFtQQVRD
SF0gQ3lnd2luOiBjbG9zZTogRG8gbm90IGxvY2sgZmR0YWINCg0KT3RoZXJ3aXNlLCBhIGRlYWRs
b2NrIGNhbiBvY2N1ciBpZiB0aGUgY2hpbGQgcHJvY2VzcyBhdHRlbXB0cyB0bw0KbG9jayBhIGZp
bGUgd2hpbGUgdGhlIHBhcmVudCBwcm9jZXNzIGlzIGNsb3NpbmcgdGhlIHNhbWUgZmlsZSwgd2hp
Y2gNCmlzIGFscmVhZHkgbG9ja2VkLiBUaGUgZGVhZGxvY2sgbWVjaGFuaXNtIGlzIGFzIGZvbGxv
d3MuDQoNCldoZW4gdGhlIGNoaWxkIHByb2Nlc3MgYXR0ZW1wdHMgdG8gbG9jayBhIGZpbGUsIGl0
IG5vdGlmaWVzIHRoZSBwYXJlbnQNCnByb2Nlc3MgYnkgY2FsbGluZyBDcmVhdGVSZW1vdGVUaHJl
YWQoKSwgd2hpY2ggY3JlYXRlcyBhIHJlbW90ZSB0aHJlYWQNCmluIHRoZSBwYXJlbnQuIFRoYXQg
dGhyZWFkIGNoZWNrcyB3aGV0aGVyIHRoZSBmaWxlIGJlaW5nIGxvY2tlZCBpcw0KY3VycmVudGx5
IG9wZW5lZCBpbiB0aGUgcGFyZW50LiBEdXJpbmcgdGhlIG9wZXJhdGlvbiwgY3lnaGVhcC0+ZmR0
YWINCmlzIHRlbXBvcmFyaWx5IGxvY2tlZCBpbiBvcmRlciB0byBlbnVtZXJhdGUgdGhlIGZpbGUg
ZGVzY3JpcHRvcnMuDQoNCkhvd2V2ZXIsIGlmIHRoZSBwYXJlbnQgcHJvY2VzcyBpcyBjbG9zaW5n
IHRoZSBzYW1lIGZpbGUgYXQgdGhhdCBtb21lbnQsDQppdCBhbHNvIGxvY2tzIGZkdGFiIHZpYSBj
eWdoZWFwX2ZkZ2V0IGNmZChmZCwgdHJ1ZSkgaW4gX19jbG9zZSgpLg0KSWYgdGhlIHBhcmVudCBh
Y3F1aXJlcyB0aCBmZHRhYiBsb2NrIGZpcnN0LCBpdCBwcm9jZWVkcyB0byBjYWxsDQpkZWxfbXlf
bG9ja3MoKSwgd2hpY2ggYXR0ZW1wdHMgdG8gbG9jayB0aGUgaW5vZGUgaW4gaW5vZGVfdDpnZXQo
KS4NCg0KQXQgdGhpcyBwb2ludCwgdGhlIGlub2RlIGlzIGFscmVhZHkgbG9ja2VkIGluIHRoZSBj
aGlsZCwNCnNvIHRoZSBwYXJlbnQgd2FpdHMgZm9yIHRoZSBjaGlsZCB0byByZWxlYXNlIHRoZSBp
bm9kZS4gTWVhbndoaWxlLA0KdGhlIGNoaWxkIGlzIHdhaXRpbmcgdG8gYWNxdWlyZSB0aGUgZmR0
YWIgbG9jaywgd2hpY2ggaXMgc3RpbGwgaGVsZA0KYnkgdGhlIHBhcmVudC4gQXMgYSByZXN1bHQs
IHRoZSBwYXJlbnQgYW5kIGNoaWxkIGJlY29tZSBkZWFkbG9ja2VkLg0KDQpIb3dldmVyLCBzaW5j
ZSBjbG9zZV9hbGxfZmlsZXMoKSBhbmQgY2xvc2VfcmFuZ2UoKSBkbyBub3QgbG9jayBmZHRhYiwN
Cml0IHNob3VsZCBub3QgYmUgbmVjZXNzYXJ5IGZvciBfX2Nsb3NlKCkgdG8gbG9jayBmZHRhYiBl
aXRoZXIuDQoNClRoaXMgcGF0Y2ggcmVtb3ZlcyBmZHRhYiBsb2NrIGluIF9fY2xvc2UoKSB0byBy
ZXNvbHZlIHRoZSBpc3N1ZS4NCg0KQWRkcmVzc2VzOiBodHRwczovL2N5Z3dpbi5jb20vcGlwZXJt
YWlsL2N5Z3dpbi8yMDI1LURlY2VtYmVyLzI1OTE4Ny5odG1sDQpGaXhlczogZGY2M2JkNDkwYTUy
ICgiKiBjeWdoZWFwLmggKGN5Z2hlYXBfZmRtYW5pcCk6IE5ldyBjbGFzczogc2ltcGxpZmllcyBs
b2NraW5nIGFuZCByZXRyaWV2YWwgb2YgZmRzIGZyb20gY3lnaGVhcC0+ZmR0YWIuIikNClJlcG9y
dGVkLWJ5OiBOYWhvciA8bmFob3IuaitjeWd3aW5AZ21haWwuY29tPg0KUmV2aWV3ZWQtYnk6DQpT
aWduZWQtb2ZmLWJ5OiBUYWthc2hpIFlhbm8gPHRha2FzaGkueWFub0BuaWZ0eS5uZS5qcD4NCi0t
LQ0KIHdpbnN1cC9jeWd3aW4vc3lzY2FsbHMuY2MgfCAyICstDQogMSBmaWxlIGNoYW5nZWQsIDEg
aW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQoNCmRpZmYgLS1naXQgYS93aW5zdXAvY3lnd2lu
L3N5c2NhbGxzLmNjIGIvd2luc3VwL2N5Z3dpbi9zeXNjYWxscy5jYw0KaW5kZXggMWIxZmYxN2Iw
Li43NTI4N2Y3MmEgMTAwNjQ0DQotLS0gYS93aW5zdXAvY3lnd2luL3N5c2NhbGxzLmNjDQorKysg
Yi93aW5zdXAvY3lnd2luL3N5c2NhbGxzLmNjDQpAQCAtMTcwMiw3ICsxNzAyLDcgQEAgX19jbG9z
ZSAoaW50IGZkLCBpbnQgZmxhZykNCiANCiAgIHB0aHJlYWRfdGVzdGNhbmNlbCAoKTsNCiANCi0g
IGN5Z2hlYXBfZmRnZXQgY2ZkIChmZCwgdHJ1ZSk7DQorICBjeWdoZWFwX2ZkZ2V0IGNmZCAoZmQp
Ow0KICAgaWYgKGNmZCA8IDApDQogICAgIHJlcyA9IC0xOw0KICAgZWxzZQ0KLS0gDQoyLjUxLjAN
Cg0K

--Multipart=_Sat__3_Jan_2026_23_05_11_+0900_mt=kfKvTBxH72A=I--
