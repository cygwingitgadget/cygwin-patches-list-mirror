Return-Path: <cygwin-patches-return-3261-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 6735 invoked by alias); 2 Dec 2002 15:42:13 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 6202 invoked from network); 2 Dec 2002 15:41:39 -0000
Date: Mon, 02 Dec 2002 07:42:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: --enable-runtime-pseudo-reloc support in cygwin, take 3.
Message-ID: <20021202154220.GB19575@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20021119072016.23A231BF36@redhat.com> <3577371564.20021119120659@logos-m.ru> <1451205547776.20021202133024@logos-m.ru> <1551207829817.20021202140826@logos-m.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1551207829817.20021202140826@logos-m.ru>
User-Agent: Mutt/1.5.1i
X-SW-Source: 2002-q4/txt/msg00212.txt.bz2

On Mon, Dec 02, 2002 at 02:08:26PM +0300, egor duda wrote:
>Hi!
>
>Monday, 02 December, 2002 egor duda deo@logos-m.ru wrote:
>
>ed> 2002-12-02  Egor Duda <deo@logos-m.ru>
>ed>         * cygwin/lib/pseudo-reloc.c: New file.
>
>I guess i should put it to the public domain, so that mingw folks can
>also use it.

I'm not sure that public domain is going to work with the cygwin license.

I'm also not sure that this is a great idea for mingw, which is supposed
to be a pretty generic windows environment, AFAIK.  If mingw starts
creating fancy new dlls then that sort of strays from their core
purpose, IMO.

Obviously not my call, though.

cgf
