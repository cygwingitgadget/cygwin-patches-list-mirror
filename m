Return-Path: <cygwin@jdrake.com>
Received: from mail231.csoft.net (mail231.csoft.net [96.47.74.235])
 by sourceware.org (Postfix) with ESMTPS id 95A853858D39
 for <cygwin-patches@cygwin.com>; Sun, 26 Dec 2021 21:35:28 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 95A853858D39
Received: from mail231.csoft.net (localhost [127.0.0.1])
 by mail231.csoft.net (Postfix) with ESMTP id BAFB7CB50;
 Sun, 26 Dec 2021 16:35:27 -0500 (EST)
Received: from mail231 (mail231 [96.47.74.235])
 (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
 (No client certificate requested) (Authenticated sender: jeremyd)
 by mail231.csoft.net (Postfix) with ESMTPSA id A6D91CB1B;
 Sun, 26 Dec 2021 16:35:27 -0500 (EST)
Date: Sun, 26 Dec 2021 13:35:27 -0800 (PST)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: Ken Brown <kbrown@cornell.edu>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH] fhandler_pipe: add sanity limit to handle loops
In-Reply-To: <317dc73a-fb9d-3937-7354-c79492c1c64c@cornell.edu>
Message-ID: <alpine.BSO.2.21.2112261331090.11760@resin.csoft.net>
References: <alpine.BSO.2.21.2112231503400.11760@resin.csoft.net>
 <alpine.BSO.2.21.2112231623490.11760@resin.csoft.net>
 <c5115e9b-6475-d30e-04d3-cb84cfa92b3a@cornell.edu>
 <alpine.BSO.2.21.2112241136160.11760@resin.csoft.net>
 <622d3ac6-fa5d-965c-52da-db7a4463fffd@cornell.edu>
 <alpine.BSO.2.21.2112241638280.11760@resin.csoft.net>
 <20211225121902.54b82f1bb0d4f958d34a8bb7@nifty.ne.jp>
 <alpine.BSO.2.21.2112241945060.11760@resin.csoft.net>
 <20211225131242.adef568db53d561a6b134612@nifty.ne.jp>
 <alpine.BSO.2.21.2112242101520.11760@resin.csoft.net>
 <20211226021010.a2b2ad28f12df9ffb25b6584@nifty.ne.jp>
 <alpine.BSO.2.21.2112251111580.11760@resin.csoft.net>
 <alpine.BSO.2.21.2112251457480.11760@resin.csoft.net>
 <8172019c-e048-4fe2-79c9-0b3262057d3e@cornell.edu>
 <alpine.BSO.2.21.2112252054310.11760@resin.csoft.net>
 <c7664703-0ec2-388f-64e3-8c46d4590b3e@cornell.edu>
 <d2af0b22-666a-b820-acb0-afc835836372@cornell.edu>
 <317dc73a-fb9d-3937-7354-c79492c1c64c@cornell.edu>
User-Agent: Alpine 2.21 (BSO 202 2017-01-01)
MIME-Version: 1.0
X-Spam-Status: No, score=-9.4 required=5.0 tests=BAYES_00, BODY_8BITS,
 DKIM_SIGNED, DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, GIT_PATCH_0,
 SPF_HELO_PASS, SPF_PASS, TXREP autolearn=ham autolearn_force=no version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
 server2.sourceware.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
X-BeenThere: cygwin-patches@cygwin.com
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Cygwin core component patch submission and discussion
 <cygwin-patches.cygwin.com>
List-Unsubscribe: <https://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <https://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Sun, 26 Dec 2021 21:35:30 -0000

On Sun, 26 Dec 2021, Ken Brown wrote:

> On 12/26/2021 11:04 AM, Ken Brown wrote:
> > On 12/26/2021 10:09 AM, Ken Brown wrote:
> > > 1. For some processes, NtQueryInformationProcess(ProcessHandleInfor=
mation)
> > > can return STATUS_SUCCESS with invalid handle information.=C2=A0 Se=
e the
> > > comment starting at line 5754, where it is shown how to detect this=
.

I kind of thought something like this (that NumberOfHandles was
uninitialized memory).

> > If I'm right, the following patch should fix the problem:
> >
> > diff --git a/winsup/cygwin/fhandler_pipe.cc b/winsup/cygwin/fhandler_=
pipe.cc
> > index ba6b70f55..4cef3e4ca 100644
> > --- a/winsup/cygwin/fhandler_pipe.cc
> > +++ b/winsup/cygwin/fhandler_pipe.cc
> > @@ -1228,6 +1228,7 @@ fhandler_pipe::get_query_hdl_per_process (WCHAR=
 *name,
> >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 H=
eapAlloc (GetProcessHeap (), 0, nbytes);
> >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!phi)
> >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g=
oto close_proc;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 phi->NumberOfHandle=
s =3D 0;
> >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 status =3D Nt=
QueryInformationProcess (proc,
> > ProcessHandleInformation,
> >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 phi, nbytes, &len);
> >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (NT_SUCCES=
S (status))
>
> Actually, this first hunk should suffice.
>
> > Jeremy, could you try this?
> >
> > Ken


I've built (leaving the assert in place too), and I've got 3 loops going
on server 2022 and 1 going on ARM64.  So far so good.  I don't know how
long before calling it good though.
