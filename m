Return-Path: <cygwin-patches-return-2442-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 26260 invoked by alias); 16 Jun 2002 05:47:27 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 26219 invoked from network); 16 Jun 2002 05:47:23 -0000
Date: Sat, 15 Jun 2002 22:47:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: Reorganizing internal_getlogin() patch is in
Message-ID: <20020616054756.GA7382@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20020613052709.GA17779@redhat.com> <20020613052709.GA17779@redhat.com> <3.0.5.32.20020616000701.007f7df0@mail.attbi.com> <20020616051506.GA6188@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020616051506.GA6188@redhat.com>
User-Agent: Mutt/1.3.23.1i
X-SW-Source: 2002-q2/txt/msg00425.txt.bz2

On Sun, Jun 16, 2002 at 01:15:06AM -0400, Christopher Faylor wrote:
>>c) adding a member "namelen" in spenv (as in win_env) seems to be helpful.
>
>Possibly, but this is one of those situations where you sully your patch
>by making it do too many things.  It's generally good practice to have
>one idea per patch.

FWIW, I've checked in a variation of this patch.  Your method actually
had some use in another place in environ.cc, too.

cgf
