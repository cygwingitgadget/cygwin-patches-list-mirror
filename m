Return-Path: <SRS0=g5AQ=F4=gmx.de=Johannes.Schindelin@sourceware.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	by sourceware.org (Postfix) with ESMTPS id 8698B4BB24C0
	for <cygwin-patches@cygwin.com>; Mon,  3 Aug 2026 19:37:00 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 8698B4BB24C0
Authentication-Results: sourceware.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 8698B4BB24C0
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=212.227.15.19
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1785785820; cv=none;
	b=VJdkxCp8FEtm8qvLVQYkn9DTMNKK8CYovulCRIjglVWoSp/I4DtiITU7Ri+jSD1ZTF+vquCyksvlQg2qturNxz9SZwEORj74B7bZndnu4EIMeVjILPAld+Y9uPXaTXjTP6ArPtwtLObM3tyDxNxA8b1lT9eUgfxhdl3JDejbAHE=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1785785820; c=relaxed/simple;
	bh=B+/E9FrXrsJHKeL989rHbALWJ7PVdUD1rYFy//qXv38=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=VbrIBECai/ZpF3Wl0JpMe3gU6BmXu5/K5JSeZjqECTiTZ2KH9c7weM4gms8iWYxnTbbchAMhQK1puyZh89TkTrQYoWSzkRMJxcbybDscEnQzJ9r+haVgPTBURLPQJhZ9tIG7pCoVuGiyJc6m3+uKcdPqcXf6gOoOOQz0kLbU1rA=
ARC-Authentication-Results: i=1; sourceware.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1785785781; x=1786390581;
	i=johannes.schindelin@gmx.de;
	bh=ajeJYVoQqctEJIwP9tmZMCD3hlUyuyGJN7aujrq5uds=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=lb88bk1JMSWUXQQ8LrqUXuVnuIYo2RvAav7xSUrbacrjFNAUCjtxOC9/QvUQRzsk
	 C9WEnVDtKJOf+0AjQjGR7oiVQfOs8wmmP639PAclP0MUL2fN9hXS1az0nlflo5vYP
	 wk7y+4GE7AD0G0h+jPez6idmJ8yyyqaXcAD1qcZj7OMUfRSIY2T9bx4R02EmTygYu
	 r36IDLEPxdbVTpbbznuMGJoK5CFnJXCa0LAx+Fnkf//HR7sisA9KP0SjgYGjCRaTM
	 lzhiw/qHsV/PNBQDiMvESDayZCJ+3nhW0S11/iou7skQimIJdsErm77foxLb5foWs
	 wSyxvEmS16zW/XQxZw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MtwZ4-1xBeZd1Yke-010hQ4; Mon, 03
 Aug 2026 21:36:21 +0200
Date: Mon, 3 Aug 2026 21:36:19 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Takashi Yano <takashi.yano@nifty.ne.jp>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: open: Add missing unlock on error
In-Reply-To: <20260803032303.5382-1-takashi.yano@nifty.ne.jp>
Message-ID: <0f3a1f92-f9fa-5aff-c837-249a2408b95f@gmx.de>
References: <20260803032303.5382-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Provags-ID: V03:K1:A0YXE1wqXTWXrUvzoPtAA1zqvveAQfA6TTGdgLRBBuqa/tQKeqO
 N3zK/S24Fnhees/Sfmzw//vQ9qV4imghKPbEt7lch1J7R4YOlChDNMK5oPkUQrLsSlvN2gP
 B7SM3vZYAnbrboUYwVhXoRMCKpoWITN1bEAhsU64sU+QhjZqBLEaJlBlAmU2muUJlMXiSTD
 HLrfdMFaWaM9R1JOLUBbw==
UI-OutboundReport: notjunk:1;M01:P0:mvlsD2YHHY0=;3trri32oaA+3/0/nKcLfnA1Gia5
 kfqkwEG16cKGZGIPjB/0XUrK5BEdui1evqZld1JZlEZI1zNKj38ixHdTSuu8bm3o0+jPIWGNy
 cksJACh6XICzTXPa/cyWfJG202IQ2Wev0WS2Mnq+HT+zO36TDRRdlpmnxUyQAs5OgpwGdyLSy
 zDN0V1F56Amvs7cxtzFKdVu7v8fxL68rLSNKJpsltJYAWKdEidD14rAXcUp+Foa6zGQNX8QTw
 HB+Y7tDMg8n//P8C/jMlyToAQQoc7STTzB8TT4W+zLr9ra4tEx4i68mjMq85xF0binzgBKDVB
 w0o9KbslzKAlRIh2Gv22gTwT1a61OqmOxNZFUAkZtiwPD9xjvJaGH7QwOdRi8zbwPhgQ+/uh0
 pFzzbzYNPWOthrVyhr/hvv0/U5CcrDHCgi5TzGNMHcoMipHyCmIEQQ/rMo8vYQRE4HTYJGiDF
 U4lEFRLSzwKyVeiiReXEFungjqXCtkqwJUp3aBHYlaJtVLxCPhicthPqhngQRVtkaZM/431jI
 j7doqnHcDaYyoDO2cgIO6psc2nYVOt0nvwGZqWz/NO8RqRqioPfcWJV9d7mzNo0di2iDntIsV
 59Jb8gqJWY1vlj1yYL91lxJ4radBilhp6inEPJjXhD4OySVQVQGixHIwVzj1/vRMTbdYk34cG
 qNXTanHDn2u4/30mcLT39XWzp5/pPJBfzsvVZhvR4K5u8JmWyj+5pHCvm60hFz/9on7cx2oig
 qnNqa//HXcvrrQt4OEpdM7FfSCqBVw9S+YYldz0j9Ibc1ouDdRNytY74iu/TUt8M56fYPlUVS
 IGTaloxJSHIqIGMQSjeVq1G6iZ5fL0RS+PS3fbL5pFHBlD3o6jWYbrJwjq7LkINzxH60Cw5C1
 dUxT5fHSApE9k2V6LBget880616vOIkCMuOO28eRCDO6Dg+5nmPwL8/M0YNiwd5gCPpJrTXGU
 KS363+Qh6d9/rrvGKsEcwNoi/BB1grxXui4o+d+uztfRL//eTe2Bnl2Cn5PA9SluVf5I/SU/j
 hafsZ+e8xCpWiwplEDC6GjLKS9Y6rcPsOt7vtXEkswx/iEoDzi1LXX/SY7Cn5EiBf0p1Yvdxc
 C3Fwa5HbmQUY9Msukc2L1s4tP8pcAjUoaUcOY7rrPcvDI33w21qkIm2QVV3a6RYENHIdRb3zY
 SeopOZdDjOmv0jSkH1WeHdeVjTFGVZbcy6b1DVh1geeyMoWWmZ1l3VS0ZsLdXKmxl+2g2qLnH
 tvQNTArW11X28e7vLqaeK+YqZKnkN2FBKDDRkWZOvrXvyWFHTKRvpsov9ETFbZeb8tDjH5fkc
 vZpaHNV/3MxzCDWdmtJw06QKB3xXJNvSLAFx6bzsyhoa/M5z+ohOAlvy2JsMWw3aPjM4XANB2
 fDjq5GOmgiwQjfz/xDTB25y674htD5aY4QQ5ZelbyiVTe2o3yRPqiMRQGXp2v8hvkTmZkrRGC
 gKdf3D3ByFmjPfKNDeppG0YnD3LTUSf3UT/CkR+31rGgj5TCndtYJUIMgSTAmYNhSo+wtdD1+
 gHjWNYIYl6oq9foXS1M9OSCriKL2qu1C6csH36tSCbk+rPspwy3LX6D96VQbbTfwFzwaAh02Q
 +t/jC9GwAaqka+bt4mkmTrL1fbuA4Rmv1R1oHDcOUYp1kquN2gE6Vzv5UOKq/VQVPQICtOOMW
 +xtJkfc7J+sGP6kZ08hxc3OvEaHt3f/vj6UMElEG+OYvDPpFR3bkEsUkWNJB7eHK7JKP6Si1s
 Zy2FpQp6cU/g4FtJHshtISw4CBIVVRZkVqSDdHnFu3N1RCN7b/GqQj+vpAFSytPR0PyimNLnC
 sIAmZWWjv0zw6bOjYo844IQcdrAvPZ8oeoyudu0vKmAkbAT4Flt634OP0DyhFJ8Lq2mXjedGF
 dF5XbpumyppOqXYyYI7atjq9PvpdqCWsJjOOt2utR3bExy5r+bh/BoKa9vjd+bCGp5Gt0Tda0
 LXCnBm+bfkY/olK2NqksVRW9fUvcmPs5gNmHQtnpmMse/Gcqk6wC0Lt4CbWJPKyowU7bLTdp3
 rYWD3KzJt5CTIkhUfFExWj9/7aMksEMeUE4SPZnIWXhOzT+OvxGtWU3236d1m3ynLtP/tDTCE
 K+XayNhXt5EYbENhy1K9YsnuOSVB6kSelrGe8PGeqO57XrUN0rcJnhPlXxBtRV4zobRmrOv2/
 x332V+abjsvABBUgSZwHvaEoVqwWN+Q5hZJoEXGLpYNraHNgIeZcUczizXbI6Cp9EmaOEuisH
 sE8SVwXnFtJdzRdDFH8ZzTHqvbk1ylRwbnWjsXa4pCsOiGe6xvTV8WjQa6BEG5YKSLAbKkYHv
 8qDrSj/2puSdvKzei2XhYpeEqpiKAfNiUs75SWgeX6afhVmc2cRxP8Z+jWALxbg28M3t5biNY
 myk8lpbpkNxLUFO9tsps4C1Ntevey/Wo/bih2Pgf1yBu+DORMp5jLM/hFxjqAk4zPXcP1xBU+
 DJjfXj7h2b0A2z9dIFSakbTejSFIfoGiO/dPcif+9dnRc2JzXndyVfgLKOjilo45DCX6ooLR3
 JNgS3spuXIgIepulRQwda74t4SZSB/Y4Bpp4Bv3ghXPjGeehABrJb0yyjHoCiFiDwRLfZ5H2Z
 IXZTJCBPWtW9JXodk/h2eXrRATfiPCE/Os9q5RMhWXhozgOCYnZoKlurCSjckVehHkOnI5daS
 TGR7IoFbse0psKkkeBFaMfH76ISQLAwvKPlnD8mKqMo7UtCDG+lK+wEIKzvWfWr8CRxpq8TPr
 Wx1rpWuw0erBRNOZyh68K/SDHN2nAJiKX7ox5uqBWPhQ/ImwCYdEkPS/SeAAd7/5II4totHDU
 b+3d065/ka3n0Dnny+QTPxa63VM8KvczYsFzUKKQQU1kP72l4PsDBmjFUg6R+5ynAgVDJEVAi
 g633+P8uuNwwIg5eisuyNU3ROd+Xbe5H1kWzNFurwYHqy1f6D75vZgh/MjKCHQ7nJfDXDuQIw
 MgaprUJSI9/Qbp6ABLjNzHB61/Dc5CMnhYIWJ6WKnmFXbOI+jhp/6FRvpXkD/AKUqsqcc7uyn
 sKI3YumKJLXw1n2jyqEakP454IHmTrF1ez4fbRgd91WSA8j3A725nXZZSz7/iITitKj0FcZWS
 ohTcI0hI+6paOYLDde0mXimMnGSqT3SU/uVgwhOpUGXDHuaUzOHIEZRO8L7U+ybHwwh6N6gHy
 oFDR/Zl+4uMHLVBzIjum5xet7UFb6ieyERffE5Q0BiwhonuiBkkEsE6309XIyOCHT064cC+u3
 ETXr/2fEQH/Hqhwbm0pPDTjB276c1IdGBRS/CUq+dDU79oX3YRf6Cn1I5HT/Y7qAMvxtwZCEb
 NIs0z1x9kjW+c/nkhTxOGaBFZV8ENSKDMMme1pytqRE+lWoKBKbTBIwaXV9ccmfcNLDJXI9XR
 3uZ96PP8y9tIWtQRO2KJG6/fZ7n+Wc9JwLjeAqWHSSPgLSG/9Alu6jly94vZRxZifW0Nr9r0j
 4d3mE7lp08MI4gUfaFqJX8sylSQHQvKUWiY2vhte46Y8VsuCNFdCIaMqk6P0uIQ30hqbX2Ua2
 iOarp5H4L40p+VqJBZyGakJpUS9RuH+mYpdcTeRziTlULmmfn5+tYYPPNhLhILXH9af1XePM4
 QVqeT2ahiR0oCMMOThQqvsXoSS1ZS2PFzrVBzjACNMbL+hs0oFzOHtFA4n1hZ0C6S2MOuVVg+
 T/gFIqxX1EiIhw75k/kcJiWVHTN2FsFPGxGpRfVh7kU9w+d4MUJ9tlHGMolapZKQXXPAbeoO8
 iGHpTfhEykWmeJox0wefS0cNqIBN2EDMBrcTJrZg1xfRrjEL0iHpJf71glWfxTPbQqNzICeK1
 MrJnWhPvZROqZfCCpXo6ppePl71JzphtnTw1PZ8ZreHj3rb8oR4Qwpy38cm6Ia8BCvXIcf67M
 t/DJZuxt2OvhQ8lyyKI/9o2jQduLIoE3RY/XDc+8KozDbiIHnbCH+TwPBUnRpK0IY5CmVrc01
 logYs/d1bFHZUxizztHxW6D5COIahHSInlh4GIDGS0KexAEyy8xjZiuESbJV7jtA904MrkaU8
 9Jrte41fMk0s0T9SifuIKt8Uklx3nE+Uo1jtpnR9v29KE5EYu9NjOClUtgt01HKnqwUuP5k/M
 +xUnNjfXo0a58+uBGsc9emdKf+BOXg8aVptMFrPGD7yMWwt59JOdG97kJrNQltqZW0oois/jc
 PWEdq//5KQDcR1DpC16udlSipdL6U3E49ZNsOrEAwTY7eoYlhC2Um45lO6veJBw+9h5M92C5n
 seI4ExmUT1GcXfjiDgJssE1cW9/kyTuEu86fdQYsjNhC3J+RmtqZ4Cv/Sx9NLshWe2QLplqLP
 9wUY4/yf6rAKmAY3pc6TdMoLiE3e64K/+IX1JWtmQV+J9N8gnHavgXgN0DerUfRGAVzYPZ00O
 ixtQZWXAuXH4UWoHJvAmutFh5NiDWh3zGO0nj2W6PDJ3N/zWEEy9kEoF+QwhP6rUAK/SNpXvM
 81xizg5aZ2fPGeLxuVlqNl5gMC2p0rA7rH4VR3kjhixAYa4UIZ2kb0Vks33/sYj5l98pIfNxc
 /jGV5AWkE2KAcP8QDxsJWOaIDVqZ14Bt2m8d26UWafcMC+oEK4F6LdWAcizLlFtr8U/dsffCP
 Ex4mC1EMf4eFZ19I7LYBWhXDkME+9ZPIE7dfYcXaKxKJLbeym6AUuSqZ2tvQfOIRpzbKUVn4K
 HjEs8cZG+Eat3On+Ot3GEx8uT4cze+0IFInkcUlzul6YqF94FU/7M6YBIZKHUR6QoLLCKEy5I
 TfZHznTPgE1ujNz8zWsGdTYuc+pWnK4jd4nV1G2RSUGzDOJ6G9xMm5G6aFvV/l2LlgB+1nN4T
 aNfds8gq9aPVPxgvL7uQZGMNW9ShgkLCH+ONwFxceBsOHqLQL/EZlxsIoJlOhBj4bjSwbhWnm
 YNwoH0T3oJzKvkU12hrJrV8/wt8nZpVfJ8dxSUx0bC/Dx4id7X6fyHOQtT8Y8K4OR/pmz2f9c
 R4qrEjx9wCZnrV2OVg65uQrdtS08Nze7yLuBk8nxSlQw1Dc4ip3Ojh9S7JjAcd69lLl9mbVNS
 MEXQCN07iB+FmL/CouLqZwAnUuLj82TzJAvHriwJ1+I3mq5q/D9DO31Crds5U1pjkWlYFSWMz
 IRq80Q7NnjQh3iIFjz8C0pcyzDx99btQiVitelinh/nYbQwUdRnHf08InyE0IesX64s0G9NCR
 gugIXXJQkCyxSksUQ8z5v5RA0xDla62qTcKJRtnD3zZhs/c5JvbfZ2Y0hGDtTQUM/9UYpnlWK
 Nm4NUGlHJk/0/XeuKhfZE6dKzbzbQEV/sjKjADhVcpML7tDdiqpFlXr1cXyGzdTSDAryvL2iD
 U/rwvXUODTbbo2de4THVkE/VYjbtwpWr+ELZu0LFPTZCA2A7Ed2XZ87+hE6c73nCwdc1cqc8P
 WThOHN1OBx4TeHsPDKsbTiJHNG4Bkw0IXPeyN6q308NovlJ3/h5If+yBQtDqJQDZ7JN2xEIHb
 qJiDFQzHfU0o8zwinxi4+piogBhO5lhAK2uTrHN/9RV6qS/p3XBHDPDnjUgwTU9pzrglRI2oG
 9fdwW96KY5OQIk7egHRctEkzraI/4eopItvRjguCHwleVLTY4bFxO+4AK2GJiFSfG9+16Vsbz
 iKK5AraTQ6G1bsOoV3j3eZicedZ0obUnrWWXuYYxmRXr92/p+VzQxlZcV0dNnnKaBWHo5S5JF
 Sdj8F6ZQtXd5GUn3iyPU+RYbGMKaHYOzz+c9YtawQ++kB7ODasiyTTRHUjQmP1gkKO0CDt3ji
 v12PCXgU9+sCVI+Y+AzVDHWA8GhoVMaG9ClhsMGoCBG/JFO4PfWgRt6sLd6BFYLyaIhvVe3QI
 /WwePuV2o97OXobnTU24uwtsRI/4g8C0cxM26DbP6mE05VesdnKz4UWw8AVM+B8GDjTEPSrZV
 HhdEiVYoyOhzQvMf3vX/EbTzZln3BYkQhUptH0sDYeFbv67JzDX1L0rfu8Fto0Pyrz2
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-10.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Takashi,

I independently reviewed this and reached the same conclusion: the fix is
correct and minimal. I see it already landed on master as 0d3ea0ee653f
(with Mark's Reviewed-by), so it's kind of a belated review.

On Mon, 3 Aug 2026, Takashi Yano wrote:

> the commit 524d75ff7398 ("Cygwin: open: Unlock fdtab before open_
> with_arch()") introduced a bug that fdtab lock was not unlocked
> when new fd cannot be allocated due to an error.

Worth restating how much this matters, because the leaked lock is not
fd-table-local. The dtable lock acquires and releases
`lock_process::locker`, a process-wide recursive muto that also guards
`fork`, exec/spawn, `dup`, and every `open` and `close`. So the pre-fix
code let the owning thread hold it forever, turning a transient
out-of-descriptors failure (`EMFILE`) into a permanent, process-wide
deadlock. That is why it is a showstopper even though the trigger is rare.

> This patch adds missing unlock for fdtab lock on error.
>=20
> Fixes: 524d75ff7398 ("Cygwin: open: Unlock fdtab before open_with_arch()=
")
> Suggested-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> Reviewed-by:
> ---
>  winsup/cygwin/syscalls.cc | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/winsup/cygwin/syscalls.cc b/winsup/cygwin/syscalls.cc
> index e3ba8c65c..8373482e9 100644
> --- a/winsup/cygwin/syscalls.cc
> +++ b/winsup/cygwin/syscalls.cc
> @@ -1554,7 +1554,10 @@ open (const char *unix_path, int flags, ...)
>        cygheap->fdtab.lock();
>        fd =3D cygheap->fdtab.find_unused_handle ();
>        if (fd < 0)
> -	__leave;		/* errno already set */
> +	{
> +	  cygheap->fdtab.unlock();
> +	  __leave;		/* errno already set */
> +	}

This is safe and addresses the issue. At that early exit the lock is
unconditionally still held: neither `find_unused_handle()` nor `extend()`
touches it; they just return a negative value on failure. So exactly one
unlock is correct, with no risk of a double-release.

The rest of the error handling stays sound. The return value is still
negative and the reserved index is still negative, so the end-of-function
cleanup (which only runs for a non-negative index) is correctly skipped,
while the built `fhandler` is still freed. And this is the only early exit
between the lock and its matching unlock.

Incidentally, the version that landed differs from the posted hunk in
exactly one whitespace detail: the new call is written
`cygheap->fdtab.unlock ();` with a space before the parenthesis (GNU
style). No functional difference.

To reiterate the scope from the v2 discussion: this addresses the first of
the two follow-ups, releasing the lock when no descriptor is available.

For the second item, the reserved-marker design so that a
reserved-but-not-yet-open descriptor does not look fully open to the rest
of the fd table, you sent two alternative patches, which I will review
next.

Ciao,
Johannes

>        cygheap->fdtab[fd] =3D fh; /* tentative setting to mark as used *=
/
>        cygheap->fdtab.unlock();
> =20
> --=20
> 2.51.0
>=20
>=20
