Return-Path: <SRS0=3N9S=II=gmx.de=Johannes.Schindelin@sourceware.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	by sourceware.org (Postfix) with ESMTPS id 36E9B4BA23DC
	for <cygwin-patches@cygwin.com>; Sun, 18 Oct 2026 15:08:28 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 36E9B4BA23DC
Authentication-Results: sourceware.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 36E9B4BA23DC
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=212.227.15.18
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1792336108; cv=none;
	b=QYalaExK8YFhoekNpTFTnqtMR4BuB35iShDoeE5ebYNWFwF8tpItxXox5iS9UpuHirvC5JZy02XarpUw/y5xxaZFJZSmJWO8nedUGFhMbrJ1E4PkkErt2hCwqCl+hx5gXVT5wI8obSPYNmoLUhnmNn7NgF97SWkgntAlvPOmqhU=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1792336108; c=relaxed/simple;
	bh=FZByC2Fi/FMSKFWTlX+1wpylHvdIiAXk4xbKDDjINso=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=r+IGXa52mtvyCjgQHmpuc+Nl6QqlZHTLgVp3G6kQClarPJ/qE0tAWo3++08nucB1OpYZebwZzlO5m4R+9kmSQmvaiW2GW4qqXkzJl/hxSvR+3D7t1v3nNdCLch51t3uy0DQ6Rmvu32MKGPAp8NCrGEizE0dG0MEzMCYfWHgPSI8=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=K23hh4yJ
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 36E9B4BA23DC
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=K23hh4yJ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1792336106; x=1792940906;
	i=johannes.schindelin@gmx.de;
	bh=eijgYwQ2e8pBqpOT3qkpAZmmnQNxWoFZX38HLEmdcfE=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=K23hh4yJ694toovylwCoVaCdsiANTlKegGZEF1wqTeYgxAKOTu2DHYLpu7/vtsu5
	 uyEj68rnLJLxupnrhaYft7pFYm5lE847vzQvNWfMpTy48rqj4Sq/jMHrgALACcpDr
	 keGzmfvaZLY3hdW6v/YGMKPLG74tZ2qY+hIIY4QevlZHYE2fNTOxsDyg5GNEiwLvt
	 aHTHvOo97YJITxSZQzwImUw5IddfrU6UKda85XeHUlkTBlblpZdZq59Jk7FX7pGSV
	 DjVS8tZb8kTcfJqV4YAaJ3PYXXtMc+gFfjvJaQI855ssrOrrTV3CzAN6E4pJtmXGA
	 j3pUN1RRZ9UUtP7cBg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N6siz-1wXmK52lcV-00yUnR; Sun, 18
 Oct 2026 17:08:26 +0200
Date: Sun, 18 Oct 2026 17:08:25 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Takashi Yano <takashi.yano@nifty.ne.jp>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2 0/5] Cygwin: pty: preserve terminal replies after PTY
 adoption
In-Reply-To: <20261017152213.9394289b21159f4c56815788@nifty.ne.jp>
Message-ID: <a7e10148-e530-5218-4978-a02b61e47eb1@gmx.de>
References: <pull.10.cygwin.1789302605264.gitgitgadget@gmail.com> <pull.10.v2.cygwin.1792050298.gitgitgadget@gmail.com> <20261017152213.9394289b21159f4c56815788@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Provags-ID: V03:K1:S4i/PvqlcSXrSI0rXPWepD8UkF1lOVoN2bkESdnKbcEkz2WwLF6
 DzbOMRh9vke6tbC4dtzz+L9MDm6LSI1p6ghz94wMAtBzAZmSLUJGH4BHI0C/L5hJMseDTlr
 FO1olI2OaI9VIr3c6IL6rHJVIPUywn8zXOwzdu1/9k25oq3LaQHHGtou0eSKHUq7Ato3aJf
 7s2oT20hnlfzLn8RAgMZg==
UI-OutboundReport: notjunk:1;M01:P0:HJ5weGEbiu0=;jZ0fhJGS+5Xx2CNdcIiZf8rXtr2
 yG9LpTxV32iUBHHVCbJhCvMS+GmrMfdqlbtUnRi0/K4gsVwA0lAs76oaQqi1Azccqb+jKbvg5
 jBNpLKSu0xERrBKBEL3xqwgSLVgwG3MQppQGgNzYNYLHvF3MIYXVOpS8xfY8TmhvD7PCzsjyG
 YqlJtmyBNg7nmww1uLeCEYU8Y1t2Xrf+GnqxMReD/ePwbk9V5SB3OfwKRbQmbN6olmrCSu8tS
 t220JjFeh3SkXfBtnp6H0Kro/iaU+PWuyDEDNqu7vHvnM2KF1Gmdn6AWIuxiSGceZIhMsjkd8
 ERDHQEXTmJsDwRuD0jk1hag0JWLgwCQGRCCX1eDuA+F+LXxx8q0+EhtCkaubZxd0gYgAGKflq
 Vy7XGE3rWSlmGrkQXXWG7xkfBHAu82GQVmU8KEDF5gwW/UEkZQCj2zqLY6CDFad54bX55t004
 l/777iCqGtxAwYtxqPNaHXamw68X8Uh/uINRzfep85C9nW6odE5LuG/CpvRU0rsVuGLhdB06y
 jjMyo2sVyrZvvZjhaL31mn+b5SEO3UwFTi/bgfLh/upX2n7hq/19ZPQD7wkWrgM0rMsS2X8Lz
 thPA4VM7yNT5lZAtnr+X4vt2wd81SMi01Fz8nfVvoUq+vtN3v3IrVit2D+ZHvDazD6WpNH7Ky
 Hsr0Q3Y3GtMsm0jW79jfzPsgZmbY/E7n5olG8tAahBxRceUmjFgX1R+X9TUOt8dpdgqkqSbuJ
 zOHS+L30QW4kxnZqohg2ZDUCR2QwlICjz36m6lT9wR72LYbzTJzmVigE25I8gUbStKTlXkRqh
 pG8DP4v4KGroHjAIlsn8AmFIVCrbFSPw7MxIqaQMSB4j2b08VJFBVSIHaUUltYqlpqLEh5KOW
 zuLKEXr03Ii+j8n3Bf9xs+XYX2qux8xysZIXLXzVPlsTWjORb5IT0Y/jiZcvsiMHL3h8w+gjG
 KuXlfrxVgitnrj9mJnFrx3tqcTabdBGUfJTOTaaiKeYrWZ1WCs57ThhMQJvYM2tZmkw5zj4II
 0u62Ra6hWG23laQ+yPQFuuDmBRoqrwrCLCTbhI3TCrHkokf8Gp136T9aMnBnESASmo9KztBAS
 p2k5F7U0JwL8PabrzyItIJjNeHMSvTGK6CRICQEM7LfHEOdWsmg3c5rWwhXOPfkMb3A4gHUVp
 XxJm9V0rql9P/e7+fKxnsV/SXEB+lTBlE9DYiLo/5QD9Ah0AFSRIIKIX2qMPLG1PfT/xYtgYs
 +VzmUC9paNnwNcM6OgQNqIuj9tAbKQ+/mHwn5FJnlg6TCyg8AcVEYMNySw07aVIyphO1bCaw7
 i1ptbV1hEiFYiPNoLwdoGZ8txQVir0DdDM8RIoAnfS+ezewUq98ZYKnUJ2KefR/UPjurgXsnp
 xNkouvzJoX1Vcx4Qp1L6mbyD4xC4otndeo2nahN4h/YVUxMiJy8rlQ5wqJyiPrP+ILDZFR02m
 hDss45MwYm/Bv3ifQpGpoA4lMn9TidM4bWBD63DJfmXQWstdpscNOrcGgK2nC1s4ENJROSOBk
 1SzrObOv6m4xeEPcl9iU3GXKnjcBprOk8cMh+fqtngwczJE+noksAZK//GVJunbD5w4p2qA+W
 pNv8dzs3ghDXKRueJ+SWtvVvfMm0VFs1Lsdnzz+GA+nRTd454LssLPApVdsK3gM2lEVb34+mJ
 M7Af17qDOsCvBX2x/Ycv//qMHhUj8vtKmmyF+6i/QeARbJ6I9DttdCwVkO9cHU01n7XOYsLwS
 M+IQ0Z0rGThUHEzqJdAoep8CA94DLm7NAE0J5ioZabamWMMtVtZlbNpkVf4DCdjlqKwqjyeBv
 l6s+7w+sgWxl7cqK6vuf5WH7wkI5D1HLXofqgxh1nGOES5xek8W/9qvIMYGFVdyP5/UcTEZJL
 omsFYe3EJ7Qm6o5gsswfQCzAfgx91fJCBWxj7tQFDvgHKKhgNahYJCPT0YVkhLNdtOghcXplp
 WGdheJ27kijleqZQH5PGDBqCL5zRblrBGTCg/Zay2eGKhmUobW4t67QRw9Qx2a3OpTdvcMfnx
 7sG5He9hZ9r8k9vlLVu6FqKg4gBMwXeb7qyRjK1pqJTd6wCG9EGvfSZ6stXdVmj3hTBBtDYfA
 9xz947NCA4xARUcwAPyBp69wGBUKKScEgReTMHKvwdKUqTI9juEpqkrednfTNX/TsALfy7w+x
 BJraZzhtG+EDPx3Z9/XDGeH7OT5iK7BBJSa/8yyg3pP4AzlBI5xKSep5J5ZZBkarmAgPf9z9E
 fQ/aSI+2+PAPvUbweyT64YtiA7Jc4f4tW7udaaMWnSe2/c247CUu4Z5j6bWqG9bJ1uF39eAq4
 wTPhQf4D3ghVau4eRqDiJw7yWC9HZ9ILozjpGOt7ybDtTIokrs/ZpG4CkokUxnmOE1D3DQfBg
 quBiBt+IA32ytrZFu8MlPWwDnU6QVp72GtRsCE/IcI5jATnGMq6CLmH2+G8nTLzCn7Nmyq9FF
 gtcCbUbk29DZb603zSV58Lc596wNt3ghjw3bY/OomxZQHtkUHJ+rJiNjIA318SiAo5+31pA5+
 hVH9ggjjsFim+vvD01UBjoVgAJgmkGSK+QX4UzKLRN3ndLHoSg8jkOhM6C8md2R30rFSuy50J
 6OfYE/ugYuOWFRpdoHbi5j5R2pMXQ/HdkPxR1hKKx0yGIram16MVhxxjSzyCpptxw1eNap52+
 HXH/fj/6o0j/kEyVWQQZ84GM6D3lsCyr0wHe8PKy4OqifOVnDg6Ao9FaMp2C0HbbcbK0dpS5j
 wjGGplokECAfHOSaeG2M5H6chGEau43f4c3WQpmHx4+KPscheAZhuJq0C2BUnRjFD1NozvKsy
 UlsOIQ3H1GLN551RYbeOhdi19aXLdBGZutaP9n43zPyxz+YxUuVzCNY55X4DrtanqdqIXGJ/G
 qcoQvT+wE/KIqWV71uTDcFrLJ/0EkncJbLU3MlM/iMOGzo6LmjOAPDPFkF0Ms1HmBkYVi/WVX
 HrldRQSO5ZidTFnV86gBDdF6pN1Q3jMrLb/qmkPZXTFiz1AJ4ciXHP21paXQNuy8HxHzinuxd
 uqYaZUB4JFnfdRUxx15b/IyVA/7sxvQqTV3KQJfAeMtf3XYwJ8Zf8MgpPCC6wtt+TLxtMI75e
 zwWPNPxa9g+cx9+Y/5D0/F+LuMDbMYo7E3XT24DK/fDfHeoRSs+Cr08QyI/VEnWAnW55+Qg2G
 klLdU3zW/mOSe9ML27Bg5hln0R7lJH+xcOR34vvyUICwIIsTJu29LYkgYWMM1Sr0lv9gahN5T
 s9ch6we2ZXoxh6FHPGUVLKNrpMqF90EgKTsvjD44h31Bq8/5a492McuZIqEi8MjAvsX0kMBLt
 6oBj1BbZ/yvC+vG40iwe9rPxSMuSSlsW89XI1+MnMVmP3Cpq42qKYll8pwcaWS2/IiJWvcFk+
 knIM+td/Y3jaGk7KyhCsGpAwDUD8vjkZjeOop45VJbEW55MSERiOHx1r/AYCwfdrktcxnxGSt
 ufZK8ZMeQHHGc3ggr/vrCiaoRDuim34S/drhBwKcDrNxxNjP1SKtTsfPl6sxW5OX1B/gDP9Im
 8oQMK1IXqIY1Nkhi1hqm8Sp1uWXIkeuIza7ExMPErEqCu3vATcOT9LEtxis4PUb+dwTuFFGZV
 0k3iKT6nsnwxGY9B/unaAWpaUFpy+5bwo2WMi4WLDWaKmFGwejEUn8/GA+GUIPP5uOzlYKfbq
 yFgc/TCcEuEeMbEjfaDWA8KdPTP0K7xHuGfxbicoDq7IJ77920WM6COKUwixudUFqowV4KaXI
 2jeCLdA9vLnT4I7QkGZ0PnygnASR9PoyiFqaFNPJ1wzmhTJH1xGX1wow0N9ofLHK96UqQhgnV
 +kASrFRMcUd9GyisxgwTqnhj+IK3kXgtesDgK5qFVXqwc7KAKIC8JRyFD8T2YQa2FBNG+uCS0
 l6IH5QUw3hmmQgLg4441vCNByEeVK6VdQQhx15U/h1I1ksrB3tl7LiGRL/Xo7Oi75pL3LVeTF
 7xDkNL3/5p79uTfLIr3DeftyaCI50KMt6aTNfYURZSeYm/6yaSTtwWaGTHSz5dJ3KC04/cn1Z
 +YXaRyrDBHkwlAWdBm7VmA5SIA/qcOo1PGevGwTbpxQnI816r7/BhgVy3+Tb46AYiq5m+3h42
 y8hK9v7PKY8x28k3/XJ8Sg4dE9X8krL7q4Pd7Bspl53VprVxk977IeNog0E+BfsQfKsyJ2rwq
 lRroBOdcFVJR8qJwxtmNXhYpLwCSCBqlJQYN/JWv/3D+/dOK05nupS0roFJsDQw4sOh/N3TOA
 054sKwLyLL1tUznWr4KArZRRUM7GWf6FwC3GdgyfOVUUw22Htma5S9OqARPI+oL6rFVkMvPix
 k/LmE9mjGqHjmuJXHmY9Nwe9cckiY1c55OJZK0nkBMntPpffnheYGW9gR6Bzl1BkS+QgV7R6G
 jUF4NKbZ27l6x0Ld6s18qPxobKDy6mrU2yWzYtnssT22Yb4pTEUXggUnoRLN7MsU6wyBJTSOB
 iUCr0Py0qGKgxz6cFiy6O8Le8/ayX093m6h7cfxaYFJuFFBeLk7JIT099/eS0vHKMeYvWEjRg
 0dyhAOsnZrmDxgZTxymG8iaUP9w4GR65qb6lEeqkJ5r/sR7TCdsp4+3sQIzOcm6OP6akyp2Xc
 3O7TFPcbDYBCTTCECVdtWDxqzjL7MHliIuOTx5NaQ8dzMurdLkYSyTSFNg9KooG8+70U2oWyd
 SKxemMAitQfavtqKeIELnTpROSMOs1OkahS8gfZKJs1ti5ClQ9xFqyH9ImggmdaMh5wwV75YG
 HVVwxsNHrBFMQ43WaSbwgc4o/R8MFLoti6FTKxVi3ru3T8wUdWQvNqlu6waoN12G+6zxFpswC
 hg84gnjEN346WdWn0fpw7/5SknS2ueNI4Amv7b/mz0cFirGKcwb/HaZF2x8ByPMoFk77jUfLF
 Ue56dhlp8FdXpffKOypv1pfvCrvMNcvwFSNMvJzsCsANOYmk4yF9cTGMnuLQswj4iSaYj3IE7
 yPxGl/lb/dYzIFgNJqLgMcCYhPZqA8roTDMQPTbHGRPctgFTs/0twlt1WTks0ytP40Kh8JjFI
 y40ZURdNU4UyPimZMtLUBlyfAp7eer308DU+cDDtdcZtVLkgl9d2PWuW7r+4uVrXhyqFTSvC+
 pC3iUVl7SUikewCuQWx6ek98yIsT7/PdM4BAfgG8+dHZYYwJrb5qTvGDXi9z0IfeJ/50rrZbe
 N/UHenfh+BhpbQPkes9qd7q06WRtMcdU4y+7uYhgGfg8R3wz3yMw09faaG/nsTCCrpyGVvRDN
 C/jb5uFaM0O6I4J3msVA/aKS/diZ+jt8LK7AffR+Cqfo+/cUe5baZn9pSll3Sa3Y7K7AlzxLb
 g4Xu+TMSmjyzKcHAFPF2ybi57OxU27BB/SOq+0J2ZUJbftK6aalrBlOg7LDQQ1RNxwMbKudzs
 BP7pw2799Zn1ybsPJeNtl3um51KSEAmwbVojc4TLc2ai6sJ2a7420iWWzzKm5PAdVkkYwK9cG
 2diYS4K01lVIDQ07Gp/2hsFdLnFxNe61FAtVoBVKuPydelyu8/hRnT9deRC7UXFOjnF9VuPQC
 FY6ZRjcIqMdLb4ISFDozXh7X8y+11KoI6dPOFmZX6wm/SWy4VSSxHq71+fzHMQEbxPFk/3Zvx
 DLTinDbajcLcVeV8p9BUploqVg0S0nmiFkAX3xhIKCFvxijEJd9axrDQX+MfvzfZ34HI9YooE
 dj9B81F13x5YHhO8/CrSG4pjTDXRWi5FDhpfpSN+CoWu9JBpFkiieRYNi9CBHqIH22g97RDId
 Vm1nQJPGQOlxxXcoqf38ffb+QvVyiRbk6D/R35xOPgnOAnZf6hvSPUc04rIyyy1K/+BFvnF+m
 pUwWeiXgz1Eof0eI8I/ZpA8PC2oZsTYVvnGiB3lTKLY+lRmmrZ9l+wu9nazMxttBtmYie/4g7
 RgZxHjyknxnrbv3vl8kcL9k8u8x9uoxLmOm7+zgXpIIcvGs1Id43n5J/lfqnmJSUo5Gl7ArxP
 lVSMDIN5zgDDVkT0LxG6GwjzY/sCsiAub9dVZW49FLyjjN+BjfEdoXy2Chs9q2Sy7Nt12rPwa
 Ml/q26LMpAgVfmNS4SAtfd8KjOWP0uouXKNsehWZH68vU9Dw5Ltz1tPOyptcQ0XVuciepaH2b
 GgXCTElIyx7GFwpgIsmm1NDWVYEF1G1WbuHIEADxrz2NOc32BYTXpfgr4EmliIxW5ystN4NQy
 rLnoMiSS+15rZ1y9MGDMKJylA4TuqOgLdmHNF27YRbvpVtmzFqRShpL/gBq1YlIvzN/eZg8EC
 eEklD2YXyLXqrzaQpiUINMaOvq80dzsJ0Vb5RHLuCoxByNInvBGt7GWEVbbgIFcl3Bc+CsIVG
 8gI4doZ6IlTDo+/+XK39mFclLZu/KM8Lzed5SDjb6qHfgBFC7psh17U0C2SMvpf1A3V9Y/69U
 5nwmXTe7T6iGk03Nc65C0tUvCVYg7/Vbbufxvk6Rno5vwIPQBqeI27qk0aJe78Q/RTR2DOgbP
 nrM9YhuRRF/mjKVwGalaiEDpAYfzuQ4/HkOGgg1teH7F0uUcPZKiFYRP/7oDwsj59UmbzL7Mg
 NlbMnvPmsOm8oQA2rEUWtXHd88LSpp0msTuuMNmS53iaYgyvIIZyJALNsERGxZvh5Snuyfphy
 eK+h/BrZBwj40eSL21qD29B1YW0vL3KlrJn1WQqNZtcsaOMkFyKLFOp3P9jLzLgq9G1WrA90i
 B5MNW24SLZI5mjCdNAglXAiw2NPicbjD
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-10.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Takashi,

thank you for the review!

On Sat, 17 Oct 2026, Takashi Yano wrote:

> Two things.
> (1) This patch series cannot be applied git master cleanly.

Right. Those are only mechanical merge conflicts, though. I pushed a
rebased version of v3 to
https://github.com/dscho/cygwin/pull/new/fix-vim-terminal-replies-for-cygm=
aster,
and here is the range-diff:

=2D- snip --
1:  8a6255016b ! 1:  1e8ff0df6b Cygwin: pty: restore foreground input rout=
ing after exec
    @@ winsup/cygwin/fhandler/pty.cc: fhandler_pty_slave::replace_nat_hand=
les (HANDLE n
    =20
      ## winsup/cygwin/local_includes/fhandler.h ##
     @@ winsup/cygwin/local_includes/fhandler.h: class fhandler_pty_slave:=
 public fhandler_pty_common
    -   void setpgid_aux (pid_t pid);
        static void release_ownership_of_nat_pipe (tty *ttyp, fhandler_ter=
mios *fh);
        void replace_nat_handles (HANDLE new_input, HANDLE new_output);
    +   void req_fixup_pcon_state (void);
     +  void fixup_input_state_for_cygwin_app (void);
      };
     =20
2:  ebf384575c ! 2:  9cd61e3529 Cygwin: testsuite: allow cygrun without th=
e testing namespace
    @@ winsup/testsuite/cygrun.c: main (int argc, char **argv)
      ## winsup/testsuite/cygrun.sh ##
     @@ winsup/testsuite/cygrun.sh: then
          windows_runtime_root=3D$(cygpath -m $runtime_root)
    -     $cygrun "$exe -v -cygwin $windows_runtime_root/cygwin1.dll"
    +     $mingwtestdir/cygrun "$exe -v -cygwin $windows_runtime_root/cygw=
in1.dll"
      else
    --    cygdrop $cygrun $exe
    +-    cygdrop $mingwtestdir/cygrun $exe
     +    # Executables beside their private DLL need no extra testing nam=
espace.
     +    case "$exe" in
     +        testinst/bin/*|./testinst/bin/*) set -- -notesting "$exe" ;;
     +        *) set -- "$exe" ;;
     +    esac
    -+    cygdrop "$cygrun" "$@"
    ++    cygdrop "$mingwtestdir/cygrun" "$@"
      fi
3:  cceb823afd ! 3:  ddc225f60e Cygwin: testsuite: cover foreground PTY in=
put recovery after exec
    @@ winsup/testsuite/.gitattributes (new)
      ## winsup/testsuite/Makefile.am ##
     @@ winsup/testsuite/Makefile.am: clean-local:
     =20
    - if CROSS_BOOTSTRAP
    + if MINGW_PROGS
      SUBDIRS =3D mingw
     +check_PROGRAMS +=3D testinst/bin/pty-background-native
     +testinst_bin_pty_background_native_SOURCES =3D \
    @@ winsup/testsuite/mingw/Makefile.am: override CC =3D @MINGW_CC@
      override CXX =3D @MINGW_CXX@
      AM_CPPFLAGS =3D
     =20
    --noinst_PROGRAMS =3D cygrun cygload
    -+noinst_PROGRAMS =3D cygrun cygload pty-native-input
    +-noinst_PROGRAMS =3D cygrun cygload winchild
    ++noinst_PROGRAMS =3D cygrun cygload winchild pty-native-input
     =20
      cygrun_SOURCES =3D \
      	../cygrun.c
    -@@ winsup/testsuite/mingw/Makefile.am: cygrun_SOURCES =3D \
    - cygload_SOURCES =3D \
    - 	../winsup.api/cygload.cc
    - cygload_LDFLAGS=3D-static -Wl,-e,cygloadCRTStartup
    +@@ winsup/testsuite/mingw/Makefile.am: winchild_SOURCES =3D \
    + 	../winsup.api/posix_spawn/winchild.c
    + winchild_LDFLAGS=3D-municode
    + winchild_LDADD=3D-lntdll
     +
     +pty_native_input_SOURCES =3D \
     +	pty-native-input.c
4:  2b13ec62fc =3D 4:  09e7bbe46c Cygwin: pty: recover input for children =
of native programs
5:  cdd3d9ce99 =3D 5:  f193c4cd45 Cygwin: testsuite: cover PTY input recov=
ery with a native parent
6:  4469693b51 =3D 6:  d89eb54766 Cygwin: testsuite: cover queued native i=
nput with pcon disabled
=2D- snap --

> (2) Typeahead input is broken without pseudo console enabled
>     with this patch series.
>       1. Run `env CYGWIN=3Ddisable_pcn script`
>       2. Run `cmd`
>       3. Run `sleep 10`
>       4. Type ps<enter>ps<enter> while sleeping.
>     The the second `ps` will not be executed in cmd.
>=20
> Regarding (2), I think we have two options.
>=20
> (a) Add an extra fix such as:
> diff --git a/winsup/cygwin/fhandler/pty.cc b/winsup/cygwin/fhandler/pty.=
cc
> index 294bf8007..8f3b14327 100644
> --- a/winsup/cygwin/fhandler/pty.cc
> +++ b/winsup/cygwin/fhandler/pty.cc
> @@ -1286,8 +1286,23 @@ fhandler_pty_slave::cleanup ()
>    while (arch->num_reader)
>      mask_switch_to_nat_pipe (false, false);
> =20
> -  if (get_ttyp ()->pcon_activated && get_ttyp ()->getpgid () =3D=3D mys=
elf->pgid)
> -    req_fixup_pcon_state ();
> +  if (get_ttyp ()->getpgid () =3D=3D myself->pgid)
> +    {
> +      if (get_ttyp ()->pcon_activated)
> +	req_fixup_pcon_state ();
> +      else if (get_ttyp ()->switch_to_nat_pipe)
> +	{
> +	  WaitForSingleObject (input_mutex, mutex_timeout);
> +	  if (get_ttyp ()->pty_input_state_eq (tty::to_cyg))
> +	    {
> +	      acquire_attach_mutex (mutex_timeout);
> +	      transfer_input (tty::to_nat, get_handle (), get_ttyp (),
> +			      input_available_event, input_transferred_to_cyg);
> +	      release_attach_mutex ();
> +	    }
> +	  ReleaseMutex (input_mutex);
> +	}
> +    }
> =20
>    /* This used to always call fhandler_pty_common::close when we were e=
xecing
>       but that caused multiple closes of the handles associated with thi=
s pty.
>=20
> (b) Call fixup_input_state_for_cygwin_app() only when pcon_activated
>     in fixup_after_exi() and post_open_setup().
>=20
> What do you think?

Excellent feedback, I had completely missed that. I went for option (b),
and extended the test cases to cover this scenario, too.

Thank you!
Johannes
