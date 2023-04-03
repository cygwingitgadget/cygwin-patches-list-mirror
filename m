Return-Path: <SRS0=7Fjc=72=gmx.de=Johannes.Schindelin@sourceware.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	by sourceware.org (Postfix) with ESMTPS id B5AC93858C50;
	Mon,  3 Apr 2023 06:45:34 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org B5AC93858C50
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1680504333; i=johannes.schindelin@gmx.de;
	bh=skKu86uEv5cKwnS0Gm+gII0UX7Rec1r+ytsuPt/RtS4=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
	b=HYLEBSZO2goncWljfW0Jf+YkJhgtv34wFlv6ZnT7cUCnfNgp4lBwo2kYMRuAw3zkl
	 b/HmQJVEeqjVR7yGPqIArOvl1A83gsSHvx7XwEwIK7VZnZkYsKnma8DHSC4yrrFIhT
	 w068ByLFakhvYhtFZbdnvzPaYJ//77RllEB1UK7t8Y9OOjbD6mNOiZQU4qPdv67Q6c
	 rk/F8drg3B2x1wFlGIBZ0AR+nKZn+PeAJIr3jKegdN/nzp3sKsmoGZ46xIoA8yKCvK
	 WQUvf5oUx+r+dGT8Zca7sJYxKnpt4ggWwoLpj23JOBzyZrczlKGGu4kRXah1Tt0gWl
	 2n0mHcr7voO8g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.213.182]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MyKHm-1qdNR31nH2-00yl2G; Mon, 03
 Apr 2023 08:45:33 +0200
Date: Mon, 3 Apr 2023 08:45:32 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Corinna Vinschen <corinna-cygwin@cygwin.com>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH v4 3/3] Respect `db_home: env` even when no uid can be
 determined
In-Reply-To: <ZCK+v7yBxRBft3UK@calimero.vinschen.de>
Message-ID: <97e5226e-60c6-9d03-0c71-72e3192abe59@gmx.de>
References: <cover.1663761086.git.johannes.schindelin@gmx.de> <cover.1679991274.git.johannes.schindelin@gmx.de> <4cd6ae73074f327064b54a08392906dbc140714a.1679991274.git.johannes.schindelin@gmx.de> <ZCK+v7yBxRBft3UK@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:JybAcFepd1EHjAzOdoQ2PVVsYsIvYzD79IP0echmle9kkaSrRTq
 V0V2+JN+Kaj7ZESb1bGV1PGz5RRhI4Fd3OdOKPV74eool8pzebkA45UBBHrKdCnwr6T/jA8
 Yvx6I8XNNFLQ9oXb9zHVtGwv+qgtc9IRTh9iyw9N6wlWKJvSFd5rK2K9SJBacvAoNmkMikr
 xj6lNemYgTGp8gVeTdKOg==
UI-OutboundReport: notjunk:1;M01:P0:qoh4XB7QxkE=;d5wV+Dj/ew1gacv29KjnXxocORy
 wuCi+PIf62DCd/faG/rAkVUNI6rKh+LwRcsi/pq9ThrNTjCaLzfyMNiDtbYckqKxdG7kn9HKO
 JbK7GzMKHJiD4IXp2l5LGamtE2JLncfVrks89tDh6C4brAHhb/6RxwAYNlKvSWnhQj4djF4sE
 ciY+xknFXI9pueyLNPat4QYJ3X4b5on7fFmmZxQDNqAjGnVNC6z8prKym6wFAuZAkte2oiyu/
 EJTifemPu84+BXO19wvfBrbUDfc9+SzJe1b9AekjVyVF7bf1+IzHrDoZ4+yhdcy2gKWnoX6Pm
 H82RJ3ZW1Z+cA+oPQKxI6q6C//kADWV2HSLFILnnmuotb2V+EIyL/RPEPJTTF8wPVQ84PcafT
 LJ8T3lpstNM/U0GvcMtV8jrNrIIhxqoZX42BSIZMScNO+slVBX795YwLRgw6flhsiUnleDxBD
 ez6NmKjUUNr2l4UMu8iQcRtsI8NIEeQstm/TXjVWm5/x5sqlqIdiV5ttOdcmk4CFOn1HkilOq
 vIhk0K7d5gHMLQQqgwaOlOwRmUvNWXEyxsnKWcsscM2ROuYCgjgCOWvZweV7xmkgf7+vsQGml
 NVNDGKggLQOjaueyT1NA8EJxy3XTrjLkIxqiH25izYvdf/bfs0sLNQynLkd4fjKWWUbEXkH6+
 VuQ+bNQB99zAlWAHVaY0dSHTThIpcIA7RK1pxLbMLEdo7ntQi6UpUW2J56TGeauOjF4+EqfYj
 URN4pIPzZqrkQCQ4sRo3EkDerrzyTgCWWN2UW/79miMqfRHUlj9icM89Me0K5p1EPhwgCJk0l
 5OTGiVIWHtFb8GV0ecJUr5aSfXsqHjxbHPe4tj9HnrHFVbOBgeCfW5XStDGR00jWWOdvuz1Vb
 sjw9gKfnvFPbjiPva5hScsh1KndBS2gOA4jmJnxm3+WmD1soAkolduvHTV1jtFWffn+jRrSQU
 MNZDyaCCW02axnE03op2nDKgaKo=
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-10.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Corinna,

On Tue, 28 Mar 2023, Corinna Vinschen wrote:

> On Mar 28 10:17, Johannes Schindelin wrote:
> > In particular when we cannot figure out a uid for the current user, we
> > should still respect the `db_home: env` setting. Such a situation occu=
rs
> > for example when the domain returned by `LookupAccountSid()` is not ou=
r
> > machine name and at the same time our machine is no domain member: In
> > that case, we have nobody to ask for the POSIX offset necessary to com=
e
> > up with the uid.
> >
> > It is important that even in such cases, the `HOME` environment variab=
le
> > can be used to override the home directory, e.g. when Git for Windows =
is
> > used by an account that was generated on the fly, e.g. for transient u=
se
> > in a cloud scenario.
>
> How does this kind of account look like?  I'd like to see the contants
> of name, domain, and the SID.  Isn't that just an account closely
> resembling Micorosft Accounts or AzureAD accounts?  Can't we somehow
> handle them alike?

It took a good while to remind me what was going on there. Essentially, I
had to dig up a mail from 2016 that David Ebbo sent me via my work email
(because he was working on Kudu, the Azure shell, where this issue arose).
Sadly, David is no longer a colleague of mine (he seems to work at Google
now), so I cannot pester him about details. Besides, it might be too long
ago to remember details, anyways.

What I _can_ do is try to recreate the problem (the report said that this
happens in a Kudu console of an Azure Web App, see
https://github.com/projectkudu/kudu/wiki/Kudu-console) by creating a new
Azure Web App and opening that console and run Cygwin within it, which is
what I am going to do now.

> > Reported by David Ebbo.
>
> This should be
>
>   Reported-By: David Ebbo <email address>

Will fix. Naturally, it won't be his Microsoft email address any longer,
but the recent patches I obtained from repositories at
https://github.com/davidebbo/ have a GMail address on record.

> > diff --git a/winsup/cygwin/uinfo.cc b/winsup/cygwin/uinfo.cc
> > index d493d29b3b..b01bcff5cb 100644
> > --- a/winsup/cygwin/uinfo.cc
> > +++ b/winsup/cygwin/uinfo.cc
> > @@ -883,6 +883,8 @@ fetch_from_path (cyg_ldap *pldap, PUSER_INFO_3 ui,=
 cygpsid &sid, PCWSTR str,
> >  	    case L'u':
> >  	      if (full_qualified)
> >  		{
> > +		  if (!dom)
> > +		    break;
>
> No domain?  Really?

Yes, I distinctly remember that I had to do that, otherwise the code would
not work as intended.

Ciao,
Johannes
