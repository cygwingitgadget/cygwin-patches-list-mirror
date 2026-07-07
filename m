Return-Path: <SRS0=bLel=FB=gmx.de=Johannes.Schindelin@sourceware.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	by sourceware.org (Postfix) with ESMTPS id 430B94BA2E19
	for <cygwin-patches@cygwin.com>; Tue,  7 Jul 2026 10:34:18 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 430B94BA2E19
Authentication-Results: sourceware.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 430B94BA2E19
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=212.227.15.18
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1783420458; cv=none;
	b=n/EnR/EpVRPLHoZvwiWI0cMx3tmlqxoKCiW+/fcsmkMDF1tXj21lL2cJoWcOssRZrxMJy5KJp0AuUtFHtxZ/H68uiZTHdp+NoArzhf/vkKcs+V8qmzsodN5CO5uR7vE2PTDtVly+0cv6m1rKH1ziEIhUVhAHl5AYgev6ChoK4EY=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1783420458; c=relaxed/simple;
	bh=smOS5QIXIdjd3ueRferEVEnwr5YJvTdL9VKut7u1kuo=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=hVu5ZR3/VG+PLNbZ58FGAxFI+yRFU7Ao8Q4oFKJwLh/QOIDRL9ruufSHoDGWOY6x8VR1IXT75yTc8T6Vc++3uEoda8VV1b4niVJEK8XPQ1S6oNpbpiN3dV9VcKYIt8MsxIinZVVBCxu2ZhWtBFfociTFdvXMR0fPc5XFTEg/OB0=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=GDlDNZEs
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 430B94BA2E19
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=GDlDNZEs
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1783420452; x=1784025252;
	i=johannes.schindelin@gmx.de;
	bh=fdZDgpKmPbmZQJZs2usP9zrH1YzW+XAi/Qg8F/bfIvc=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=GDlDNZEs7fVCR7PlzSTcwvZEOxFvsksxKqKh6fCNV/rdjwEq0/Z54JMqUyhEZX70
	 cZp14hGH52vHSfzRzn/O88OMV8BcU9UND8Do5loEYxuRsiUjpC0LEzA0CMLxj3kHi
	 CUHk3RyTulJGG0F0PTFYVJh5DvmAmVdx3WBbejNJrE1HjWwPgAznmFQLTNaDr6grg
	 zSWjomrsq9UCQz+iuN86Oj8NMtJz41XVD40kUKIRUlkf8bwvJXJsk9f4qHCAvZAwv
	 LMoUtMxNS2LyhfTZQBay1GRzilox+GjuxG38hlOCc7rQqOig2QVCzyN5adB/duBWp
	 DHVh3E8iV+gR1u12CQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M8hZD-1wlhxq3yLZ-00Ckbh; Tue, 07
 Jul 2026 12:34:12 +0200
Date: Tue, 7 Jul 2026 12:34:10 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Takashi Yano <takashi.yano@nifty.ne.jp>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] Cygwin: pty: Do not transfer input to nat-pipe while
 masked
In-Reply-To: <20260706122120.bd5fba24fa7e4d01c3ee8543@nifty.ne.jp>
Message-ID: <d82924e6-5395-9289-662f-fe79a7085dbf@gmx.de>
References: <20260630081436.2427-1-takashi.yano@nifty.ne.jp> <67131026-6c13-7d7e-f80f-56565aea5aa2@gmx.de> <20260706122120.bd5fba24fa7e4d01c3ee8543@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Provags-ID: V03:K1:VpBVhIsW1lXA+5O+Af+jQ/9jexZUqSbevyDLn/Qw/sdciBvhz69
 WfOze90SxbrYMzUpgx8lQKcJn+h8TaG2mo1a+vEWGsrSDyY3NE+9FUcsFsc8n3CDYDo9sI9
 3G0gIg1iYv2uDP7ZsoJIPnKN/hCCbs+SCGe25C3bXqHxWPhmRpYQbe16UgqPRD9kzvng+9P
 fHvTrLvw5Fgpq4mCNniew==
UI-OutboundReport: notjunk:1;M01:P0:zRcQnvyalAQ=;uYzg/rkQN+8VKYX3l3Z0xz6RLtZ
 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
 VWKCnM3X7oamMsHPFQ=
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Takashi,

On Mon, 6 Jul 2026, Takashi Yano wrote:

> On Sun, 5 Jul 2026 10:10:51 +0200 (CEST) Johannes Schindelin wrote:
>=20
> > Concretely, consider two cygwin readers on the same pty:
> >=20
> > Process A takes the first mask. `InterlockedIncrement` returns 1, so A
> > calls `CreateEvent` and writes A's handle value into `get_ttyp
> > ()->slave_reading`. Process B then takes a second mask; the counter go=
es
> > to 2, so B does not create or store anything. A releases first: the
> > counter goes to 1, so A does not close. B releases last: the counter g=
oes
> > to 0, and B executes `CloseHandle (get_ttyp ()->slave_reading)`. But t=
hat
> > HANDLE value lives in A's handle table, not B's. In the benign case B =
gets
> > `ERROR_INVALID_HANDLE` and the event object leaks (A already lost its =
slot
> > in this API, so nobody will ever close it). In the malignant case, tha=
t
> > same numeric HANDLE value happens to be live in B's own handle table
> > pointing at an unrelated object, which B then closes out from under
> > itself.
> >=20
> > In v1 both fields were per-fhandler, so this could not arise: whicheve=
r
> > fhandler created the event also closed it, in the same process. For th=
e
> > specific same-process teardown path that v2's `cleanup ()` adds ("rele=
ase
> > all masks I still own"), the hazard also does not trigger by construct=
ion,
> > since the process draining `masked_cnt` is the same one that took thos=
e
> > masks. So the concern is purely about the general mask/unmask API cont=
ract
> > now that the storage is shared.
> >=20
> > Two questions, then:
> >=20
> > First, is cross-process mask ownership actually reachable via the curr=
ent
> > call sites (read paths, `cleanup ()`, `close ()`, exec/spawn transitio=
ns)?
> > If every mask is guaranteed to be released by the same process that to=
ok
> > it, the hazard is theoretical and it would suffice to document that
> > invariant near the field. I have not fully traced this myself and woul=
d
> > trust your reading here.
>=20
> This happens when,
>  1) Start `cat` and suspend it by Ctrl-Z
>  2) Start another `cat` and suspend it by Ctrl-Z
>  3) Foreground the first `cat` and press Ctrl-D
>  4) Foreground the second `cat` and press Ctrl-D
>=20
> > Second, if it _is_ reachable, would it make sense to mirror the by-nam=
e
> > lookup you already do in `transfer_input ()` on the release side as we=
ll,
> > that is, `OpenEvent` the named event by name inside
> > `mask_switch_to_nat_pipe (false, ...)` when the counter hits zero and
> > close the freshly opened handle, so `CloseHandle` always operates on a
> > handle native to the closing process? Then `slave_reading` in the shar=
ed
> > struct would only serve as the "an event with this name exists" flag, =
and
> > no cross-process HANDLE ever gets closed.
>=20
> Looks good. Thanks! You can find the similar in v3 patch.
> It reverts the change that made num_reader and slave_reading shared.
> Even if a process close slave_reading, the other process keeps
> slave_reading opened. Therefore, checking `masked` by OpenEvent() return=
s
> true. Therefore, there was no need to make slave_reading and num_reader
> shared.

Basically: the kernel already refcounts the named event object for us.
As long as any process holds a handle obtained via CreateEvent on that
name, OpenEvent-by-name from any other process succeeds. So each
process managing its own per-fhandler num_reader and its own handle to
the shared named event is sufficient, and the "an event with this name
exists" signal is emergent from the kernel's own refcount without any
HANDLE ever needing to cross a process boundary. That is a nice
observation, and it makes v3 considerably simpler than v2.

Thanks,
Johannes
