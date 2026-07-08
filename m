Return-Path: <SRS0=LZdQ=FC=gmx.de=Johannes.Schindelin@sourceware.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	by sourceware.org (Postfix) with ESMTPS id 5BA224BA543C
	for <cygwin-patches@cygwin.com>; Wed,  8 Jul 2026 14:58:58 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 5BA224BA543C
Authentication-Results: sourceware.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 5BA224BA543C
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=212.227.15.19
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1783522738; cv=none;
	b=wq5PaS+SWfSkwPgHMBgbRxYJVhWDfufaQy4PyWTsW2D1+vBdqt9vHpWS9jNz0HYpRb0z4alBz8RHEt06oXGd2/KRbkKCHRoTJsLUv3jZE9527Ul2nYgDuUfrYtW/ktdp99XavBwbeSjloAbejbgi4g6WqnnmI2Q7EoOY4TYVMU0=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1783522738; c=relaxed/simple;
	bh=eXMHds2Q2HKKfJLWUx8us/XQspk/bhFQdeBe17Q+MS0=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=PbuLdZOjiJfPg5M4fW5d8UWO++J8xiXzo02So+j1r/Cr2ug/lPr1ofOPXmPb2+n86QNlgCbo5SCzpaL1NnN+lviD8KupYrkhasYgDTGbETXbMkoAbDmw/Vy577SXPO8VsanJLp/LrJOP9NmyNTOD+Tus8WlpGrdHkFROM0fywZ4=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=c0cbnvdU
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 5BA224BA543C
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=c0cbnvdU
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1783522737; x=1784127537;
	i=johannes.schindelin@gmx.de;
	bh=i/l7KuPVcIzRZBbc+QT/97mpB/DmTpT2GSPuVUWbX98=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=c0cbnvdUr76ZXZwhhln2jfdPXWyeVTtMdFxhTRsZEhTaPUeLP7ef2rphN3oUjX47
	 //T/YPQdMNdJOi8cye9IfimDHbufKvpVk07Vt/TwedsqRmVhK1CM/rjsyEZ+6WWTW
	 TfqcpYKClSIHSWdCdYTS6bSxk7jIOGy4XFiVeqYLyXkxwI3fjthzTXMF1A0I61b/E
	 BAZwkU4WNqmRHYRxdUPkpM18YurZ3BX8P2N7Q/NICebPT9CCJeTdyua0XIhCM/UnG
	 3snFyZIZ7p1dOOX5a4iRQ9pZiiUSPQZw4tUw5G8ZOpEm0flvo/TG71OTI5mqYmEZf
	 YmMiEBXrhp5b8on35Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MEm6L-1wsCAV3hNL-001DH2; Wed, 08
 Jul 2026 16:58:56 +0200
Date: Wed, 8 Jul 2026 16:58:57 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Takashi Yano <takashi.yano@nifty.ne.jp>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH v3] Cygwin: console: Correct previous NOFLSH fix
In-Reply-To: <20260708040323.905-1-takashi.yano@nifty.ne.jp>
Message-ID: <6ac18250-e205-89ff-3913-92c4f8f86606@gmx.de>
References: <20260708040323.905-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Provags-ID: V03:K1:e83O6HgLK5EJYA7j25RS6GmS8gfRyIyBcuYNUsxnwDHqbRU4aXD
 I5Jzk+yNplKqUnRnfZtfyMwSuil45PTPD2ye0jj/ahIftIYXoQ2DiWmFteCakgBWtz8d/Q8
 xkPdNKvS3GmEUCnL5esZTyhd5QMuE8rrFnjhgVLHYCz0GowFizN/8/uP2bF7rj+ksrYMbiN
 uhUgtIEowkroSimSZBBMw==
UI-OutboundReport: notjunk:1;M01:P0:SwSol20ZwK0=;B1pNhGo8OP53MSDVuBhYyf4b3gl
 oHKNUqAQaK4f6+rGoqIf0M4ycUTvW6aWRwaYRBjXj5Dbi9AWX+XSDNSY3rF4bHXp6XCpRpY7T
 Q4h1KgEB1q8jupLrshKFR0MjBF1mECou1BZufc3eLHAZmaz1l24DSKk1MSygSLZW5jeVnSedx
 vqNeRRCViODEFMAKOv5qKZpuh0QQZ6sburgbC5H5NdOmPZA+wU6RvzKOINi8aRtZZx2TDzC71
 zaEzXLIfosekgfypcOylDx2zyt6+du8nw1k99lV5T6Bx9xraFayYu5tYFOw0dfoT6f/7nhGRH
 f+OY8WocsrXmf6dQ9/2zqInAtqCai+hRucKt7svwXMLUAl/EX5+d2T7TJx3XiUNgsaCB0p2TK
 hOPNo7CPTMxrt7nDaShgn0zMWOfAmydQbiST0n1FAgea5WytBgaGFfPLPZ6ieGJpTAYynRbsS
 TAhvf2ZfnYrlH0/hv6noAwDzXILZdgsd0xZAjb0n6mCgAlgj6eDNNHkBg8Lra/YCLRTWOFoUK
 o2vCbar6xmc3r0a3wnHgfBECRsHYTTlv7jLvuruoPYUEt4i0MnOarS605K+o6QyDVBMwIA3Rk
 I6juOXbSLUbf5LWB/ATUUjusBMQ4m6mKrNMzYHWHGNjM15f4Hg7D2oqk2d91DFqs9vPcKhPXa
 MEzBMkFrvoVTpN6N/RLgMwm+WPu/cLKFSpI65NGUCEwc9IcU7FA9HlB8KBjRzD63nMwG/1KTz
 rvNF3/kacvyM6GZECMn7BiNMwdrX6z5GDsjZSCF5hnf6pviP/knigT9qAbwAaAFqY7dXOZ282
 WFOxVgaBZlCwK6Q9V5VyQ92fiQTe+PT48ETTMkrly+FuM6EiD12somZD81rm0/rn/FsYo/b1/
 DFpVsguYkLrjd+5XPDyhkbu8lfP4HEndtR/F/CLhxdWXQKO6mdM3Iy6AWzcYG4crC2vegebdl
 3LzxQjDiCB0CTxp+49yb7fsXQVvKszRr+z492pFE7GX+loaMLEVhO4KIaDIdi9Rir8WnD4Po7
 5TeZSD35ceG9Ezp8u06R2IvOXeMsXV04wxAJgrkuaHIm+RnAoASRMfXjMcCBTOoXQcKzw5t7R
 wYjKPzQXC5/SQZpIUDRupazFKj7n27qWFqkxqVf+0l/iFRS8193t2rm4rCbmUgGKEuUMcfM4J
 6QssdB0JMdvM19N0DkmZivCCtNgzPvFL2hrfAuqTPPxL6RzbAH3h4lpAvXNck97d3CPQCHRm+
 Ipi2bkwVFua9zDBoDWDn/qF3Dve82UPwHCmJZFaBAsShErirRn3nGob0+b6eD5CPWE2ZmQ491
 AyqDUIB6KLoN5Zkr5jW0uGfposqA1IrxqbCdCakVdB6dxXyTa0hvc1eQ7Wl9q532FgZl9B0D5
 pRqqSW/sHS5t6ycoVhFkzXDHz0gr1YImHHBjigh7W5jsbEzbEcrVwecbZaAhkC/PwacaTrJbX
 u4L9uNA8jkNN56QLoUNILMRZICG6ODRNavhIAlqi2hyW5ixlBc9ONwXhIcc38QBVk/7P2V00+
 g37V1j1PXKX+yWYp1KDOimrJJ8Uuxy/ZCUdHP231HvcF7l/4tUcKTtLJdOziPEUvCzAfmUsla
 KBaVmUryskr0E/W9r/90dJPCsXqg/Alrzxek0xNOGdsfkoTOMDPdYpoZtEe4R2NQPXnJM8Vs/
 UbxJyydJ7j77Xot932k1QuLrTX53BLVtidlQsoGmtOFNO0KXdREt0pULShd5e1INdBzCg50po
 a0H3dXsApCQhWTObsxWJDRY5vrQX53vO3JDCctmi/xJsSS4fqRRgLb8YRBaQBzyUdDs2CuuGO
 Gvr3+ICq033CcUXkkceUxtpdaViLZ9aaX6s9e2wCcB9I0jMjACaKc4kzzTTjdQSYJmJe74Y2v
 6K3d7jqHjT2QKWjOpyLBr2osOfrwPxFkqm/rNs50jPv586L3F+TC6AOFjp/msiFG0VbC5jEed
 o1t8kuscSuAr6i7FUhCaxq+mdeskFAxpzRBJqknl5oMQPn0pOwr1dVQh7fxtRVNWSa8FlkBKl
 cK1WTIY71p9rlZzc8QrfMEQvOfgrZZqmmcgXNseqbV6tQ3CdCftMqGxY/pgMkYJUZVURh+Uh9
 9d5vt393g7tCc9eSfMdj+waeqfOczglobA8vUcF28fy0J5GnBscW9Y1q884JlACMnvTyPCun1
 0sElQ0UNYOioyKY6S+PhT3EjoDjPruQdgAYCmsgdcHhNVr/CPmvyj2+/we/CWwco3su8g9vTr
 BndmDk4+zDtIgiuboA+5aTheYDe/TIQaiEJJgq4AZxYde1aDzsv9aXlc0mH6j5TExLePwZ2CA
 UPymzZ1JsZ22gUxVZw91n/mN5iLi1hrepNbYtNJb2DF42P2VBebfzACPKTbv+057VHP8773NH
 8mLRXtvPCq8c+epmR9OS2GboaJeV3d2x8IrQP1ZKRzdHThgArU+JR1QM487tJOR1dDSKkrPuh
 0vuv0A9dVWWya6tnED7xeNtzynM3qp3wGclTZpB41ERBBp1Xb0d8Dss9Ulz/A+n5jJCO6QxYO
 4BIhcLjIBbRXYoXojubESRZruj6Jo4ySHQWOk8LLFbN6pSzBGg6mT11+oMnavC1IfrDzmeFn4
 RGAxVpqEwwmyVja0r1OxO420mAgPJB49UjF+q1CJ9sCEDoVaM68hwnPB6iW7Ti0/HFAKnrxfd
 yXfzt4aWDzpVdO0W+gxgx/+gepvFsjiUAL+CeGDaMPZREv/6EA72+y0fRzNl/4/5uKB6xUo1R
 rNuMzdeSGg5pb/CdKHm2LreulvTk/qkA/y0XrCFSIXRqrhvwrxHO5Lm1oPdl03obdoyVlgpnP
 8JDust0z8Ep5zlx6yTcSHQZPz7WVcJYorvBrVRluWz2yoXxebtOJQ36lt+nRXVzPiG6ig+ZA4
 WpylbR3Bu7WoonBXqetgTCMgRf+YOW13xBrtEj2E0TJGfm9qmwI2X3uNwkDYeDBAKWmO08VIj
 h9irGz5HrcpMSEBXn+sEM8VGQ1kXnzDxlnv6EBemwGqyf7czsdOtEluVcNVc3A+8oQ6d+4g+f
 AyInUuNTZgci7SaOx8k6ImJMsHiQjnhFblcvE9MM6E2oQ33XHNG+g7Fdd1lt0Km1XxQ6Dcn3o
 VbqlW4EX9y9m7mpGPzh9g9iX31HpShDauv3U2MYaj4HpWELTR4X+KoU3cr96eFix37FFQmZFu
 M6i5Xz3PFXX+L4O8eNJ55JBq4gzk2Uf5RRt4LN+eF2ubNB0p6PwhTtUai/7R8gXkf99b69/6b
 4T2T8oxRxW4Gn5LiWz+fKiMzB/3VXam2c7dEn1v9Uup+jURSqrfp0B6+VHJf9tTBJ2vb6xSCb
 AV6cNvMwKw+U38aGcKDqkGW80X522xAJsoJD0x+x+m+IWkpTSK9l5u/tsAQBw9jGHOxWKBLU8
 /ab2jvC1sn6t4CXGsdmzZ1oGawvQlxZa0oYh7F8tSaQUKgS+CtGPRxyC01T7tCYOL91NKmPk4
 eDMK3kYK58ChFKu323JPdQyDKaIPAiPwLgkrxj2sdk9zBswgOn+h5RSBC6VXSBGxnLKnWrcsG
 ON/8buZgi9U/es9U4Y6yaMVHwA5RnypnUr+/d/9Smlt93Bqo7ro17/TyZbvWcyY4+59eW0AsE
 0mxKkPqJe+XhFoJiolodhkHviSKJoxbfFD9dP5e+rXFrHaQRX95uKPFAAk1lASsiSBQrdMHjq
 rupRBkFWZIyaYg9vQ1z2KU7B5L907VDl8SdIF+7UDJPWXyQVDbc4Rxy6gWelbh7y7Q0e28SOL
 A9jmxPyRTdftustRwoFJzJiHnzflLk2Q85l0s3vPduvdf31MOaaLUpRk3VWgPIXk0vFN/gvpz
 EuWOrSOOx4YUvtZMf5K23JpcmwojPGBiSz/mW9EwvN6IGNWygENEn1JgL/9QXBiN5twleiegK
 qpC68/qo3nV68q3opTcg6Hp3A0mOGzRsRcO+p0Koei6J3qTDBAZK+BZd/3pIjg+5R5nu/6MIn
 1iyYFR0JZm+86NRlU6XoNIIaKORSMnwI696zZrwH2/zwjakWHpdtqdWwSeQ1l6eeKiQJsgnqa
 dt2r77rBgeJWJoHKpPpLGlCYazkjn0290J3V6udc0iOgIXJ9FFwa2tIYuctgaBevyT1dPL+Ro
 a0T5Sz2GGPumS4qRACjcbS7NH5Hfwt1qrjvPmfaiBE4LzeYA6nV1H3VouRTXW3w19kjqr/htX
 n0yF+pERAKaBleBDJQulwt1icpIcWoGyhaawnz7F2zQ99s/quasPIbnkgrRkaaqz/pESo98Tv
 NYpTO+vCU0IqzJZwq3lMX1d+6cMHc0hlaE+P1z4nJzR5XHfllZtcgPBpqaHJapJeWhRWCG4nX
 8S7vMHxLaue/SuBjyGh63T37Kc6IVH9/qeoN0O93qWlTftEhQ9TrCPjVoeRcDPUGrB9CWdFrB
 LZs3497VwSvQZYhwQRbcS1+acTpSRVr+QgkzuO5NXtKxwrbszTM/LlrcJj8Bu4d1q93k27VGY
 soSwSz1qMesoLS+VaiWaKKMSVcVxQcjr8QtO4c2W2g9qM/vj6qnqgSNwz1xWvHz4vFqre8N7W
 OwySGZqpH2MoFQU/ekBT2d8qtEc0ZEkmNWIrq30PgG4sjKm43w7F8x4lc3YRDqhICQ0JjSm9k
 xgtkMf4xEeoS2nqkuIS+dDLpWg9eqwuq7yEBjyX5J29w66vWzKp8e1oi9ArcYexavEeNJeDso
 tF7zGAf5RVAUKK9+q7qg8/bSaIBOGQUPGrm/BpP4oX0e/OnFDx0OuabPxl/gpZlQLeeVSXhy/
 o3/x42Z/xFGgbgMSTISp6zCbK/5ipL7D0sKAodjzpRn6+lpI4olJzdZKpFdctaJ3KzMoTb+5v
 SgdtN3K+YrcsaRU89abd7GaYYkHKoVZ5UusvYX83ljqe1kAcVE8OMJgfyC2G+XdWhchOWeDDE
 geoFVSzphWpwCJmdnJsr93sAibd86hPPJKi7rlpw1v9Uc56aK/0eRK87P+m+fo2BdP1hEIPdU
 oxafkZdrrFuOhF5qg+NjH0954Ng0Z+qyCDrbZdCAJXuU17cAYO+R9k9etEum9YzmvhrFsQyQo
 IEdyRIyNMR1RoGwFptwsLla5O4dXaNvoKEIAIMcOSAbN/1cFQTArahS4VpKPuYKPPsfi7EVWg
 HFUFFuAOO1YFRxABrg/ijY1UtbM2VuhT+qn4/KOedNU0EbS08OfIGQmbsR9fTijT2FSmMWOn2
 saJ68yBaqRh4OpeuEp+tW/nZe98bLxHmi+wNKFyHgSwI3tiMsRV5YzLMv/fk3M6ihTP2gRgLD
 +B8MaqKY7NfKY+xbA5EZAMFswe4CTh/DGz30fT/CHeOhvfm0IhCBN+YhYz88+54zDTUsO3MZ7
 iF6QMtVAQuht8pK+eHyLKvCXdCoMFBSxQfqIJtK3J9eDUopyMUXMvdOX+ErAvv4KbTjJ/jNrB
 QG6cciMcxJBZgpFHC0owfXAb65/6oJShhEZqvX3VxUYdChplB3PIkHu9TajRauWL6OMzADNuL
 C3MAoWlUb0eDRQC+5KSu65C8KvjGAJCDv2IYtXis4wDyPvza08kRfTGblvcsWPYMQrx37bXh4
 7FwcnGLww7YkWTyDzN9fKw2b4fI01pqu7oQlnuSqlYAWbNHv9q9xdyzsuZ0bTZkflvzWq9m/G
 3TrOcccKPQfm9/rqPe0PVpUxZwCxGzr7y0xZhnmUfttKQorYXGpXtXLt9eS64Kb07R1BrAWAJ
 ft8J/eULE=
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Takashi,

Thank you for v3. Both concerns from v2 are addressed, and the "stty intr
^x; cat | non-cygwin-app" case now behaves as expected.

I have two non-blocking observations further below, and a question: Out of
curiosity, not a blocker: how does the `with_debugger_nat` branch actually
get reached in practice? gdb normally reads the console only at its own
prompt, i.e. when the inferior is stopped and thus not foreground, so the
pre-conditions do not obviously line up.

  Reviewed-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

On Wed, 8 Jul 2026, Takashi Yano wrote:

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
> This patch also fixes two more special cases. One is done_with_debugger
> case. When `gdb cat` is executed and the `cat` is running, Ctrl-C
> discards all the key events including the events after Ctrl-C. This
> is because tcflush() is used for the purpose. Use discard_key_events(0)
> instead. The other case is not_signalled_but_done case. Previously,
> when `cat | non-cygwin-app` is executed and Ctrl-C is pressed, but
> the `Ctrl-C` is not VINTR, line_edit() wrongly returned
> line_edit_signalled even though `cat` is not signalled by Ctrl-C.
> In this case, `cat` should receive Ctrl-C as a input char, while
> `non-cygwin-app` has been killed by Ctrl-C. Fix this in line_edit().
>=20
> Fixes: 66324edf64a9 ("Cygwin: console: Fix NOFLSH behaviour a bit")
> Co-authored-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> Reviewed-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> ---
> v2: Use discard_key_events(0) instead of tcflush(TCIFLUSH), which
>     discards events to the current position processed.
> v3: Fix behaviour of two special cases: done_with_debugger and
>     not_signalled_but_done
>=20
>  winsup/cygwin/fhandler/console.cc       | 25 +++++++++++++---------
>  winsup/cygwin/fhandler/termios.cc       | 28 ++++++++++++++-----------
>  winsup/cygwin/local_includes/fhandler.h |  1 +
>  3 files changed, 32 insertions(+), 22 deletions(-)
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

The new counter member is missing from the constructor's init list. It is
safe in practice because `cnew()` zero-fills, but adding it explicitly
would match the surrounding style.

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
> index 605258731..9971bb1d9 100644
> --- a/winsup/cygwin/fhandler/termios.cc
> +++ b/winsup/cygwin/fhandler/termios.cc
> @@ -353,7 +353,10 @@ fhandler_termios::process_sigs (char c, tty* ttyp, =
fhandler_termios *fh)
>  	      fhandler_pty_common::attach_console_temporarily (p->dwProcessId)=
;
>  	  if (fh && p =3D=3D myself && being_debugged ())
>  	    { /* Avoid deadlock in gdb on console. */
> -	      fh->tcflush(TCIFLUSH);
> +	      if (fh->is_console ())
> +		fh->discard_key_events (0 /* to current position */);
> +	      else
> +		fh->tcflush(TCIFLUSH);
>  	      fh->release_input_mutex_if_necessary ();
>  	    }
>  	  /* CTRL_C_EVENT does not work for the process started with
> @@ -444,10 +447,14 @@ fhandler_termios::process_sigs (char c, tty* ttyp,=
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
>  	}
>        if (fh)
>  	fh->release_input_mutex_if_necessary ();
> @@ -525,11 +532,12 @@ fhandler_termios::line_edit (const char *rptr, siz=
e_t nread, termios& ti,
>        switch (process_sigs (c, get_ttyp (), this))
>  	{
>  	case signalled:
> -	case not_signalled_but_done:
>  	case done_with_debugger:
>  	  sawsig =3D true;
>  	  get_ttyp ()->output_stopped &=3D ~BY_VSTOP;
>  	  continue;
> +	case not_signalled_but_done:
> +	  break;

Dropping `not_signalled_but_done` from the shared switch case also drops
the clearing of `BY_VSTOP` on this path. Probably fine, since no cygwin
signal is delivered here, but a sentence in the commit message would save
future git-blame archaeology.

Ciao,
Johannes

>  	case not_signalled_with_nat_reader:
>  	  disable_eof_key =3D true;
>  	  break;
> @@ -666,13 +674,9 @@ fhandler_termios::sigflush ()
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
