Return-Path: <cygwin-patches-return-2654-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 25768 invoked by alias); 15 Jul 2002 09:00:41 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 25754 invoked from network); 15 Jul 2002 09:00:40 -0000
Message-ID: <01c701c22bde$6281c100$6132bc3e@BABEL>
From: "Conrad Scott" <Conrad.Scott@dsl.pipex.com>
To: <cygwin-patches@cygwin.com>
References: <002a01c22b2f$07f9bda0$6132bc3e@BABEL> <20020714161750.GA26964@redhat.com> <005301c22b64$56c7e4e0$6132bc3e@BABEL> <20020714222738.GA607@redhat.com>
Subject: Re: Protect handle issue-ettes
Date: Mon, 15 Jul 2002 02:00:00 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-SW-Source: 2002-q3/txt/msg00102.txt.bz2

"Christopher Faylor" <cgf@redhat.com> wrote:
> It almost sounds like you are not running with the
> most recent sources.

I can't quite see how I was doing that but I suppose I must have
been, especially since you couldn't recreate it with the same
version of the branch code.

Actually, I've just gone back through the CVS postings: I assume
that what I did was to lose my local copy of the setclexec() patch
I sent you (which is rather ironic) since I didn't do a cvs merge
to pick that up until I did the one to pick up your second set of
changes.  Sorry to have messed you about.

Regardless of all that, it is nice to have things running without
any of those warnings, and thanks for that.

// Conrad


