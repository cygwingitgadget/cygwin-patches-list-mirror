Return-Path: <cygwin-patches-return-2888-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 6261 invoked by alias); 30 Aug 2002 13:17:07 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 6204 invoked from network); 30 Aug 2002 13:17:06 -0000
Date: Fri, 30 Aug 2002 06:17:00 -0000
From: egor duda <deo@logos-m.ru>
Reply-To: egor duda <cygwin-patches@cygwin.com>
Organization: deo
X-Priority: 3 (Normal)
Message-ID: <110182341242.20020830171358@logos-m.ru>
To: Corinna Vinschen <cygwin-patches@cygwin.com>
Subject: Re: [PATCH] Added Kazuhiro's new wchar functions to cygwin.din
In-Reply-To: <20020830150147.G5475@cygbert.vinschen.de>
References: <20020830142028.F5475@cygbert.vinschen.de>
 <97179922214.20020830163339@logos-m.ru>
 <20020830150147.G5475@cygbert.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-SW-Source: 2002-q3/txt/msg00336.txt.bz2

Hi!

Friday, 30 August, 2002 Corinna Vinschen cygwin-patches@cygwin.com wrote:

CV> On Fri, Aug 30, 2002 at 04:33:39PM +0400, Egor Duda wrote:
>> CV> did I miss one?
>> 
>> btowc, wctob, mbsinit, mbrlen, mbrtowc, mbsttowcs, wcrtomb, wcsrtombs.

CV> Thanks!

CV> I didn't find mbsttowcs and mbstowcs is already defined, though.

It was a typo, sorry. Now, after double-checking, it should read

btowc, wctob,
mbsinit, mbrlen,
mbrtowc, mbstowcs, mbsrtowcs,
wcrtomb, wcstombs, wcsrtombs

Egor.            mailto:deo@logos-m.ru ICQ 5165414 FidoNet 2:5020/496.19
