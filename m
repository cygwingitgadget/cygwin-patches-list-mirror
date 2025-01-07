Return-Path: <SRS0=A9bf=T7=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e08.mail.nifty.com (mta-snd-e08.mail.nifty.com [106.153.226.40])
	by sourceware.org (Postfix) with ESMTPS id 4F48E3858D34
	for <cygwin-patches@cygwin.com>; Tue,  7 Jan 2025 21:14:27 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 4F48E3858D34
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 4F48E3858D34
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.226.40
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1736284468; cv=none;
	b=jaRmEoy8PvclouRRt3bKELE2pkBjom76e+Rz7SkwGhQXkbo7vATxfyZioceIa1nz3vGrrVAvl0TSp0kV6AuFqM6M8wgj8Wmpnn4es+Cu+Qr8vd33XAgUvSqfUo7V9oLeZHcmLAzQlWE+6BoELUASWneeyTP1oMw99gP0+kxs5y0=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1736284468; c=relaxed/simple;
	bh=LfDJdhWoGxH9ZiJL8gWSDRoc3vObVp6pmTt+F/Dju2c=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=PIcfdORnBy8xg6+EeiJ+6mPqs/7v1lrL9rHGJJYZ68SHZepgCiE9Gl8IADYPvW8r8XWTaY2V2N2zcG4DC5Gl2hIgr+ZFCsfsIodezzazeOrEwwMe3cvbBiunVA0e1yTqF7uQMyj7VfTdm/+y2HrS9irsEkCOmCu1ChhazEn/Hxo=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 4F48E3858D34
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=t2+GsIca
Received: from HP-Z230 by mta-snd-e08.mail.nifty.com with ESMTP
          id <20250107211425244.PCLO.11752.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Wed, 8 Jan 2025 06:14:25 +0900
Date: Wed, 8 Jan 2025 06:14:24 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: access: Fix X_OK behaviour for administrator
Message-Id: <20250108061424.066e0e3bc0c911b3b4c3bc97@nifty.ne.jp>
In-Reply-To: <Z31a-_lO1hs4yc5I@calimero.vinschen.de>
References: <20241226123410.126087-1-takashi.yano@nifty.ne.jp>
	<Z31a-_lO1hs4yc5I@calimero.vinschen.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart=_Wed__8_Jan_2025_06_14_24_+0900_/NQnLgqA1Lv_eMrC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1736284465;
 bh=qcjlTeMXhtNbxLuSMpWjvMTI8zJtG0n5uhJ3NzpV6kk=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=t2+GsIca34y5TZnGqFjEyXFOGU2RX/7u9cdAOINcuoh6VEsdbgI7w2ex4EASIHug4sLZ3nMe
 aagPB3+F/fdXmJ64IgqhgP2wMEiyEa7CacfmqPubPegpDHqw268cPzSCLCzXe7VD1FLRFiq5N5
 jXdK78hptqvVr9KmNKTsWPr7a5NnHIeDE7kbvkFmeUvna7nRC/wS6MkEa/tkwBM2RYfhhTq3mE
 jzM0hHofCShYJCjJrSaXxFiIqhgBlUqOySxl/hHNqYJunpI3bVhhZFuYsVFHUbt+ieITXWJJRc
 RgP+N4tEZPYG1fY/i09Ck0/shKCYxaN0I/J25HZxXnv5/fKA==
X-Spam-Status: No, score=-10.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

This is a multi-part message in MIME format.

--Multipart=_Wed__8_Jan_2025_06_14_24_+0900_/NQnLgqA1Lv_eMrC
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Corinna,

On Tue, 7 Jan 2025 17:48:59 +0100
Corinna Vinschen wrote:
> Hi Takashi,
> 
> Happy New Year!
> 
> On Dec 26 21:34, Takashi Yano wrote:
> > @@ -613,6 +613,22 @@ check_file_access (path_conv &pc, int flags, bool effective)
> >    if (flags & X_OK)
> >      desired |= FILE_EXECUTE;
> >  
> > +  /* The Administrator has full access permission regardless of ACL,
> > +     however, access() should return -1 if 'x' permission is set
> > +     for neither user, group nor others, even though NtOpenFile()
> > +     succeeds. */
> 
> The explanation isn't quite right, see below.
> 
> > +  if ((flags & X_OK) && !pc.isdir ())
> > +    {
> > +      struct stat st;
> > +      if (stat (pc.get_posix (), &st))
> > +	goto out;
> > +      else if ((st.st_mode & (S_IXUSR | S_IXGRP | S_IXOTH)) == 0)
> > +	{
> > +	  set_errno (EACCES);
> > +	  goto out;
> > +	}
> > +    }
> > +
> 
> Calling stat here is not the right thing to do.  It slows down access()
> as well as exec'ing applications a lot because it adds the overhead of a
> full system call on each invocation.
> 
> When I saw your patch this morning for the first time, I was inclined to
> request that you simply revert a0933cd17d19 ("Correction for samba/SMB
> share").  The behaviour on Samba was not a regression, but this here
> is, so it would be prudent to rethink the entire approach.
> 
> However, it occured to me that there may be a simpler way to fix this:
> 
> The reason for this behaviour is the way SE_BACKUP_PRIVILEGE works.  To
> allow a user with backup privileges full access to files, you have to
> enable the SE_BACKUP_PRIVILEGE in the user's token *and* you have to
> open files with FILE_OPEN_FOR_BACKUP_INTENT.  The problem now is this:
> SE_BACKUP_PRIVILEGE + FILE_OPEN_FOR_BACKUP_INTENT allow to open the
> file, no matter what.  In particular, they allow to open the file for
> FILE_EXECUTE, even if the execute perms in the ACL deny the user
> execution of the file.
> 
> So... given how this is supposed to work, we must not use the
> FILE_OPEN_FOR_BACKUP_INTENT flag when checking for execute permissions
> and the result should be the desired one.  I tested this locally, and I
> don't see a regression compared to 3.5.4.
> 
> Patch attached.  Please review.

Thanks for reviewing and the counter patch.

With your patch, access(_, X_OK) returns -1 for a directory without 'x'
permission even with Administrator.
This seems due to lack of FILE_OPEN_FOR_BACKUP_INTENT.

How about simpler patch attached?

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>

--Multipart=_Wed__8_Jan_2025_06_14_24_+0900_/NQnLgqA1Lv_eMrC
Content-Type: text/plain;
 name="v2-0001-Cygwin-access-Fix-X_OK-behaviour-for-backup-opera.patch"
Content-Disposition: attachment;
 filename="v2-0001-Cygwin-access-Fix-X_OK-behaviour-for-backup-opera.patch"
Content-Transfer-Encoding: base64

RnJvbSA2NmNhNzY1Y2QyM2NiODM5YzU5ODk1ZTg4ZTA2MTdmNmQ5MjBlMGY5IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQ0KRnJvbTogQ29yaW5uYSBWaW5zY2hlbiA8Y29yaW5uYUB2aW5zY2hlbi5k
ZT4NCkRhdGU6IFR1ZSwgNyBKYW4gMjAyNSAxNzo0NDo0NCArMDEwMA0KU3ViamVjdDogW1BBVENI
IHYyXSBDeWd3aW46IGFjY2VzczogRml4IFhfT0sgYmVoYXZpb3VyIGZvciBiYWNrdXAgb3BlcmF0
b3JzDQogYW5kIGFkbWlucw0KDQpBZnRlciBjb21taXQgYTA5MzNjZDE3ZDE5LCBhY2Nlc3MoXywg
WF9PSykgcmV0dXJucyAwIGlmIHRoZSB1c2VyDQpob2xkcyBTRV9CQUNLVVBfUFJJVklMRUdFLCBl
dmVuIGlmIHRoZSBmaWxlJ3MgQUNMIGRlbmllcyBleGVjdXRpb24NCnRvIHRoZSB1c2VyLiAgVGhp
cyBpcyB0cmlnZ2VyZWQgYnkgdHJ5aW5nIHRvIG9wZW4gdGhlIGZpbGUgd2l0aA0KRklMRV9PUEVO
X0ZPUl9CQUNLVVBfSU5URU5ULg0KDQpGaXggY2hlY2tfZmlsZV9hY2Nlc3MoKSBzbyBpdCBjaGVj
a3MgZm9yIFhfT0sgd2l0aG91dCBzcGVjaWZ5aW5nDQp0aGUgRklMRV9PUEVOX0ZPUl9CQUNLVVBf
SU5URU5UIGZsYWcuDQoNClJlYXJyYW5nZSBmdW5jdGlvbiBzbGlnaHRseSBhbmQgYWRkIGNvbW1l
bnRzIGZvciBlYXNpZXIgY29tcHJlaGVuc2lvbi4NCg0KRml4ZXM6IGEwOTMzY2QxN2QxOSAoIkN5
Z3dpbjogYWNjZXNzOiBDb3JyZWN0aW9uIGZvciBzYW1iYS9TTUIgc2hhcmUiKQ0KUmVwb3J0ZWQt
Ynk6IEJydW5vIEhhaWJsZSA8YnJ1bm9AY2xpc3Aub3JnPg0KU2lnbmVkLW9mZi1ieTogQ29yaW5u
YSBWaW5zY2hlbiA8Y29yaW5uYUB2aW5zY2hlbi5kZT4NCi0tLQ0KIHdpbnN1cC9jeWd3aW4vc2Vj
L2Jhc2UuY2MgfCAyNiArKysrKysrKysrKysrKysrKysrLS0tLS0tLQ0KIDEgZmlsZSBjaGFuZ2Vk
LCAxOSBpbnNlcnRpb25zKCspLCA3IGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvd2luc3Vw
L2N5Z3dpbi9zZWMvYmFzZS5jYyBiL3dpbnN1cC9jeWd3aW4vc2VjL2Jhc2UuY2MNCmluZGV4IDY0
N2MyN2VjNi4uNWRiZTgyY2NlIDEwMDY0NA0KLS0tIGEvd2luc3VwL2N5Z3dpbi9zZWMvYmFzZS5j
Yw0KKysrIGIvd2luc3VwL2N5Z3dpbi9zZWMvYmFzZS5jYw0KQEAgLTYwNCw4ICs2MDQsMTQgQEAg
Y2hlY2tfYWNjZXNzIChzZWN1cml0eV9kZXNjcmlwdG9yICZzZCwgR0VORVJJQ19NQVBQSU5HICZt
YXBwaW5nLA0KIGludA0KIGNoZWNrX2ZpbGVfYWNjZXNzIChwYXRoX2NvbnYgJnBjLCBpbnQgZmxh
Z3MsIGJvb2wgZWZmZWN0aXZlKQ0KIHsNCi0gIGludCByZXQgPSAtMTsNCisgIE5UU1RBVFVTIHN0
YXR1cyA9IFNUQVRVU19TVUNDRVNTOw0KICAgQUNDRVNTX01BU0sgZGVzaXJlZCA9IDA7DQorICBV
TE9ORyBvcHRzID0gMDsNCisgIE9CSkVDVF9BVFRSSUJVVEVTIGF0dHI7DQorICBJT19TVEFUVVNf
QkxPQ0sgaW87DQorICBIQU5ETEUgaCA9IE5VTEw7DQorICBpbnQgcmV0ID0gLTE7DQorDQogICBp
ZiAoZmxhZ3MgJiBSX09LKQ0KICAgICBkZXNpcmVkIHw9IEZJTEVfUkVBRF9EQVRBOw0KICAgaWYg
KGZsYWdzICYgV19PSykNCkBAIC02MTYsMTMgKzYyMiwxOSBAQCBjaGVja19maWxlX2FjY2VzcyAo
cGF0aF9jb252ICZwYywgaW50IGZsYWdzLCBib29sIGVmZmVjdGl2ZSkNCiAgIGlmICghZWZmZWN0
aXZlKQ0KICAgICBjeWdoZWFwLT51c2VyLmRlaW1wZXJzb25hdGUgKCk7DQogDQotICBPQkpFQ1Rf
QVRUUklCVVRFUyBhdHRyOw0KICAgcGMuaW5pdF9yZW9wZW5fYXR0ciAoYXR0ciwgcGMuaGFuZGxl
ICgpKTsNCi0gIE5UU1RBVFVTIHN0YXR1czsNCi0gIElPX1NUQVRVU19CTE9DSyBpbzsNCi0gIEhB
TkRMRSBoOw0KLSAgc3RhdHVzID0gTnRPcGVuRmlsZSAoJmgsIGRlc2lyZWQsICZhdHRyLCAmaW8s
IEZJTEVfU0hBUkVfVkFMSURfRkxBR1MsDQotCQkgICAgICAgRklMRV9PUEVOX0ZPUl9CQUNLVVBf
SU5URU5UKTsNCisNCisgIC8qIEZvciBSX09LIGFuZCBXX09LIHdlIGNoZWNrIHdpdGggRklMRV9P
UEVOX0ZPUl9CQUNLVVBfSU5URU5UIHNpbmNlDQorICAgICB3ZSB3YW50IHRvIGVuYWJsZSB0aGUg
ZnVsbCBwb3dlciBvZiBiYWNrdXAvcmVzdG9yZSBwcml2aWxlZ2VzLg0KKyAgICAgRm9yIFhfT0ss
IGRyb3AgdGhlIEZJTEVfT1BFTl9GT1JfQkFDS1VQX0lOVEVOVCBmbGFnLiAgSWYgdGhlIGNhbGxl
cg0KKyAgICAgaG9sZHMgU0VfQkFDS1VQX1BSSVZJTEVHRSwgRklMRV9PUEVOX0ZPUl9CQUNLVVBf
SU5URU5UIG9wZW5zIHRoZSBmaWxlLA0KKyAgICAgbm8gbWF0dGVyIHdoYXQgYWNjZXNzIGlzIHJl
cXVlc3RlZC4NCisgICAgIEZvciBkaXJlY3RvcmllcywgRklMRV9PUEVOX0ZPUl9CQUNLVVBfSU5U
RU5UIGZsYWcgaXMgYWx3YXlzIHNldA0KKyAgICAgcmVnYXJkbGVzcyBvZiBYX09LLiAqLw0KKyAg
aWYgKCEoZmxhZ3MgJiBYX09LKSB8fCBwYy5pc2RpciAoKSkNCisgICAgb3B0cyB8PSBGSUxFX09Q
RU5fRk9SX0JBQ0tVUF9JTlRFTlQ7DQorDQorICBzdGF0dXMgPSBOdE9wZW5GaWxlICgmaCwgZGVz
aXJlZCwgJmF0dHIsICZpbywgRklMRV9TSEFSRV9WQUxJRF9GTEFHUywgb3B0cyk7DQogICBpZiAo
TlRfU1VDQ0VTUyAoc3RhdHVzKSkNCiAgICAgew0KICAgICAgIE50Q2xvc2UgKGgpOw0KLS0gDQoy
LjQ1LjENCg0K

--Multipart=_Wed__8_Jan_2025_06_14_24_+0900_/NQnLgqA1Lv_eMrC--
