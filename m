Return-Path: <cygwin-patches-return-2799-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 20353 invoked by alias); 7 Aug 2002 21:40:20 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 20339 invoked from network); 7 Aug 2002 21:40:20 -0000
Message-ID: <060701c23e5b$5f1d7fb0$6132bc3e@BABEL>
From: "Conrad Scott" <Conrad.Scott@dsl.pipex.com>
To: <cygwin-patches@cygwin.com>
References: <040201c23e37$256b0810$6132bc3e@BABEL> <20020807200131.GA9098@redhat.com> <056501c23e54$031f67c0$6132bc3e@BABEL> <20020807210442.GB10258@redhat.com> <05d101c23e57$b9237220$6132bc3e@BABEL> <20020807212905.GC12225@redhat.com>
Subject: Re: IsBad*Ptr patch
Date: Wed, 07 Aug 2002 14:40:00 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-SW-Source: 2002-q3/txt/msg00247.txt.bz2

"Christopher Faylor" <cgf@redhat.com> wrote:
> >Perhaps I ought to leave it until tomorrow in that case, to
give
> >Corinna a chance to savour the discussion and veto the patch if
> >necessary.
>
> Ok.
>
> At the very least, the removal of const is ok, assuming you can
> remove that and not affect the Corinna parts.

I need to bung it all in together 'cos once the const is removed a
few functions fail to compile (including a couple in "net.cc"), as
they check write rather than just read access.  So, I'll pause the
lot for the moment.

Cheers,

// Conrad


