Return-Path: <cygwin-patches-return-2905-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 15289 invoked by alias); 1 Sep 2002 12:50:02 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 15275 invoked from network); 1 Sep 2002 12:50:02 -0000
Message-ID: <3D720D1F.37080487@yahoo.com>
Date: Sun, 01 Sep 2002 05:50:00 -0000
From: Earnie Boyd <earnie_boyd@yahoo.com>
X-Accept-Language: en
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Added Kazuhiro's new wchar functions to cygwin.din
References: <20020830142028.F5475@cygbert.vinschen.de>
		<97179922214.20020830163339@logos-m.ru>
		<20020830150147.G5475@cygbert.vinschen.de>
		<110182341242.20020830171358@logos-m.ru> <s1selceuumv.fsf@jaist.ac.jp>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-SW-Source: 2002-q3/txt/msg00353.txt.bz2

Kazuhiro Fujieda wrote:

> >>> On Fri, 30 Aug 2002 17:13:58 +0400
> >>> egor duda <deo@logos-m.ru> said:
>
> > btowc, wctob,
> > mbsinit, mbrlen,
> > mbrtowc, mbstowcs, mbsrtowcs,
> > wcrtomb, wcstombs, wcsrtombs
>
> The current implementations of these functions don't conform the
> standard at all. I will correct these implementations in the
> near feature. I recommend the dll doesn't export these functions
> and the functions added by me until then.

So, instead of Corinna fixing the cygwin.din to/not to export them,
could you submit the patch?

Earnie.
