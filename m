Return-Path: <cygwin-patches-return-2937-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 5382 invoked by alias); 5 Sep 2002 07:45:59 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 5346 invoked from network); 5 Sep 2002 07:45:57 -0000
Date: Thu, 05 Sep 2002 00:45:00 -0000
From: egor duda <deo@logos-m.ru>
Reply-To: egor duda <cygwin-patches@cygwin.com>
Organization: deo
X-Priority: 3 (Normal)
Message-ID: <155228642049.20020905114529@logos-m.ru>
To: Christopher Faylor <cygwin-patches@cygwin.com>
Subject: Re: proposed how-autoload-works.txt
In-Reply-To: <20020904151853.GC1284@redhat.com>
References: <53165040475.20020904180525@logos-m.ru>
 <20020904151853.GC1284@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-SW-Source: 2002-q3/txt/msg00385.txt.bz2

Hi!

Wednesday, 04 September, 2002 Christopher Faylor cgf@redhat.com wrote:

CF> On Wed, Sep 04, 2002 at 06:05:25PM +0400, egor duda wrote:
>>Spelling, grammar and factual corrections are welcome.

CF> I checked this in with some corrections.  I checked in your version
CF> first and my version second if you want to see what I did.

CF> It was basically just some minor grammar and formatting changes.

CF> I did add some words to explain that, after the first load, calls
CF> to an autoloaded function should be as fast as a normal function
CF> call.

Thanks!

Actually, i was meaning an extra jmp when talking about overhead, but
now i realize that an extra jmp is performed in normal dll+implib
setup too. 

Egor.            mailto:deo@logos-m.ru ICQ 5165414 FidoNet 2:5020/496.19
