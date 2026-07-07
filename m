Return-Path: <SRS0=bLel=FB=gmx.de=Johannes.Schindelin@sourceware.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	by sourceware.org (Postfix) with ESMTPS id AEFAB4BA2E07
	for <cygwin-patches@cygwin.com>; Tue,  7 Jul 2026 10:23:39 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org AEFAB4BA2E07
Authentication-Results: sourceware.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org AEFAB4BA2E07
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=212.227.15.18
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1783419820; cv=none;
	b=S2KT8X50I619aZIocwrHpe4lvV1L/tuv8ZBXoqF3k7Lk45/PgmFD1Dopg9u7FNHFjMvlwoDRZQ2lVQYLvMeOhHj39JmATtjJgub1oiuZxuAxPJDQR2O4TddwYnclOsveSmzkgXOL5znZnrDqC03K/7RYBYF63/t6DMnumR2DSHY=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1783419820; c=relaxed/simple;
	bh=tXroE2VKekwiaLQCoWO1eu7r1EUIPI7FlfLgXySjxyo=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=X2xHAPBzvQFLlwXDneOE+/hdufAtfGc/e2LNuurspnGGBx8H4TuVUbQvw8fw/U3EqbX0/ADtjO8CiudCdtLY6uTci1dHIiPAUf2H4a4akTo/PmPaOGoB3THNaXEhGmhuWCJ6i6KGRPOu/Pa8eKk2O7k91wClJJbFuesf7WKa/Gg=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=K9FUXeAl
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org AEFAB4BA2E07
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=K9FUXeAl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1783419818; x=1784024618;
	i=johannes.schindelin@gmx.de;
	bh=revVsvEAITVwn32Df2ZWHDIZ0ktg8Pu+RtHZoqQ70oU=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=K9FUXeAl4C9TQiUm5eWywvUZZUmoI/IYoFCB3YTXS3yjbwMcazmZmSr6Hy2Ke9Id
	 fbfSYpQ2Q3WUrcElhWYtpBvp/bKZzn6i8PH7nq+RxhuigyQDkA47klPj4i6z77NhF
	 i+6o9sVWN2AqZdaEfPMd+aNIAQTmncokoPSgkxpufpqEe14rsKu5DZsCaCI4YjFKz
	 KBvEfjg5qPrOxxJ1A0HchyloramDagT+evooOcNEwFdit9DuVHpvaK63X9xNGgCC8
	 4XUkehMx4LdCcAQw0s1QExfLRx/n8acXSsF9IeIMzigcvKFGGKA+7yJVzvG4FbqpL
	 ZJfFKQRAEeknjjdAWg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MNswE-1wRZRq2AkS-00SLP9; Tue, 07
 Jul 2026 12:23:38 +0200
Date: Tue, 7 Jul 2026 12:23:37 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Takashi Yano <takashi.yano@nifty.ne.jp>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] Cygwin: console: Correct previous NOFLSH fix
In-Reply-To: <20260705153745.1827-1-takashi.yano@nifty.ne.jp>
Message-ID: <c2c9a3e8-d992-b8f0-7441-4d0567fa9567@gmx.de>
References: <20260705153745.1827-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Provags-ID: V03:K1:ZIPho8A5HZSMHmKexBUM5rkzbtcV0YDP5Yj+9qlggbCBDZmPwIa
 Ksj9ypq7zfBB22UCbPl+Ca3S/o6XxQLIocgpD9Lr1t7uOkR8paaND7qiAAAAAZeCvn5cpq/
 G8ezMUSk/P97ufgMxOnK5kNU7fXwGd/GjZRKIRta2WWRjV+mhO2bVId3LbKDV+dxRLcQFW+
 OwSXAzKYwYsW0OPfZT3WA==
UI-OutboundReport: notjunk:1;M01:P0:M5LPNZGqCC0=;Zp9f+kjtX+ACU+CneBASA99NJeD
 IYTkZJLNwsIkfV5Gnr70UpCPivEUKOgEPHpeLPVO5yZU33pruDlgxfOgwweiDWcQlVPdZ8SLF
 4SD5Qa8+xrJj8ZkROgiWvYuoglLU+rXlp57ImQ2ftSZx8MZZXlSs4wr6DpPdfo9ro4ACd6rzD
 1IOsp22Z4I8mWiMcJF90uzDEDH8hFXJzAZS4qvlwVOTsN+xCEnCoIhLM1eKHy8Zv8aqBXkGhJ
 FRgOP3p2Gdg2PYmryJU9HgTZyZPMvFepi2qi1VuqZUpGOTNJsUE3ExV/EQVL455/ZXcouVhgV
 f4iC/QiHbRUJ5Jv/AcCnKfs58PdWJDaFnbXcBFdpR7P0BAcuusenjUTuIEkjEI1SzyvfxpTI6
 TdgFA6uNIWBQaqoW/UK1BmCZCfDfSK+4UP0sCtSnsRXCwm+pcoSwNURd/5liquqoxMPhx+lUl
 TuGaiduCVjA0EtqAjAMJh7zQjV6cjM9GVmfrmtv0a5KvIKbJxXLGNoyOuqR+MwBmgVuTFVFqg
 cL25XIwh8N6ZdHItRsaIm9oR5u7aEw0mL4b7n1wfXkneqBL04P44LqSmdYBDgb2oD0JJsT5fg
 VdVNO6lpxW93fMrrjzx5yOhdEd49ELS4wpWs4E6yEjEtiFlzDc0dvOXRagKra3wFicvBx4fWb
 WZJHyMoPBjcQFVo6du0wGdw33M6PisYkjeRvnVTsB7IwIUWW/dGxsNcIUaLC/o+Zs6o1I9em0
 P4btdgAKa+HWrfN5gaKdv0On2bSLBy9tnC/i/fdU3gIEgGumGSFL4+9LvLDkoxK7S5XJ4vTzv
 Lg+gwnRhlPEEVaHZRqMmwPUN4TY9+1c9NwpouD/ydhfxghoi0TdYOh5rGTOlPTelJde+f/HRB
 k9QL06nbWGWMvlktpRamZ8Q0oSBK5rSpoWZxO4xld0ipJ5PfV+sD7evcJmyDfy8Ttc8YFo4/5
 BpEZQtSsexWJ36iW2qk7skho/3IBtY/DX+zQiTIMzQfbXrKx4OOXJz1TYykAM77QXXaW0NOQP
 DVix0bu8F3l5OV37GI+HGA4QOPpJ9KFXEc9tCIWxsZ2eMnDtMYdR40BchGPsP0j8SOHi4l44U
 w8pA6eBQvHpimXcUU383U4fT5awnqzBw2BFhambdcJRLEJZBy63dSS/C8We4i2DqRrTSuzQXU
 21M+2eleLxmJwFduATfVwnaHuBIolPgMoralmSLJ0kitg1nEOrN5G66aa42ap1jqbFMYEKv1B
 yqY0vuViC6tIWHV1sYQwLXApkdYrlMhnMvP9NYxxuMkOXBWaBSqWd6FeENIZRHbiUs07H6DGF
 I2ouinFAjrTp1sbwhvqGPG2nLFVz7ms8yNGxaf1hza5YpltywQyLIoEOJuQbr9jgw7Cvk53jk
 p6MhnUa06IN1/ymwOBfBkSsc2caM588sG+hVgojrB+5d29lUjt1/aG3qm9kcSmG7BdOHpEDAW
 SKUDKmE1ugx2fbhgFMcuYz9fzrukaKoYa/ozN+phZneqRVMZM9Quo7N/keVaEzKmbiTXEyiCA
 1N4NWgNxxqbSDmAQkHHX55yiKMn7g/dNoynl0x2xkHmGYWuI7JimL9AoSIzN39Q+z1GCGe/q5
 1BIoTyvKy8xxlwYHoiMQ1RGyMUOzxlspjdMS55ET4zG79PHbRHZ41Abz/pMNYMLB7FBQYa0n4
 LZr7kFzbCm8jGaq6412zFMgaifXapL6xBbu70kAk86Jn9C6XpvUeS2KvsB4Co5PzVmf0ga7+P
 +9GntkXWcDHbmVZvP3uz3+b8zRyCNqJFjbRCjGHSPF168w1a9rVrJQ0rqlMq3qOfR8pi0TYIl
 fCta/WABT6zmpQG+h8wg+pbIDnH11D4kQKlgblhBAPKZqqpRjeNCrLEE+AauS+abuztEv22X/
 THPxbxWobfnLrWe9U7bUT07ttqHNALv056PqxJCzrYhYxDf9q6mamIEUucaKkBFm1XhHm+zAG
 ZUGv8DPxg0BSsUB9K3IfCBfcsQfkG6O96Op1D/q3p+wTSHCLEJ0Mc1uT/9WzFfW8VQe9Gc5fL
 SwBhlpS8udZ7VgMdm15PqIFrYPOAK0uWF8ymDSYpBMlSEN3N+HYM/XQri+tq3hdw4AIyAqMSg
 tDxNJI3xM64IVnoqfPWU4veC38FWsSLpzacfFFbEUdQL99cDAsCLi3aIiex8MABGqKD6LyLPW
 IS0w78dVwnx72UJHmCLfM74HVWjLiF70KhCdUsLFG1aNDwtW3e98dii3cqCEEIH6WHH8Kx/ur
 n0in+g0pdYHs9O8Q0BPcQVyyEF3C6YAg3heGFwScw0W2rGauLhNcNwRnzj4XeMwF2k3YOL9Pq
 AHvwFElyqfHfB0qMVPQ9kKn7lP3N6MWSaipSHhnLpfRT3GL4dk7tyvd6NyZZslr7nRIYA4ssf
 OSQJdY4PaTaOg9+kmE8gaVoTwerR74k0G6w263HaPIMZFxr+UJBujuaT/6lUXhzHrws1tjQTb
 igPHuGeBRELKNKHNj0/4IymU8b32sM0eU4yD0EWUoc19dAJdOO5RrKVWn85u31Isf+kJFGy0h
 swvJmnyAIB6TBF2uZhA+sSjAusQFXz4sIUf2w7YkMhXrk15mDFATeszxYqZDb4Zfe1jZG4P6k
 N8KNTdZweTO1O3OAOWwmWe3OwwB1LAILyiK3Cg9fjUk+ZziTJ1akkcRBo7lJCzOz1ZPRULnQm
 xrhRjkucH/93miPqqcSSBL8fue+Ph88Q+K6wVTuwWk4tbukZuVkTi2JfmRq2RwmZW5dZ/O4Ht
 WTGtpXHMUYBLwRbFWTxlzlsdXBEtrbnwAkF5l/i8QwK84IWrHitMbdjwutjC7rRSS+YGmtXbA
 JIVTViX9ER+aKE1RpbxNVHLqdK3SJAP9o0x9fOzdky9WTTS5ckdfpYKRxzEH8egmtHNI3YOu2
 TxwIvZM6IXbwumAJ7DiO2rJUfJ7DnVqhUBT+pC1Wr7/ZjjNVdZ5kJmYsBm68B02Ron1h/soxP
 IpJxIfhQN7BRi+kI5LnKZGepasT449vXxC03asY6YLeVnmHGDuC1Xu3Fe37PIiAiBrQjCg5Sz
 YZXXUzZI/zARg6GZQOPIk4TwpADnyLu52lvwwNcQcU1Gg4P8pnJYFdamaXnxoDLxqqnhvHSS/
 eHqBGfpOfkH0DTsiUPUO+YaBM8SjUA43E/zLQTid4Cws1+92tngqMt3GlYo2KefS+0VW2UCij
 x7xidBsd0ybNLS4RcWh5W446T5gj5tZ0RHbRdRnBDbxHPPkG9gfQLQ5J+Y6l2oIW4sOjtnv4R
 sETKFla3zKG6ZziVF9r24XSUmDx9RciOVjnGay+bJupLrEVPCCXGomglbMXQbLYTgD8s02hyr
 gJTt94hmZDcUXL/eEjvLcbKJIxLwRYwRSZh3i18UljftAZKqVWpx5Mk5oW5VlxQ0gu6o3C+jA
 DVSaLcRPoHVVFqIg2HAgli+uTTtUHQF3bj0HmNAF5zAeQJYymBhDjEwJiza3PYNNKmndB3Pz9
 ftnW8jIXO5Wyi5/uqo40ZtgTjPTYpYHhz/vi52o5RN1EonVJEvpeh97OhWmrEg7unoF50K3PW
 xHhTsu/RNTMpxUCwJhVpjNg9qXG1EawH7C6dvJvesGqaP4TFel0kFV/PE/duFmMA5nZt4RrSu
 3XUqjpQL9/1VDcHZFcGLxV1WZk7UDiryBHUph9xK8q257whdzjjRiFfoxxnnQF6toee5vWVG4
 EJhUuTbD9zRi691EPs6j2qfAj1fziv51AeJbNFuC+xvnyf+UrAlifuJCw04ehZQfTYMfkonSz
 p7i20TZFi+I9y5HtKMhZaR/y34Ty5d2UcZoJJxqHc5u+k+CZTftbgbI/JpLeIsDGbzLyrapv2
 Cbtlpl8t420XG5UzklKHoHLYNCSoscb7lyJjXIQunbmI4XYKMd7+vwKhtF8ner1FvIhPJpdMl
 PNzo+4BAG6gf5ewn7ihld7zm72/XzdTasgoCUaO8grlIgj4dgqDdcWhDBZdnzeUJjO7fx3N8j
 M1qPKwDnkoC3VK90/2FNH86MMjKLNRQov610dTEoc9TlkQHdOpLvRkODNPqGmrhVEV7hWZ5sq
 YQMzxbQeWqvZ/6qXevwqQYf1zDZcFOETh6oOVrcIFjbacY1H9M4K/0m9mWq7ROFIYHjL4LfGh
 C8P6GbZRu3v32/Bes9IQ7ElVkcgQsX6Qz4fhQ8sfKTHDfjNcMVWnb7RwIVYbe46D7BJCSzKUv
 B2QQf0lCd7evjqnhL4lojHr6QmoWnTZv6C+5PWZePUqU33TJNRrTBMi69Xp2PViraWCa0G0af
 YwjtkfXpuUwU5kktXus5EBs+ynrI/v8fzMppzmJgExFMUFzbEb7DqGz8n8GokyOIt4/qDUI4T
 rN5vl/TzMxtIMwRt8phuEdK5G/RkDcMC/Yv2EOTO8iNNapCwEjyooGhQTgxVUtP30hIn5RrJv
 thECp0rKTDApvjgfvYsaPA9jfh/PzHasWjzbg6Jekcno93dTIytuhaKzHmjcYOKPKI8wtRp59
 grDwf8TlSE51KxMCHPYZ3uXmdQQWS4Rts1pmLzuboT2+MAby/BRVIe216hVb8B5TAIXK4fT8c
 FMUhME9iSVdwqmMmhg3t9BOOAxUk4joIlEjlL4isih2T0u1qQX9DDaHS4A4HF8gtom3JQbRP3
 4MPsx6NiDAPGNzcWyaZ5mz/onc0Iqb/XjRnhHnapslLKzS55xK1Hnvs873tqe4UX7w9LgddbO
 HKbTxztUIInlHzMep0G1ZHps7OH75Qi2ZNpZfqL1L4xKq5gUBpfpmUp0iRj4Zxbz1aFYEHtQe
 C8dQ8GrU3tXmXvlPpsbNPSia+cWLeg2cHBJSGKU0hVLz3+Q1QemcXqX3uVZHGKRTU0JjYLeXe
 OWTGsX0FA8785706t94FxpWZW+6K0ljkRexTcRNX2bIYAjoWCm2qFPbTF4b/B6yyEoM6L2Xos
 ogGxb3DFQSBl6B4l50T0RgBIW9v4drOAUXKV/ND6gRcvnMNQhcHrEfvJelt9Hjn/nUgKm8CQ9
 RRxKPpwNt0m+eHwmSQEAbEtDMfRKAr7DTiYjUorQ49/Yl5xCGj0aXjDYigjx/aVBKUfxPsfK0
 DjeYnRZX+MmHLwiGOd9NXeKF7zO0eF2fgAwBeS5RiWTxSi/6mLiy91M45ncFvMDNFY2VWhDmQ
 xtQFQ8ZHdVF4wgCCx2MeUBNvmkaVSm9mMOT5E/rYY0PSOP8/1Dvqu4OdgThW4Q9+rC9dqdS5I
 SFemxNnu8+VpDKQMfWPCpCQmaUOPiHRDepTVmbtCNgBu5feElFNxT4tNMcmukJaEsG4rPcAEq
 kQXMzgn/WMLOn+Kg4ObbYfxy/Qctfj1LL6MBqd4XIZaOG6o8/mEJxqebA0NQTCVAvks6GY/LZ
 tSkqMsWBnj/NCUB1xmGRAXaoDElMKO6CU8t7TfcHso10+4cnH5Ah+Lbn/h1/fFpahFxTrabBj
 NN9bfV/zL8j5U9MmV6ocjcBfY86KiFVX3cB38M9W3V/p9IZT7c+9TSRWh8T3+sYUNUQCfehzT
 ieu2Cafia7s7CuYsAtGmAFZ7mGvyRp5x3S8XLgKKfrIp9jg8zYN26zLfI//fv9pIHpZ/MlWQ5
 YUz1v+U5eaTIUQVLz0XO+98EZ8xarnZcAr0ka1r63wapPppEq4xvJumAJOH3EIvcbV/wMcLyh
 JfZ0lPS3kg0dwJfxgrpD1TqgFfFcX5vN/EBrMUvRuFGvio79ApPDl2d4hCYy7gzlqQgHRmEE7
 2cSKJmJFA=
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Takashi,

Thank you for v2. It correctly addresses the NOFLSH concern from the v1
review by adopting approach (b): replacing the unconditional `tcflush()`
with a targeted discard of only the records the user thread has already
handed to `line_edit`.

On Mon, 6 Jul 2026, Takashi Yano wrote:

> The previous fix for NOFLSH mode does not work as intended.
>=20
> discard_key_events(), added in "Cygwin: console: Fix NOFLSH behaviour a
> bit", loops on ReadConsoleInputW() until it has consumed the requested
> number of records, but ReadConsoleInputW() blocks while the console
> input buffer is empty. sigflush() calls it with a hard-coded count of
> one and no guarantee that a record is actually queued: in the
> master-thread path the signalling record has already been read out of
> the buffer before sigflush() runs, so the call blocks until, and then
> swallows, the user's next keystroke.
>=20
> To avoid this, this patch does not discard input when process_sigs()
> is called from cons_master_thread, where the value of `fh` is NULL,
> because discarding will be done in cons_master_thread.
>=20
> And because the ReadConsoleInputW() return value is unchecked, a failed
> read leaves the count indeterminate, so "n -=3D n1" can underflow and sp=
in.
> Check return value of ReadConsoleInputW() and abort if it fails.
>=20
> Moreover, discard_key_event(1) does not work as intended if the first
> key event is not a bKeyDown event correspoding to the signalling key.
> Use discard_key_events(0) instead. This means discarding input events
> to the current position processed. Since the key-strokes prior to the
> signalling key are already in the readahead buffer, so this call discard=
s
> only the signalling key. The important point here is to discard input
> before releasing input_mutex by release_input_mutex_if_necessary(),
> because, if not, cons_master_thread starts to process key events before
> discarding signalling key event because the thread can acquire
> input_mutex. This causes the signalling key is processed twice.
>=20
> One separate point: the `process_input_message()` caller wraps
> `discard_key_events()` in `acquire_attach_mutex()` + `attach_console
> (con.owner)`, but the `sigflush()` call site does not, so the
> `ReadConsoleInputW()` there runs against whatever console the calling
> process happens to be attached to. With the guard above the worst case
> is a no-op when the calling process happens not to be attached, so
> it would be more correct to move the attach into the helper itself.
>=20
> Fixes: 66324edf64a9 ("Cygwin: console: Fix NOFLSH behaviour a bit")
> Co-authored-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> Reviewed-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> ---
>=20
> v2: Use discard_key_events(0) instead of tcflush(TCIFLUSH), which
>     discards events to the current position processed.
>=20
>  winsup/cygwin/fhandler/console.cc       | 25 +++++++++++++++----------
>  winsup/cygwin/fhandler/termios.cc       | 20 ++++++++++----------
>  winsup/cygwin/local_includes/fhandler.h |  1 +
>  3 files changed, 26 insertions(+), 20 deletions(-)
>=20
> diff --git a/winsup/cygwin/fhandler/console.cc b/winsup/cygwin/fhandler/=
console.cc
> index 730bb0b45..cc4591c14 100644
> --- a/winsup/cygwin/fhandler/console.cc
> +++ b/winsup/cygwin/fhandler/console.cc
> @@ -1718,6 +1718,7 @@ fhandler_console::process_input_message (size_t le=
n)
>  	  continue;
>  	}
> =20
> +      num_input_events_processed =3D i + 1;
>        num_chars +=3D nread;
>        if (toadd)
>  	{
> @@ -1748,17 +1749,11 @@ out:
>    /* Discard processed recored. */
>    DWORD discard_len =3D min (total_read, i + 1);
>    /* If input is signalled, do not discard input here because
> -     tcflush() is already called from line_edit(). */
> -  if (stat =3D=3D input_signalled && !(ti->c_lflag & NOFLSH))
> +     discard_key_events() is already called from line_edit(). */
> +  if (stat =3D=3D input_signalled)
>      discard_len =3D 0;
>    if (discard_len && (len || stat !=3D input_ok))
> -    {
> -      acquire_attach_mutex (mutex_timeout);
> -      DWORD resume_pid =3D attach_console (con.owner);
> -      discard_key_events (discard_len);
> -      detach_console (resume_pid, con.owner);
> -      release_attach_mutex ();
> -    }
> +    discard_key_events (discard_len);
>    return stat;
>  }
> =20
> @@ -1766,15 +1761,25 @@ void
>  fhandler_console::discard_key_events (size_t n)
>  {
>    DWORD discarded =3D 0;
> +  if (n =3D=3D 0)
> +    {
> +      n =3D num_input_events_processed;
> +      num_input_events_processed =3D 0;
> +    }
>    INPUT_RECORD input_rec[INREC_SIZE];
>    DWORD n1 =3D min (INREC_SIZE, n);
> +  acquire_attach_mutex (mutex_timeout);
> +  DWORD resume_pid =3D attach_console (con.owner);
>    while (n)
>      {
> -      ReadConsoleInputW (get_handle (), input_rec, n1, &n1);
> +      if (!ReadConsoleInputW (get_handle (), input_rec, n1, &n1) || !n1=
)
> +	break;
>        n -=3D n1;
>        discarded +=3D n1;
>        n1 =3D min (INREC_SIZE, n);
>      }
> +  detach_console (resume_pid, con.owner);
> +  release_attach_mutex ();
>    con.num_processed -=3D min (con.num_processed, discarded);
>  }
> =20
> diff --git a/winsup/cygwin/fhandler/termios.cc b/winsup/cygwin/fhandler/=
termios.cc
> index 605258731..6395a99ea 100644
> --- a/winsup/cygwin/fhandler/termios.cc
> +++ b/winsup/cygwin/fhandler/termios.cc
> @@ -444,10 +444,14 @@ fhandler_termios::process_sigs (char c, tty* ttyp,=
 fhandler_termios *fh)
>  	goto not_a_sig;
> =20
>        termios_printf ("got interrupt %d, sending signal %d", c, sig);
> -      if (!(ti.c_lflag & NOFLSH) && fh)
> +      if (fh)
>  	{
> -	  fh->eat_readahead (-1);
> -	  fh->discard_input ();
> +	  if (!(ti.c_lflag & NOFLSH))
> +	    {
> +	      fh->eat_readahead (-1);
> +	      fh->discard_input ();
> +	    }
> +	  fh->discard_key_events (0 /* to current position */);

Originally, I worried that in the non-NOFLSH case the leading `def` byte
would now survive in the console input buffer, because `discard_key_events
(0)` only consumes records 0..i. On re-reading `process_sigs`, that worry
is unfounded: after the targeted discard, the `signalled` branch proceeds
to `kill_pgrp`, which invokes `sigflush()` on the ctty, and `sigflush()`
calls `tcflush (TCIFLUSH)`, which in turn calls
`FlushConsoleInputBuffer()`. So the remaining records get dropped by the
existing `sigflush` path, and the net effect matches the pre-patch
behavior for non-NOFLSH. Please disregard that part of my earlier reply.

That said, while auditing the same area I noticed a related internal
inconsistency that is worth raising, though it is more of a "clean up
while you are here" than a v2 blocker.

The new `discard_key_events (0)` in v2 sits on the main `signalled` branch
of `process_sigs`. There are two other returns from `process_sigs` that
`line_edit`'s switch treats the same way as `signalled`:

        switch (process_sigs (c, get_ttyp (), this))
          {
          case signalled:
          case not_signalled_but_done:
          case done_with_debugger:
            sawsig =3D true;
            get_ttyp ()->output_stopped =3D false;
            continue;

All three set `sawsig`, which eventually makes `line_edit` return
`line_edit_signalled` and drives `process_input_message` into `if (stat =
=3D=3D
input_signalled) discard_len =3D 0;`. That branch assumes the records at
0..i have already been consumed. For the main `signalled` branch that is
now true, thanks to the new `discard_key_events (0)`. But the other two
returns in `process_sigs` do neither the targeted discard nor `kill_pgrp`,
so nothing consumes those records:

        if ((with_debugger || with_debugger_nat) && need_discard_input)
          {
            if (!(ti.c_lflag & NOFLSH) && fh)
              {
                fh->eat_readahead (-1);
                fh->discard_input ();
              }
            ti.c_lflag &=3D ~FLUSHO;
            return done_with_debugger;
          }

and, at `not_a_sig:`,

        if ((ti.c_lflag & ISIG) && need_discard_input)
          {
            if (!(ti.c_lflag & NOFLSH) && fh)
              {
                fh->eat_readahead (-1);
                fh->discard_input ();
              }
            ti.c_lflag &=3D ~FLUSHO;
            return not_signalled_but_done;
          }

Neither path drains the console input buffer at all. Combined with the
unconditional `discard_len =3D 0;` in `process_input_message`, records 0..=
i
survive into the next `read()`, which re-peeks them and re-enters
`process_sigs` on the same records, potentially re-sending `CTRL_C_EVENT`.

For the record, this is not strictly a v2 regression. The pre-a42e4625e1
shape of that condition was

        if (stat =3D=3D input_signalled && !(ti->c_lflag & NOFLSH))
          discard_len =3D 0;

so for NOFLSH plus one of the debugger/ISIG paths, `discard_len` stayed
non-zero and the fallback discard at the `out:` label consumed the
records. The `!NOFLSH` sub-case was already broken pre-v1 (it relied on
`sigflush()` firing, which it does not on these two returns). v1 dropped
the `!NOFLSH` gate; v2 preserves that shape. So the NOFLSH sub-case was
regressed by v1, the non-NOFLSH sub-case is pre-existing, and neither is
fixed by v2 on its own.

The two shapes I can see for addressing this are (a) also call
`fh->discard_key_events (0)` from the `done_with_debugger` and
`not_signalled_but_done` returns in `process_sigs`, so the postcondition
"when `process_sigs` returns something that `line_edit` treats as
signalled, records 0..i have been consumed" holds uniformly across the
three return values; or (b) narrow the `if (stat =3D=3D input_signalled)
discard_len =3D 0;` condition in `process_input_message` so it only fires =
on
the code path where the discard has actually happened.

I lean slightly toward (a), because it makes the postcondition symmetric
across the three returns that `line_edit`'s switch coalesces, but I do not
feel strongly.

Do you think this is worth folding into a v3, or would you rather ship v2
as is and address it as a separate follow-up? Given how narrow the
scenario is (GDB attached to a Cygwin process reading `/dev/cons0` with
`need_discard_input` set, or a foreground pgroup containing only
non-Cygwin processes with Ctrl-C into a `foreground_special_process`), I
have no objection to splitting. Or have I missed something and this does
not need fixing at all?

Ciao,
Johannes

>  	}
>        if (fh)
>  	fh->release_input_mutex_if_necessary ();
> @@ -666,13 +670,9 @@ fhandler_termios::sigflush ()
>       be NULL while this is alive.  However, we can conceivably close a
>       ctty while exiting and that will zero this. */
>    if ((!have_execed || have_execed_cygwin) && tc ()
> -      && (tc ()->getpgid () =3D=3D myself->pgid))
> -    {
> -      if (!(tc ()->ti.c_lflag & NOFLSH))
> -	tcflush (TCIFLUSH);
> -      else
> -	discard_key_events (1);
> -    }
> +      && (tc ()->getpgid () =3D=3D myself->pgid)
> +      && !(tc ()->ti.c_lflag & NOFLSH))
> +    tcflush (TCIFLUSH);
>  }
> =20
>  pid_t
> diff --git a/winsup/cygwin/local_includes/fhandler.h b/winsup/cygwin/loc=
al_includes/fhandler.h
> index 8e9cbef4b..d11b3ec4f 100644
> --- a/winsup/cygwin/local_includes/fhandler.h
> +++ b/winsup/cygwin/local_includes/fhandler.h
> @@ -2201,6 +2201,7 @@ private:
>    HANDLE input_mutex, output_mutex;
>    handle_set_t handle_set;
>    _minor_t unit;
> +  size_t num_input_events_processed;
> =20
>    /* Used when we encounter a truncated multi-byte sequence.  The
>       lead bytes are stored here and revisited in the next write call. *=
/
> --=20
> 2.51.0
>=20
>=20
