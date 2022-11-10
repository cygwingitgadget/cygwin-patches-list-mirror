Return-Path: <Johannes.Schindelin@gmx.de>
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	by sourceware.org (Postfix) with ESMTPS id C13213858408
	for <cygwin-patches@cygwin.com>; Thu, 10 Nov 2022 15:16:24 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org C13213858408
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1668093383; bh=eRoB7IqYHT7boIMgI/kqDsAPj2dBmfqT4cTyUGKZrSI=;
	h=X-UI-Sender-Class:Date:From:To:Subject:In-Reply-To:References;
	b=nkQk7BQAQ2zesOxLrqzACVve3zQzYRAuI3evREjDhhoaiu1lUCVStcvckd5KBVVnz
	 +49f7mpaMBCC0Mk+L65LLxb/3Tx/a6h1ckcUeotSRzUAFGtuHxkIn+8jvya8v12V/V
	 mywhzlSkKAULZ9idfp+DbTiqPws3oRXf199oNfkkqc1ekt3UYWd93RTiRbS47PVqXQ
	 BsZSOoFGOqecHS6m5mOofio/Te67SG1YF26x2VxmWaMj2fISxglXK9l96jmJ+0je8N
	 7lev3zJZNb5Vem9qmwK1jgu3c9YaO01ul2DjVmdKVsSSgRsJ4lnTIuxFFfWL1Uiwry
	 Jy3oKZFoRTlyw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.27.167.171] ([213.196.213.188]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MYvY8-1oXEhT18UK-00Uso4 for
 <cygwin-patches@cygwin.com>; Thu, 10 Nov 2022 16:16:23 +0100
Date: Thu, 10 Nov 2022 16:16:21 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2 1/2] Allow deriving the current user's home directory
 via the HOME variable
In-Reply-To: <Y1Z48Mdk79/Qtwc9@calimero.vinschen.de>
Message-ID: <66o0nq89-4599-np26-625n-2n8oon6p558q@tzk.qr>
References: <0Lg1Tn-1YnzUw0ScN-00pcgi@mail.gmx.com> <cover.1450375424.git.johannes.schindelin@gmx.de> <047fe1d78c365afca7edfdf169fff5e1940c3837.1450375424.git.johannes.schindelin@gmx.de> <20151217202023.GA3507@calimero.vinschen.de> <1r1pq0r7-o3s3-so08-o426-296542797q94@tzk.qr>
 <Y07cOhhwu4ExRDzb@calimero.vinschen.de> <0q096627-r8pr-rno5-0863-s6n90psosq07@tzk.qr> <Y1Z48Mdk79/Qtwc9@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:IDYMmA8nwL/FuoAAWwah+65/LqgDq5gQh0/E7bIobr+nLbt7GG1
 ndT7gQor1/dayeoUhPwX5wMs6xqPQVl07DMQipH3gXcjP/bii88Y/LwgrLkZbA/ahNdZHgK
 yt1Q2sUzxJ+TDCu7CcLpJESXDKnoB0lG/L/V3O+MvTROrZqk9fmZeIBbs4ZNJdh3VPVVTRS
 Kh8KbF5iteW3QaEYu5rEQ==
UI-OutboundReport: notjunk:1;M01:P0:jtDoLWM6tns=;OatmpISOry9gZYvaOoqWhdBwuao
 h2QT0AiEecKP/XGNnIKNs4Vev2O67UwBfmq74DprdhfoE3CVlth6VHh9+LD7m35Vsg6i/eqtO
 EINCt/R222WopV9yOrlVj8/mLYrHcxuEDD8na1lGGIM5VeZ01gK93+dirEDT+O0dx2Qqmxf18
 hyQ5skuZYiD7ySHqxJJS7GVGpNg7W+3JvS7VnDsEmzBtWO1g2zhWG0F75UVREpI+aNfODsM/C
 1P8ebPnYiIRCcAFxhb6zXCkETz51c6ha+KQwl15lDYHF0w7IAADnt2D8/33dCx/Ar0sGsnkJx
 0BtgnxKZCY8/fbHSCCPVZUqNHTOtCayXnvOazn8kPmwwV3HAjT6yUVFflUIB26p2/EdK6cBqH
 M52Ihn1nql6PmmjkyZBh2uMy1A5WcxZWgWVOgQUMRVr5aD6sSAWxfG7yxo3V2uCq1m/JXYNSg
 TkuGo5sT0f+EJ1J88zS12G+MDazUat41tzbgAMFLC7axaoO98gaw4eXhy35RHj4VrrFOwFUIv
 ueAmkbvKeJUblh71hEQWVO11o0BgWd+IIfYVl1WnOTPRMupB/w3+NV2hZCcsLDFunEbLQ3hpo
 6rILBRMquxWTlM+GjqrGGcCpnWVCwpiwmQfmnZnLhLOEwRGsVQ0NnmjrpdIctmT9MHtfd+4pu
 yXdsfYZYxC1vrnnLb6XdenqzKU721KV2G9fvN/0uN0Big7MJ/Ui1mDc7Elw3Kb7UusXL2jBw8
 KSI9yItGwn9L1skNO2vqyt9A/hrNfVpb0fmU/PgSt4soIdgV87dXH947La1BkolBAT3PHwVom
 yV+bMm6HVJD9oAEiWZ6KHhyB5NbbAs7EZeo5rZW6jFpMMab7w3B2nDPSGca6UunUiLnvx4S6+
 aXGPMkjDVyYaUIe+uyeAuCKoRLczKxFB1hLEux35KwAyNACc/+HGpzBCJIMKAA9KhfswAx8NK
 fNAiUQ==
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Corinna,

On Mon, 24 Oct 2022, Corinna Vinschen wrote:

> On Oct 23 23:04, Johannes Schindelin wrote:
> > On Tue, 18 Oct 2022, Corinna Vinschen wrote:
> > [...]
> > > That means, the results from the "env" method is equivalent to the
> > > "windows" method, just after checking $HOME.  That's a bit of a down=
er.
> > >
> > > Assuming the "env" method would *only* check for $HOME, the user wou=
ld
> > > have the same result by simply setting nsswitch.conf accordingly:
> > >
> > >   home: env windows
> >
> > Except when the domain controller is (temporarily) unreachable, e.g. w=
hen
> > sitting in a train with poor or no internet connection. Then that latt=
er
> > approach would have the "benefit" of having to wait 10-15 seconds befo=
re
> > the network call says "nope".
> >
> > This particular issue has hit enough Git for Windows users that I foun=
d
> > myself being forced to implement these patches and run with them for t=
he
> > past seven years.
> >
> > Given the scenario of an unreachable domain controller, I hope you agr=
ee
> > that the `env` support added in the proposed patches _has_ merit.
>
> Yes, I don't doubt an `env' method checking for $HOME even a bit.

Cool!

> I'm just not sure as far as HOMEDRIVE/HOMEPATH/USERPROFILE are
> concerned.  Those vars should be left alone, but we can't control that,
> so reading them from genuine sources is preferred.

I do not recall the exact reasons because it has been a good while since I
worked on these patches. But I do remember that we had to have a fall-back
for the many scenarios in Git for Windows where `HOME` is not even set,
and we specifically had to add HOMEDRIVE/HOMEPATH handling because
USERPROFILE alone would lead to problems (IIRC there were plenty of
corporate setups where USERPROFILE pointed to a potentially-disconnected
network drive).

> Sure, the downside in terms of the LDAP server is clear to me
>
> So I guess it's ok to allow the env method to read the values of those
> vars from the env.  I would just feel better if we urge the
> user to set $HOME and read that exclusively.

I would feel better about that, too, if it was practical.

But I cannot ask millions of Git for Windows users to please go ahead and
first configure their `HOME` variable correctly, it took much less time to
implement the patch we're discussing than asking all users individually
;-)

And since there is nothing specific about Git for Windows here, I expect
Cygwin users to benefit from this feature, too.

With this context in mind, I would like to ask to integrate the patch
as-is, including the HOMEDRIVE/HOMEPATH and USERPROFILE fall-backs.

Thanks,
Dscho
