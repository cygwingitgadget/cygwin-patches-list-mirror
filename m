Return-Path: <cygwin-patches-return-2936-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 26778 invoked by alias); 4 Sep 2002 15:19:08 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 26761 invoked from network); 4 Sep 2002 15:19:08 -0000
Date: Wed, 04 Sep 2002 08:19:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: proposed how-autoload-works.txt
Message-ID: <20020904151853.GC1284@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <53165040475.20020904180525@logos-m.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <53165040475.20020904180525@logos-m.ru>
User-Agent: Mutt/1.3.23.1i
X-SW-Source: 2002-q3/txt/msg00384.txt.bz2

On Wed, Sep 04, 2002 at 06:05:25PM +0400, egor duda wrote:
>Spelling, grammar and factual corrections are welcome.

I checked this in with some corrections.  I checked in your version
first and my version second if you want to see what I did.

It was basically just some minor grammar and formatting changes.

I did add some words to explain that, after the first load, calls
to an autoloaded function should be as fast as a normal function
call.

Thanks very much for providing this info.

cgf
