Return-Path: <cygwin-patches-return-2885-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 13022 invoked by alias); 30 Aug 2002 12:36:39 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 13008 invoked from network); 30 Aug 2002 12:36:38 -0000
Date: Fri, 30 Aug 2002 05:36:00 -0000
From: egor duda <deo@logos-m.ru>
Reply-To: egor duda <cygwin-patches@cygwin.com>
Organization: deo
X-Priority: 3 (Normal)
Message-ID: <97179922214.20020830163339@logos-m.ru>
To: Corinna Vinschen <cygwin-patches@cygwin.com>
Subject: Re: [PATCH] Added Kazuhiro's new wchar functions to cygwin.din
In-Reply-To: <20020830142028.F5475@cygbert.vinschen.de>
References: <20020830142028.F5475@cygbert.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-SW-Source: 2002-q3/txt/msg00333.txt.bz2

Hi!

Friday, 30 August, 2002 Corinna Vinschen cygwin-patches@cygwin.com wrote:

CV> Hi,

CV> did I miss one?

btowc, wctob, mbsinit, mbrlen, mbrtowc, mbsttowcs, wcrtomb, wcsrtombs.

CV> Index: cygwin.din
CV> ===================================================================
CV> RCS file: /cvs/src/src/winsup/cygwin/cygwin.din,v
CV> retrieving revision 1.59
CV> diff -u -p -r1.59 cygwin.din
CV> --- cygwin.din  28 Aug 2002 10:50:26 -0000      1.59
CV> +++ cygwin.din  30 Aug 2002 11:32:53 -0000
CV> @@ -1031,6 +1031,42 @@ wcscmp
CV>  _wcscmp = wcscmp
CV>  wcslen
CV>  _wcslen = wcslen
CV> +wcscat
CV> +_wcscat = wcscat

[...]

Egor.            mailto:deo@logos-m.ru ICQ 5165414 FidoNet 2:5020/496.19
