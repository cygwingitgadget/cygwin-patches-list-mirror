Return-Path: <SRS0=jVAF=BF=gmx.de=Johannes.Schindelin@sourceware.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	by sourceware.org (Postfix) with ESMTPS id 0BBE54BA2E11
	for <cygwin-patches@cygwin.com>; Thu,  5 Mar 2026 08:50:17 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 0BBE54BA2E11
Authentication-Results: sourceware.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 0BBE54BA2E11
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=212.227.17.20
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1772700618; cv=none;
	b=NBAT65pCbuYBgeWx9np6NlWCNRhVfsyZaqlT4f/7lV3Qilze43mmFsq8/10uJ4jrmkLB8nbSFjpj1owJgJLG/GyOrjMAnzArvnEKCZ1h+5dBxC4QABOG5fR01tjS+BQEUGRMeKOr7lSBj1/rtKGWQ0ULqZgGPnH4gcUZaIfi3d8=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1772700618; c=relaxed/simple;
	bh=5YloWd0RmboDh3RpDQ9YBZQyQYrQqEgBvZyckA/gSiY=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=PG8WPBujkrCawP6mTe+wWJ3L50djjG34mHLTQTFt1O732nXCZLVuCuAPB8ogf60JT6Dqzfhpd7DoE1+mq4r+83sCw3e1A73fyMrZKfv/NP9F3OgEV0fM0vjYHqQBT1VSeo5VRd284Swr777kdhslgGz2MmqzmYPoIBsWatSwgPE=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 0BBE54BA2E11
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=OStW+s5k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1772700611; x=1773305411;
	i=johannes.schindelin@gmx.de;
	bh=nO+4sZMbtfTNFXe2bw8TRdYhwunhsNDOlKA6t/yw4BY=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=OStW+s5kKsqP3FHAGYnd8TnNOhXUt74NPWRh1WwMZgYGIJJWjfVSatWEmsd+7fPx
	 cVl4qv2fXVL3Y+41f24GUlM1nN6tLVdUXKLwJxAhLBaWJH+lFq7fsyvOZeQh/p76w
	 Q1cvJyGIQDu/M+Vg4mcOZoZjfTZi2rJyt6LDNqFFjqJ8t/6VsBZJqh2W9YTQXzeG9
	 gtyr7vkxjsM5ibpp2uyKpCodSgk/IGPpzPOeKzwT8rUkHCmlg938OYlkk+tmz5Xhf
	 PO+Z6NiY4FgZOcA90QdIk0XSE+1ZE68ClbAWMAQYZrCynCc/+aS6H/7f8osxNjiQX
	 B+y4dX94KmlLjByiWw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MvK0X-1vgGNG0HdB-016zfe; Thu, 05
 Mar 2026 09:50:11 +0100
Date: Thu, 5 Mar 2026 09:50:09 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Takashi Yano <takashi.yano@nifty.ne.jp>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pty: Do not switch input to to_nat if native
 app is background
In-Reply-To: <20260303134058.3517-1-takashi.yano@nifty.ne.jp>
Message-ID: <c62dccd0-a723-1c06-b9b0-cc213b5b6eb7@gmx.de>
References: <20260303134058.3517-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:zBwgux1erupVMdI0+KBDIqCx0VvqYtAVvJiOap6NHOTomvJ+CBj
 61OAEe8BOL6PUrInMg8XaU4HTbVj5EBEJYbAA3R1A6TeY6T0fSxI2m+dmbUUq1+U/huEccV
 iuDxEcSFFbWQmQP9TzFVkym+GvRgu1eTx8okdYbydhjPCuZWTtHxI7u+27fUgomYoK28urJ
 7FNzcFpDBNsivdb1QxxdA==
UI-OutboundReport: notjunk:1;M01:P0:Ty5HRZEutOo=;WGMHXikMPi09EThaWj4DX/J9PkD
 nMOOlWV0kuQADlk/yzBZ+xIsxQ5EXKV8JIEWpSFfEGcA/KAQF8LTqBkVoU0mbFDn1VKndqjMY
 7Kp7Lh7sp3wSJ3eVxHERhO3jisyZflZ/17Wsg/ZGpl1yex7CxdLI7DBnT3K8Y87Ts35Qt2xSu
 UZtcclnoEesPUpLp4m/Jg7ec3V/P2qsphWkUPGjiupZAGnCfRJYko8fxlXL0jv7pGZem4VqQ2
 avbqQg2vN4DNQAs+xRJ4ePXGjJwaFUEeClmSz6ph1ZHrPddAEiNzmcYTw5R+rwzPiIhRsjBr6
 0YHNVE+Av4UpQEPm5FZDs4rNHKM7Lc+pA7XYLCfFixDQH7hS2ECyjSNqpF95pNjiYvluN6hvj
 lP6JCZ7jKN7f83jLzZAwyOx1e7e79vJR3NdCYh11GvIjrMNCT9tLVbcrnRwYeEXlRqPH5C6eq
 KJNZ2r/mgITHY94ZZybYiDa5FxrFsVg8SZGfAvfe6kupGuRyUPrs2RYG3CnDgYJs1sddsgS2T
 ymzfNHZzKcZuxxltDbsD2pqNvabV59CkjGJc0yKnKiEL/2O6YX49W12rUSmcZ+G8YtcJ0Z1Im
 boUqa19//cVLigzUKG0AVp5QoBskBbQciaIkyUNT4mHtWujpYB4TGgQjgr1leEljX9iSHlAdt
 3Y/O9aFlPkxXxMqF/ttdSngCYEu8SaWuB9QaxtNMuSe716h2P1M/X12NadcV5CaPpTwpehk5p
 46F9ntNNQv2VOrdPrla2rXvx2HSNgCUsgAhGHZsKP1koUVJbDVKOac9lW3iyVCw5ZO4dqV7C+
 rtUTO8IH7KpJNLCAEQVxtICKscL8Xpca/q4gd0oe0M/hdSa3l5ZmX8tjQAgP/MgSYytVhCq8S
 6gE9aQx123drbsXOLqX1AFsOXz7VgKqCxNF/wQLlxWsK3whvu7z8kvtjZ6E61h/MIhXrzunRf
 yvjJmamz4K8bRDeGTEs3MVyyBaDoYFt+Dq8s/WzpusV4iLYDKVXjrOi5F05z002JYVQ8HlslF
 91A2EB6xYSy0jjhcZQ/AwUbeCDpX1rOGgFDjCPh/SoLzs/whdWLDbAtat+UQMRG4GRXx+kGsX
 PnLjEWepo1iqsG3gieBxY+7J4yAiG3dGYNy1TnhotQuOLNEC/Ef8HfcSt5/r7XmJbB34xs346
 hlvsBpofRchgu9tNkI4yPqNrzR/hEzeT13JmNzLm88OaThnymBVV8LIqNzc/Dx9hTHu6GUtht
 GzFzyI5wIZ9LjxlyFep9rqEqQwUxLDIpjqQJrpRihX5tTh12OyetGMCM29xo7Ul2QB9fM9goK
 DwS1gjY+OIEeUcDhUD/ijWEyQtq6VjTwKieU8CP0Ax3FNetTVOMMF0rcsfHklBYXKwqnXpUIA
 6pmJp1NwnhJvLkOGec5poqQz/X2sy4khvSbyuuMjczWbH8kmLZwYLBOM22VCrxl+DqtEpym9s
 XBfOtziuJiB+3PsR/XCHNPJoFJcS8cPTeOwKVTcOnaAKVxLXIHN8n6AsVAf7DFIyo3Ydujen+
 2MH1VfU2Z7A9LRO4fp9y5zwiS8J+Ej/a64L6ioi2X5xFnIgGlnzKwsMdfoE2kHMN6jTF3GzhE
 avws5wd+SPX9gvwonxZRjq8r+aYBZnTNCJ2Gsp29QeVcbTGZkvXj//fjejzXVaXq3oSTNABfp
 W3Sv8Ue33WeTv5ToXdRgS/b5IR0J2yPP4vcmSbSKn1rvWPMSxADVHYx8sLGG4Lr6dGc+hNiVq
 fu4FzLWL85CFVuBBp/uA2idtVSqmWHBXJ3tNkmk+/ZUFnDTxU7Ri2A5HGZz3H27BCEllW/Col
 sefunZm+O3o5di1pDSfdm/TYcla098l6BXi2V29MJnHrd/2UJY3rlm3FOS+0X6ZU7jQB72V3Q
 EGDYml+eSZGI3vXhFPLGlFdsWGfEjWBM43q7PRo0E/oyS6IUffJxRdj2ILtHjlf+kJR+9sDnJ
 N8dnPBQvraVsbYzL1tOhG5FZ49hhnIBn4idybB6R+M8Su3Hr8CoXLnE/vX4usHm1KnLno+w6n
 MAVlijgtLOEv/4SF+1leKc+Gt0SQmW9af55jXiRXODUNmZDiLELRIZy/cXiBSwGfi4QdUWFnB
 QTPJgRFD7BCOGavEHIXnmd6rpr0tleTTRH+Fj+yjg+AlvTOK+3Mn6TKqW0G5HMvcf5Wqo2KMr
 zhmohMEveWunbJNCZ2qvSCDjV9zqUPnXiL9TRzx7WhOn06Ki54NxRECuTlmgX42ohD5PCl3V4
 mgtbGFQfBRoiRXpePlolz3aBzlvpejo0z4SLSEXyJBziR9JucPh8ofa/34Srn6CJpTA6NkR2d
 Zl0oVImaFpiU4qtkg6iMQ0gbCHKsWYyvf8IQLXknWpL8zSCny3EMOPQc4ZTE6xz4GWpbtinSQ
 V9uuGQvB0nJ2cbQoFyVP7UC01pBuZwEOR7au58kziFoQHUafc35U6u80M3CbEGVLQIp4WWhwf
 +X+M23Vb+87YtrXgt1gMx6q+qovSWWJ32f7i7olohPDfBtdmwR6ujA/8uJ0vHlFjyTcDPsiXO
 FCUVTbEyv9cFsC0nk+IlqRnpAdyzMEEa1hAtfZP5D1uFmzrqGY5YJjd/WfWC/UD27pR6VMnPs
 KSALqdhvfjJxJXpFQto5uRmWKMSKYDYhXUZ19QNqfBsavtZGWs+Rp7yKU/a74glZOQrb7HV2f
 9Zd9lisIcM1Nv1RA8PSWVtetWSGsLwGkunD7l6E0LTMEPoaMWU6E+sEjEiJJ1F3zAXzOJ6b/Y
 hTVfOKNsd0RXtP1bhtxAVQoYrlxR2mhDzpN+LpwDLIYd7TQ58U+8yHMFQ8ZPAkZIRlLPtOzNp
 wjP8YsHF+hQ2WJ0X2JqzCTFFCbT3H9CrQRbJcCuHZAT2Gu2xeS+iq0bbsqgS3Lk6rJYxbVIFO
 gVZ1bfCZNn4CW/hSg29KKCOXLIalZTSs7zSEVaVVS/HOZ6uHbijptBLcyOS0TkTumNUcJokE5
 pqX0RqK9cJ0VzUkcVV35BofVte7MZOEhqLa5SpES5rdxDNZCwGMeQWDQPQsfQ4AKCyPmpdz+Z
 8w00PnEIu/23cCSJAZIp11OqbbUag1rZTJzRBrgnLOLuKWaNvvcwhsOkxO4abg6uAPA0WdTRz
 mxCup5/mWAtxw+CUW5F29FAjngXKqDX2utxn4UYP/dMpLWzyXno/G/eRlguxYCDDlj50WuqiU
 BI2YShqHEGYrkXmJ2pZURKTbVfaJOXJ1YARpogk2yLvRLR0o2B+9SeVhCrXlComnUaupPcJz4
 nniAG73uDKlZ+oWwDqliKGnV1EnmIXaLDFvMD4YLeh9eKtQz4I5dV6jBDGYE/LLi9QGrYHwDB
 6uyaxd8/PFdPIMlRed+WIPjcNBdPzpKnV/q3GwqvIU82dwyYlhcRPmrpK6dIP8Bgzus8VeXGO
 aSwSrerpwZmfRLn1zaqC+/rWkNjVwB2f2IZlhF8U0t5Y1ANDODaHksJsy/A5tGY1nPlNWRTV0
 5pInhgz2GiZHvyxWmxDqzBFYNVFk4JTofVvQ3DC48OjRZozB4516bnmye5W4xo6YmRLS5tLS6
 Q79gdGCCBYZ79kJc9OgaCVk9zeXRtLD5JNWuWqole+gIBl5dpJNXRcSLoLIgkDF3ZvCm1zvb/
 osi/RGDeFVIKQI/y7hn5jth+GHd//k60JAyla7G2ToGO8sFKRkn+NNR1/0+uytLKlYjVUvyVB
 C+NlFTaqhXA2ulzWyGD/Eb0BA1rp4zYeWdjO5eKCqyx6vNJva4jK6hRQw4Ijem2lDJyySlBDY
 quOF9McMhtbyKIau53JzaoeuuT17JUxioLw5Qictokt1+ovcHlrfcJfL0vysIv2RngzHX4KpC
 I5sY04b2D2SRDgngEVd2fsegBjJ1nNCSROobV6wRRCAFT4ixK3qtHq2OBd4Xlo3EuLQDXcpwj
 Hu8O9j7N2JA7/zt0JVwV4rjyP/WJbbkjptQxttbzCKCnnRYXIVcWaJV/ulMREYCU84HTmSp52
 j2t1Wkov0qra8G3eTpKubIs0cuyS8rEyz3S43KCXrmG34hVZwHiTGLYNent1bF6wu6K9qwnof
 Ms2YneFVrjxTYVM+JHUbnXv4ZVULv0+d+z9jKfcLff9hkYDA9f8g6yrJeNYPOVnWN6LpkAH/u
 Fri6SWXj/wI6wkoM8K9rms5IGpLG2AdWxlKkDjYhZQf5Vs9z2THQ3/r2msg51hW7uBL5d1OFn
 4uWWbzu5WRDowEehKdaaV5Fx9Sbq/p1Lx3Tpjj7u61oFLChggLOGNrShLsE3fuC3HI6prH3a0
 mrt6jguSvXSYQkwX1MWYoWeZkM6hYC3HUkWrKnwcXmQbuYQJK1zT3pTF0nK5i5pc1v+Ry7kmu
 vfyPVzD6TQ7h7ke+4ehzYU2obJ5QadyH9nlo0vK98fhcwebZxw69mtRj44sYYnOzoyzuHnUQj
 dZZr7H/wnYiVK/H/uSJis3Dzs8ng2nnjLb+jxgBzbArR/2qZr9FZ3LMLzRAlqG6b63mohtzkh
 IMLuqNkjOanO4zNoOAfAL/4L6HrveYLFrjOMtTvBUqFmuS7yk4az2Ef7iQ5M5EBhc4jIRVjch
 weDDHM4/7sA2/1EN0dUz0dYm/GXDFMdqYl70X4vfD4ggGiiBq7xpG4htywsLwT+KDYDVaD994
 3KHI34uh6lUWdm6LJBAh/0wjH2+/qX4BD52YwQkwL/KYPMLfbD7JgbmDuGwEAeo6K8TR2IcRB
 bfuP8oEdUIlvnmbPdl/pgRMM5XxvTmotFYA6LOONDKuFxydkurDUC8F1DlNOIQqFBTbKLsIxF
 DFKLy0eS3b+PyvrAsv0rdKrAlCl5OjbNHqLz6AyKiU5O3+GtaI0Yyrtf1Z7py6PuXW/1J1Dwk
 x+4/AVyBbm8zzNM29jimMfYLHbLOo9Gfh2+YpdivupBfKsAANO1JPbabsc1tltpNutdyWxjm2
 wGv5SPKltVYg9PvTcdCnlWWg8Ub0BaAO45PE4mUHlITkxwNqcGTzNWfRTUnIdrCV4LSIP2CRH
 WgFoCoSVkNgz6XsyxZeJt4hRSDzrxbThKqEEPty+ACf0aqO8wp4BGv5NDUoMkXHDiUIFmHj07
 6SUNJPKienIlh3vUydTNTa8c5R2kiPfy2q7b/5utJbtPt6Azcs3POAMY5Wi+QL4ILPkeiwcwt
 uy8DmJFlyPRbbiAUyACoW6TNZOob69jFdttCrS0Vkw30cyG0AW7trdMdHPGg4cIJENNqA67Cx
 JsAkFYX4=
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-8.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_NONE,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Takashi,

On Tue, 3 Mar 2026, Takashi Yano wrote:

> If the native (non-cygwin) app is started as background process,
> the input should be kept in to_cyg mode because input data should
> go to the cygwin shell that start the non-cygwin app. However,
> currently it is switched to to_nat mode in a short time and reverted
> to to_cyg mode just after that.
>=20
> With this patch, to avoid this behaviour, switching to to_nat mode
> is inhibited by checking PGID of the process, that is newly created
> for a background process and differs from PGID of the tty.
>=20
> Fixes: Fixes: 9fc746d17dc3 ("Cygwin: pty: Fix transferring type-ahead in=
put between input pipes.")
> Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> Reviewed-by:

Well explained, and the patch is precise just like I like 'em!

Thank you,
Johannes

> ---
>  winsup/cygwin/fhandler/pty.cc | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/winsup/cygwin/fhandler/pty.cc b/winsup/cygwin/fhandler/pty.=
cc
> index b996880fb..3e8c7ff9f 100644
> --- a/winsup/cygwin/fhandler/pty.cc
> +++ b/winsup/cygwin/fhandler/pty.cc
> @@ -2210,6 +2210,7 @@ fhandler_pty_master::write (const void *ptr, size_=
t len)
>  	{ /* Pseudo console initialization has been done in above code. */
>  	  pinfo pp (get_ttyp ()->pcon_start_pid);
>  	  if (get_ttyp ()->switch_to_nat_pipe
> +	      && pp && pp->pgid =3D=3D get_ttyp ()->getpgid ()
>  	      && get_ttyp ()->pty_input_state_eq (tty::to_cyg))
>  	    {
>  	      /* This accept_input() call is needed in order to transfer input
> --=20
> 2.51.0
>=20
>=20
