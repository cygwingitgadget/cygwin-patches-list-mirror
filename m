Return-Path: <cygwin-patches-return-3266-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 30573 invoked by alias); 2 Dec 2002 17:49:23 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 30563 invoked from network); 2 Dec 2002 17:49:22 -0000
Date: Mon, 02 Dec 2002 09:49:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: --enable-runtime-pseudo-reloc support in cygwin, take 3.
Message-ID: <20021202175006.GC21442@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20021119072016.23A231BF36@redhat.com> <3577371564.20021119120659@logos-m.ru> <1451205547776.20021202133024@logos-m.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1451205547776.20021202133024@logos-m.ru>
User-Agent: Mutt/1.5.1i
X-SW-Source: 2002-q4/txt/msg00217.txt.bz2

On Mon, Dec 02, 2002 at 01:30:24PM +0300, egor duda wrote:
>2002-12-02  Egor Duda <deo@logos-m.ru>
>
>        * cygwin/lib/pseudo-reloc.c: New file.
>        * cygwin/cygwin.sc: Add symbols to handle runtime pseudo-relocs.
>        * cygwin/lib/_cygwin_crt0_common.cc: Perform pseudo-relocs during
>        initialization of cygwin binary (.exe or .dll).

I'm rapidly approaching the I-don't-care-anymore state for this but I am
not clear on why we need to add the changes to cygwin.sc.  This is for people
who want to link the cygwin DLL without using the appropriate header files
which label things as __declspec(dllexport) or using the appropriate libcygwin.a,
right?  Why should that matter?

cgf
