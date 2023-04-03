Return-Path: <SRS0=7Fjc=72=gmx.de=Johannes.Schindelin@sourceware.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	by sourceware.org (Postfix) with ESMTPS id 0C10E3858C5F;
	Mon,  3 Apr 2023 13:19:34 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 0C10E3858C5F
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1680527973; i=johannes.schindelin@gmx.de;
	bh=bi/4m3E00RFIT4v5fGTet5sopownJ9d7zEa0NfJVO0s=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
	b=KGD47xSdX98RXm25TcezWUOntry+62jfWKndB7XR19k9qJSOHmczu1dNPua96Rvcf
	 Fy1u2EPjZdf0A+d+plsmX7c4p3CEBqVTNqORASlGwZTEYUVs+UtgDwH0t5ydw3tTfa
	 QG+48TEXsfIvTjy2pvq+qGYQwjmYoiF1mgCw/emNK2Psow/Bb1bLbHjsfR6tyUc65G
	 qcfXF3f+C4aYAV0/MxbXSacDj19MZsky0SS+Tj/xl672XhJS7m4ihU6Z3LRSTV9p7b
	 QrBx+qlbzVdEVFBbt7NVex8/INWQ+4bHDDVWkP3NRTdDXgw2HU7FQeWn7SfURvXFRD
	 5xlR2ndsPOVKQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.213.182]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MtOGa-1qYH5X2hg6-00utoh; Mon, 03
 Apr 2023 15:19:33 +0200
Date: Mon, 3 Apr 2023 15:19:32 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Corinna Vinschen <corinna-cygwin@cygwin.com>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH v4 3/3] Respect `db_home: env` even when no uid can be
 determined
In-Reply-To: <97e5226e-60c6-9d03-0c71-72e3192abe59@gmx.de>
Message-ID: <cf4a8739-af7c-a6ac-3037-e18228864045@gmx.de>
References: <cover.1663761086.git.johannes.schindelin@gmx.de> <cover.1679991274.git.johannes.schindelin@gmx.de> <4cd6ae73074f327064b54a08392906dbc140714a.1679991274.git.johannes.schindelin@gmx.de> <ZCK+v7yBxRBft3UK@calimero.vinschen.de>
 <97e5226e-60c6-9d03-0c71-72e3192abe59@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:8lQfTWjAJWRr1pSkmRaCgrsI8ucsgjXxGgZTv6dWoyupEbzzyNO
 Ip0VT5uOsJDJC6vyx8VAxAQ+62eC7aSyTgiGTItzb7M/Uxjanip1Ye4v10T/t1rtbHuTExC
 0H5Nd8UnamdtfAQkUwmMwa7IEjfMqfBQDR8MAh1Rqwd4b3FeRNO8hxCWxigRNfvFIa0DksL
 FA4YdWDG+X6jQ608tb6Nw==
UI-OutboundReport: notjunk:1;M01:P0:maKc6XsjJ4Q=;4YZF/9wgq+886gdXra55BdLi4B4
 oMPE1XG7LNyTRgZ9SGoeBcFs0xEAHr9l3xdW+wFNjVgyGe3H+GMeBoUfu7Kb1V0Hx/rqRCkVa
 43bt08LvMeSMD9fqejk6sshpcvMvAJ8t7YefeW/aSf+IlNrX1PhCExyCrR54EZUsZjS3hoKPh
 tEESATS1N7+WAkM+0ewx71ua6e1TCt3pZCypXs7XOJxWDZ9N9lyoPnkAGeLSs3g21knLkUl34
 AY2y+ApUjJDLj2PR8zkQuhBTVzx+GRYDGqENbo1oYmxXkpUMGvqMBskHCObTGRHO/djWVab4g
 iYGbVy+emFoLw4JowmnaHmvfELG+x4FvxQ3gV6trKy0IOENNrl229q0zkFEx4POCZzqWpaMCy
 xGC8vQuLf52t2QFt+UjnnyRmDL2BhzLQ1DDWoafjt209ZxbVp58SMQs4z8sgWb8FghqFgHcEA
 TSn8sOVa7TH5OpVM00NnVLs0CXicYLy1n4SI7EKxeC3/44AUeIvR7zOrku7txfMIG24/ASagO
 NMPql8hyV+aDQcfClkgjQNnecmNYhuLojUxv1ECTGtp1jBz/z5508m+xmO+3LyanHWhxmOH1o
 KfTKDBJL3R7TDjnFMMRQ0a6bRxafSdf3MvE0YB8ArPBRJy7Lwng3jhy+FJvsatoVJJV6JkVVs
 AktNaK0sr0nDN7lVQPrJxHzOsU9gEJP2G33vyk9PpD22Wr4kHlG46xVvUHBMBf0UM8o9i8ui4
 PpE7RyuD19W2ovowwHOO6AYiSe7qFG5ebuBSQN6HzIv/ZzOpgXvty4L97xKJzKXZ64EwD7oEy
 J0K344yjr31jmP4Ojokbrnm+eKj/59Ht9h8mq/xpQ1E9yb9ptDpKhzJmFi4TCLj5nMi3zkrAx
 WVUFGdDV5GGIn0lGzQl8dWUbfCOkCSsHKg6gFxhZ3QIhO3R77g00trqaA2A03wxZRFlH+zm6/
 s5HGi70mvrw7zUtn7xtvTRd1JXs=
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-10.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Corinna,

On Mon, 3 Apr 2023, Johannes Schindelin wrote:

> On Tue, 28 Mar 2023, Corinna Vinschen wrote:
>
> > On Mar 28 10:17, Johannes Schindelin wrote:
>
> > > diff --git a/winsup/cygwin/uinfo.cc b/winsup/cygwin/uinfo.cc
> > > index d493d29b3b..b01bcff5cb 100644
> > > --- a/winsup/cygwin/uinfo.cc
> > > +++ b/winsup/cygwin/uinfo.cc
> > > @@ -883,6 +883,8 @@ fetch_from_path (cyg_ldap *pldap, PUSER_INFO_3 u=
i, cygpsid &sid, PCWSTR str,
> > >  	    case L'u':
> > >  	      if (full_qualified)
> > >  		{
> > > +		  if (!dom)
> > > +		    break;
> >
> > No domain?  Really?
>
> Yes, I distinctly remember that I had to do that, otherwise the code wou=
ld
> not work as intended.

Right. This is actually really easy to explain: The new call I introduced
in this very patch passes `NULL` as the `dom` parameter (because this is
in a scenario where we do indeed not have a domain to work with):

  if (arg.id =3D=3D cygheap->user.real_uid)
	    home =3D cygheap->pg.get_home ((PUSER_INFO_3) NULL,
					 cygheap->user.sid(),
					 NULL, NULL, false);

					 ^^^^
					 this is the `dom` parameter

(see
https://github.com/dscho/msys2-runtime/commit/4cd6ae73074f327064b54a083929=
06dbc140714a#diff-1ffeda03bc188fa732454f52c4932977bc8233d9db4da19ab5acb0c5=
8c7320ccR2188-R2191
for details)

Ciao,
Johannes
