Return-Path: <cygwin-patches-return-2852-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 10150 invoked by alias); 21 Aug 2002 20:27:12 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 10136 invoked from network); 21 Aug 2002 20:27:12 -0000
Message-ID: <01ab01c24951$827ec580$6132bc3e@BABEL>
From: "Conrad Scott" <Conrad.Scott@dsl.pipex.com>
To: <cygwin-patches@cygwin.com>
References: <017501c24948$aa02fa30$6132bc3e@BABEL> <20020821195621.GB30141@redhat.com>
Subject: Re: recv/send revert patch
Date: Wed, 21 Aug 2002 13:27:00 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-SW-Source: 2002-q3/txt/msg00300.txt.bz2

"Christopher Faylor" <cgf@redhat.com> wrote:
> Would it make sense to use recvfrom/sendto on systems that
support
> it by implementing a new wincap capability?

The main reason I chopped out the recv/send methods and used the
existing recvfrom/sendto methods instead was simply to eliminate
some code, i.e. if recvfrom with a couple of NULL arguments is a
drop-in replacement for recv then why have methods for both?
Other than that, there isn't any reason to use recvfrom rather
than recv AFAIK.

(What's particularly annoying is that it is only for one
particular situation where the replacement fails on NT4.0; but to
work around that would require having the code in the DLL anyhow,
so the saving is immediately lost.)

On that basis, I'd have thought it's just cleaner and easier to
drop what my initial patch was attempting and call the matching
winsock interface each time.

HTH,

// Conrad


