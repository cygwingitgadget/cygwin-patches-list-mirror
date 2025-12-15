Return-Path: <SRS0=Ov4U=6V=gmx.de=johannes.schindelin@sourceware.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	by sourceware.org (Postfix) with ESMTPS id DBA344BA2E07;
	Mon, 15 Dec 2025 15:40:41 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org DBA344BA2E07
Authentication-Results: sourceware.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org DBA344BA2E07
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=212.227.17.20
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1765813242; cv=none;
	b=B82NsANkEwvn69ptY6VCOFjJ/iHamFljmO96O75fXNH7n4BQO/Bd7Pbky5ajOHXDySROqui4sz9GYqWJNEBBBNn32EMtyr6h4a6wnatayorkaZNLWv66s9uuVfZMejGxN85JLK7minSeBVpxDQaRl36pwPY23VoqWevllTgD8Ok=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1765813242; c=relaxed/simple;
	bh=b4RVoMwhD8nHglewO3yrS66TEoOV8gY68JFJ10YJwN0=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=I+vyYSt9S9dUuFR5kIDWemgUMpayfn+lPNa1hsqoF0YFItZR8eAYfRKDC52Uv0cGLoZL2mv47YEmEAaZRJrYEwlVXtXG/jHhYfVgoBCgAvg4dJQCKT7yzIagpk3F/eVe2HvJQkdp3MNxcECjEZyniHf6LCnCqbBWbtrw7XOzjfo=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org DBA344BA2E07
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=XkQmnDWi
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1765813240; x=1766418040;
	i=johannes.schindelin@gmx.de;
	bh=o1c5FXJ+0GdHfx4tBc/GNY2/6g1lspsWwc56Y1qsysQ=;
	h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
	 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=XkQmnDWinEaLS/Dw/41XyTXnmeosXegKqOgfasmTFxoLAqUUza9GQ7fptC3ix+O9
	 54yXQdVVvtM9DjKMh7w7L5uCqI98Rj0a2ibQ7tQCKiuy8DlWx+LiN8TB5yr/Te88q
	 Ar6gLVvf1PuUmao1bW0hahvXHBmt8riN+PGdmUf+sno5MgQYvzhtM3/ZcF9VRg++U
	 wza1824DIyDtXbsfKIj5x5ZCEk2kUbH6ICXHGyMni2GHDORsVjcbUPwAxCuBpJUvM
	 eYFwDi6ZU7nO2s2GU1qwHndLq3GLmOwIaIV3GAt0iafjgnuEwd05E8bbkAIZhw6QU
	 neWWZyCrHMfIh6O9kg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from ehlo.thunderbird.net ([89.1.215.18]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N1fmq-1vxvpw1sCm-00vAQZ; Mon, 15
 Dec 2025 16:40:40 +0100
Date: Mon, 15 Dec 2025 16:40:38 +0100
From: Johannes Schindelin <johannes.schindelin@gmx.de>
To: cygwin-patches@cygwin.com, Corinna Vinschen <corinna-cygwin@cygwin.com>,
 Takashi Yano <takashi.yano@nifty.ne.jp>
CC: Cody Tapscott <cody@tapscott.me>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_3/3=5D_Cygwin=3A_is=5Fconsole=5F?=
 =?US-ASCII?Q?app=28=29=3A_handle_app_execution_aliases?=
User-Agent: K-9 Mail for Android
In-Reply-To: <aUAoxVEKMpj6xNjM@calimero.vinschen.de>
References: <pull.5.cygwin.1765809440.gitgitgadget@gmail.com> <6ae42c5d17102a7805ed6539b9548df437df88a1.1765809440.git.gitgitgadget@gmail.com> <aUAoxVEKMpj6xNjM@calimero.vinschen.de>
Message-ID: <18909F97-1145-4F61-9E23-4E4B9C97CF2E@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/h7bB7rTs3x9jBo4x5YQDvWFRlzEUEHsmuBOXEgU7tHsTya9ebp
 LvISIX4a5gUuNU481OiD34kzRwXOlRHvr2VWSB7jcBBP1fVg0jS8qGhIxRb3NrtoGaMMix6
 bpnMWCwEPoMyw910MbDvqDpz0gH5qYkTJpJ9uKnNfvheqsNbORCSjVI+w8GX2r7hG7Zagp6
 w3XNM/XYhpXkMBVWoV+Cw==
UI-OutboundReport: notjunk:1;M01:P0:L4pWQ8eYE8M=;n9Fbfhnx+DcBMRazjWes+bdPBK2
 7TFtXImbRHwblaDmBoIxtPddmBMAZgRKsC+1t4dfIDXydAnB4JNXbcTrBtNjl/HtO+u5pH2bn
 U0QaOa+WPlZTGbK8WgTgWTouzfAqAnVZByOfU5hsblMGAEe9hh6AZMNB5fzW5nJe36TLG5tcl
 0dUeBVeJFkLM/jGPtF5i4EeutBGc6QxzzUpn21erIqA9vlppPai3k79x2EnuUNvNJhUNwvtiz
 7wWo+Fh68GXz7jTaAcyLCKoaAWoP67egKA930r+qBgwcn79CRdMZWTXzOgjn49suSASvreJNj
 8fSMa8DICJISyJIGGMV/yhaRAn8zhsPgBWLtZCKdR3Py+sUuFlhPzSmc/jdGJwQcNZSCf+HnL
 wXDAMdsS9Bk2O6FhAyWgiVrSmQv2YvXUijayLKo6F9r/W/DC//XFEb7ctwm+yroKLKmfiK9pD
 +Ig0w+E1UvR8E/HCMXGtp4fELNcHD7L4rBLvsLlVrU2bk9SWmlq2DgZ5YmwDC0y5CFHUUWw9A
 aEi1MyjMBdkkXrj8y7PXbvhZpWUxnoBmX8NoxWFbLKOiqdSLfeG6ia/jX4G3hni26fi0zTL0C
 /FjJNKlRDRbwh5DKd6TTW1otZTc//zrhU5HqsjamT4733QcRdBZe3AWHB+R3fpkuOlVcjd5pP
 fBg7MyattqBP22lNERf/SZ6RA0i6xHCvrKTeUoqJPxpCRTTb3acfR8uuWNZMpCn4XApsYNziz
 kt5p7qB0xai3qxwmwUuHPMLv+gSahWvufv5CaYvJvzzYrVV2jB+Sk52+dsV2eeuvMn2JLb9u7
 mzMFPJFgAn+fw05EUJHatBOQ8KYgLzSBz1n0vVSkM8chw674Odf2+rFn1yq264crASRj1069K
 zn4hLWTBA+W5XOvIt8G8a+Hwm6u1e/NVaoR7OVvMvZBgeuCb8Q1TZ/s4u2RtzN3pu8hwKGV48
 bnT/z47Dqi6SEucaeqTVjIt43cBKyq6gmcMLhJrxYrTnrMQZ4mNVTGbH5Xir2HztE1kH8k9f0
 U+TI+BIiuohyv5YVgjLzHh2VR+ceAgafgla+DTJ0/QLLoOC9qgwKaICfM5hKfmWKBDbFeEj6M
 QiyIH80eC771Zb3m+bafkmLuXJW9ZvOzD24YTuEgw9AVNebfCYZif8p0pnF1rocYdM8jzDEPp
 Lz6UVCSCuYIi5vWq2Ka3RnaCi63nbYYf7ZsPaDDAyKvIcm9O7RBAyxev8vlw5EEbAFcnwrAXq
 Su+JPhkLZSGLB+rzxY/TjnDRqGrfyeOF68V+cVmPyrqqmj/ruguCU3adInrj0cdMTUJkC/x50
 YBMsjh2vpWQ9KULvimR4kfi2iYBFqVjUtBNM99CNuJLMLlDrl4XEjWWpc9SxMW7Len48rvdjd
 Gn+M9OaINMolgl9BficystBc9TUTRPWE1gtmWyVoYbXV5PF3tTuE/VAEARPpC00x0mQQsJYFj
 GlQb2AOu63tiiW/xUeFVgB46dj31Y/0UrVGWoylHotm2lpJNDivAtrz4fpVvbxZysGyL1sCaZ
 2s8lxyl+p2dUlEr+0HGC7+cklMikfIEr6P0mh9jsQe11hWM0IOYsfSRc7fwkWsmxZWQJFwSyq
 fHjZQkCDBVpLQUNalD9ab55O/iq4nuZVQwXDB79cy5Ho+vsXuadrJ4K8IBt9/wLALAWWtC+11
 SPbuksUR9o1txmPA2rV2cieilrk1ZOfxBleHZg8UvUv8WVGZCbV81SzgoowCMs1ZYL9FfVY8X
 YUnf+rLjy0+ohX9+S4abcV8Trv32CeY0wgw1IHvaem6tmlGYIyvpdaJtMYkbttws0jcO+EapP
 Djw0NP/Lh26oh6DQu7KsLGhuzyBz3Od7Ds8lFyeEW7Wo4a/3UkxYeT8OP3zMkeqm2I5ZCO1CO
 lTQTV3uPmOQs45CH6s/yoX7/QexczeEHtuyoXG9BV/KVgTBFhxEQDlXP4GJfAfkUGG0xhFJ/e
 tRLYhr/bXT3p9wXon1ZmCL6JHWbfAqENfg+iVb185aA/EadHzzRiLimZKPiiqugZtoqX4aWoZ
 eEwemRCqsrcfSQ0rOht+nvjQoypqHt1ofyDaLZHsYLcohmYvbwy1aHcaV/HmHkWx5Pk7VHGov
 pMe31pHa137vZDjI2Bjki1OkOOGr/oMpJN4I2nD0el25zzBf3fLzhDybaLvGMgMMMPTBtCuMI
 8zKF3bFu+f6OaHlRq8kDYKEl5wStm/a6Ff6IRG6De+Etjq7nQ1AssEVFIjx5+9Io5PQN1YpI9
 9RcJtx0bBmHAqhlkAx4P6399Vfa5gdAMiKbiJcnA14t/dZUSD4DSf6TqC5h40o169OqP0yVC+
 olDIApNhIUdorvfdsd2Cfpxru0PzXSxFvTDH0fShFIeXd4zZsFdzPuRlQo9YLfr1C5x6MrgnW
 Tu7srKtfbw3lzb/+3hJOtFd3uFjFM0JOZB7H45y43Hb+S1eB+CYFAMipLMxxE1W0/IQ+dnYqJ
 MIYw74QJUapKZ1w/7LJdUjTxNQvIvNbKODaNgDsNr28CxlLQ/NRhCi+0CJ/wdRDq98WefjDpr
 NIQr1OaIyi4bcx0GGm4FgryMYO6wiuk7mw7gN8b1MEZoV5tu/1k+zaYPSZmMjipWCd6ZnAJ8d
 twkjidd94A5iIcE0jeBJPNS4xn7QTuk2C767WIIdENdUSEIqkula2ROp/FcNYDuLN6ZqAil2E
 MXe0RlebGodq4l3iN8x+pnLI495nJplydSvRQu69dwJLsKd2SeRUqTMPHVkjXZ/f77BQVAyjE
 v6RAvNTP/Up4uMVuk7C5hqucErU6aRBo6Y6VX1a1qVyqZkPiWuDPAhI16WUY+8/TEy3gFEBWZ
 SBKSDMGgRX5mMl+wfIM1mN5DXmMN6Px244W1yXVljrqCKq99deGQx64wEfyHZr9XdUcnlhLlT
 AJ9KBbXwrcRnH4rUr27QQxJcfUYlC4KtB4eBXVo+aPL/HzYORYL6aWDpLqfHa1YE27r57gA+7
 hOXJe8TvzBO0RcEdNg6A0LIcKSTgxz/80lrfsvrJ3zQGxXWv/KzgOxRZqeqqtjCDUKeNkXjVu
 /crAixX8PK9c8tByXnWenaclosj5HA/8qpTyMYS2KQQk9/Ws9a2ak2OZUJfUFkCWu6u1REYhn
 QhzpTBFiGSPb/gu3nm3l/dkJOmTvia9FSZMPs2talEqPZNS2EbfufUf+zE/d9l57iNm6xxKja
 dWt2IARVFVYnfcKNp4MWDZRXWPkZTMlFmpeQXp/RirUK3Rv62Mk2gOMSGwYSCEO9WSaWJujgr
 cLz3CLlUGTVYlZgFFQfzybJoOYJZ+8kityIfY3DqOzy40JjagGGqU8O/77s8KB9qaApeDZF0P
 GcpILccwhksrBqd5ku/ThaCc0jtZ1LObc4A/3FOx9xVcBap2WTHExjOgQghjCNBMA32OWKkuf
 9VIEKa0EGv0vKwDIu5ne4H8waa4jE+1/5yzQMTDZ2+Us0sfxPjzGvGAtTzh2RWkTfGr5cPXwb
 dW7iOC9LAEMyR5ilseGb7Ccr8BMgp74ny8qyrqq+RrdGxNiy8iP63LQfIaqk5MTmpd77wRPGg
 kZ4V6uhx8rcpwqWaNDe+nFzGxt58zeQek8j+tA1Yc2RUMNxLPl01OgSdNA9/ki/mkf1GOdyH2
 K8CMz/yac7JVOIKXljTp1A9JC2rfuU67gYv9BQPh/4ujGFbMmSQNUm3pw6lQF+Maraa9r6SgA
 zlrutD3qxTTOhpSYkb9YPjvaQM1mxMeH92bDOT3HImUL/VxpqNvuQupFYLPFKlpqMs/+zOEDQ
 V6nPsfg3AlY9tCFHtUA9wqSvXlUrXEMjzJy1xSg+v9ONY1/5ggikteUt5hWDLUE5/Au0sogbb
 1M2k2m9yXzqX+dtjD8j0HLT189O4hxeZoz6L0Io5ema4rsW5mv8ZI+5QC1JodCbtgGRkWl4UL
 omaM1bE2oJRSA3DhWUSFD/gdFPxOYqtX410PB+tSkI+KLA5DbNKwC9VxcmJwOKQRgurm5Ucc8
 5xkc1ZiigwHzyeZPgWFmjkYX5AX2IUUfdrDhoUXC2ipbc0tY+gfpHQ91BMgqadUK21GdFGlWj
 fLUUEuv0zRAmYH9XnUWsKYQHPUvxg2Av3a7crR85piEGquxrmRIjUCwob2TQ8JclRdzLbHGzt
 n4QWuSzG2WNTyGAprEVqRBCWScEN0DIfzHYigMbMwfjg3a5++QAAqS/+D1OA+7XNSj+iQTO3c
 vgn3O199N6m5iqkyCP/XNKHTOufPJC6otWdG07XKLQ3pE4jJadeCydTA7B7YA9X4OonYf3Bj7
 29KheCNydZ8x8nn6sbLvuvxCTx6G2uGTwitYHwabQfpApNbgFCUP1UmUXUU36hhf5Be3SizIO
 kxQ/PPzwS5z4RNYEIWNhehMcF0D8UJT2OXHEsSP55g+ZWnDCj3YUB7QXjV9SjEEntHInXhkAC
 +uZqVBD5hhuJeUTs+6Ea6bwVXnsUZLjUydv2c7WM+hk9AEwTa48b+PKOUS8GgpQ7szwbKXIdU
 iLw6Iob7SP1oClTEW+eh1jJ3W9ETRzYCS9mRORGqVgtA6L7kp1dKhTQHyb3mX97+yxFutI70K
 9NIhmJbRH7iH8lKK0tFdFrRlY5Rr+tDANnvuq28iI1OgfqnTIG1ilepRjuk9oj45ecWzjILZe
 4kL036U+z81479RkNorTBOpm3U1zTz99KQBP9FczN+yfzpsLDZ5cq8wAKa/jCcFe1gsqT9bhW
 MjkhMofcPQ+X+PQwha/fIOrO0dx6XTCK8wHgTPKDzL2WOx2C7eCI63gwtB7GcOQlTnzlomTAj
 dbLSsy1rXg9OnP0Rk0oabNYFu2kIKzqJ57PRLNa8+r3NTJ5yg+EWC0XDZLTvnyGRKXwdLjfX/
 hSgAOBZ5YWrK9t/9X+ecSMz/uxhOzua1BZRETQn0sHOfG79lyjktzjp2PBG2H+yWVBDcnW4Ks
 wul1rgJTDdOGuefjuylzTyNCz4aiyPrdn6ZR10hZHA9ICuKonOasxlxBc2CmupsbsHBK0k869
 hyuJNsR8awdmMukl3ooH+Stn/50eOFeb1LPJn5Z6tkV+5vdvqLgCQKd4mK/MfdeFYeMMoBb6U
 hLH7PjIfwlNE05zW2iwURMn4LO41RIqakZNy2/LHhZaswCao1TETZLzIeTzLhMVvAjNLwrNMi
 GTiu9AImxFu0UJcCiIxMSrD/5wUiTzhDGhg9Jmt3pA1RQptJPYefEN+MWIQ91PVQ0FIoQ9uKA
 McyIR4NwI0m8jULbb/zfZL9vsZn38DIa7HoSdDG68iQYl5B9///CwS9PnwUayVw9e0A2Q9A55
 drWP/yZfplzZa9Ipy1C6
X-Spam-Status: No, score=-9.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,RCVD_IN_BARRACUDACENTRAL,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_NONE,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hey Corinna,

[Sorry for top-posting]

I take it you mean <https://cygwin=2Ecom/pipermail/cygwin-patches/2025q4/0=
14403=2Ehtml>? Then yes, it looks as if we're trying to fix the same issue,=
 even if I have to admit that I wouldn't have begun to have guessed that fr=
om the commit message in that mail that the bug is about app execution alia=
ses (regular symbolic links don't have a problem, I don't think, and theref=
ore the message might be considered misleading to a certain extent)=2E For =
that reason, I _much_ prefer the more verbose description of the problem th=
at I offered in the email you quoted=2E

Also, it looks as if that other proposed patch will always add overhead, n=
ot only when the reparse point needs to be handled in a special way=2E Give=
n that this code path imposes already quite a bit of overhead, overhead tha=
t delays execution noticeably and makes debugging less delightful than I'd =
like, I would much prefer to do it in the way that I proposed, where the ex=
tra time penalty is imposed _only_ in case the special handling is actually=
 needed=2E

Thanks,
Johannes



-------- Original Message --------
From: Corinna Vinschen <corinna-cygwin@cygwin=2Ecom>
Sent: December 15, 2025 4:27:01 PM GMT+01:00
To: Johannes Schindelin <johannes=2Eschindelin@gmx=2Ede>, Takashi Yano <ta=
kashi=2Eyano@nifty=2Ene=2Ejp>
Cc: cygwin-patches@cygwin=2Ecom, Cody Tapscott <cody@tapscott=2Eme>
Subject: Re: [PATCH 3/3] Cygwin: is_console_app(): handle app execution al=
iases

Johannes, Takashi,

On Dec 15 14:37, Johannes Schindelin via GitGitGadget wrote:
> From: Johannes Schindelin <johannes=2Eschindelin@gmx=2Ede>
>=20
> In 0a9ee3ea23 (Allow executing Windows Store's "app execution aliases",
> 2021-03-12), I introduced support for calling Microsoft Store
> applications=2E
>=20
> However, it was reported several times (first in
> https://inbox=2Esourceware=2Eorg/cygwin/CAAM_cieBo_M76sqZMGgF+tXxswvT=3D=
jUHL_pShff+aRv9P1Eiug@mail=2Egmail=2Ecom
> and then also in
> https://github=2Ecom/msys2/MSYS2-packages/issues/1943#issuecomment-34675=
83078)
> that there is something amiss: The standard handles are not working as
> expected, as they are not connected to the terminal at all (and hence
> the application seems to "hang")=2E
>=20
> The culprit is the `is_console_app()` function which assumes that it can
> simply open the first few bytes of the `=2Eexe` file to read the PE head=
er
> in order to determine whether it is a console application or not=2E
>=20
> For app execution aliases, already creating a regular file handle for
> reading will fail=2E Let's introduce some special handling for the exact
> error code returned in those instances, and try to read the symlink
> target instead (taking advantage of the code I introduced in 0631c6644e
> (Cygwin: Treat Windows Store's "app execution aliases" as symbolic
> links, 2021-03-22) to treat app execution aliases like symbolic links)=
=2E
>=20
> Signed-off-by: Johannes Schindelin <johannes=2Eschindelin@gmx=2Ede>
> ---
>  winsup/cygwin/fhandler/termios=2Ecc | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>=20
> diff --git a/winsup/cygwin/fhandler/termios=2Ecc b/winsup/cygwin/fhandle=
r/termios=2Ecc
> index 5505bf416=2E=2E6edd5be9b 100644
> --- a/winsup/cygwin/fhandler/termios=2Ecc
> +++ b/winsup/cygwin/fhandler/termios=2Ecc
> @@ -710,6 +710,19 @@ is_console_app (const WCHAR *filename)
>    HANDLE h;
>    h =3D CreateFileW (filename, GENERIC_READ, FILE_SHARE_READ,
>  		   NULL, OPEN_EXISTING, 0, NULL);
> +  if (h =3D=3D INVALID_HANDLE_VALUE && GetLastError () =3D=3D ERROR_CAN=
T_ACCESS_FILE)
> +    {
> +      UNICODE_STRING ustr;
> +      RtlInitUnicodeString (&ustr, filename);
> +      path_conv pc (&ustr, PC_SYM_FOLLOW);
> +      if (!pc=2Eerror && pc=2Eexists ())
> +	{
> +	  tmp_pathbuf tp;
> +	  PWCHAR path =3D tp=2Ew_get ();
> +	  h =3D CreateFileW (pc=2Eget_wide_win32_path (path), GENERIC_READ,
> +		           FILE_SHARE_READ, NULL, OPEN_EXISTING, 0, NULL);
> +	}
> +    }
>    if (h =3D=3D INVALID_HANDLE_VALUE)
>      return false;
>    char buf[1024];

Erm=2E=2E=2E does this patch collide with
https://sourceware=2Eorg/pipermail/cygwin-patches/2025q4/014421=2Ehtml
by any chance?  Are you both trying to fix the same problem somehow?


Thanks,
Corinna
